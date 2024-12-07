rules: list[list[int]] = []
updates: list[list[int]] = []

with open("input.txt", "r") as f:
    reading_rules = True
    for line in f.readlines():
        line = line.strip()
        if len(line) == 0:
            reading_rules = False
            continue

        if reading_rules:
            parts = list(map(int, line.split("|")))
            rules.append(parts)
        else:
            parts = list(map(int, line.split(",")))
            updates.append(parts)


def is_manual_correct(instructions: list[int]) -> bool:
    for i, page in enumerate(instructions):
        for first, second in rules:
            if first == page:
                if second in instructions[:i]:
                    return False

    return True


total = 0
for manual in updates:
    if is_manual_correct(manual):
        middle = manual[len(manual) // 2]
        total += middle

print(total)
