ai = {}

ai.read = (gamestate) ->
    len = gamestate.length - 1
    result = {}
    result.length = len
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


ai.eval = (input) ->
    pt = input.points.self[getRandInt(0, input.points.self.length)]
    coin_toss = getRandInt(1, 2)
    for key of input.corners
        if key.status is 'unclaimed'
            return value.pos
    
    get_rand = ->
        [(getRandInt(0, input.length)),(getRandInt(0, input.length))]
    
    (->
        if pt is undefined
            return get_rand()
            
        else if coin_toss is 1
            surround = ptsAroundpt(pt)
            for pos in surround
                if pos is undefined
                    break
                if game.state[getX(pos)][getY(pos)] is 'unclaimed'
                    return pos
                    
        else if coin_toss is 2
            surround = ptsAroundpt(pt)
            for pos in surround
                if pos is undefined
                    break
                if game.state[getX(pos)][getY(pos)] is 'unclaimed'
                    return pos
        )()
        
ai.respond = (grd) ->
    state = getCurrentState(grd)
    if game.players.ai is "X"
        if (game.turns % 2) isnt 0
            choose = ai.eval(ai.read state)
            chose_cell = grd.rows[getX(choose)].cells[getY(choose)]
            chose_cell.status = "X"
            $("#cell-#{chose_cell.row}-#{chose_cell.col}-img").attr('src', x_path)
            game.turns = game.turns + 1
            
    else if game.players.ai is "O"
        if (game.turns % 2) is 0
            choose = ai.eval(ai.read state)
            chose_cell = grd.rows[getX(choose)].cells[getY(choose)]
            chose_cell.status = "O"
            $("#cell-#{chose_cell.row}-#{chose_cell.col}-img").attr('src', o_path)
            game.turns = game.turns + 1