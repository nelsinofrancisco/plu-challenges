import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navigation-bar"
export default class extends Controller {
  static targets = ["headerLogo", "locationHeader", "locationIcon", "modalSection"]

  connect() {
  }

  toggleCropImage() {
    if (window.innerWidth < 992) {
      this.headerLogoTarget.classList.add('logo-cropped')
    } else {
      this.headerLogoTarget.classList.remove('logo-cropped')
    }
  }

  showMenu() {
    document.querySelector('body').style.overflow = 'hidden';
    document.getElementById("mob-modal").classList.remove('d-none');
  }

  closeMenu() {
    document.querySelector('body').style.overflow = 'visible';
    document.getElementById("mob-modal").classList.add('d-none');
  }
}
