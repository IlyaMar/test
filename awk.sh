
# фильтр логов и сорт по одной колонке
cat example_log | awk -F '\t' '$5 == "status=200" {print $20 " " $0}' | sort | tail -1
