// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"
import "popper.js"

import jquery from 'jquery'
window.$ = jquery

import "bootstrap"
import "@hotwired/turbo-rails"

window.addEventListener("load", function() {
  jquery('[data-toggle="tooltip"]').tooltip({
    trigger: 'hover'
  });
});