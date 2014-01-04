var position_blocks = function() {
  var blocks = $('.game-block')
  var top = 211
  var left = 30
  for (var x=0; x < blocks.length; x++) {
    if (x === 1) {
      left = 450
      top = 301
    }
    if (x === 2) {
      top = 301
      left = 30
    }
    if (x === 3) {
      top = 211
      left = 480
    }
    if (x === 4) {
      left = 210
      top = 301
    }
    if (x === 5) {
      left = 30
      top = 421
    }
    if (x === 6) {
      left = 360
      top = 421
    }
    if (x === 7) {
      left = 150
      top = 421
    }
    if (x === 8) {
      left = 480
      top = 421
    }
    blocks.eq(x).css('top', top).css('left', left)
  }
}

var position_solution = function() { 
  $('#solution').css('top', 181).css('left', 150)
}

var position_text = function() {
  $('#solution_text').css('top', 110).append('<p>Same blocks, different shape. Get to work!</p>')
  $('#blocks_text').css('top', 520).css('left', 328)
}