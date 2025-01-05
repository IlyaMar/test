#!/usr/bin/env bash

CLOUD_GO_DIR="%cloud_go_dir%"
METADATA_SOURCE_DIR="%metadata_source_dir%"
METADATA_BUILD_DIR="%metadata_build_dir%"
METADATA_ORIGIN_DIR="%metadata_origin_dir%"

add_bitbucket_pull_request_comment () {
    local COMMENT_TYPE="${1?}"
    local COMMENT_TEXT="${2?}"

    local PULL_REQUEST_ID=$(echo "%teamcity.build.branch%" | grep -oP "(?<=pull-requests/)(\d+)")
    if [[ "${PULL_REQUEST_ID?}" == "" ]]; then
        return
    fi

    local ADD_COMMENT_DATA=$(jq --compact-output --null-input \
        --arg text "${COMMENT_TEXT?}" \
        '{"text": $text}'
    )

    # todo share "cloud/cloud-go" between triggerRules and CLOUDIA_CHECKOUT_RULES_PARAM
    local BITBUCKET_PROJECT="cloud"
    local BITBUCKET_REPO="cloud-go"

    if [[ "${COMMENT_TYPE?}" == "comment" ]]; then
        local ADD_COMMENT_URL="https://bb.yandexcloud.net/rest/api/1.0/projects/${BITBUCKET_PROJECT?}/repos/${BITBUCKET_REPO?}/pull-requests/${PULL_REQUEST_ID?}/comments"
    else
        local ADD_COMMENT_URL="https://bb.yandexcloud.net/rest/api/1.0/projects/${BITBUCKET_PROJECT?}/repos/${BITBUCKET_REPO?}/pull-requests/${PULL_REQUEST_ID?}/blocker-comments"
    fi

    # todo review -u robot-yc-bitbucket:%robot-yc-bitbucket.token%
    curl \
        --silent \
        --show-error \
        --retry 5 \
        -X POST \
        -u robot-yc-bitbucket:%robot-yc-bitbucket.token% \
        -H "Content-Type: application/json" \
        -d "${ADD_COMMENT_DATA?}" \
        ${ADD_COMMENT_URL?}
}

add_arcanum_pull_request_comment () {
    local COMMENT_TYPE="${1?}"
    local COMMENT_TEXT="${2?}"

    # todo review users/robot-stark/iam/ prefix
    local PULL_REQUEST_ID=$(echo "%teamcity.build.branch%" | grep -oP "(?<=users/robot-stark/iam/)(\d+)")
    if [[ "${PULL_REQUEST_ID?}" == "" ]]; then
        return
    fi

    if [[ "${COMMENT_TYPE?}" == "comment" ]]; then
        local ADD_COMMENT_ISSUE="false"
    else
        local ADD_COMMENT_ISSUE="true"
    fi

    local ADD_COMMENT_DATA=$(jq --compact-output --null-input \
        --arg content "${COMMENT_TEXT?}" \
        --arg issue "${ADD_COMMENT_ISSUE?}" \
        '{"content": $content, "issue": $issue}'
    )

    local ADD_COMMENT_URL="https://arcanum.yandex.net/api/v1/pull-requests/${PULL_REQUEST_ID?}/comments?fields=id"

    local ARCANUM_OAUTH_TOKEN=$(cat /root/.arc/token)

    curl \
        --silent \
        --show-error \
        --retry 5 \
        -X POST \
        -H "Authorization: OAuth ${ARCANUM_OAUTH_TOKEN?}" \
        -H "Content-Type: application/json" \
        -d "${ADD_COMMENT_DATA?}" \
        ${ADD_COMMENT_URL?}
}

add_pull_request_comment () {
    local COMMENT_TYPE="${1?}"
    local COMMENT_TEXT="${2?}"

    add_bitbucket_pull_request_comment "${COMMENT_TYPE?}" "${COMMENT_TEXT?}"
    add_arcanum_pull_request_comment "${COMMENT_TYPE?}" "${COMMENT_TEXT?}"
}

