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
        result
    catch e
        console.log gamestate
        console.error e

ai.eval = (input) ->
    for item,point in input.corners
        if point.status is 'unclaimed'
            return point.pos
    
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
    if game.players.ai is "X"
        if (game.turns % 2) isnt 0
            try
                choose = ai.eval(ai.read(getCurrentState(grd)))
                chose_cell = grd.rows[getX(choose)].cells[getY(choose)]
                chose_cell.status = "X"
                $("#cell-#{chose_cell.row}-#{chose_cell.col}-img").attr('src', x_path)
                game.turns = game.turns + 1
            catch e
                console.log "grd: "
                console.log grd
                console.log "getCurrentState: "
                console.log getCurrentState(grd)
                console.log "game.state: "
                console.log game.state
                console.log "ai.read(game.state): "
                console.log ai.read(game.state)
                console.log "choose: " 
                console.log choose
                console.error e
            
    else if game.players.ai is "O"
        if (game.turns % 2) is 0
            try
                choose = ai.eval(ai.read(getCurrentState(grd)))
                chose_cell = grd.rows[getX(choose)].cells[getY(choose)]
                chose_cell.status = "O"
                $("#cell-#{chose_cell.row}-#{chose_cell.col}-img").attr('src', o_path)
                game.turns = game.turns + 1
            catch e
                console.log "grd: "
                console.log grd
                console.log "getCurrentState: "
                console.log getCurrentState(grd)
                console.log "game.state: "
                console.log game.state
                console.log "ai.read(game.state): "
                console.log ai.read(game.state)
                console.log "choose: " 
                console.log choose
                console.error e
