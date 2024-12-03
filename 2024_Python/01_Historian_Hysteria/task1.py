with open("input.txt", "r") as f:
    data_str = [l.split() for l in f.readlines()]

    left = [int(t[0]) for t in data_str]
    left.sort()

    right = [int(t[1]) for t in data_str]
    right.sort()

difference = 0

for l, r in zip(left, right):
    difference += abs(l - r)

print(difference)
