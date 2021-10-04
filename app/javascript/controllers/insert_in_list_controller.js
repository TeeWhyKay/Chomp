import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ['items', 'form', 'zeroReviewsNotice','ratingDesc','1star','2star','3star','4star','5star','rating'];
  static values = { position: String };

  connect() {
    // console.log(this.ratingDescTarget.innerHTML);
  };


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
          const zeroReviewsNotice = document.querySelector("#zero-reviews-notice");
          if (zeroReviewsNotice) {
            this.zeroReviewsNoticeTarget.outerHTML = ""
          }
        }
        this.formTarget.outerHTML = data.form;
      })
  }

  rate(event) {
    event.preventDefault();
    // console.log(event.currentTarget.getAttribute('value'));
    
    this.ratingTarget.value = event.currentTarget.getAttribute('value');
  }
}
