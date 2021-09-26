import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['selection'];

  select(event) {
    const cuisineName = event.currentTarget.getAttribute("value").toLowerCase();
    console.log(cuisineName);

    // <label class="form-check-label collection_check_boxes" for="response_cuisine_japanese">okok</label>
  }
}
