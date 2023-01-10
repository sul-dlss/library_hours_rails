// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
// require rails-ujs
// require turbolinks
// require jquery_nested_form
// require bootstrap-editable
// require bootstrap-editable-rails
// require_tree .


window.addEventListener("load", function() {
  
  // Invoke the editable library
  // Inline mode must be used to work with BS4
  $('.editable').editable({
    mode: 'inline',
    error: function(response, newValue) {
      if(response.status !== 200) {
          return 'Server error. Please check you entered a valid time format (e.g. "9a" or "4pm"), and if so, please check the logs.';
      } else {
          return response.responseText;
      }
    }
  });
  
  $('[data-toggle="tooltip"]').tooltip({
    trigger: 'hover'
  });

  //automatically show next editable
  $('.term-hours .editable').on('save', function(){
      var that = this;
      setTimeout(function() {
          $(that).closest('td').next().find('.editable').editable('show');
      }, 200);
  });

  $('.weekly-hours .editable').on('save', function() {
    $(this).closest('td').addClass('exceptions');
  });
});