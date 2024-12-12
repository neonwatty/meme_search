window.addEventListener("scroll", () => {
  const sections = document.querySelectorAll(".section");

  sections.forEach((section) => {
    const rect = section.getBoundingClientRect();

    // Apply a sticky effect when the section reaches the top of the viewport
    if (rect.top <= 0 && rect.bottom >= 0) {
      section.classList.add("sticky", "top-0");
      section.classList.remove("translate-y-20");
    } else {
      section.classList.remove("sticky", "top-0");
      section.classList.add("translate-y-20");
    }
  });
});
