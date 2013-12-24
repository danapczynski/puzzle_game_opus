$(function() {
  objectify()
  activeBehavior()
  populateGrid()  
});

var activeBlock = []
var allBlocks = []

// gameBlock object creator:

var gameBlock = function(htmlObject){
  var element = htmlObject
  var filled = element.getElementsByClassName('filled')
  var colors = ['red', 'blue', 'green', 'yellow', 'purple', 'orange']
  var activeColor = colors[Math.floor(((Math.random() * colors.length)))]
  var rotDeg = 0
  var hPos = 1
  var vPos = 1
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
      element.style['-webkit-transform']=('rotate(' + rotation + 'deg)') 
      element.style['-moz-transform']=('rotate(' + rotation + 'deg)')
      element.style['-o-transform']=('rotate(' + rotation + 'deg)')
      element.style['-ms-transform']=('rotate(' + rotation + 'deg)')
    },
    moveRight: function(){
      element.style['left'] = ((hPos += 30) + 'px');
    },
    moveLeft: function(){
      element.style['left'] = ((hPos -= 30) + 'px');
    },
    moveUp: function(){
      element.style['top'] = ((vPos -= 30) + 'px');
    },
    moveDown: function(){
      element.style['top'] = ((vPos += 30) + 'px');
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
      element.className = 'object game-block'
      element.style['z-index'] = 0
      activeBlock = []
      this.toggleColor()
    },
    activate: function(){
      element.className += ' active'
      element.style['z-index'] = 10
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
      for (x=0; x < filled.length; x++) {
        rect.push(filled[x].getBoundingClientRect());
      }
      return rect
    },
    compareSolution: function() {
      var rect = this.getRect()
      for (var x=0; x < rect.length; x++) {
        filled[x].className = 'filled'
        for (var y=0; y < solutionLocation.length; y++) {
          if ((rect[x].top === solutionLocation[y].top) && (rect[x].left === solutionLocation[y].left)) {
            filled[x].className += ' fit'
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
    var active = $('.active')[0]
    console.log(e.keyCode)
    if (e.keyCode == 32) {
      e.preventDefault();
      activeBlock[0].rotate()
    }
    if (e.keyCode == 13) {
      e.preventDefault();
      activeBlock[0].deactivate()
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
    activeBlock[0].compareSolution()
  })
}

var solutionLocation = function() {
  var rect = []
  var filled = $('#solution .filled')
  for (x=0; x < filled.length; x++) {
    rect.push(filled[x].getBoundingClientRect());
  }
  return rect
}()

