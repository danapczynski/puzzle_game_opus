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
  $('#solution_text').css('top', 140).append('<p>A larger space to fill makes things considerably more difficult.</p>')
  $('#blocks_text').css('top', 350).append('<p>Helpful hint: the "f" key flips the active block to its mirror image.</p>')
}