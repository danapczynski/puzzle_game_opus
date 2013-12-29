$(function() {
  position_blocks()    // See level-specific JS file 
  position_solution()  // See level-specific JS file
  position_text()      // See level-specific JS file
  solutionRect = solutionLocation()
  objectify()
  activeBehavior()
  populateGrid()
  resizableSolution() 
});

var activeBlock = []
var allBlocks = []

// gameBlock object creator:

var gameBlock = function(htmlObject){
  var element = htmlObject
  var filled = $(element).children().children().children('.filled')
  var colors = ['red', 'blue', 'green', 'yellow', 'purple', 'orange']
  var activeColor = colors[Math.floor(((Math.random() * colors.length)))]
  var rotDeg = 0
  var hPos = $(element).offset().left
  var vPos = $(element).offset().top
  var home = null
  var rect = null

  return {
    nextRotation: function() {
      if (rotDeg < 270) {
        return rotDeg += 90
      }
      else {
        return rotDeg = 0
      }
    },
    rotate: function(){
      var rotation = this.nextRotation()
      $(element).css('rotate', rotation)
    },
    moveRight: function(){
      $(element).animate({
        left: "+=30"
      }, 0);
    },
    moveLeft: function(){
      $(element).animate({
        left: "-=30"
      }, 0);
    },
    moveUp: function(){
      $(element).animate({
        top: "-=30"
      }, 0);
    },
    moveDown: function(){
      $(element).animate({
        top: "+=30"
      }, 0);
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
      this.toggleColor()
    },
    activate: function(){
      $(element).removeClass('inactive').addClass('active').css('z-index', 10)
    },
    clickActivate: function() {
      var that = this
      element.addEventListener('click', function(){
        if (activeBlock[0]) { activeBlock[0].deactivate() }
        that.activate()
        activeBlock = [ that ]
        that.toggleColor()
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

// Game setup functions:

var objectify = function() {
  var objects = $('.game-block')
  for (var x = 0; x < objects.length; x++) {
    objects[x].id = ('object' + x)
    var object = gameBlock(objects[x])
    object.clickActivate()
    allBlocks.push(object)
  }
}

var populateGrid = function(){
  var grid = $('#game-grid')
  for (var y=0; y < 32; y++) {
    var row = "<tr class='grid-row'>"
    for (var x=0; x < 32; x++) {
      row += "<td class='grid-cell'></td>"
    }
    row += "</tr>"
    grid.append(row)
  }
}

var activeBehavior = function(){
  document.addEventListener('keydown', function(e){
    if (activeBlock[0]) {
      if (e.keyCode == 32) {
        e.preventDefault();
        activeBlock[0].rotate()
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
  if (($('.game-block .filled').length === $('.game-block .fit').length) && $('.overlap').length === 0) {
    activeBlock[0].deactivate()
    $('#solution_text').html('')
    $('#blocks_text').html('<h3>Congratulations!</h3>')
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