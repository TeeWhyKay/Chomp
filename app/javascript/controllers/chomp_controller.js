import { Controller } from "stimulus"

export default class extends Controller {
static targets = ["alert", "deduct", "total", "add", "warning", "submit"]

  connect() {
    this.totalCount = 1;
  }

  increment() {
    console.log('clicking');
    this.totalCount += 1
    this.totalTarget.innerText = this.totalCount
    this.checkTotal()
  }

  decrement() {
    console.log('clicking');
    this.totalCount -= 1
    this.totalTarget.innerText = this.totalCount
    this.checkTotal()
  }

  checkTotal() {
    if (this.totalCount > 2) {
      this.warningTarget.classList.remove('d-none');
      this.submitTarget.disabled = true;
    } else {
      this.warningTarget.classList.add('d-none');
      this.submitTarget.disabled = false;
    }
  }
}
