import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["alert", "deduct", "total",
    "add", "warning", "submit", "inviteesinput", "name", "timeOutput" ]

  connect() {
    if (window.location.pathname.includes('new')) {
      this.totalCount = 1;
    } else {
      let chompId = /\d+/.exec(window.location.pathname)[0]
      fetch(`/chomp_sessions/${chompId}`, {
            method: 'GET',
            headers: { 'Accept': 'application/json' }
        })
        .then( res => res.json())
        .then( data => this.updateInvitees(data.invitees))
    }
  }

  updateInvitees(invitees) {
    this.totalCount = invitees;
    this.inviteesinputTarget.setAttribute('value', invitees);
    this.totalTarget.innerText = invitees;
  }

  increment() {
    this.totalCount += 1
    this.inviteesinputTarget.setAttribute('value', this.totalCount);
    this.totalTarget.innerText = this.totalCount
    this.checkTotal()
  }

  decrement() {
    this.totalCount = this.totalCount - 1 == 0 ? 1 : this.totalCount - 1
    this.inviteesinputTarget.setAttribute('value', this.totalCount);
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
