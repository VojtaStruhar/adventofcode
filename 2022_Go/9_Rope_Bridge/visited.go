package main

type VisitedRegistry struct {
	grid map[int]bool
}

func NewVisitedRegistry() *VisitedRegistry {
	vr := new(VisitedRegistry)
	vr.grid = map[int]bool{}
	return vr
}

func (visited *VisitedRegistry) Mark(position *Vector2) {
	// this number encodes the XY coordinates into a single int key
	key := (position.x << 32) | position.y
	visited.grid[key] = true
}

func (visited *VisitedRegistry) Count() int {
	return len(visited.grid)
}

func (visited *VisitedRegistry) Has(position Vector2) bool {
	key := (position.x << 32) | position.y
	return visited.grid[key]
}
