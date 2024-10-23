# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@stimulus-components/notification", to: "@stimulus-components--notification.js" # @3.0.0
pin "stimulus-use" # @0.52.2
pin "venobox" # @2.1.8
pin "non-stimulus/venobox-init"

pin "@stimulus-components/color-picker", to: "@stimulus-components--color-picker.js" # @2.0.0
pin "@simonwep/pickr", to: "@simonwep--pickr.js" # @1.9.0
