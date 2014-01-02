$(function() {
  armHelpButton()
  startTimer()
  position_blocks()      // See level-specific JS file 
  position_solution()    // See level-specific JS file
  position_text()        // See level-specific JS file
  myTransformProperty = setTransformProperty($('td').first()[0]) // See blocks.js
  objectify()            // See blocks.js
  activeBehavior()       // See blocks.js
  clickObscuredObject()  // See blocks.js
  clickOffDeactivate()   // See blocks.js
  resizableSolution()    // See blocks.js
  solutionRect = solutionLocation() // See blocks.js
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

var onVictory = function(){
  activeBlock[0].deactivate()
  $('#comp_time').val($('#current_seconds').text())
  stopTimer()
  $('#score_form form').submit()
  $('#solution_text').html('')
  $('#blocks_text').html('<h3>Congratulations!</h3>')
  $('#next_level_link').show()
}




