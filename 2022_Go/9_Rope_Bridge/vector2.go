package main

import "math"

type Vector2 struct {
	x int
	y int
}

func (vec *Vector2) Equals(other Vector2) bool {
	return vec.x == other.x && vec.y == other.y
}

func (vec Vector2) Length() float64 {
	return math.Sqrt(float64(vec.x*vec.x + vec.y*vec.y))
}

func (vec Vector2) Normalized() Vector2F {
	length := vec.Length()
	return Vector2F{
		float64(vec.x) / length,
		float64(vec.y) / length,
	}
}

func (vec Vector2) Multiplied(scalar int) Vector2 {
	return Vector2{
		vec.x * scalar,
		vec.y * scalar,
	}
}

func (vec *Vector2) Multiply(scalar int) {
	vec.x *= scalar
	vec.y *= scalar
}

func (vec *Vector2) Add(other Vector2) {
	vec.x += other.x
	vec.y += other.y
}

// B - A
func (vec *Vector2) StepTo(other Vector2) Vector2 {
	return Vector2{
		other.x - vec.x,
		other.y - vec.y,
	}
}

// First step in a path to approaching the other vector.
// Prioritizes diagnoal steps before orthogonal steps
func (vec *Vector2) StepTowards(other Vector2) Vector2 {
	if vec.Equals(other) {
		return Vector2{0, 0}
	}

	dx := other.x - vec.x
	dy := other.y - vec.y

	return Vector2{
		Sign(dx),
		Sign(dy),
	}

}

func (vec *Vector2) MaxXyDistance(other Vector2) int {
	return int(math.Max(
		math.Abs(float64(vec.x-other.x)),
		math.Abs(float64(vec.y-other.y)),
	))
}

func (vec *Vector2) Move(motion Motion, amount int) {
	vec.Add(motion.toVector2().Multiplied(amount))
}
