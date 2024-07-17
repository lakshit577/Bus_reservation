// app/javascript/controllers/validate_date_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dateField", "submitButton"]

  connect() {
    this.submitButtonTarget.addEventListener("click", this.validateDate.bind(this))
  }

  validateDate(event) {
    const dateField = this.dateFieldTarget.value
    if (!dateField) {
      event.preventDefault()
      alert("Please select a valid date")
      // Preventing Turbo from showing the modal
      const modalElement = document.getElementById('seatsModal')
      if (modalElement) {
        const bootstrapModal = bootstrap.Modal.getInstance(modalElement)
        if (bootstrapModal) {
          bootstrapModal.hide()
        }
      }
    }
  }
}