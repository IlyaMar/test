mkdir ~/.arc/stores/objects-common

nice arc mount --mount ~/arcadia/ --object-store ~/.arc/stores/objects-common
nice arc mount -r cloudia -m ~/cloudia --object-store ~/.arc/stores/objects-common
nice arc mount -r cloudia -m ~/cloudia-ro --object-store ~/.arc/stores/objects-common


arc mount -r cloudia ~/cloudia


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


# original object store
ilya-martynov@ilya-martynov-n:~$ nice arc mount -r cloudia -m ~/cloudia
Store path is not specified, using last mounted: /home/ilya-martynov/.arc/stores/_home_ilya-martynov_cloudia
[mounted, pid: 440520] mount: /home/ilya-martynov/cloudia store: /home/ilya-martynov/.arc/stores/_home_ilya-martynov_cloudia object_store: /home/ilya-martynov/.arc/stores/_home_ilya-martynov_cloudia/.arc/objects

MountPoints {
  Mount: "/home/ilya-martynov/cloudia"
  Store: "/home/ilya-martynov/.arc/stores/_home_ilya-martynov_cloudia"
}
