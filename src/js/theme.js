document.addEventListener("DOMContentLoaded", () => {
  setTimeout(() => {
    // get elements
    const themeToggle = document.getElementById("theme-toggle");

    const toggleLabel = document.getElementById("toggle-label");
    const toggleLabelClasses = toggleLabel.classList;

    // set icon visibility
    function iconVisibility() {
      if (themeToggle.checked) {
        toggleLabelClasses.remove("fa-sun");
        toggleLabelClasses.add("fa-moon");
      } else {
        toggleLabelClasses.remove("fa-moon");
        toggleLabelClasses.add("fa-sun");
      }
    }

    // initial setting
    iconVisibility();

    // form event handler
    themeToggle.addEventListener("change", () => {
      // change toggle appearance
      iconVisibility();

      // change theme mode
      document.documentElement.classList.toggle("dark", this.checked);
    });
  }, 100);
});
