import { Controller } from "@hotwired/stimulus"

// Optimistically flips the star icon and bumps the count when the user
// clicks the like button. The Turbo Frame response reconciles the UI
// with the server's truth once the request returns.
export default class extends Controller {
  static targets = ["icon", "count"]
  static values = {
    liked: Boolean,
    lineUrl: String,
    fillUrl: String
  }

  toggle() {
    this.likedValue = !this.likedValue
    this.iconTarget.src = this.likedValue ? this.fillUrlValue : this.lineUrlValue
    this.iconTarget.alt = this.likedValue ? "Unlike" : "Like"
    const current = parseInt(this.countTarget.textContent, 10) || 0
    this.countTarget.textContent = current + (this.likedValue ? 1 : -1)
    this.element.classList.toggle("liked", this.likedValue)
  }
}
