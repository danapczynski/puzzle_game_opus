var position_blocks = function() {
  var blocks = $('.game-block')
  var top = 301
  var left = 30
  for (var x=0; x < blocks.length; x++) {
    if (x === 4) {
      top = 421
      left = 120 
    }
    blocks.eq(x).css('top', top).css('left', left)
    left += 150
    if (x === 4) {
      left += 30
    }
  }
}

var position_solution = function() { 
  $('#solution').css('top', 181).css('left', 150)
}

var position_text = function() {
  $('#solution_text').css('top', 140).append('<p>What\'s one more block?')
  $('#blocks_text').css('top', 110)
}