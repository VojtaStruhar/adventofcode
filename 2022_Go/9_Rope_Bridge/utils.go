package main

func Sign(number int) int {
	if number < 0 {
		return -1
	}
	if number > 0 {
		return 1
	}
	return 0
}

func Signf(number float64) int {
	if number < 0 {
		return -1
	}
	if number > 0 {
		return 1
	}
	return 0
}
