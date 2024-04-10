import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.slimSelect = new SlimSelect({
      select: this.element,
      placeholder: this.element.dataset.placeholder || 'Select an option',
      isEnabled: !this.element.disabled,
      settings: {
        showSearch: this.element.getAttribute('data-show-search'),
        placeholderText: this.element.getAttribute('data-placeholder'),
        searchText: this.element.getAttribute('data-search-text'),
        searchPlaceholder: this.element.getAttribute('data-search-placeholder'),
      },
    });
  }

  update(options) {
    this.slimSelect.setData(options);
  }

  disconnect() {
    if (this.slimSelect) {
      this.slimSelect.destroy();
    }
  }
}
