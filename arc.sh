mkdir ~/.arc/stores/objects-common
mkdir ~/.arc/stores/objects-common-arcadia

nice arc mount --allow-other --repository arcadia -m ~/arcadia --object-store ~/.arc/stores/objects-common-arcadia
nice arc mount --allow-other --repository arcadia -m ~/arcadia-dashboard --object-store ~/.arc/stores/objects-common-arcadia


nice arc mount --allow-other --repository cloudia -m ~/cloudia-cloud-go --object-store ~/.arc/stores/objects-common
nice arc mount --allow-other --repository cloudia -m ~/cloudia-terraform --object-store ~/.arc/stores/objects-common
nice arc mount --allow-other --repository cloudia -m ~/cloudia-salt --object-store ~/.arc/stores/objects-common
#nice arc mount --allow-other --repository cloudia -m ~/cloudia-bootstrap --object-store ~/.arc/stores/objects-common
nice arc mount --allow-other --repository cloudia -m ~/cloudia-deploy --object-store ~/.arc/stores/objects-common

nice arc mount --allow-other --repository cloudia -m ~/cloudia-k8s-deploy --object-store ~/.arc/stores/objects-common
nice arc mount --allow-other --repository cloudia -m ~/cloudia-cloud-java --object-store ~/.arc/stores/objects-common
nice arc mount --allow-other --repository cloudia -m ~/cloudia-monitoring --object-store ~/.arc/stores/objects-common



function arc_mount() {
  path=$1
  repo=$2
  if [ "${repo?}" ]; then
    echo "it's cloudia"
    object_store=~/.arc/stores/objects-common
    repo_param="--repository cloudia"
  else
    echo "it's arcadia"
    object_store=~/.arc/stores/objects-common-arcadia
    repo_param=
  fi
  if nice arc mount --allow-other ${repo_param?} -m ${path?} --object-store ${object_store?}; then
    echo "Mounted ${path?}"
  else
    echo "Failed to mount ${path?}"
    sudo umount -f ${path?}
    nice arc mount --allow-other ${repo_param?} -m ${path?} --object-store ${object_store?}
  fi
}

arc_mount ~/arcadia
arc_mount ~/arcadia-iam-bot
arc_mount ~/arcadia-scripts
arc_mount ~/arcadia-docs
arc_mount ~/arcadia-dashboard

arc_mount ~/cloudia cloudia
arc_mount ~/cloudia-metro cloudia
arc_mount ~/cloudia-cloud-java cloudia
arc_mount ~/cloudia-terraform cloudia
arc_mount ~/cloudia-monitoring cloudia
arc_mount ~/cloudia-spinnaker cloudia
arc_mount ~/cloudia-cloud-go cloudia
arc_mount ~/cloudia-activeprobes cloudia
arc_mount ~/cloudia-k8s-deploy cloudia
arc_mount ~/cloudia-bootstrap-templates cloudia
arc_mount ~/cloudia-iam-sync cloudia
arc_mount ~/cloudia-salt-formula cloudia




arc unmount ~/cloudia
arc unmount ~/cloudia-metro
arc unmount ~/cloudia-cloud-java
arc unmount ~/cloudia-terraform
arc unmount ~/cloudia-monitoring
arc unmount ~/cloudia-spinnaker
arc unmount ~/cloudia-cloud-go
arc unmount ~/cloudia-activeprobes
arc unmount ~/cloudia-k8s-deploy
arc unmount ~/cloudia-bootstrap-templates
arc unmount ~/cloudia-iam-sync
arc unmount ~/cloudia-salt-formula





nice arc mount --mount ~/arcadia --object-store ~/.arc/stores/objects-common-arcadia
nice arc mount --mount ~/arcadia-scripts --object-store ~/.arc/stores/objects-common-arcadia
nice arc mount --mount ~/arcadia-docs --object-store ~/.arc/stores/objects-common-arcadia
nice arc mount --mount ~/arcadia-iam-bot --object-store ~/.arc/stores/objects-common-arcadia
nice arc mount --mount ~/arcadia-dashboard --object-store ~/.arc/stores/objects-common-arcadia
nice arc mount -r cloudia -m ~/cloudia --object-store ~/.arc/stores/objects-common
nice arc mount -r cloudia -m ~/cloudia-cloud-java --object-store ~/.arc/stores/objects-common
nice arc mount -r cloudia -m ~/cloudia-terraform --object-store ~/.arc/stores/objects-common
nice arc mount -r cloudia -m ~/cloudia-monitoring --object-store ~/.arc/stores/objects-common
nice arc mount -r cloudia -m ~/cloudia-spinnaker --object-store ~/.arc/stores/objects-common
nice arc mount -r cloudia -m ~/cloudia-cloud-go --object-store ~/.arc/stores/objects-common
nice arc mount -r cloudia -m ~/cloudia-activeprobes --object-store ~/.arc/stores/objects-common
nice arc mount -r cloudia -m ~/cloudia-k8s-deploy --object-store ~/.arc/stores/objects-common
nice arc mount -r cloudia -m ~/cloudia-bootstrap-templates --object-store ~/.arc/stores/objects-common
nice arc mount -r cloudia -m ~/cloudia-iam-sync --object-store ~/.arc/stores/objects-common
nice arc mount -r cloudia -m ~/cloudia-salt-formula --object-store ~/.arc/stores/objects-common
nice arc mount -r cloudia -m ~/cloudia-aw --object-store ~/.arc/stores/objects-common





arc unmount ~/cloudia-cloud-java



ya whoami
arc mount
arc checkout -b my-branch1
vim ya.make
arc status
arc diff
arc add ya.make
arc commit -m "my commit 1"
arc pull trunk
arc rebase trunk
arc pr create --push -m "my first pull request"
for branch in $(arc branch --all|grep "users/${USER?}"); do echo $branch; arc push -d $branch; done


# original object store
ilya-martynov@ilya-martynov-n:~$ nice arc mount -r cloudia -m ~/cloudia
Store path is not specified, using last mounted: /home/ilya-martynov/.arc/stores/_home_ilya-martynov_cloudia
[mounted, pid: 440520] mount: /home/ilya-martynov/cloudia store: /home/ilya-martynov/.arc/stores/_home_ilya-martynov_cloudia object_store: /home/ilya-martynov/.arc/stores/_home_ilya-martynov_cloudia/.arc/objects

MountPoints {
  Mount: "/home/ilya-martynov/cloudia"
  Store: "/home/ilya-martynov/.arc/stores/_home_ilya-martynov_cloudia"
}

nice arc mount -m ~/arcadia
Store path is not specified, using last mounted: /home/ilya-martynov/.arc/store
[mounted, pid: 915590] mount: /home/ilya-martynov/arcadia store: /home/ilya-martynov/.arc/store object_store: /home/ilya-martynov



CURRENT_SALT_TAG=...
PREVIOUS_SALT_TAG=...
./changelog_salt_formula.sh as ${PREVIOUS_SALT_TAG} ${CURRENT_SALT_TAG}