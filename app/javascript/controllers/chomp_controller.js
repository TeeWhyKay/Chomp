import { Controller } from "stimulus"

export default class extends Controller {
static targets = ["alert", "deduct", "total", "add", "warning", "submit"]

  connect() {
    this.totalCount = 1;
  }

  increment() {
    this.totalCount += 1
    this.totalTarget.innerText = this.totalCount
    this.checkTotal()
  }

  decrement() {
    this.totalCount = this.totalCount - 1 == 0 ? 1 : this.totalCount - 1
    this.totalTarget.innerText = this.totalCount
    this.checkTotal()
  }

  checkTotal() {
    if (this.totalCount > 2) {
      this.warningTarget.classList.remove('d-none');
      this.submitTarget.disabled = false;
    } else {
      this.warningTarget.classList.add('d-none');
      this.submitTarget.disabled = false;
    }
  }
}
