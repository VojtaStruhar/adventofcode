import math

with open("input.txt") as f:
    data = []
    for line in f.readlines():
        data.append(list(map(int, line.split())))

sign = lambda x: math.copysign(1, x)


def violating_index(report: list[int]) -> int | None:
    p_diff = report[0] - report[1]
    if not 1 <= abs(p_diff) <= 3:
        return 1

    for i in range(2, len(report)):
        diff = report[i - 1] - report[i]
        if not 1 <= abs(diff) <= 3:
            return i
        if (p_diff < 0) != (diff < 0):
            return i

        p_diff = diff

    return None


safe_reports = 0
for r in data:
    if (vi := violating_index(r)) is None:
        safe_reports += 1
        continue

    # The violating index here is index of the last DIFF that creates
    # the error. So if you have elements like
    # [5, 1, 3, 4]
    # The vi would be 2 (because 5->1 decreases, but 1->3 increases),
    # but the solution here is actually to remove at 0 (the first 5),
    # because after that the values increase peacefully.
    #
    # This is an ugly, ugly solution. Sorry about that

    modified = r.copy()
    modified.pop(vi)
    if violating_index(modified) is None:
        safe_reports += 1
        continue

    modified = r.copy()
    modified.pop(vi - 1)
    if violating_index(modified) is None:
        safe_reports += 1
        continue

    if vi >= 2:
        modified = r.copy()
        modified.pop(vi - 2)
        if violating_index(modified) is None:
            safe_reports += 1
            continue

    print(f"Unsafe: {r}, ({vi})")

print(safe_reports, "safe out of", len(data))
