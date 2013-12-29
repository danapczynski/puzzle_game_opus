var position_blocks = function() {
  var blocks = $('.game-block')
  var top = 421
  var left = 75
  for (var x=0; x < blocks.length; x++) {
    blocks.eq(x).css('top', top).css('left', left)
    left += 150
  }
}

var position_solution = function() { 
  $('#solution').css('top', 211).css('left', 225)
}

var position_text = function() {
  $('#solution_text').css('top', 120).append('<h3>HOW TO PLAY</h3><p>Fill this:</p>')
  $('#blocks_text').css('top', 360).append('<p>...with these!</p>')
}