import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="connections"
export default class extends Controller {
  static targets = ["like"]
  connect() {
  }
  
  initialize() {
    this.element.setAttribute("data-action", "click->likes#prepareLikeParams")
  }

  prepareLikeParams(event) {
    event.preventDefault()
    this.url = this.element.getAttribute("href")
    const element = this.element
    const postId = element.dataset.postId
    const userId = element.dataset.userId
    
    const connectionBody = new FormData()
    connectionBody.append("like[user_id]", userId)
    connectionBody.append("like[post_id]", postId)

    fetch(this.url, {
      method: "POST",
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: connectionBody
    })
    .then(response => response.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
}
