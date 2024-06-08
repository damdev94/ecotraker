import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dayCheckbox"];

  connect() {
    console.log("CheckAllController connected");
  }

  allchecked() {
    const checkAllBox = this.element.querySelector("#check-all");
    const isChecked = checkAllBox.checked;

    if (this.dayCheckboxTargets) {
      this.dayCheckboxTargets.forEach(checkbox => {
        checkbox.checked = isChecked;
      });
    }
  }
}
