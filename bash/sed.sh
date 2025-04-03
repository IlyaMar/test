
grep -oP '(data \[^]+\])' logs

# find and print 1st group
sed -nr '/.*START(.*)END.*/{s/.*START(.*)END.*/\1/p;q;}' file

# replace all strings
sed -r 's/.*START(.*)END.*/\1/' file

# ...data [xxx],... -> xxx
sed -r 's/.*data \[([^]]+)\],.*/\1/' log > log_msg
