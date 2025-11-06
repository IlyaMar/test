#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e
# Fail if any command in a pipeline fails
set -o pipefail

command="${1:-plan}"
command_args="${2}"


# Function to run terraform operations
# Parameters:
#   $1: directory to run terraform in
#   $2: dry_run flag (true/false)
#   $3: additional terraform arguments
run_terraform() {
    local dir="${1}"
    local kind="${2}"
    local env="${3}"
    
    echo "Running terraform in ${dir}"
    
    # Change to the directory
    cd "${dir}"
    
    # Run terraform init
    echo "Initializing terraform in ${dir}"
    ./init.sh
    
    echo "Running terraform in ${dir}"
    if [ "${kind}" = "monitoring" ]; then
        if [[ "${dir}" == *main/iam* ]]; then
            terraform ${command} -var oauth_token=$(cat ~/.monitoring_yandex_team_oauth_token) ${command_args}
        else 
            YCP_PROFILE=${env} YC_IAM_TOKEN=$(ycp --profile ${YCP_PROFILE?} iam iam-token create-for-service-account --service-account-id yc.iam.service-account) terraform ${command} ${command_args}
        fi
    else
        if [[ "${dir}" == *kz ]]; then
            YCP_PROFILE=kz YTR_JUGGLER_TOKEN=$(ycp --profile ${YCP_PROFILE?} iam create-token) terraform apply
        else
            TF_VAR_juggler_token=$(cat ~/.juggler_oauth_token) terraform ${command} ${command_args}
        fi
    fi
    
    # Return to original directory
    cd - > /dev/null
    
    echo "Terraform operation completed successfully in ${dir}"
}

# Main script
main() {
   
    echo "Starting Terraform operations with command: ${command}"


    # run_terraform "solomon-tf/preprod/iam/testing" "monitoring" "preprod"
    # run_terraform "juggler-tf/main/iam/testing" juggler


    # run_terraform "solomon-tf/prod/iam/prod"       "monitoring" "prod"
    # run_terraform "solomon-tf/preprod/iam/preprod" "monitoring" "preprod"
    run_terraform "solomon-tf/preprod/iam/testing" "monitoring" "preprod"
    # run_terraform "solomon-tf/kz/iam/kz"                   "monitoring" "kz"
    # run_terraform "solomon-tf/prod/iam/internal-dev"       "monitoring" "prod"
    # run_terraform "solomon-tf/prod/iam/internal-prestable" "monitoring" "prod"
    # run_terraform "solomon-tf/prod/iam/internal-prod"      "monitoring" "prod"

    # run_terraform "solomon-tf/main/iam/internal-dev"       "monitoring" "main"
    # run_terraform "solomon-tf/main/iam/internal-prestable" "monitoring" "main"
    # run_terraform "solomon-tf/main/iam/internal-prod"      "monitoring" "main"


    # run_terraform "juggler-tf/main/iam/prod" juggler
    # run_terraform "juggler-tf/main/iam/preprod" juggler
    # run_terraform "juggler-tf/main/iam/testing" juggler
    # run_terraform "juggler-tf/kz/iam/kz" juggler
    # run_terraform "juggler-tf/main/iam/internal-dev" juggler
    # run_terraform "juggler-tf/main/iam/internal-prestable" juggler
    # run_terraform "juggler-tf/main/iam/internal-prod" juggler
    
    echo "All Terraform operations completed successfully"
}

# Run the main function with the arguments
main 
