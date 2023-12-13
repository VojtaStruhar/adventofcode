package main

func decode_play(c byte) Play {
	if c == 'A' || c == 'X' {
		return Rock
	}
	if c == 'B' || c == 'Y' {
		return Paper
	}
	// This isn't _really_ correct, but since I know the input is OK...
	return Scissors
}

func decode_desired_result(c byte) GameResult {
	if c == 'X' {
		return Loss
	}
	if c == 'Y' {
		return Draw
	}
	// This isn't _really_ correct, but since I know the input is OK...
	return Win
}

type Play int

const (
	Rock     Play = 1
	Paper    Play = 2
	Scissors Play = 3
)

func (play Play) nemesis() Play {
	if play == Rock {
		return Paper
	}
	if play == Paper {
		return Scissors
	}

	// Scissors
	return Rock
}
func (play Play) ez() Play {
	if play == Rock {
		return Scissors
	}
	if play == Paper {
		return Rock
	}

	// Scissors
	return Paper
}

func (myself Play) fight(opponent Play) GameResult {
	if opponent == myself.ez() {
		return Win
	}
	if opponent == myself.nemesis() {
		return Loss
	}
	return Draw
}

type GameResult int

const (
	Loss GameResult = 0
	Draw GameResult = 3
	Win  GameResult = 6
)
