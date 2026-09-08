// Khuzama Touch (لمسة خزامى) Webpage Interactions & Flowchart Logic Engine

let currentUploadTarget = null;

document.addEventListener('DOMContentLoaded', () => {
  console.log('Khuzama Touch Poster Webpage initialized.');
  
  const uploaderInput = document.getElementById('global-image-uploader');

  // Global click handler for uploadable images and icons (works inside main document and modals)
  document.addEventListener('click', (e) => {
    const uploadable = e.target.closest('.uploadable-img, .uploadable-icon');
    if (uploadable && !e.target.closest('.modal-close-btn')) {
      e.stopPropagation(); // Prevent opening/closing parent modals when uploading image
      currentUploadTarget = uploadable;
      if (uploaderInput) uploaderInput.click();
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
          triggerToast('تم تحديث الصورة/الأيقونة بنجاح!', 'success');
        };
        reader.readAsDataURL(file);
      }
      uploaderInput.value = '';
    });
  }

  // Interactive Tab Pills switching inside screens
  document.addEventListener('click', (e) => {
    const tab = e.target.closest('.pill-tab');
    if (tab) {
      e.stopPropagation();
      const container = tab.closest('.tabs-pills');
      if (container) {
        container.querySelectorAll('.pill-tab').forEach(t => t.classList.remove('active'));
        tab.classList.add('active');
        triggerToast(`تم اختيار التبويب: ${tab.textContent.trim()}`, 'info');
      }
    }

    // Stepper (Increment / Decrement Text Field) Click Handler
    const stepperBtn = e.target.closest('.stepper-btn');
    if (stepperBtn) {
      e.stopPropagation();
      const group = stepperBtn.closest('.stepper-input-group');
      if (!group) return;
      const input = group.querySelector('.stepper-field');
      if (!input) return;

      const min = input.hasAttribute('min') ? parseFloat(input.getAttribute('min')) : -Infinity;
      const max = input.hasAttribute('max') ? parseFloat(input.getAttribute('max')) : Infinity;
      const step = input.hasAttribute('step') ? parseFloat(input.getAttribute('step')) : 1;
      let val = parseFloat(input.value) || 0;

      const action = stepperBtn.getAttribute('data-action') || (stepperBtn.textContent.trim() === '+' ? 'increment' : 'decrement');

      if (action === 'decrement' || stepperBtn.classList.contains('btn-minus')) {
        if (val - step >= min) {
          input.value = val - step;
          input.dispatchEvent(new Event('change', { bubbles: true }));
        }
      } else if (action === 'increment' || stepperBtn.classList.contains('btn-plus')) {
        if (val + step <= max) {
          input.value = val + step;
          input.dispatchEvent(new Event('change', { bubbles: true }));
        }
      }
    }
  });

  // ESC key to close modal
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
      closeScreenModal();
    }
  });
});

// Toast Notification Engine
function triggerToast(message, type = 'info') {
  const container = document.getElementById('toast-container');
  if (!container) return;

  const toast = document.createElement('div');
  toast.className = `toast ${type}`;
  
  let icon = 'ℹ️';
  if (type === 'success') icon = '✓';
  if (type === 'error') icon = '✕';
  if (type === 'warning') icon = '⚠️';

  toast.innerHTML = `<span style="margin-left: 8px;">${icon}</span> ${message}`;
  container.appendChild(toast);

  setTimeout(() => {
    toast.style.animation = 'fadeOut 0.4s ease forwards';
    setTimeout(() => toast.remove(), 400);
  }, 3500);
}

