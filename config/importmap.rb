# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "popper.js", to: "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/esm/popper.min.js"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@4.6.2/dist/js/bootstrap.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.3/dist/jquery.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
