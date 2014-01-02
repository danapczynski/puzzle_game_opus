$(function() {
  armHelpButton()
  position_blocks()      // See level-specific JS file 
  position_solution()    // See level-specific JS file
  position_text()        // See level-specific JS file
  myTransformProperty = setTransformProperty($('td').first()[0]) // See blocks.js
  objectify()            // See blocks.js
  activeBehavior()       // See blocks.js
  clickObscuredObject()  // See blocks.js
  clickOffDeactivate()   // See blocks.js
  startTimer()
  resizableSolution() 
  solutionRect = solutionLocation()
});

// Game setup functions:

var armHelpButton = function(){
  $('#help').hide()
  $('#help-button').on('click', function(e){
    e.preventDefault()
    if ($('#help').is(':hidden')) {
      $('#help').slideToggle('fast');
      $('#help-button').text('Go Back');
      $('#current_seconds').attr('id', 'paused');
    }
    else {
      $('#help').slideToggle('fast');
      $('#help-button').text('Help!');
      $('#paused').attr('id', 'current_seconds');
    }
  })
}

var startTimer = function(){
  var getTime = function(){
    return Number($('#current_seconds').text())
  }
  setInterval(function(){
    $('#current_seconds').text(getTime() + 1)
  }, 1000);
}

var stopTimer = function(){
  $('#current_seconds').attr('id', '')
}

var solutionLocation = function() {
  var rect = []
  var index = 0
  var filled = $('#solution .filled')
  filled.each(function(){
    rect.push([$(this).offset().left, $(this).offset().top])
  })
  return rect
}

var resizableSolution = function() {
  $(window).resize(function(){
    solutionRect = solutionLocation()
  })
}

var checkForVictory = function() {
  if (($('#solution .filled').length === $('.game-block .fit').length) && $('.overlap').length === 0) {
    activeBlock[0].deactivate()
    $('#comp_time').val($('#current_seconds').text())
    stopTimer()
    $('#score_form form').submit()
    $('#solution_text').html('')
    $('#blocks_text').html('<h3>Congratulations!</h3>')
    $('#next_level_link').show()
  }
}



