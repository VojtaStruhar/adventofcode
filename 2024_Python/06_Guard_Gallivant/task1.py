space: list[str] = []

with open("input.txt", "r") as f:
    for line in f.readlines():
        l = line.strip()
        if (caret_x := l.find("^")) != -1:
            guard = (caret_x, len(space))
            l = l.replace("^", ".")

        space.append(l)

def get(coords: tuple[int, int]) -> str:
    cx, cy = coords
    return space[cy][cx]

def mark_visited(coords: tuple[int, int]) -> None:
    cx, cy = coords
    visited[cy][cx] = True

def add(coords: tuple[int, int], direction: tuple[int,int]) -> tuple[int, int]:
    return coords[0] + direction[0], coords[1] + direction[1]

def in_bounds(coords: tuple[int, int]) -> bool:
    x, y = coords
    return 0 <= y < len(space) and 0 <= x < len(space[y])

def turn_right(direction: tuple[int, int]) -> tuple[int, int]:
    UP = (0, -1)
    DOWN = (0, 1)
    LEFT = (-1, 0)
    RIGHT = (1, 0)

    if direction == UP:
        return RIGHT
    if direction == RIGHT:
        return DOWN
    if direction == DOWN:
        return LEFT
    if direction == LEFT:
        return UP

    assert False



visited = [[False] * len(space[0]) for _ in space]
guard_dir = (0, -1)  # Y up

for i in range(len(space)):
    print(space[i], "\t", [1 if v else 0 for v in visited[i]])


while True:
    mark_visited(guard)

    next_pos = add(guard, guard_dir)
    if not in_bounds(next_pos):
        print("Out of the map", guard)
        break

    if get(next_pos) == ".":
        guard = next_pos
    else:
        guard_dir = turn_right(guard_dir)



for i in range(len(space)):
    print(space[i], "\t", [1 if v else 0 for v in visited[i]])

result = sum([sum(v) for v in visited])
print(result)