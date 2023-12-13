package main

import "fmt"

type ElfGroup struct {
	rucksacks [3]string
	count     int
}

func (group *ElfGroup) add_elf(items string) {
	if !group.isFull() {
		group.rucksacks[group.count] = items
		group.count = group.count + 1
	} else {
		println("Trying to add elf to a full group - skip")
	}
}

func (group *ElfGroup) isFull() bool {
	return group.count >= 3
}

func (group *ElfGroup) badge() rune {
	if !group.isFull() {
		println("Trying to compute the group badge, but the group isn't full (3 elves)")
	}
	candidates := map[rune]bool{}

	// first elf - all items are badge candidates
	for _, value := range group.rucksacks[0] {
		candidates[value] = true
	}

	// middle elf - narrow down the candidates
	common_candidates := map[rune]bool{}
	for _, value := range group.rucksacks[1] {
		_, exists := candidates[value]
		if exists {
			common_candidates[value] = true
		}
	}
	candidates = common_candidates

	// last elf - we should get to only a single candidate by now
	common_candidates = map[rune]bool{}
	for _, value := range group.rucksacks[2] {
		_, exists := candidates[value]
		if exists {
			common_candidates[value] = true
		}
	}
	candidates = common_candidates

	keys := make([]rune, 0, len(candidates))
	for k := range candidates {
		keys = append(keys, k)
	}

	if len(keys) != 1 {
		fmt.Println("We have", len(keys), "badge candidates!", string(keys), "from line", string(group.rucksacks[0]))
	}

	return keys[0]
}

func item_priority(letter rune) int {
	letter_number := int(letter)

	// A-Z
	if 65 <= letter_number && letter_number <= 90 {
		return letter_number - int('A') + 27
	}

	// a-z
	if 97 <= letter_number && letter_number <= 122 {
		return letter_number - int('a') + 1
	}

	println("PRIORITY FOR", string(letter), "NOT RECOGNIZED")
	return 0
}
