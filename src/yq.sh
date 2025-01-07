
# generate & transform for each array element
yq e -n '{"name": "mike", "pets":["a", "b"]} | {.name: .pets.[]}'