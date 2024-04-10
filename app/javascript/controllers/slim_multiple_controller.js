import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slim-multiple"
export default class extends Controller {
  connect() {
    new SlimSelect({
      select: this.element,
      settings: {
        showSearch: this.element.getAttribute('data-show-search'),
        closeOnSelect: false,
        placeholderText: this.element.getAttribute('data-placeholder'),
        searchText: this.element.getAttribute('data-search-text'),
        searchPlaceholder: this.element.getAttribute('data-search-placeholder'),
      },
    })
  }
}
