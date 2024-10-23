import { Application } from "@hotwired/stimulus";
import Notification from "@stimulus-components/notification";
import { ColorPreview } from "tailwindcss-stimulus-components";

const application = Application.start();
application.register("notification", Notification);
application.register("color-preview", ColorPreview);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
