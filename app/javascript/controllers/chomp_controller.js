import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["alert", "deduct", "total", "add", "warning", "submit", "name", "timeOutput"]

  connect() {
    this.totalCount = 1;
  }

  increment() {
    this.totalCount += 1
    this.totalTarget.innerText = this.totalCount
    this.checkTotal()
  }

  decrement() {
    this.totalCount -= 1
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

  autofillTime(event) {
    console.log(this.nameTarget.value);
    const whatTime = (givenTime) => {
      return this.nameTarget.value.toLowerCase().includes(givenTime)
    }

    const thereIsBreakfast = whatTime("breakfast") || whatTime("morning");
    const thereIsBrunch = whatTime("brunch");
    const thereIsLunch = whatTime("lunch") || whatTime("afternoon");
    const thereIsDinner = whatTime("dinner") || whatTime("evening");
    const thereIsSupper = whatTime("supper") || whatTime("night");

    if (thereIsBreakfast) {
      this.timeOutputTarget.value = "09:00:00"
    } else if (thereIsBrunch) {
      this.timeOutputTarget.value = "11:00:00"
    } else if (thereIsLunch) {
      this.timeOutputTarget.value = "13:00:00"
    } else if (thereIsDinner) {
      this.timeOutputTarget.value = "18:00:00"
    } else if (thereIsSupper) {
      this.timeOutputTarget.value = "22:00:00"
    }

  }
}
