document.addEventListener("DOMContentLoaded", () => {
  setTimeout(() => {
    const mobileMenuButton = document.querySelector("#menu-button");
    const menuButtonHidden = document.querySelector("#menu-button-hidden");
    const menuButtonOpen = document.querySelector("#menu-button-open");
    const mobileMenu = document.querySelector("#mobile-menu");
    let ignoreFirstOutsideClick = true;

    function toggler() {
      menuButtonOpen.classList.toggle("hidden");
      menuButtonHidden.classList.toggle("hidden");
      mobileMenu.classList.toggle("hidden");
    }

    function mobileMenuActions(e) {
      if (!ignoreFirstOutsideClick) {
        if (!mobileMenu.classList.contains("hidden")) {
          if (!mobileMenu.contains(e.target)) {
            toggler();
          } else {
            toggler();
          }
        }
      }
      ignoreFirstOutsideClick = false;
    }

    function toggleMobileMenu(e) {
      toggler();
      if (!mobileMenu.classList.contains("hidden")) {
        ignoreFirstOutsideClick = true;
        document.addEventListener("click", mobileMenuActions);
      } else {
        document.removeEventListener("click", mobileMenuActions);
      }
    }
    mobileMenuButton.addEventListener("click", toggleMobileMenu);
  }, 500);
});
