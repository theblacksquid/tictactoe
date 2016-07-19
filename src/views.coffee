
turn = 1

class Cell 
	constructor: (@el, @col, @row) ->
		@status = 'unclaimed'
	
	template: ->
		"""
		<div class='cell' id='cell-#{@row}-#{@col}' style='display: inline-block'>
			<img id='cell-#{@row}-#{@col}-img' src='icons/ic_crop_din_black_24dp/web/ic_crop_din_black_24dp_2x.png' />
		</div>
		"""
	
	render: ->
		$(@el).append @template()
		@onClick()
	
	onClick: () ->
		self = @
		$("#cell-#{@row}-#{@col}-img").click(->
			if self.status is 'unclaimed'
				if (turn % 2) is 0
					self.status = 'claimed-X'
					$("#cell-#{self.row}-#{self.col}-img")
						.attr("src", "icons/ic_block_black_24dp/web/ic_block_black_24dp_2x.png")
					turn++
				else 
					self.status = 'claimed-O'
					$("#cell-#{self.row}-#{self.col}-img")
						.attr("src", "icons/ic_clear_black_24dp/web/ic_clear_black_24dp_2x.png")							
					turn++
			else console.log("claimed cell clicked")
		)

class Row
	constructor: (@el, @rownum, @numcells) ->
		@cells = []
	
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
		$(@el).append @template()
		@generateRows(@numrows)
		
	generateRows: (rownums) ->
		i = 0
		while rownums > i
			row = new Row("#game-grid", i, rownums)
			@rows.push row
			row.render()
			i++


















