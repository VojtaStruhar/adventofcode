DIAGONAL = [
    (1, 1),  # 45 deg
    (-1, 1),  # 135 deg
]

data: list[str] = []

with open("input.txt", "r") as f:
    for file_line in f.readlines():
        data.append(file_line.strip())

h = len(data)
w = len(data[0])


def check_x_mas(startx: int, starty) -> int:
    diagonals_found = 0

    for dx, dy in DIAGONAL:
        cx, cy = startx + dx, starty + dy
        if cx < 0 or cx >= w:
            continue
        if cy < 0 or cy >= h:
            continue

        word = data[cy][cx]
        cx, cy = startx - dx, starty - dy

        if cx < 0 or cx >= w:
            continue
        if cy < 0 or cy >= h:
            continue

        word += data[cy][cx]

        if word == "MS" or word == "SM":
            diagonals_found += 1

    return diagonals_found == 2


total = 0
for y, line in enumerate(data):
    for x, letter in enumerate(line):
        if letter == "A":
            total += check_x_mas(x, y)

print(total)
