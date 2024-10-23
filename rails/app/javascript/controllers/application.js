import { Application } from "@hotwired/stimulus";
import ColorPicker from "@stimulus-components/color-picker";
import Notification from "@stimulus-components/notification";

const application = Application.start();
application.register("notification", Notification);
application.register("color-picker", ColorPicker);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
