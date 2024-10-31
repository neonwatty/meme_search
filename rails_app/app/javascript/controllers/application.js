import { Application } from "@hotwired/stimulus";
import {
  Alert,
  ColorPreview,
  Slideover,
} from "tailwindcss-stimulus-components";

const application = Application.start();
application.register("color-preview", ColorPreview);
application.register("alert", Alert);
application.register("slideover", Slideover);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
