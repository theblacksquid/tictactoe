
getX = (pt) ->
	pt[0]

getY = (pt) ->
	pt[1]

slope = (point1, point2) ->
	switch
		when (getY(point1) - getY(point2)) is 0
			'VERTICAL'
		when (getX(point1) - getX(point2)) is 0
			'HORIZONTAL'
		else ((getY(point1) - getY(point2)) / 
		      (getX(point1) - getX(point2)))

lineFromGrid = (grid, direction) ->
    length = grid.length
    cache = []
    i = 0
    switch 
        when direction is 'HORIZONTAL'
            grid[0]
        when direction is 'VERTICAL'
            for row in grid
                cache.push row[0]
            cache
        when direction is 'DIAGONAL'
            while length > i
                cache.push grid[i][i]
                i++
            cache
        when direction is 'ANTI-DIAG'
            while length > i
                cache.push grid[i][(length - 1) - i]
                i++
            cache

pointsEq = (lineArr) ->
    i = 0
    while lineArr.length > i
        if lineArr[i] isnt lineArr[0]
            return false
        i++
    true
        

