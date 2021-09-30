import { Controller } from "stimulus"

export default class extends Controller {
static targets = ["alert", "total"]

  connect() {
    // console.log(this.alertTarget);
  }

  increment() {
    this.totalTarget.innerHTML = ""
    this.checkTotal()
  }

  decrement() {
  // this.totalTarget.innerHTML = ""
// check if number can be reduced, if yes reduce if not don't --> AFTER THAT CHECK TOTAL
    this.checkTotal()
  }

  checkTotal() {

    this.alertTarget.innerHTML = "blah blah"

  }
}
