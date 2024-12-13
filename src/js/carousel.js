// Next/previous controls
export function plusSlides(n) {
  showSlides((slideIndex += n));
}

// Thumbnail image controls
export function currentSlide(n) {
  showSlides((slideIndex = n));
}

let slideIndex = 1;

export function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  let dots = document.getElementsByClassName("dot");
  if (n > slides.length) {
    slideIndex = 1;
  }
  if (n < 1) {
    slideIndex = slides.length;
  }
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex - 1].style.display = "block";
  dots[slideIndex - 1].className += " active";
}

document.addEventListener("DOMContentLoaded", () => {
  setTimeout(() => {
    showSlides(slideIndex);
  }, 1200);
});
