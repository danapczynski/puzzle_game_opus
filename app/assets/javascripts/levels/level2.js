var position_blocks = function() {
  var blocks = $('.game-block')
  var top = 421
  var left = 45
  for (var x=0; x < blocks.length; x++) {
    blocks.eq(x).css('top', top).css('left', left)
    left += 150
  }
}

var position_solution = function() { 
  $('#solution').css('top', 211).css('left', 225)
}

var position_text = function() {
  $('#solution_text').css('top', 160).append('<p>A larger space to fill...</p>')
  $('#blocks_text').css('top', 350).append('<p>...makes your task considerably more difficult.</p>')
}