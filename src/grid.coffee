
getX = (tuple) ->
	tuple[0]

getY = (tuple) ->
	tuple[1]

slope = (point1, point2) ->
	switch
		when (getY(point1) - getY(point2)) is 0
			'VERTICAL'
		when (getX(point1) - getX(point2)) is 0
			'HORIZONTAL'
		else ((getY(point1) - getY(point2)) / 
		      (getX(point1) - getX(point2)))

isStraightLine = (lineArr) -> # hopelessly incomplete, like my lovelife
	switch 				      # super WIP, do not use
		when lineArr is [] 
			"EMPTY"
		when  ""  is 0
			true
		else false


