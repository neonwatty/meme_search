// set icon visibility
function iconVisibility(toggle, label) {
  const toggleLabelClasses = label.classList;
  if (toggle.checked) {
    toggleLabelClasses.remove("fa-sun");
    toggleLabelClasses.add("fa-moon");
  } else {
    toggleLabelClasses.remove("fa-moon");
    toggleLabelClasses.add("fa-sun");
  }
}

document.addEventListener("DOMContentLoaded", () => {
  setTimeout(() => {
    // get elements
    const themeToggle = document.getElementById("theme-toggle");
    const toggleLabel = document.getElementById("toggle-label");

    // initial setting
    iconVisibility(themeToggle, toggleLabel);

    // form event handler
    themeToggle.addEventListener("change", () => {
      // change toggle appearance
      iconVisibility(themeToggle, toggleLabel);

      // change theme mode
      document.documentElement.classList.toggle("dark", themeToggle.checked);
    });
  }, 500);
});
