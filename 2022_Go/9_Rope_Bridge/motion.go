package main

type Motion int

const (
	Left Motion = iota
	Right
	Up
	Down
)

func (motion Motion) toVector2() Vector2 {
	var result Vector2
	switch motion {
	case Left:
		result = Vector2{-1, 0}
	case Right:
		result = Vector2{1, 0}
	case Up:
		result = Vector2{0, 1}
	case Down:
		result = Vector2{0, -1}
	}
	return result
}

func (motion Motion) toString() string {
	var result string
	switch motion {
	case Left:
		result = "Left"
	case Right:
		result = "Right"
	case Up:
		result = "Up"
	case Down:
		result = "Down"
	}
	return result
}
