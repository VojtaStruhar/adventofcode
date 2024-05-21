This was a cumbersome one. I've done plenty of these map-traversal tasks at this point. 
Both for AOC and for school. And I never quite know how to approach this in an elegant way.
In the end I still end up with 4-direction checking and indexing into the game state and lots
of very specific if statements everywhere... oh well.

My approach for this one is to just count the length of the entire loop (traverse it tile by
tile) and then divide it by two - that's the farthest point.

