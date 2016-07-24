
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
            if x isnt "unclaimed"
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
    
getCurrentState = (grid) ->
    rows = grid.rows
    state = []
    for row in rows
        cache = []
        for cell in row.cells
            cache.push cell.status
        state.push cache
    state
    
game = {}

game.state = []

game.turns = 1

game.over = (grid) ->
    for row in grid.rows
        for cell in row.cells
            $("#cell-#{cell.row}-#{cell.col}-img").off()
    game.turns = 1

game.players = {
    human: ""
    ai: ""
}

game.obj = {}
    
game.main = (parent, num) ->
    grd = new Grid(parent, num)
    grd.render()
    game.state = getCurrentState(grd)
    isState = "CONTINUE"
    for row in grd.rows
        for cell in row.cells
            $("#cell-#{cell.row}-#{cell.col}-img").click(->
                game.state = getCurrentState(grd)
                ai.respond(grd)
                result = evalGame(game.state, "X", "O")
                if result isnt "CONTINUE"
                    game.over(grd)
                    $("#status").html "Tic Tac Toe | #{result}"
                    newGame = new SelectModal("#leftmenu")
                    newGame.render()
                )
    game.state = getCurrentState(grd)
    ai.respond(grd)
