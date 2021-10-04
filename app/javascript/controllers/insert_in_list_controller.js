import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ['items', 'form', 'zeroReviewsNotice','ratingDesc','onestar','twostar','threestar','fourstar','fivestar','rating'];
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
    const filled = "fas";
    const unfilled = "far";
    // console.log(event.currentTarget.getAttribute('value'));
    // console.log(event.currentTarget.classList);
    this.ratingTarget.value = event.currentTarget.getAttribute('value');
    if (this.ratingTarget.value == 1){
      this.twostarTarget.classList.replace(filled, unfilled);
      this.threestarTarget.classList.replace(filled, unfilled);
      this.fourstarTarget.classList.replace(filled, unfilled);
      this.fivestarTarget.classList.replace(filled, unfilled);
      this.ratingDescTarget.innerHTML = "Blegh!";
    } else if (this.ratingTarget.value == 2) {
      this.twostarTarget.classList.replace(unfilled, filled);
      this.threestarTarget.classList.replace(filled, unfilled);
      this.fourstarTarget.classList.replace(filled, unfilled);
      this.fivestarTarget.classList.replace(filled, unfilled);
      this.ratingDescTarget.innerHTML = "Below Average";
    } else if (this.ratingTarget.value == 3){
      this.twostarTarget.classList.replace(unfilled, filled);
      this.threestarTarget.classList.replace(unfilled, filled);
      this.fourstarTarget.classList.replace(filled, unfilled);
      this.fivestarTarget.classList.replace(filled, unfilled);
      this.ratingDescTarget.innerHTML = "Alright";
    } else if (this.ratingTarget.value == 4){
      this.twostarTarget.classList.replace(unfilled, filled);
      this.threestarTarget.classList.replace(unfilled, filled);
      this.fourstarTarget.classList.replace(unfilled, filled);
      this.fivestarTarget.classList.replace(filled, unfilled);
      this.ratingDescTarget.innerHTML = "Not Bad";
    } else {
      this.twostarTarget.classList.replace(unfilled, filled);
      this.threestarTarget.classList.replace(unfilled, filled);
      this.fourstarTarget.classList.replace(unfilled, filled);
      this.fivestarTarget.classList.replace(unfilled, filled);
      this.ratingDescTarget.innerHTML = "Amazing!";
    }
  }
}
