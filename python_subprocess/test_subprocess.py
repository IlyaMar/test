import subprocess
import sys

file = open("script.log", "w")

cmd = "/home/ilya-martynov/IdeaProjects/yc-monitoring/solomon-tf/main/iam/testing/sync.sh"
ret = subprocess.call([cmd, 'aaa bbb cccr'], stdout=file, stderr=file)
if ret != 0:
    sys.exit(1)

print("success!")
