$(function() {
  mainMenu();
  signInButton();
});

var mainMenu = function() {
  $(main_menu_login).on('ajax:success', function(e, data){
    e.preventDefault();
    $('#container').html(data)
  })
  $(main_menu_create).on('ajax:success', function(e, data){
    e.preventDefault();
    $('#container').html(data)
  })
}

var signInButton = function() {
  $('#sign-in-button').on('click', function(e){
    e.preventDefault();
    $('#login_form').submit()
  });
};