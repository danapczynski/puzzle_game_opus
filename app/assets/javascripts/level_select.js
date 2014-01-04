$(function() {
  levelSelect.positionSolutions()
  levelSelect.hoverSolution()
  levelSelect.displayFirstLevelButtons()
  levelSelect.nextButton()
  levelSelect.prevButton()
});

levelSelect = {}

levelSelect.buttonIndex = $('.object').length

levelSelect.numberOfOptions = $('.object').length

levelSelect.displayFirstLevelButtons = function() {
  $('.object').hide()
  $('ul li').hide()
  $('.object').last().show()
  $('ul li').last().show()
  $('#next').hide()
  $('#prev').width(400)
  if (levelSelect.numberOfOptions === 1) {
    $('#prev').hide()
  }
}

levelSelect.positionSolutions = function() {
  for (var x=0; x < $('.object').length; x++) {
    var left = ((600 - $('.object').eq(x).width()) / 2)
    var top = (160 + (300 - $('.object').eq(x).height()) / 2)
    $('.object').eq(x).css('left', left).css('top', top)
  }
}

levelSelect.nextButton = function() {
  $('#next').on('click', function(e){
    e.preventDefault();
    $('#next').width(195)
    $('#prev').show()
    $('ul li:nth-child(' + levelSelect.buttonIndex + ') table').hide()
    $('ul li:nth-child(' + levelSelect.buttonIndex + ')').hide()
    levelSelect.advanceIndex()
    $('ul li:nth-child(' + levelSelect.buttonIndex + ') table').show()
    $('ul li:nth-child(' + levelSelect.buttonIndex + ')').show()
    if (levelSelect.buttonIndex === levelSelect.numberOfOptions) {
      $('#next').hide()
      $('#prev').width(400)
    }
  })
}

levelSelect.prevButton = function() {
  $('#prev').on('click', function(e){
    e.preventDefault();
    $('#prev').width(195)
    $('#next').show()
    $('ul li:nth-child(' + levelSelect.buttonIndex + ') table').hide()
    $('ul li:nth-child(' + levelSelect.buttonIndex + ')').hide()
    levelSelect.rewindIndex()
    $('ul li:nth-child(' + levelSelect.buttonIndex + ') table').show()
    $('ul li:nth-child(' + levelSelect.buttonIndex + ')').show()
    if (levelSelect.buttonIndex === 1) {
      $('#prev').hide()
      $('#next').width(400)
    }
  })
}

levelSelect.advanceIndex = function() {
  if (levelSelect.buttonIndex < levelSelect.numberOfOptions) {
    levelSelect.buttonIndex += 1
      }
  else {
    levelSelect.buttonIndex = levelSelect.numberOfOptions
  }
}

levelSelect.rewindIndex = function() {
  if (levelSelect.buttonIndex > 1) {
    levelSelect.buttonIndex -= 1
      }
  else {
    levelSelect.buttonIndex = 1
  }
}

levelSelect.hoverSolution = function() {
  $('#main').on('mouseover', '.level_select_button', function(){
    $('.filled:visible').css('background-color', '#476200').css('box-shadow', 'inset 1px 1px #222200, inset -1px -1px #222200')
  }).on('mouseout', '.level_select_button', function(){
    $('.filled:visible').css('background-color', '#222200').css('box-shadow', 'inset 1px 1px #476200, inset -1px -1px #476200')
  })
}