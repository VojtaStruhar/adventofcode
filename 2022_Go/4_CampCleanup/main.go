package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	fmt.Print("Task 1: ")
	task1()
	fmt.Print("Task 2: ")
	task2()
}

func task1() {
	scanner := CreateScanner("input.txt")

	contained_ranges := 0

	for scanner.Scan() {
		line := scanner.Text()
		elf1, elf2 := InputlineToRanges(line)

		if IncludedRange(elf1, elf2) {
			contained_ranges += 1
		}
	}

	fmt.Println("Contained area ranges:", contained_ranges)
}

func task2() {
	scanner := CreateScanner("input.txt")

	overlapping_ranges := 0

	for scanner.Scan() {
		first, second := InputlineToRanges(scanner.Text())

		if first.overlaps(second) {
			overlapping_ranges += 1
		}
	}

	fmt.Println("Overlapping ranges:", overlapping_ranges)
}

func InputlineToRanges(line string) (*Range, *Range) {
	areas := strings.Split(line, ",")

	return CreateRange(areas[0]), CreateRange(areas[1])
}

func CreateRange(inputline string) *Range {
	numbers := strings.Split(inputline, "-")
	low, _ := strconv.Atoi(numbers[0])
	high, _ := strconv.Atoi(numbers[1])

	result := new(Range)
	result.low = low
	result.high = high
	return result
}

func IncludedRange(first *Range, second *Range) bool {
	return first.includes(second) || second.includes(first)
}

type Range struct {
	low  int
	high int
}

func (rang *Range) includes(other *Range) bool {
	return rang.contains(other.low) && rang.contains(other.high)
}

func (rang *Range) contains(number int) bool {
	return rang.low <= number && number <= rang.high
}

func (rang *Range) overlaps(other *Range) bool {
	return IncludedRange(rang, other) || rang.contains(other.low) || rang.contains(other.high)
}

func CreateScanner(filename string) *bufio.Scanner {
	file, err := os.Open(filename)
	// I should be closing the file somehow probably

	if err != nil {
		fmt.Println("Error opening file", filename)
		return nil
	}

	return bufio.NewScanner(file)
}
