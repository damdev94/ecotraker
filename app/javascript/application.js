// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener("DOMContentLoaded", () => {
  const checkAllBox = document.getElementById("check-all");
  const dayCheckboxes = document.querySelectorAll(".days-section input[type='checkbox']")

  checkAllBox.addEventListener("change", () => {
    dayCheckboxes.forEach(checkbox => {
      checkbox.checked = checkAllBox.checked
    })
  })
})
