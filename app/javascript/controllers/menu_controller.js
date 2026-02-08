import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mobileNav"]

  toggle() {
    this.mobileNavTarget.classList.toggle("hidden")
  }
}
