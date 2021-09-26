import { each } from "jquery";
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['selection'];

  connect() {
    const initialCheckedStatus = document.querySelectorAll(".tag-selector[checked='checked']");
    initialCheckedStatus.forEach(element => {
      const cuisineLabel = element.nextSibling;
      cuisineLabel.innerHTML = `<i class="fas fa-check-circle"></i>`;
    });
  }

  select(event) {
    const cuisineName = event.currentTarget.getAttribute("value");
    const cuisineLabel = document.querySelector(`label[for="response_cuisine_${cuisineName.toLowerCase()}"]`);
    if (cuisineName == cuisineLabel.innerHTML) {
      cuisineLabel.innerHTML = `<i class="fas fa-check-circle"></i>`;
    } else {
      cuisineLabel.innerHTML = cuisineName;
    }

  }
}
