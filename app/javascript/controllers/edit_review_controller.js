import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['infos', 'form'];

  displayForm() {
    this.infosTarget.classList.add('d-none');
    this.formTarget.classList.remove('d-none');
  }
}
