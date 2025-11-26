// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"
import "@popperjs/core"
import bootstrap from "bootstrap"
import "@hotwired/turbo-rails"

;["load", "turbo:load"].forEach(event => {
  window.addEventListener(event, function () {
    const tooltipTriggerList = document.querySelectorAll(
      '[data-bs-toggle="tooltip"][data-bs-title]:not([data-bs-title=""]'
    )
    tooltipTriggerList.forEach(
      tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl)
    )

    const popoverTriggerList = document.querySelectorAll(
      '[data-bs-toggle="popover"]'
    )
    popoverTriggerList.forEach(
      popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl)
    )
  })
})
