$(function() {
  mainMenu();
});

var mainMenu = function() {
  $('#main_menu').on('ajax:success', function(e, data, status, xhr){
    $('#main_menu').html(data)
  }).on('ajax:complete', function(e){
    var id = e.target.id
    if (id === 'sign-in-button') {
      $('#login_form').submit()
    }
  });
}

