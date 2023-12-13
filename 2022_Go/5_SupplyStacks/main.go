package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type CrateMover interface {
	Perform(*Instruction)
	SetSupplies(*Supplies)
}

func main() {
	fmt.Print("Task 1: ")
	DoTask("input.txt", new(CrateMover9000))

	fmt.Print("Task 2: ")
	DoTask("input.txt", new(CrateMover9001))
}

func DoTask(filename string, crane CrateMover) {
	scanner, file := CreateScanner(filename)
	defer file.Close()

	supplies := new(Supplies)
	crane.SetSupplies(supplies)

	OrganizeCrates(scanner, supplies, crane)

	fmt.Println("Crate tops:", supplies.StackTops())

}

func OrganizeCrates(scanner *bufio.Scanner, supplies *Supplies, crane CrateMover) {

	for scanner.Scan() {
		line := scanner.Text()
		if len(line) == 0 {
			// Moving onto parsing the instructions
			break
		}

		if strings.Contains(line, "[") {
			crate_letter_index := 1

			for crate_letter_index < len(line) {
				letter := line[crate_letter_index]
				if letter == ' ' {
					crate_letter_index += 4
					continue
				}

				supplies.AddBottom(rune(letter), (crate_letter_index-1)/4)
				crate_letter_index += 4
			}
		}

	}

	for scanner.Scan() {
		line := scanner.Text()
		instruction, err := ParseInstruction(line)
		if err != nil {
			fmt.Println("Failed to parse instruction line:", line)
			continue
		}

		crane.Perform(instruction)
	}

	result := new(strings.Builder)
	for _, stack := range supplies.crates {
		result.WriteRune(stack[len(stack)-1])
	}

}

func ParseInstruction(line string) (*Instruction, error) {
	inst := new(Instruction)
	parts := strings.Split(line, " ")

	count, err := strconv.Atoi(parts[1])
	if err != nil {
		return inst, err
	}
	src, err := strconv.Atoi(parts[3])
	if err != nil {
		return inst, err
	}
	dest, err := strconv.Atoi(parts[5])
	if err != nil {
		return inst, err
	}

	inst.count = count
	inst.source = src - 1
	inst.destination = dest - 1

	return inst, nil
}

func CreateScanner(filename string) (*bufio.Scanner, *os.File) {
	file, err := os.Open(filename)
	// I should be closing the file somehow probably

	if err != nil {
		fmt.Println("Error opening file", filename)
		return nil, nil
	}

	return bufio.NewScanner(file), file
}
