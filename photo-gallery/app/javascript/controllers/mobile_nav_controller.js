import { Controller } from "@hotwired/stimulus"

// Toggles the .open class on the nav menu when the hamburger is clicked
// and keeps aria-expanded in sync with state for accessibility.
export default class extends Controller {
  static targets = ["menu", "toggle"]

  toggle() {
    const open = this.menuTarget.classList.toggle("open")
    this.toggleTarget.setAttribute("aria-expanded", open ? "true" : "false")
  }
}
