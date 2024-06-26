import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["address"]

  connect() {
    console.log("coucou")
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
      class: "custom-geocoder-input",
      placeholder: "3458 rue Atateken",
      countries: "CA"
    })
    this.geocoder.addTo(this.element)
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
    document.querySelector('.mapboxgl-ctrl-geocoder--input').classList.add('custom-geocoder-input');
  }

  disconnect() {
    this.geocoder.onRemove()
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"]
  }

  #clearInputValue() {
    this.addressTarget.value = ""
  }
}
