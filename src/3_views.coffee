

o_path = 'icons/ic_block_black_24dp/web/ic_block_black_24dp_2x.png'
x_path = 'icons/ic_clear_black_24dp/web/ic_clear_black_24dp_2x.png'
box_path = 'icons/ic_crop_din_black_24dp/web/ic_crop_din_black_24dp_2x.png'

class Cell 
	constructor: (@el, @col, @row) ->
        @status = 'unclaimed'
        @id = "cell-#{@row}-#{@col}"
        
	template: ->
		"""
        <div class='cell' id='cell-#{@row}-#{@col}' style='display: inline-block'>
			<img id='cell-#{@row}-#{@col}-img' src='#{box_path}' />
		</div>
		"""
	
	render: ->
		$(@el).append @template()
		@onClick()
	
	onClick: ->
		self = @
		$("#cell-#{@row}-#{@col}-img").click(->
			if self.status is 'unclaimed'
				if (game.turns % 2) is 0
					self.status = 'O'
					$("#cell-#{self.row}-#{self.col}-img")
						.attr("src", o_path)
					game.turns++
				else 
					self.status = 'X'
					$("#cell-#{self.row}-#{self.col}-img")
						.attr("src", x_path)							
					game.turns++
			else console.log("claimed cell clicked")
		)

class Row
	constructor: (@el, @rownum, @numcells) ->
        @cells = []
        @id = "row-#{@rownum}"
    
	template: ->
		"""
		<div id='row-#{@rownum}'>
		</div>
		"""
	
	render: ->
		$(@el).append @template()
		@generateCells(@numcells)
	
	generateCells: (cellnums) ->
		i = 0
		while cellnums > i
			cell = new Cell("#row-#{@rownum}",@rownum,i)
			@cells.push cell
			cell.render()
			i++

class Grid
	constructor: (@el, @numrows) ->
		@rows = []
	
	template: ->
		"""
		<div id='game-grid'>
		</div>
		"""
	
	render: ->
		$(@el).html @template()
		@generateRows(@numrows)
		
	generateRows: (rownums) ->
		i = 0
		while rownums > i
			row = new Row("#game-grid", i, rownums)
			@rows.push row
			row.render()
			i++

class SelectModal
	constructor: (@el) ->
	
	template: ->
		"""
		<div class='w3-container'>
			<div class='w3-row'>
				<div class='w3-container w3-half'>
					<input type='image' id='choose-x' src='#{x_path}' class='w3-hover-light-gray' /> <br />
					Go First
				</div>
				<div class='w3-container w3-half'>
					<input type='image' id='choose-o' src='#{o_path}' class='w3-hover-light-gray' /> <br />
					Go Second
				</div>
			</div>
		</div>
		"""
	
	render: ->
		$(@el).html @template()
		@chooseTurn()
		
	chooseTurn: ->
		self = @
		$('#choose-x').click(->
			game.players.human = "X"
			game.players.ai = "O"
			main = new MainModal("#leftmenu")
			main.render()
			)
			
		$('#choose-o').click(->
			game.players.human = "O"
			game.players.ai = "X"
			main = new MainModal("#leftmenu")
			main.render()
			)

class MainModal
	constructor: (@el) ->
		
	template: ->
		"""
		<div>
			<input id='menu-val' type='text' placeholder='Number of Rows' class='w3-input w3-border w3-hover-light-grey'/> <br />
			<button id='menu-btn' class='w3-btn-block'>START</button> 
			<br />
			<p>Indicate the number of rows you want the
			game's grid to have, and it will create
			a grid that has that number of rows squared
			amount of cells. A minimum of 3 is required.</p>
		</div>
		"""
		
	render: ->
		$(@el).html @template()
		@onStart()
		

	onStart: ->
		$("#menu-btn").click(->
			if $("#menu-val").val() < 3
            	$("#status").html "Tic Tac Toe | A minimum of three rows are required"
            	console.log $("#menu-val").val()
            else
				game.main("#game", $("#menu-val").val())
				$("#status").html "Tic Tac Toe |"
				$('#menu-btn').off()
				console.log $("#menu-val").val() + " proper"
			)

class App 
	constructor: (@el) ->
	
	template: ->
		"""
		<div class='w3-container'>
			<div class='w3-container w3-black'>
				<h2 id='status'>Tic Tac Toe | </h2>
			</div>
			<div id='main-screen' class='w3-container w3-row'>
				<div id='leftmenu' class='w3-container w3-third' style='padding-top: 16px'>
				</div>
				<div id='game' class='w3-container w3-rest w3-center'>
				</div>
			</div>
		</div>
		"""
	
	render: ->
		$(@el).html @template()
		leftmenu = new SelectModal("#leftmenu")
		leftmenu.render()
