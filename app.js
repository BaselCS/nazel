// Khuzama Touch (خزامى تشك) Webpage Interactions & Image Uploader

let currentUploadTarget = null;

document.addEventListener('DOMContentLoaded', () => {
  console.log('Khuzama Touch Poster Webpage initialized.');
  
  const uploaderInput = document.getElementById('global-image-uploader');

  // Global click handler for uploadable images and icons
  document.addEventListener('click', (e) => {
    const uploadable = e.target.closest('.uploadable-img, .uploadable-icon');
    if (uploadable) {
      e.stopPropagation(); // Prevent opening screen modal when clicking image upload target
      currentUploadTarget = uploadable;
      uploaderInput.click();
    }
  });

  // File selection change event
  if (uploaderInput) {
    uploaderInput.addEventListener('change', (e) => {
      const file = e.target.files[0];
      if (file && currentUploadTarget) {
        const reader = new FileReader();
        reader.onload = (event) => {
          const imgUrl = event.target.result;
          currentUploadTarget.innerHTML = `<img src="${imgUrl}" class="uploaded-custom-img" alt="صورة مرفوعة">`;
        };
        reader.readAsDataURL(file);
      }
      uploaderInput.value = '';
    });
  }

  // Interactive Tab Pills switching inside screens
  const tabContainers = document.querySelectorAll('.tabs-pills');
  tabContainers.forEach(container => {
    const tabs = container.querySelectorAll('.pill-tab');
    tabs.forEach(tab => {
      tab.addEventListener('click', (e) => {
        e.stopPropagation(); // prevent modal opening when clicking internal tab
        tabs.forEach(t => t.classList.remove('active'));
        tab.classList.add('active');
      });
    });
  });

  // Stop propagation on buttons/switches inside screens
  const interactiveElements = document.querySelectorAll('.primary-action-btn, .outline-action-btn, .fab-btn, .toggle-switch, .bottom-nav .nav-item');
  interactiveElements.forEach(el => {
    el.addEventListener('click', (e) => {
      e.stopPropagation();
    });
  });

  // ESC key to close modal
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
      closeScreenModal();
    }
  });
});

// Modal Screen Inspector
function openScreenModal(screenId) {
  const container = document.querySelector(`.screen-card-container[data-screen-id="${screenId}"]`);
  if (!container) return;

  const phoneFrame = container.querySelector('.phone-frame');
  const modalHolder = document.getElementById('modal-screen-holder');
  const modalOverlay = document.getElementById('screen-modal');

  // Clone phone frame into modal
  modalHolder.innerHTML = '';
  const frameClone = phoneFrame.cloneNode(true);
  
  // Enable internal scrolling in modal view
  const clonedScreen = frameClone.querySelector('.phone-screen');
  if (clonedScreen) {
    clonedScreen.style.overflowY = 'auto';
  }

  modalHolder.appendChild(frameClone);
  modalOverlay.classList.add('open');
  document.body.style.overflow = 'hidden';
}

function closeScreenModal(e) {
  if (e && e.target && !e.target.classList.contains('modal-overlay') && !e.target.classList.contains('modal-close-btn')) {
    return;
  }
  const modalOverlay = document.getElementById('screen-modal');
  modalOverlay.classList.remove('open');
  document.body.style.overflow = '';
}
