import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hello"
export default class extends Controller {
  connect() {
    
    
  }

  colorChange(event) {
    debugger
    const checkbox = event.target;
    const seatDiv = checkbox.closest('.seat-checkbox');
  
    if (checkbox.checked) {
    
      seatDiv.style.backgroundColor = 'violet'; 
    } else {
      seatDiv.style.backgroundColor = ''; 
    }
  }
}