// View Mode Switcher Engine
function switchViewMode(view) {
  const tabs = document.querySelectorAll('.view-tab-btn');
  tabs.forEach(tab => {
    if (tab.getAttribute('data-view') === view) {
      tab.classList.add('active');
    } else {
      tab.classList.remove('active');
    }
  });

  const workflowSec = document.getElementById('workflow-section');
  const unitsWorkflowSec = document.getElementById('units-workflow-section');
  const bookingsWorkflowSec = document.getElementById('bookings-workflow-section');
  const allScreensTitle = document.getElementById('all-screens-section');
  const screensGrid = document.querySelector('.screens-grid');

  if (view === 'all') {
    if (workflowSec) workflowSec.style.display = 'block';
    if (unitsWorkflowSec) unitsWorkflowSec.style.display = 'block';
    if (bookingsWorkflowSec) bookingsWorkflowSec.style.display = 'block';
    if (allScreensTitle) allScreensTitle.style.display = 'block';
    if (screensGrid) screensGrid.style.display = 'grid';
    triggerToast('تم عرض جميع أقسام البوستر والوركفلو 🌐', 'info');
  } else if (view === 'workflow') {
    if (workflowSec) workflowSec.style.display = 'block';
    if (unitsWorkflowSec) unitsWorkflowSec.style.display = 'block';
    if (bookingsWorkflowSec) bookingsWorkflowSec.style.display = 'block';
    if (allScreensTitle) allScreensTitle.style.display = 'none';
    if (screensGrid) screensGrid.style.display = 'none';
    triggerToast('تم الانتقال لمسارات الوركفلو الشاملة 🔄', 'info');
  } else if (view === 'screens') {
    if (workflowSec) workflowSec.style.display = 'none';
    if (unitsWorkflowSec) unitsWorkflowSec.style.display = 'none';
    if (bookingsWorkflowSec) bookingsWorkflowSec.style.display = 'none';
    if (allScreensTitle) allScreensTitle.style.display = 'block';
    if (screensGrid) screensGrid.style.display = 'grid';
    triggerToast('تم الانتقال لعرض كافة شاشات التطبيق الـ 14 📱', 'info');
  }
}

// Modal Inspector for Workflow Step Screens
function openWorkflowModal(stepId) {
  const container = document.querySelector(`.workflow-step-card[data-workflow-id="${stepId}"]`);
  if (!container) return;

  const phoneFrame = container.querySelector('.phone-frame');
  const modalHolder = document.getElementById('modal-screen-holder');
  const modalOverlay = document.getElementById('screen-modal');

  if (!modalHolder || !modalOverlay) return;

  modalHolder.innerHTML = '';
  const frameClone = phoneFrame.cloneNode(true);
  
  const clonedScreen = frameClone.querySelector('.phone-screen');
  if (clonedScreen) {
    clonedScreen.style.overflowY = 'auto';
  }

  modalHolder.appendChild(frameClone);
  modalOverlay.classList.add('open');
  document.body.style.overflow = 'hidden';
}

// Modal Inspector for Units Workflow Step Screens (03_units_management_workflow.jpeg)
function openUnitsWorkflowModal(stepId) {
  const container = document.querySelector(`.workflow-step-card[data-units-workflow-id="${stepId}"]`);
  if (!container) return;

  const phoneFrame = container.querySelector('.phone-frame');
  const modalHolder = document.getElementById('modal-screen-holder');
  const modalOverlay = document.getElementById('screen-modal');

  if (!modalHolder || !modalOverlay) return;

  modalHolder.innerHTML = '';
  const frameClone = phoneFrame.cloneNode(true);
  
  const clonedScreen = frameClone.querySelector('.phone-screen');
  if (clonedScreen) {
    clonedScreen.style.overflowY = 'auto';
  }

  modalHolder.appendChild(frameClone);
  modalOverlay.classList.add('open');
  document.body.style.overflow = 'hidden';
}

// Modal Inspector for Bookings Workflow Step Screens (04_bookings_management_workflow.jpeg)
function openBookingsWorkflowModal(stepId) {
  const container = document.querySelector(`.workflow-step-card[data-bookings-workflow-id="${stepId}"]`);
  if (!container) return;

  const phoneFrame = container.querySelector('.phone-frame');
  const modalHolder = document.getElementById('modal-screen-holder');
  const modalOverlay = document.getElementById('screen-modal');

  if (!modalHolder || !modalOverlay) return;

  modalHolder.innerHTML = '';
  const frameClone = phoneFrame.cloneNode(true);
  
  const clonedScreen = frameClone.querySelector('.phone-screen');
  if (clonedScreen) {
    clonedScreen.style.overflowY = 'auto';
  }

  modalHolder.appendChild(frameClone);
  modalOverlay.classList.add('open');
  document.body.style.overflow = 'hidden';
}

