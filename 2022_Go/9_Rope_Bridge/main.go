package main

import (
	"bufio"
	"errors"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	file, err := os.Open("input.txt")
	if err != nil {
		fmt.Println(err)
		return
	}
	scanner := bufio.NewScanner(file)

	visited := NewVisitedRegistry()
	head_position := &Vector2{0, 0}
	tail_position := &Vector2{0, 0}

	visited.Mark(tail_position)

	for scanner.Scan() {
		line := scanner.Text()

		motion, amount, err := ParseLine(line)
		if err != nil {
			continue
		}

		for i := 0; i < amount; i++ {
			head_position.Move(motion, 1)

			if tail_position.MaxXyDistance(*head_position) > 1 {
				step := tail_position.StepTowards(*head_position)
				tail_position.Add(step)
			}
			visited.Mark(tail_position)

		}
	}
	PrettyPrint(head_position, tail_position, 6, visited)

	fmt.Println("Tail has visited", visited.Count(), "tiles")
}

func PrettyPrint(head *Vector2, tail *Vector2, area int, visited *VisitedRegistry) {
	for i := 0; i < area; i++ {
		if i < 10 {
			fmt.Printf("%d ", i)
		} else {
			fmt.Printf("%d", i)
		}
	}
	fmt.Println()
	for row := area - 1; row >= 0; row-- {
		for col := 0; col < area; col++ {
			if head.x == col && head.y == row {
				fmt.Print("H ")
			} else if tail.x == col && tail.y == row {
				fmt.Print("T ")
			} else if col == 0 && row == 0 {
				fmt.Print("s ")
			} else {
				pos := Vector2{col, row}
				if visited.Has(pos) {
					fmt.Print("# ")
				} else {
					fmt.Print(". ")
				}

			}
		}
		fmt.Println(row)
	}
	fmt.Println()
}

func ParseLine(line string) (Motion, int, error) {
	words := strings.Split(line, " ")
	motion, err := ParseMotion(words[0])
	if err != nil {
		fmt.Println(err)
		return Left, 0, err
	}

	amount, err := strconv.Atoi(words[1])
	if err != nil {
		fmt.Println(err)
		return Left, 0, err
	}

	return motion, amount, nil
}

func ParseMotion(letter string) (Motion, error) {
	switch letter {
	case "L":
		return Left, nil
	case "R":
		return Right, nil
	case "U":
		return Up, nil
	case "D":
		return Down, nil
	default:
		return Left, errors.New("Invalid motion: " + letter) // the motion doesn't matter here
	}
}
