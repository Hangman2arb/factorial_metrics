import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["overlay", "container"]

  openModal() {
    this.overlayTarget.classList.remove("hidden");
    this.containerTarget.classList.remove("hidden");
  }

  closeModal() {
    this.overlayTarget.classList.add("hidden");
    this.containerTarget.classList.add("hidden");
  }

  stopPropagation(event) {
    event.stopPropagation();
  }

}
