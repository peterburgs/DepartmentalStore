const current = document.querySelector("#current");
const imgs = document.querySelector(".imgs");
const img = document.querySelectorAll(".imgs img");
const opacity = 0.6;
// Set first img opacity
img[0].style.opacity = opacity;

imgs.addEventListener("click", imgClick);

function imgClick(e) {
  // Reset the opacity
  img.forEach(img => (img.style.opacity = 1));

  // Change current image to src of clicked image

  if (e.target.src !== undefined) {
    current.src = e.target.src;
    // Add fade in class
    current.classList.add("fade-in");

    // Remove fade-in class after .5 seconds
    setTimeout(() => current.classList.remove("fade-in"), 200);

    // Change the opacity to opacity var
    e.target.style.opacity = opacity;
  }
}
