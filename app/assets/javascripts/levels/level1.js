var position_blocks = function() {
  var blocks = $('.game-block')
  var top = 421
  var left = 91
  for (var x=0; x < blocks.length; x++) {
    blocks.eq(x).css('top', top).css('left', left)
    left += 150
  }
}

var position_solution = function() {
  var solution = $('#solution')
  solution.css('top', 151).css('left', 241)
}