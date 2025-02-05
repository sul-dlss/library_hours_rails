// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"
import * as Popper from "@popperjs/core"
import bootstrap from "bootstrap"
import "@hotwired/turbo-rails"

['load', 'turbo:load'].forEach(event => {
  window.addEventListener(event, function() {
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"][title]')
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
  });
});
