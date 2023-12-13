package main

import (
	"bufio"
	"os"
)

func subtask2() {
	print("Subtask 2: ")

	file, err := os.Open("input.txt")
	if err != nil {
		println("File error:", err)
		return
	}

	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)

	top_three := []int{0, 0, 0}

	for true {
		cals := elf_calories(scanner)
		if cals == 0 {
			break
		}

		smallest_index := 0
		smallest_value := top_three[smallest_index]

		// Find the least in the top 3
		for i, v := range top_three {
			if v < smallest_value {
				smallest_index = i
				smallest_value = v
			}
		}

		// Replace the smallest in top 3 if necessary
		if cals > smallest_value {
			top_three[smallest_index] = cals
		}
	}

	println("Calorie sum of top 3 elves is:", top_three[0]+top_three[1]+top_three[2])
}
