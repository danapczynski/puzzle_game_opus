var activeBlock = []
var allBlocks = []

var gameBlock = function(htmlObject){
  var element = htmlObject
  var filled = $(element).children().children().children('.filled')
  var colors = ['blue', 'green', 'yellow', 'purple', 'orange']
  var activeColor = colors[Math.floor(((Math.random() * colors.length)))]
  var rotDeg = 0
  var hPos = $(element).offset().left
  var vPos = $(element).offset().top
  var home = null
  var rect = null
  var scaleX = 1

  return {
    nextRotation: function() {
      if (rotDeg < 270) {
        return rotDeg += 90
      }
      else {
        return rotDeg = 0
      }
    },
    nextFlip: function() {
      if (scaleX === 1) {
        return scaleX -= 2
      }
      else {
        return scaleX += 2
      }
    },
    flip: function(){
      return this.nextFlip()
    },
    rotate: function(){
      return this.nextRotation()
    },
    set_flip_and_rotate: function(){
      if (scaleX > 0) {
        $(element).css(myTransformProperty, "scaleX(" + scaleX + ") rotate(" + rotDeg + "deg)")
      }
      else {
        $(element).css(myTransformProperty, "scaleX(" + scaleX + ") rotate(" + (rotDeg * -1) + "deg)")
      }
    },
    resetFlipAndRotate: function(){
      rotDeg = 0
      scaleX = 1
      this.set_flip_and_rotate()
    },
    moveRight: function(){
      if (($('#main').offset().left + $('#main').innerWidth()) - ($(element).offset().left + $(element).outerWidth()) > 40) {
        $(element).animate({
          left: "+=30"
        }, 0);
      }
    },
    moveLeft: function(){
      if ($(element).offset().left - $('#main').offset().left > 40) {
        $(element).animate({
          left: "-=30"
        }, 0);
      }
    },
    moveUp: function(){
      if ($(element).offset().top - $('#main').offset().top > 40) {
        $(element).animate({
          top: "-=30"
        }, 0);
      }
    },
    moveDown: function(){
      if (($('#main').offset().top + $('#main').innerHeight()) - ($(element).offset().top + $(element).outerHeight()) > 40) {
        $(element).animate({
          top: "+=30"
        }, 0);
      }
    },
    setColor: function(){
      filled.css('background-color', activeColor)
    },
    toggleColor: function(){
      for (var x = 0; x < filled.length; x++) {
        if (this.isActive()) {
          filled[x].style['background'] = activeColor;
        }
        else {
          filled[x].style['background'] = 'gray';
        }
      };
    },
    deactivate: function(){
      $(element).removeClass('active').addClass('inactive').css('z-index', 2)
      activeBlock = []
    },
    activate: function(){
      $(element).removeClass('inactive').addClass('active').css('z-index', 10)
    },
    clickActivate: function() {
      var that = this
      filled.on('click', function(){
        if ($('.overlap').length === 0) {
          if (activeBlock[0]) { activeBlock[0].deactivate() }
          that.activate()
          activeBlock = [ that ]
        }
      })
    },
    isActive: function() {
      if (activeBlock[0] === this) {
        return true
      }
      else {
        return false
      }
    },
    getRect: function() {
      var rect = []
      filled.each(function(){
        rect.push([$(this).offset().left, $(this).offset().top])
      })
      return rect
    },
    checkOverlap: function() {
      var inactive = []
      $('.inactive .filled').each(function(){
        inactive.push([$(this).offset().left, $(this).offset().top])
      })
      filled.each(function(){
        var that = $(this)
        var coordinates = [$(this).offset().left, $(this).offset().top]
        for (x=0; x<inactive.length; x++) {
          if (coordinates.compare(inactive[x])) {
            that.addClass('overlap')
          }
        }
      })
    },
    overlapStatus: function() {
      if ($(element).find('.overlap').length > 0) {
        return true
      }
      else {
        return false
      }
    },
    compareSolution: function() {
      var rect = this.getRect()
      for (var x=0; x < rect.length; x++) {
        $(filled[x]).attr('class', 'filled')
        for (var y=0; y < solutionRect.length; y++) {
          if (rect[x][0] === solutionRect[y][0] && rect[x][1] === solutionRect[y][1]) {
            $(filled[x]).addClass('fit')
          }
        }
      }
    }
  }
};

var objectify = function() {
  var objects = $('.game-block')
  for (var x = 0; x < objects.length; x++) {
    objects[x].id = ('object' + x)
    var object = gameBlock(objects[x])
    object.clickActivate()
    object.setColor()
    allBlocks.push(object)
  }
}

var clickObscuredObject = function() {
  $('.empty').on('click', function(){
    var active = activeBlock[0]
    var position = [$(this).offset().left, $(this).offset().top]
    if (!active || active.overlapStatus() === false) {
      $('.game-block .filled').each(function(){
        if (position.compare([$(this).offset().left, $(this).offset().top])) {
          this.click()
        }
      })
      if (active === activeBlock[0]) {
        active.deactivate()
      }
    }
  })
}

var activeBehavior = function(){
  document.addEventListener('keydown', function(e){
    if (activeBlock[0]) {
      if (e.keyCode == 32) {
        e.preventDefault();
        activeBlock[0].rotate()
        activeBlock[0].set_flip_and_rotate()
      }
      else if (e.keyCode == 70) {
        e.preventDefault();
        activeBlock[0].flip()
        activeBlock[0].set_flip_and_rotate()
      }
      else if (e.keyCode == 13) {
        e.preventDefault();
        if ($('.overlap').length === 0){
          activeBlock[0].deactivate()
        }
      }
      else if (e.keyCode == 39) {
        e.preventDefault();
        activeBlock[0].moveRight()
      }
      else if (e.keyCode == 37) {
        e.preventDefault();
        activeBlock[0].moveLeft()
      }
      else if (e.keyCode == 38) {
        e.preventDefault();
        activeBlock[0].moveUp()
      }
      else if (e.keyCode == 40) {
        e.preventDefault();
        activeBlock[0].moveDown()
      }
      if (activeBlock[0]) {
        activeBlock[0].compareSolution()
        activeBlock[0].checkOverlap()
      }
    }
    checkForVictory()
  })
}

var clickOffDeactivate = function() {
  $('#main').on('click', function(e){
    if (activeBlock[0] && ($(e.target).attr('class') === undefined)) {
      activeBlock[0].deactivate()
    }
  })
  $('#solution td').on('click', function(e){
    if (activeBlock[0]) {
      activeBlock[0].deactivate()
    }
  })
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
    onVictory()
  }
}

Array.prototype.compare = function(arr) {
  if (!arr) {
    return false
  }
  for (var i = 0, l=this.length; i < l; i++) {
    if (this[i] instanceof Array && arr[i] instanceof Array) {
      if (!this[i].compare(arr[i]))
        return false;
    }
    else if (this[i] != arr[i]) {
      return false;
    }
  }
  return true;
}

/*
 * the setTranformProperty() function was borrowed from
 * Jakub Jankiewicz's JQuery CSS Rotate plugin, whose license
 * information can be found below.
 *
 * JQuery CSS Rotate property using CSS3 Transformations
 * Copyright (c) 2011 Jakub Jankiewicz  <http://jcubic.pl>
 * licensed under the LGPL Version 3 license.
 * http://www.gnu.org/licenses/lgpl.html
 */

var setTransformProperty = function(elem) {
  var properties = ['transform', 'WebkitTransform', 'MozTransform', 'msTransform', 'OTransform'];
  var p;
  while (p = properties.shift()) {
    if (elem.style[p] !== undefined) {
      return p;
    }
  }
  return false;
}
