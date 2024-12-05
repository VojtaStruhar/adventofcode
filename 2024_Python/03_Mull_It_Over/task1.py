import re

pattern = re.compile(r"mul\(\d{1,3},\d{1,3}\)")
total = 0

with open("input.txt", "r") as f:
    for line in f.readlines():
        for match in re.findall(pattern, line):
            left, right = match[4:-1].split(",")
            total += int(left) * int(right)

print(total)
