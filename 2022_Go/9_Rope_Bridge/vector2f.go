package main

import "math"

type Vector2F struct {
	x float64
	y float64
}

func (vec Vector2F) Rounded() Vector2 {
	return Vector2{
		int(math.Round(vec.x)),
		int(math.Round(vec.y)),
	}
}

func (vec Vector2F) Floored() Vector2 {
	return Vector2{
		int(math.Floor(math.Abs(vec.x))) * Signf(vec.x),
		int(math.Floor(math.Abs(vec.y))) * Signf(vec.y),
	}
}

func (vec Vector2F) Ceiled() Vector2 {
	return Vector2{
		int(math.Ceil(math.Abs(vec.x))) * Signf(vec.x),
		int(math.Ceil(math.Abs(vec.y))) * Signf(vec.y),
	}
}
