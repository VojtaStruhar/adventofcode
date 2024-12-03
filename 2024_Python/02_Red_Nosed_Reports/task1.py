import math

with open("input.txt") as f:
    data = []
    for line in f.readlines():
        data.append(list(map(int, line.split())))

sign = lambda x: math.copysign(1, x)


def is_report_safe(report: list[int]) -> bool:
    diff = report[0] - report[1]
    s = sign(diff)

    if not 1 <= abs(diff) <= 3:
        return False

    for i in range(2, len(report)):
        diff = report[i - 1] - report[i]

        if not 1 <= abs(diff) <= 3:
            return False
        if sign(diff) != s:
            return False

    return True


safe_reports = sum(is_report_safe(r) for r in data)
print(safe_reports)
