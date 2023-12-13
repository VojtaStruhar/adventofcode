package main

import (
	"bufio"
	"os"
)

func main() {
	print("Task 1: ")
	task1()
	print("Task 2: ")
	task2()
}

func task1() {
	file, _ := os.Open("input.txt")
	defer file.Close()

	scanner := bufio.NewScanner(file)

	duplicates_sum := 0

	for scanner.Scan() {
		line := scanner.Text()
		registry := map[rune]bool{}
		index := 0
		var duplicate_entry rune = '-'

		// Gather all items in one side of the rucksack
		for index < len(line)/2 {

			registry[rune(line[index])] = true
			index += 1
		}
		// Check if there are duplicates in the second compartment
		for index < len(line) {
			var letter rune = rune(line[index])
			_, exists := registry[letter]
			if exists {
				duplicate_entry = letter
				break
			}
			index += 1
		}

		if duplicate_entry == '-' {
			// This never happened..
			println("Uh oh, duplicate not found: ", line)
		}
		duplicates_sum += item_priority(duplicate_entry)
	}

	println("Sum of all duplicate items:", duplicates_sum)
}

func task2() {
	file, _ := os.Open("input.txt")
	defer file.Close()

	scanner := bufio.NewScanner(file)

	group := new(ElfGroup)
	badge_sum := 0

	for scanner.Scan() {
		line := scanner.Text()

		group.add_elf(line)

		if group.isFull() {
			badge_sum += item_priority(group.badge())
			group = new(ElfGroup)
		}
	}
	println("Badge sum:", badge_sum)
}
