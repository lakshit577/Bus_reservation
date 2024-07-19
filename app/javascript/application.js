// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require popper
//= require bootstrap
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"

document.addEventListener("turbo:load", () => {
    const modalElement = document.getElementById('seatsModal');
    if (modalElement) {
      new bootstrap.Modal(modalElement);
    }
  });