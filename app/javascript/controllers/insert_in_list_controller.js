import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['items', 'form'];

  connect() {
    console.log(this.element);
    console.log(this.itemsTarget);
    console.log(this.formTarget);
  }


  send(event) {
    event.preventDefault();

    console.log('TODO: send request in AJAX');
  }
}
