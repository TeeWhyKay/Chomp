import { Controller } from "stimulus"

export default class extends Controller {
static targets = ["alert", "deduct", "total",
                  "add", "warning", "submit", "inviteesinput"]

  connect() {
    console.log('connected!');
    // if I am on new,
    // url = chomp_sessions/new
    if (window.location.pathname.includes('new')) {
      this.totalCount = 1;
    } else {
      // url = chomp_sessions/4848393/edit
      console.log('in the function');
      let chompId = /\d+/.exec(window.location.pathname)[0]
      fetch(`/chomp_sessions/${chompId}`, {
            method: 'GET',
            headers: { 'Accept': 'application/json' }
        })
        .then( res => res.json())
        .then( data => this.updateInvitees(data.invitees))
    }
    // if I am on edit
    // fetch the current number of people for chomp
    // update totalCount
    // update the innerText of totalTarget
  }

  updateInvitees(invitees) {
    console.log(invitees);
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
}
