package main

import (
	"bufio"
	"os"
)

func main() {
	println("Task 2")

	file, _ := os.Open("input.txt")
	print("Subtask 1: ")
	task1(file)
	file.Close()

	file, _ = os.Open("input.txt")
	print("Subtask 2: ")
	task2(file)
	file.Close()
}

func task1(file *os.File) {
	scanner := bufio.NewScanner(file)

	score := 0

	for scanner.Scan() {
		line := scanner.Bytes()
		opponent := decode_play(line[0])
		me := decode_play(line[2])

		result := me.fight(opponent)

		score += int(result) + int(me)
	}

	println("Total score:", score)
}

func task2(file *os.File) {
	scanner := bufio.NewScanner(file)

	score := 0

	for scanner.Scan() {
		line := scanner.Bytes()
		opponent := decode_play(line[0])
		result := decode_desired_result(line[2])

		// Draw scenario
		me := opponent

		if result == Win {
			me = opponent.nemesis()
		}
		if result == Loss {
			me = opponent.ez()
		}

		score += int(result) + int(me)
	}
	println("Total score:", score)
}
