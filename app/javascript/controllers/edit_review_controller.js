import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['infos', 'form', 'card','ratingDesc','onestar','twostar','threestar','fourstar','fivestar','rating'];

  displayForm() {
    this.infosTarget.classList.add('d-none');
    this.formTarget.classList.remove('d-none');
    const filled = "fas";
    const unfilled = "far";
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

  update(event) {
    event.preventDefault();
    const url = this.formTarget.action
    fetch(url, {
      method: 'PATCH',
      headers: { 'Accept': 'text/plain' },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.cardTarget.outerHTML = data;
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
