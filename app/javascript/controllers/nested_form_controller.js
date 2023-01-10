import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["addItem", "template"]
  static values = { selector: String }

  addAssociation(event) {
    if(event) event.preventDefault()
    this.addItemTarget.insertAdjacentHTML('beforeend', this.buildNewRowFromTemplate())
  }

  removeAssociation(event) {
    event.preventDefault()
    const item = this.getItemForButton(event.target)
    item.querySelectorAll('input').forEach((element) => element.required = false)
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = 'none'
  }

  getItemForButton(button) {
    return button.closest(this.selectorValue)
  }

  buildNewRowFromTemplate() {
    return this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, new Date().valueOf())
  }
}
