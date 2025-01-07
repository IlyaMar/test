from subprocess import Popen, PIPE
import sys
import re

p = Popen(['bash', 'init.sh'], stdout=PIPE, stderr=PIPE)
output, err = p.communicate()
if p.returncode != 0:
    print("failed, stdout: %s, stderr: %s" % (output, err))
    sys.exit(1)

print("success!")
print(output)
print(err)

lines = output.splitlines()
if lines:
    last_line = lines[-1].decode()
    result = re.match("^secret: (.+)$", last_line)
    print(result)
    if result:
        print(result.group(1))

