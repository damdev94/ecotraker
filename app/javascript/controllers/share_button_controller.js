import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share-content"
export default class extends Controller {
  static values = {
    title: String,
    text: String,
    url: String
  }

  connect() {
  }

  fire() {
    if (navigator.share && navigator.canShare) {
      const payload = {
        text: this.textValue,
        title: `Ecotraker - ${this.titleValue}`,
        url: this.urlValue
      };

      if (navigator.canShare(payload)) {
        navigator.share(payload);
      }
    } else {
      alert("Sharing not supported on this device");
    }
  }
}
