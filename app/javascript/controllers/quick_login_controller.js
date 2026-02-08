import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["email", "password"]

  fill(event) {
    const { email, password } = event.currentTarget.dataset
    this.emailTarget.value = email
    this.passwordTarget.value = password
  }
}
