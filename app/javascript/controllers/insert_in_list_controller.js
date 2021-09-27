import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ['items', 'form', 'zeroReviewsNotice'];
  static values = { position: String }

  send(event) {
    event.preventDefault();

    fetch(this.formTarget.action, {
      method: 'POST',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {
          this.itemsTarget.insertAdjacentHTML(this.positionValue, data.inserted_item);

          // Update review count
          const reviewCount = document.querySelector("#review-count");
          const count = parseInt(reviewCount.innerText, 10) + 1;
          reviewCount.innerText = count;

          // Remove 0 reviews notice msg
          if (this.zeroReviewsNoticeTarget) {
            this.zeroReviewsNoticeTarget.outerHTML = ""
          }
        }
        this.formTarget.outerHTML = data.form;
      })
  }
}
