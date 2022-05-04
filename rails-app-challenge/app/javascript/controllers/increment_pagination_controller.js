import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs"

// Connects to data-controller="increment-pagination"
export default class extends Controller {
  static targets = ["properties", "pagination", "progressBar", "counter", "total"]

  connect() {
  }

  loadMore(event) {
    event.preventDefault()
    let next_page = this.paginationTarget.querySelector("a[rel='next']")
    if (next_page == null) return;

    let url = next_page.href
    this.requestProperties(url)
  }

  requestProperties(url) {
    Rails.ajax({
      type: 'GET',
      url: url,
      dataType: 'json',
      success: (data) => {
        this.propertiesTarget.insertAdjacentHTML('beforeend', data.properties)
        this.paginationTarget.innerHTML = data.pagination

        this.updateCounter()
        this.updateCounterProgress()
      }
    })
  }

  updateCounterProgress() {
    let totalProperties = parseInt(this.totalTarget.textContent, 10)
    let loadedProperties = parseInt(this.counterTarget.textContent, 10)

    let percentage = loadedProperties * 100.00 / totalProperties
    console.log(percentage)
    this.progressBarTarget.style.transform = `translateX(-${100-percentage}%)`
  }

  updateCounter() {
    let totalProperties = parseInt(this.totalTarget.textContent, 10) 
    let loadedProperties = parseInt(this.counterTarget.textContent, 10) + 8
    this.counterTarget.textContent = loadedProperties > totalProperties ? totalProperties : loadedProperties;
  }
}
