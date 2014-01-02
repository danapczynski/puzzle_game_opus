$(function() {
  myTransformProperty = setTransformProperty($('td').first()[0]) // See blocks.js
  objectify()            // See blocks.js
  activeBehavior()       // See blocks.js
  clickObscuredObject()  // See blocks.js
  clickOffDeactivate()   // See blocks.js
  positionDemo()
  armDemo()
  resizableSolution()
});

var positionDemo = function(){
  $('.game-block').css('top', 190).css('left', 240)
  $('#demo_text').css('top', 150)
  $('#solution').css('top', 300).css('left', 240)
}

var armDemo = function(){
  $('#main_menu_demo').on('click', function(e){
    e.preventDefault();
    $(this).hide()
    $('#main_menu').css('margin-top', '300px')
    $('#demo').show()
    demo(0)
  })
}

var phase0 = function(){
  $('#demo_text').text('Hit the space bar to rotate.')
  demo(1)
}

var phase1 = function(e) {
  if (activeBlock[0] && e.keyCode === 32) {
    $('#demo_text').text('Use the arrow keys to move around.')
    demo(2)
  }
}

var phase2 = function(e) {
  if (activeBlock[0] && (e.keyCode >= 37 && e.keyCode <= 40)) {
    $('#demo_text').text('Press the "f" key to flip the block to its mirror image.')
    demo(3)
  }
}

var phase3 = function(e) {
  if (activeBlock[0] && e.keyCode === 70) {
    $('#demo_text').text('Hit the "return" key to deselect a block.')
    demo(4)
  }
}

var phase4 = function(e) {
  if (e.keyCode === 13) {
    $('#demo_text').text('Nice work! Now try placing the block inside the gray solution area.')
    $('#demo_solution').show()
    allBlocks[0].resetFlipAndRotate()
    $('.game-block').css('top', 180).css('left', 240)
    solutionRect = solutionLocation()
    demo(5)
  }
}

var demo = function(phase){
  if (phase === 0) {
    $('.game-block').on('click', phase0)
  }
  else if (phase === 1) {
    $('.game-block').off('click', phase0)
    $(document).on('keydown', phase1)
  }
  else if (phase === 2) {
    $(document).off('keydown', phase1)
    $(document).on('keydown', phase2)
  }
  else if (phase === 3) {
    $(document).off('keydown', phase2)
    $(document).on('keydown', phase3)
  }
  else if (phase === 4) {
    $(document).off('keydown', phase3)
    $(document).on('keydown', phase4)
  }
  else if (phase === 5) {
    $(document).off('keydown', phase4)
  }
}

var onVictory = function() {
  activeBlock[0].deactivate()
  $('#demo_text').text('Victory! Now sign in and solve some puzzles.')
}

