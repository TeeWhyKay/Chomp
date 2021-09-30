import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "name", "timeOutput" ]

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
