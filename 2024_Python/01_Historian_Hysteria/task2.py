with open("input.txt", "r") as f:
    data_str = [l.split() for l in f.readlines()]

    left = [int(t[0]) for t in data_str]
    right = [int(t[1]) for t in data_str]

occurences = {}
for r in right:
    occurences[r] = occurences.get(r, 0) + 1

similarity_score = 0
for l in left:
    similarity_score += l * occurences.get(l, 0)

print(similarity_score)
