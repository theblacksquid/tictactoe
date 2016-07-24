ai = {}

ai.read = (gamestate) ->
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

ai.eval = (input) ->
    for point in input.corners
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
            
ai.respond = ->
    if game.players.ai is "X"
        if (game.turns % 2) isnt 0
            choose = ai.eval ai.read(game.state)
            $("cell-#{getX(choose)}-#{getY(choose)}-img").off()
            
    else if game.players.ai is "O"
        if (game.turns % 2) is 0
            choose = ai.eval ai.read(game.state)
            $("cell-#{getX(choose)}-#{getY(choose)}-img").off()
    
            
            
            
            
            
            
            