add_pull_request_file_comment () {
    local ENV_PROFILE="${1?}"
    local COMMENT_TYPE="${2?}"
    local COMMENT_TITLE="${3?}"
    local FILE_NAME="${4?}"
    local FILE_LINES=100

    add_pull_request_comment "${COMMENT_TYPE?}" "$(cat <<EOF
**${ENV_PROFILE?}** ${COMMENT_TITLE?} %teamcity.serverUrl%/repository/download/%system.teamcity.buildType.id%/%teamcity.build.id%:id/${FILE_NAME?}

{% cut 'First ${FILE_LINES?} lines' %}
\`\`\`diff
$(head -n ${FILE_LINES?} ${METADATA_BUILD_DIR?}/${FILE_NAME?})
\`\`\`
{% endcut %}
EOF
)"
}
metadata_dump () {
    local ENV_PROFILE="${1?}"
    local TEST_NAME="${ENV_PROFILE?}: build"
    local RESULT=0

    echo "##teamcity[testStarted name='${TEST_NAME?}']"

    ycp iam inner metadata dump \
        --profile ${ENV_PROFILE?} \
        --allow-warnings \
        --yaml-dir ${CLOUD_GO_DIR?}/${METADATA_SOURCE_DIR?} \
        > ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_dump.yaml \
        2> ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_dump_stderr.txt
    local DUMP_EXIT_CODE=$?

    grep "WARN Compile" ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_dump_stderr.txt | sort > ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_warnings.txt
    # if [[ -s ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_warnings.txt ]]; then
    #     add_pull_request_file_comment "${ENV_PROFILE?}" "comment" "warnings" "${ENV_PROFILE?}_warnings.txt"
    # fi

    if [[ "${DUMP_EXIT_CODE?}" == "0" ]]; then
        rm ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_dump_stderr.txt
    else
        RESULT=1
        echo "##teamcity[testFailed name='${TEST_NAME?}' message='ycp iam inner metadata dump exited with ${DUMP_EXIT_CODE?}']"
        grep "ERROR Compile" ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_dump_stderr.txt | sort > ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_errors.txt
        if [[ -s ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_errors.txt ]]; then
            add_pull_request_file_comment "${ENV_PROFILE?}" "issue" "errors" "${ENV_PROFILE?}_errors.txt"
        elif [[ -s ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_dump_stderr.txt ]]; then
            add_pull_request_file_comment "${ENV_PROFILE?}" "issue" "failed with exit code ${DUMP_EXIT_CODE?}" "${ENV_PROFILE?}_dump_stderr.txt"
        fi
    fi

    echo "##teamcity[testFinished name='${TEST_NAME?}']"
    return ${RESULT?}
}
metadata_check_new_warnings () {
    local ENV_PROFILE="${1?}"
    local TEST_NAME="${ENV_PROFILE?}: checkNewWarnings"
    local RESULT=0

    if [[ -f ${METADATA_ORIGIN_DIR?}/${ENV_PROFILE?}_warnings.txt ]]; then
        echo "##teamcity[testStarted name='${TEST_NAME?}']"

        comm \
            -13 \
            ${METADATA_ORIGIN_DIR?}/${ENV_PROFILE?}_warnings.txt \
            ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_warnings.txt \
            > ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_warnings_new.txt

        if [[ -s ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_warnings_new.txt ]]; then
            RESULT=1
            echo "##teamcity[testFailed name='${TEST_NAME?}' message='new warnings']"
            add_pull_request_file_comment "${ENV_PROFILE?}" "issue" "new warnings" "${ENV_PROFILE?}_warnings_new.txt"
        else
            rm ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_warnings_new.txt
        fi

        echo "##teamcity[testFinished name='${TEST_NAME?}']"
    else
        echo "##teamcity[testIgnored name='${TEST_NAME?}']"
    fi
    return ${RESULT?}
}

metadata_plan () {
    local ENV_PROFILE="${1?}"
    local TEST_NAME="${ENV_PROFILE?}: plan"
    local RESULT=0

    if [[ -f ${METADATA_ORIGIN_DIR?}/${ENV_PROFILE?}_dump.yaml ]]; then
        echo "##teamcity[testStarted name='${TEST_NAME?}']"

        ycp iam inner metadata update \
            --dry-run \
            --allow-warnings \
            --export-file ${METADATA_ORIGIN_DIR?}/${ENV_PROFILE?}_dump.yaml \
            --from-file ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_dump.yaml \
            > ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_plan.txt \
            2> ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_plan_stderr.txt
        local UPDATE_EXIT_CODE=$?

        if [[ "${UPDATE_EXIT_CODE?}" == "0" ]]; then
            add_pull_request_file_comment "${ENV_PROFILE?}" "comment" "plan" ${ENV_PROFILE?}_plan.txt
            rm ${METADATA_BUILD_DIR?}/${ENV_PROFILE?}_plan_stderr.txt
        else
            RESULT=1
            echo "##teamcity[testFailed name='${TEST_NAME?}' message='ycp iam inner metadata update exited with ${UPDATE_EXIT_CODE?}']"
        fi

        echo "##teamcity[testFinished name='${TEST_NAME?}']"
    else
        echo "##teamcity[testIgnored name='${TEST_NAME?}']"
    fi
    return ${RESULT?}
}

ycp init | true
ycp version
curl --version
jq --version

rm -rf ${METADATA_BUILD_DIR?}
mkdir -p ${METADATA_BUILD_DIR?}

for ENV_FILE_PATH in ${CLOUD_GO_DIR?}/${METADATA_SOURCE_DIR?}/env/*.yaml; do
    ENV_FILE_NAME=$(basename -- "${ENV_FILE_PATH?}")
    ENV_PROFILE="${ENV_FILE_NAME%.*}"
    if [[ "${ENV_PROFILE}" == "doublecloud-yc-preprod" ]] ||
       [[ "${ENV_PROFILE}" == "doublecloud-aws-prod" ]] ||
       [[ "${ENV_PROFILE}" == "doublecloud-aws-preprod" ]]; then
        continue
    fi
    metadata_dump "${ENV_PROFILE?}"
    PREVIOUS_STEP_EXIT_CODE="$?"
    if [[ -d ${METADATA_ORIGIN_DIR?} ]]; then
        if [[ "${PREVIOUS_STEP_EXIT_CODE?}" == "0" ]]; then
            metadata_check_new_warnings "${ENV_PROFILE?}"
            PREVIOUS_STEP_EXIT_CODE="$?"
        fi
        if [[ "${PREVIOUS_STEP_EXIT_CODE?}" == "0" ]]; then
            metadata_plan "${ENV_PROFILE?}"
            METADATA_PLAN_EXIT_CODE="$?"
        fi
    fi
done