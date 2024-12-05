import re

pattern = re.compile(r"mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)")

total = 0
do = True

with open("input.txt", "r") as f:
    for line in f.readlines():
        for match in re.findall(pattern, line):
            if match == "do()":
                do = True
            elif match == "don't()":
                do = False
            elif do:
                left, right = match[4:-1].split(",")
                total += int(left) * int(right)

print("\nTotal:", total)
