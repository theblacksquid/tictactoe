
didPlayerWin = (player, gamestate) ->
    i = 0
    while gamestate.length > i
        horiz = lineFromGrid(gamestate, "HORIZONTAL", i)
        vert = lineFromGrid(gamestate, "VERTICAL", i)
        diag = lineFromGrid(gamestate, "DIAGONAL", 0)
        anti = lineFromGrid(gamestate, "ANTI-DIAG", 0)
        arr = [horiz,vert,diag,anti]
        for item in arr
            if (pointsEq(item) is true) and (item[0] is player)
                return true
        i++
    false

evalGame = (gamestate, player1, player2) ->
    non_null = flatten(gamestate).filter((x) ->
            if x isnt undefined or "" or null or "unclaimed"
                true
        )
    cells = flatten(gamestate).length
    if didPlayerWin(player1, gamestate)
        "#{player1} wins"
    else if didPlayerWin(player2, gamestate)
        "#{player2} wins"
    else if non_null.length is cells
        "DRAW"
    else "CONTINUE"
    

