ai = {}

ai.read = (gamestate) ->
    try
        len = gamestate.length - 1
        result = {}
        result.corners = {
            "0-0": {
                'status': gamestate[0][0]
                "pos": [0, 0]
            }
            "0-max": {
                'status': gamestate[0][len]
                'pos': [0, len]
            }
            "max-max": {
                'status': gamestate[len][len]
                'pos': [len, len]
            }
            "max-0": {
                'status': gamestate[len][0]
                'pos': [len, 0]
            }
        }
        result.points = {
            self: ptIndex(gamestate, game.players.ai),
            opponent: ptIndex(gamestate, game.players.human)
        }
    catch e
        console.error e
        console.log gamestate

ai.eval = (input) ->
    for key,value in input.corners
        if value.status is 'unclaimed'
            return value.pos
    
    if getRandInt(1, 2) is 1
        pt = input.points.self[getRandInt(0, input.points.self.length)]
        surround = ptsAroundpt(pt)
        for pos in surround
            if game.state[getX(pos)][getY(pos)] is 'unclaimed'
                return pos
        
    else
        pt = input.points.opponent[getRandInt(0, input.points.opponent.length)]
        surround = ptsAroundpt(pt)
        for pos in surround
            if game.state[getX(pos)][getY(pos)] is 'unclaimed'
                return pos
            
ai.respond = (grd) ->
    state = getCurrentState(grd)
    if game.players.ai is "X"
        if (game.turns % 2) isnt 0
            choose = ai.eval(state)
            chose_cell = grd.rows[getX(choose)].cells[getY(choose)]
            chose_cell.status = "X"
            $("#cell-#{chose_cell.row}-#{chose_cell.col}-img").attr('src', x_path)
            game.turns = game.turns + 1
            
    else if game.players.ai is "O"
        if (game.turns % 2) is 0
            choose = ai.eval(state)
            chose_cell = grd.rows[getX(choose)].cells[getY(choose)]
            chose_cell.status = "O"
            $("#cell-#{chose_cell.row}-#{chose_cell.col}-img").attr('src', o_path)
            game.turns = game.turns + 1
            
            