// Modal Screen Inspector (Clones screen into magnified view)
function openScreenModal(screenId) {
  const container = document.querySelector(`.screen-card-container[data-screen-id="${screenId}"]`);
  if (!container) return;

  const phoneFrame = container.querySelector('.phone-frame');
  const modalHolder = document.getElementById('modal-screen-holder');
  const modalOverlay = document.getElementById('screen-modal');

  modalHolder.innerHTML = '';
  const frameClone = phoneFrame.cloneNode(true);
  
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

// More Navigation Menu Drawer Modal
function openMoreMenuModal(e) {
  if (e) e.stopPropagation();
  const modalHolder = document.getElementById('modal-screen-holder');
  const modalOverlay = document.getElementById('screen-modal');

  modalHolder.innerHTML = `
    <div style="background: white; border-radius: 24px; padding: 24px; width: 340px; border: 2px solid #EADAFF; direction: rtl; font-family: var(--font-main);">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; border-bottom: 1px solid #F3EDF7; padding-bottom: 10px;">
        <h3 style="color: var(--dark-purple); font-size: 1.1rem; margin: 0;">قائمة المزيد (More Menu)</h3>
        <span style="font-size: 0.8rem; color: var(--text-muted);">14 شاشة</span>
      </div>
      <div style="display: flex; flex-direction: column; gap: 6px; max-height: 480px; overflow-y: auto; padding-left: 4px;">
        <button onclick="openScreenModal(1)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">1. شاشة الترحيب</button>
        <button onclick="openScreenModal(2)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">2. تسجيل الدخول</button>
        <button onclick="openScreenModal(3)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">3. الرئيسية (Dashboard)</button>
        <button onclick="openScreenModal(4)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">4. الوحدات العقارية</button>
        <button onclick="openScreenModal(5)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">5. التقويم</button>
        <button onclick="openScreenModal(6)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">6. الحجوزات</button>
        <button onclick="openScreenModal(7)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">7. التسعير الذكي</button>
        <button onclick="openScreenModal(8)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">8. التحليلات والتقارير</button>
        <button onclick="openScreenModal(9)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">9. الخدمات والطلبات</button>
        <button onclick="openScreenModal(10)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">10. التراخيص والوثائق</button>
        <button onclick="openScreenModal(11)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">11. المركز المالي</button>
        <button onclick="openScreenModal(12)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">12. التنبيهات</button>
        <button onclick="openScreenModal(13)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">13. التكاملات</button>
        <button onclick="openScreenModal(14)" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #EADAFF; background: #FAF8FC; cursor: pointer; font-family: var(--font-main); font-weight: 600;">14. الإعدادات</button>
        <button onclick="triggerToast('تم تسجيل الخروج بنجاح.', 'warning'); closeScreenModal();" style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #FFCDD2; background: #FFEBEE; color: #C62828; cursor: pointer; font-family: var(--font-main); font-weight: 700; margin-top: 6px;">🚪 تسجيل خروج</button>
      </div>
    </div>
  `;
  modalOverlay.classList.add('open');
  document.body.style.overflow = 'hidden';
}

// Forgot Password Flow Modal
function openForgotPasswordModal(e) {
  if (e) e.stopPropagation();
  const modalHolder = document.getElementById('modal-screen-holder');
  const modalOverlay = document.getElementById('screen-modal');

  modalHolder.innerHTML = `
    <div style="background: white; border-radius: 24px; padding: 24px; width: 340px; border: 2px solid #EADAFF; direction: rtl; font-family: var(--font-main);">
      <h3 style="color: var(--dark-purple); font-size: 1.1rem; margin-bottom: 6px;">إعادة تعيين كلمة المرور</h3>
      <p style="font-size: 0.75rem; color: var(--text-muted); margin-bottom: 16px;">أدخل بريدك الإلكتروني ليصلك رابط تعيين كلمة المرور.</p>
      
      <div style="margin-bottom: 14px;">
        <label style="font-size: 0.7rem; font-weight: 700; color: var(--dark-purple); display: block; margin-bottom: 4px;">البريد الإلكتروني</label>
        <input type="email" id="reset-email-input" value="example@email.com" style="width: 100%; padding: 8px 10px; border-radius: 8px; border: 1px solid #CCC; font-family: var(--font-main); font-size: 0.75rem;">
      </div>

      <button onclick="triggerToast('تم إرسال رابط التعيين إلى بريدك الإلكتروني بنجاح! ✓', 'success'); closeScreenModal();" style="width: 100%; background: var(--dark-purple); color: white; border: none; padding: 10px; border-radius: 10px; font-weight: 700; font-family: var(--font-main); cursor: pointer;">إرسال رابط التعيين</button>
    </div>
  `;
  modalOverlay.classList.add('open');
  document.body.style.overflow = 'hidden';
}

// Revenue Details Sub-Modal
function openRevenueDetailsModal(e) {
  if (e) e.stopPropagation();
  const modalHolder = document.getElementById('modal-screen-holder');
  const modalOverlay = document.getElementById('screen-modal');

  modalHolder.innerHTML = `
    <div style="background: white; border-radius: 24px; padding: 24px; width: 360px; border: 2px solid #EADAFF; direction: rtl; font-family: var(--font-main);">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
        <h3 style="color: var(--dark-purple); font-size: 1.1rem; margin: 0;">تفاصيل الإيرادات</h3>
        <span style="font-size: 0.72rem; background: #E8F5E9; color: #2E7D32; padding: 4px 10px; border-radius: 100px; font-weight: 700;">مايو 2024</span>
      </div>

      <div style="font-size: 1.8rem; font-weight: 900; color: var(--dark-purple); margin-bottom: 12px;">48,250 <span style="font-size: 0.9rem; color: var(--text-muted);">ريال</span></div>

      <div style="display: flex; gap: 6px; margin-bottom: 14px;">
        <span style="font-size: 0.7rem; padding: 4px 10px; border-radius: 100px; background: var(--dark-purple); color: white; font-weight: 600;">الشهر</span>
        <span style="font-size: 0.7rem; padding: 4px 10px; border-radius: 100px; background: #F3EDF7; color: var(--text-muted);">الأسبوع</span>
        <span style="font-size: 0.7rem; padding: 4px 10px; border-radius: 100px; background: #F3EDF7; color: var(--text-muted);">اليوم</span>
        <span style="font-size: 0.7rem; padding: 4px 10px; border-radius: 100px; background: #F3EDF7; color: var(--text-muted);">السنة</span>
      </div>

      <div style="background: #FAF8FC; border: 1px solid #EADAFF; border-radius: 12px; padding: 12px; margin-bottom: 16px;">
        <svg viewBox="0 0 300 80" style="width: 100%; height: 70px;">
          <path d="M 0 60 Q 50 70, 90 40 T 170 50 T 240 15 T 300 35" fill="none" stroke="#7C4DFF" stroke-width="3"/>
        </svg>
      </div>

      <button onclick="triggerToast('جاري تصدير تقرير الإيرادات بصيغة PDF...', 'success')" style="width: 100%; background: var(--dark-purple); color: white; border: none; padding: 10px; border-radius: 10px; font-weight: 700; font-family: var(--font-main); cursor: pointer;">تحميل PDF 📄</button>
    </div>
  `;
  modalOverlay.classList.add('open');
  document.body.style.overflow = 'hidden';
}

// Occupancy Report Sub-Modal
function openOccupancyReportModal(e) {
  if (e) e.stopPropagation();
  const modalHolder = document.getElementById('modal-screen-holder');
  const modalOverlay = document.getElementById('screen-modal');

  modalHolder.innerHTML = `
    <div style="background: white; border-radius: 24px; padding: 24px; width: 340px; border: 2px solid #EADAFF; direction: rtl; font-family: var(--font-main); text-align: center;">
      <h3 style="color: var(--dark-purple); font-size: 1.1rem; margin-bottom: 12px;">تقرير الإشغال (Occupancy Report)</h3>
      
      <div style="width: 100px; height: 100px; margin: 0 auto 12px; position: relative;">
        <svg viewBox="0 0 100 100">
          <circle cx="50" cy="50" r="40" fill="none" stroke="#E0E0E0" stroke-width="12"/>
          <circle cx="50" cy="50" r="40" fill="none" stroke="#7C4DFF" stroke-width="12" stroke-dasharray="250" stroke-dashoffset="55"/>
        </svg>
        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 1.3rem; font-weight: 900; color: var(--dark-purple);">78%</div>
      </div>

      <p style="font-size: 0.78rem; color: var(--text-muted); margin-bottom: 16px;">نسبة الإشغال الحالية ممتازة مقارنة بالشهر السابق (+8%).</p>

      <div style="display: flex; flex-direction: column; gap: 8px;">
        <button onclick="openScreenModal(4); closeScreenModal();" style="background: var(--dark-purple); color: white; border: none; padding: 10px; border-radius: 10px; font-weight: 700; font-family: var(--font-main); cursor: pointer;">عرض الوحدات الفارغة</button>
        <button onclick="openScreenModal(7); closeScreenModal();" style="background: #F3EDF7; color: var(--dark-purple); border: 1px solid #EADAFF; padding: 10px; border-radius: 10px; font-weight: 700; font-family: var(--font-main); cursor: pointer;">الذهاب للتسعير الذكي</button>
      </div>
    </div>
  `;
  modalOverlay.classList.add('open');
  document.body.style.overflow = 'hidden';
}

// Booking Details Sub-Modal
function openBookingDetailsModal(e) {
  if (e) e.stopPropagation();
  const modalHolder = document.getElementById('modal-screen-holder');
  const modalOverlay = document.getElementById('screen-modal');

  modalHolder.innerHTML = `
    <div style="background: white; border-radius: 24px; padding: 24px; width: 340px; border: 2px solid #EADAFF; direction: rtl; font-family: var(--font-main);">
      <h3 style="color: var(--dark-purple); font-size: 1.1rem; margin-bottom: 12px; border-bottom: 1px solid #F3EDF7; padding-bottom: 8px;">تفاصيل الحجز</h3>
      
      <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 12px;">
        <div style="width: 40px; height: 40px; border-radius: 50%; background: #EADAFF; display: flex; align-items: center; justify-content: center; font-size: 1.1rem;">👤</div>
        <div>
          <h4 style="margin: 0; color: var(--dark-purple); font-size: 0.95rem;">أحمد محمد</h4>
          <span style="font-size: 0.72rem; color: var(--text-muted);">الوحدة: A-203</span>
        </div>
      </div>

      <div style="background: #FAF8FC; padding: 10px; border-radius: 10px; font-size: 0.75rem; color: var(--text-dark); margin-bottom: 14px; line-height: 1.6;">
        <div><strong>التاريخ:</strong> 15-18 مايو 2024</div>
        <div><strong>إجمالي المبلغ:</strong> 4,250 ريال</div>
        <div><strong>المنصة:</strong> Airbnb</div>
        <div><strong>الحالة:</strong> مؤكد ✓</div>
      </div>

      <button onclick="triggerToast('تم فتح بيانات التواصل مع الضيف', 'info'); closeScreenModal();" style="width: 100%; background: var(--dark-purple); color: white; border: none; padding: 10px; border-radius: 10px; font-weight: 700; font-family: var(--font-main); cursor: pointer;">التواصل مع الضيف</button>
    </div>
  `;
  modalOverlay.classList.add('open');
  document.body.style.overflow = 'hidden';
}

// Recommendation Details Sub-Modal
function openRecommendationDetailsModal(e) {
  if (e) e.stopPropagation();
  const modalHolder = document.getElementById('modal-screen-holder');
  const modalOverlay = document.getElementById('screen-modal');

  modalHolder.innerHTML = `
    <div style="background: white; border-radius: 24px; padding: 24px; width: 340px; border: 2px solid #EADAFF; direction: rtl; font-family: var(--font-main);">
      <h3 style="color: var(--dark-purple); font-size: 1.1rem; margin-bottom: 12px;">تفاصيل التوصية (AI Details)</h3>
      
      <div style="background: linear-gradient(135deg, #2D1456, #4F378B); color: white; padding: 14px; border-radius: 14px; margin-bottom: 14px;">
        <h4 style="margin: 0 0 6px 0; color: #D0BCFF;">نوصي بتخفيض السعر</h4>
        <p style="font-size: 0.78rem; margin: 0; line-height: 1.4;">الوحدة 203 فارغة منذ 4 أيام. تخفيض السعر بنسبة 12% سيرفع فرصة الإشغال بنسبة 85% خلال عطلة نهاية الأسبوع.</p>
      </div>

      <button onclick="triggerToast('تم تطبيق التوصية وتعديل السعر بنجاح! ✓', 'success'); closeScreenModal();" style="width: 100%; background: var(--dark-purple); color: white; border: none; padding: 10px; border-radius: 10px; font-weight: 700; font-family: var(--font-main); cursor: pointer;">تطبيق التوصية الآن</button>
    </div>
  `;
  modalOverlay.classList.add('open');
  document.body.style.overflow = 'hidden';
}

// Notification Details Sub-Modal
function openNotificationDetailsModal(e) {
  if (e) e.stopPropagation();
  const modalHolder = document.getElementById('modal-screen-holder');
  const modalOverlay = document.getElementById('screen-modal');

  modalHolder.innerHTML = `
    <div style="background: white; border-radius: 24px; padding: 24px; width: 340px; border: 2px solid #EADAFF; direction: rtl; font-family: var(--font-main);">
      <h3 style="color: var(--dark-purple); font-size: 1.1rem; margin-bottom: 12px;">تفاصيل التنبيه</h3>
      
      <div style="background: #FFF3E0; border: 1px solid #FFCC80; padding: 12px; border-radius: 12px; margin-bottom: 14px;">
        <strong style="color: #E65100; font-size: 0.85rem; display: block; margin-bottom: 4px;">⚠️ تنبيه ترخيص</strong>
        <p style="font-size: 0.75rem; color: #E65100; margin: 0;">رخصة التأجير لفيلا الياسمين تنتهي خلال 15 يوماً. يرجى تجديد الرخصة لتفادي أي غرامات.</p>
      </div>

      <button onclick="openScreenModal(10); closeScreenModal();" style="width: 100%; background: var(--dark-purple); color: white; border: none; padding: 10px; border-radius: 10px; font-weight: 700; font-family: var(--font-main); cursor: pointer;">عرض التراخيص والتجديد</button>
    </div>
  `;
  modalOverlay.classList.add('open');
  document.body.style.overflow = 'hidden';
}

// Quick Actions Sub-Modals
function openQuickActionModal(actionKey, e) {
  if (e) e.stopPropagation();
  const modalHolder = document.getElementById('modal-screen-holder');
  const modalOverlay = document.getElementById('screen-modal');

  let title = 'إجراء سريع';
  let bodyHTML = '';

  if (actionKey === 'add_unit') {
    title = 'إضافة وحدة جديدة (+ W-01)';
    bodyHTML = `
      <div style="display: flex; flex-direction: column; gap: 8px; font-size: 0.75rem;">
        <input type="text" placeholder="اسم الوحدة (مثال: فيلا النرجس)" style="padding: 8px; border-radius: 8px; border: 1px solid #CCC;">
        <input type="text" placeholder="الموقع / الحي" style="padding: 8px; border-radius: 8px; border: 1px solid #CCC;">
        <input type="number" placeholder="السعر الافتراضي لليلة (ر.س)" style="padding: 8px; border-radius: 8px; border: 1px solid #CCC;">
        <button onclick="triggerToast('تمت إضافة الوحدة بنجاح! ✓', 'success'); closeScreenModal();" style="background: var(--dark-purple); color: white; border: none; padding: 10px; border-radius: 10px; font-weight: 700; margin-top: 6px; cursor: pointer;">حفظ الوحدة</button>
      </div>
    `;
  } else if (actionKey === 'manual_booking') {
    title = 'حجز يدوي جديد';
    bodyHTML = `
      <div style="display: flex; flex-direction: column; gap: 8px; font-size: 0.75rem;">
        <input type="text" placeholder="اسم الضيف" style="padding: 8px; border-radius: 8px; border: 1px solid #CCC;">
        <input type="date" placeholder="تاريخ الوصول" style="padding: 8px; border-radius: 8px; border: 1px solid #CCC;">
        <input type="date" placeholder="تاريخ المغادرة" style="padding: 8px; border-radius: 8px; border: 1px solid #CCC;">
        <button onclick="triggerToast('تم إنشاء الحجز اليدوي بنجاح! ✓', 'success'); closeScreenModal();" style="background: var(--dark-purple); color: white; border: none; padding: 10px; border-radius: 10px; font-weight: 700; margin-top: 6px; cursor: pointer;">تأكيد الحجز</button>
      </div>
    `;
  } else if (actionKey === 'edit_prices') {
    title = 'تعديل أسعار اليوم';
    bodyHTML = `
      <div style="display: flex; flex-direction: column; gap: 8px; font-size: 0.75rem;">
        <label>السعر الجديد لليوم (ر.س):</label>
        <div class="stepper-input-group">
          <button type="button" class="stepper-btn btn-minus" data-action="decrement">-</button>
          <input type="number" class="stepper-field" value="650" min="50" max="10000" step="50">
          <button type="button" class="stepper-btn btn-plus" data-action="increment">+</button>
        </div>
        <button onclick="triggerToast('تم تحديث أسعار اليوم بنجاح! ✓', 'success'); closeScreenModal();" style="background: var(--dark-purple); color: white; border: none; padding: 10px; border-radius: 10px; font-weight: 700; cursor: pointer; margin-top: 6px;">حفظ السعر</button>
      </div>
    `;
  } else if (actionKey === 'send_notification') {
    title = 'إرسال إشعار للضيف';
    bodyHTML = `
      <div style="display: flex; flex-direction: column; gap: 8px; font-size: 0.75rem;">
        <input type="text" placeholder="عنوان الرسالة" style="padding: 8px; border-radius: 8px; border: 1px solid #CCC;">
        <textarea placeholder="نص الإشعار..." style="padding: 8px; border-radius: 8px; border: 1px solid #CCC; height: 60px;"></textarea>
        <button onclick="triggerToast('تم إرسال الإشعار للضيف عبر الواتساب! ✓', 'success'); closeScreenModal();" style="background: var(--dark-purple); color: white; border: none; padding: 10px; border-radius: 10px; font-weight: 700; cursor: pointer;">إرسال الآن</button>
      </div>
    `;
  } else if (actionKey === 'upload_doc') {
    title = 'رفع مستند جديد';
    bodyHTML = `
      <div style="display: flex; flex-direction: column; gap: 8px; font-size: 0.75rem;">
        <input type="text" placeholder="اسم الوثيقة" style="padding: 8px; border-radius: 8px; border: 1px solid #CCC;">
        <input type="file" style="padding: 6px; border-radius: 8px; border: 1px dashed #CCC;">
        <button onclick="triggerToast('تم رفع المستند وتحديث مؤشر الامتثال! ✓', 'success'); closeScreenModal();" style="background: var(--dark-purple); color: white; border: none; padding: 10px; border-radius: 10px; font-weight: 700; cursor: pointer;">حفظ الوثيقة</button>
      </div>
    `;
  } else if (actionKey === 'upload_photos') {
    title = 'رفع صور للوحدة';
    bodyHTML = `
      <div style="display: flex; flex-direction: column; gap: 8px; font-size: 0.75rem;">
        <p style="color: var(--text-muted); margin: 0;">اختر الصور المراد إضافتها لمعرض العقار:</p>
        <input type="file" multiple accept="image/*" style="padding: 6px; border-radius: 8px; border: 1px dashed #CCC;">
        <button onclick="triggerToast('تم رفع صور العقار بنجاح! ✓', 'success'); closeScreenModal();" style="background: var(--dark-purple); color: white; border: none; padding: 10px; border-radius: 10px; font-weight: 700; cursor: pointer;">رفع الصور</button>
      </div>
    `;
  } else if (actionKey === 'delete_confirm') {
    title = 'تأكيد الحذف (Delete Dialog)';
    bodyHTML = `
      <div style="text-align: center;">
        <div style="font-size: 2.5rem; color: #D32F2F; margin-bottom: 8px;">⚠️</div>
        <p style="font-size: 0.85rem; color: var(--text-dark); margin-bottom: 16px;">هل أنت تأكد من أنك تريد حذف هذا العنصر؟ لا يمكن التراجع عن هذه العملية.</p>
        <div style="display: flex; gap: 10px;">
          <button onclick="triggerToast('تم حذف العنصر بنجاح.', 'error'); closeScreenModal();" style="flex: 1; background: #D32F2F; color: white; border: none; padding: 10px; border-radius: 10px; font-weight: 700; cursor: pointer;">نعم، حذف</button>
          <button onclick="closeScreenModal()" style="flex: 1; background: #EEE; color: #333; border: none; padding: 10px; border-radius: 10px; font-weight: 600; cursor: pointer;">إلغاء</button>
        </div>
      </div>
    `;
  }

  modalHolder.innerHTML = `
    <div style="background: white; border-radius: 24px; padding: 24px; width: 340px; border: 2px solid #EADAFF; direction: rtl; font-family: var(--font-main);">
      <h3 style="color: var(--dark-purple); font-size: 1.1rem; margin-bottom: 14px; border-bottom: 1px solid #F3EDF7; padding-bottom: 8px;">${title}</h3>
      ${bodyHTML}
    </div>
  `;
  modalOverlay.classList.add('open');
  document.body.style.overflow = 'hidden';
}
