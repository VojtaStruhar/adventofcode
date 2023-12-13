package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func subtask1() {
	fmt.Print("Subtask 1: ")
	file, err := os.Open("input.txt")
	// Defer this right away - executes even if I return on an error
	defer file.Close()

	if err != nil {
		fmt.Println("Opening file failed:", err)
		return
	}

	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)

	max_calories := 0
	for true {

		cals := elf_calories(scanner)
		if cals == 0 {
			break
		}
		max_calories = max(max_calories, cals)
	}
	fmt.Println("Elf carrying the most calories has:", max_calories)
}

func elf_calories(scanner *bufio.Scanner) int {

	current_calories := 0

	for scanner.Scan() {
		// Another way to make a variable
		var line string = scanner.Text()

		parsed_number, parse_error := strconv.ParseInt(line, 10, 0)
		if parse_error != nil {
			// Int parse failed - this means an empty line separating the elves.
			// I know my input in this case :)

			return current_calories
		}

		// Ugh, conversion from int64 to int? Interesting :D
		current_calories += int(parsed_number)
	}

	return current_calories
}

func max(a int, b int) int {
	if a > b {
		return a
	}
	return b
}
