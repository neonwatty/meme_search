export function setActive(activeLinkId) {
  const links = document.querySelectorAll("#full-menu a, #mobile-menu a");
  links.forEach((link) => {
    if (activeLinkId !== null && link.id !== null && link.id === activeLinkId) {
      link.classList.add("bg-gray-700"); // Active color
    } else {
      link.classList.remove("bg-gray-700"); // Reset active color
    }
  });
}
