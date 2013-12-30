var position_blocks = function() {
  var blocks = $('.game-block')
  var top = 391
  var left = 35
  for (var x=0; x < blocks.length; x++) {
    if (x === 4) {
      top = 511
      left = 215 
    }
    blocks.eq(x).css('top', top).css('left', left)
    left += 150
  }
}

var position_solution = function() { 
  $('#solution').css('top', 211).css('left', 155)
}

var position_text = function() {
  $('#solution_text').css('top', 160).append('<p>Occasionally, space restrictions...</p>')
  $('#blocks_text').css('top', 300).append('<p>...mean someone gets left out of the fun.</p>')
}