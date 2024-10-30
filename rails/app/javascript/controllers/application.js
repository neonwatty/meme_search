import { Application } from "@hotwired/stimulus";
import { Alert, ColorPreview } from "tailwindcss-stimulus-components";

const application = Application.start();
application.register("color-preview", ColorPreview);
application.register("alert", Alert);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
