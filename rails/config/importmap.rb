# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@stimulus-components/notification", to: "@stimulus-components--notification.js" # @3.0.0
pin "stimulus-use" # @0.52.2
pin "venobox" # @2.1.8
pin "non-stimulus/venobox-init"

pin "tailwindcss-stimulus-components" # @6.1.2
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
