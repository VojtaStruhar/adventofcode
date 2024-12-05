DIRECTIONS = [
    (1, 0),  # 0 deg
    (1, 1),  # 45 deg
    (0, 1),  # 90 deg
    (-1, 1),  # 135 deg
    (-1, 0),  # 180 deg
    (-1, -1),  # 215 deg
    (0, -1),  # 270 deg
    (1, -1),  # 315 deg
]

data: list[str] = []

with open("input.txt", "r") as f:
    for file_line in f.readlines():
        data.append(file_line.strip())

h = len(data)
w = len(data[0])


def find_xmas(startx: int, starty) -> int:
    findings = 0
    for dx, dy in DIRECTIONS:
        word = ""
        cx, cy = startx, starty
        for _ in range(4):
            if cx < 0 or cx >= w:
                break
            if cy < 0 or cy >= h:
                break

            word += data[cy][cx]
            cx += dx
            cy += dy
        else:
            if word == "XMAS":
                findings += 1

    return findings


total = 0
for y, line in enumerate(data):
    for x, letter in enumerate(line):
        if letter == "X":
            total += find_xmas(x, y)

print(total)
