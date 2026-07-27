# Project Handover Summary - Khuzama Touch (خزامى تشك)

## 📌 Project Overview
Web application and interactive flowchart replica for **Khuzama Touch (خزامى تشك) | Owner App**, implemented in clean HTML5, CSS3, and JavaScript based on design mockups (`all_screens_overview_poster.jpeg` and `01_full_app_flowchart.jpeg`).

---

## 📁 File Structure & Core Responsibilities

- **[index.html](file:///home/basel/Work/flutter/nazel/index.html)**: Main HTML document (RTL `dir="rtl"`). Contains poster header branding, Map Key legend (مفتاح الخريطة), 14 interactive iPhone mockup screens, Quick Actions (+), System Popups/States, and footer banner.
- **[styles.css](file:///home/basel/Work/flutter/nazel/styles.css)**: Central design system using custom CSS properties (purples `#4F378B`, `#26134B`, lavender `#D0BCFF`, status badges, phone frames, SVG charts, upload hover outlines, and toast animations).
- **[app.js](file:///home/basel/Work/flutter/nazel/app.js)**: Interactive logic engine including dynamic image/icon uploader (`FileReader`), modal screen inspector (`openScreenModal`), More Menu drawer (`openMoreMenuModal`), sub-flow popups, Quick Actions (`openQuickActionModal`), and toast notification engine (`triggerToast`).

---

## 📱 14 Implemented Mobile App Screens

1. **Screen 1 - Welcome (شاشة الترحيب)**: Brand hero, login button, biometric login, forgot password flow trigger, signup link.
2. **Screen 2 - Login (تسجيل الدخول)**: Email/password form, remember me checkbox, login button, success state chip.
3. **Screen 3 - Dashboard (الرئيسية)**: Revenue (48,250 SAR) & Occupancy (78%) KPIs, check-in/out counters, AI assistant banner, recent requests.
4. **Screen 4 - Units (الوحدات)**: Unit cards with status chips (مشغولة / فارغة), distance & ratings, guest info, tab filters, FAB (+).
5. **Screen 5 - Calendar (التقويم)**: Monthly calendar view (May 2024), date status badges, legend indicators (فارغ, محجوز, قيد الوصول, قيد المغادرة), today's booking event card.
6. **Screen 6 - Bookings (الحجوزات)**: Platform-branded booking items (Airbnb, Booking.com, Gatherin) with tab filters.
7. **Screen 7 - Smart Pricing (التسعير الذكي)**: AI rate recommendations, daily rate calendar bar, occupancy prediction chart, bulk rate edit button.
8. **Screen 8 - Analytics (التحليلات)**: Revenue metrics, SVG donut chart for booking channels, top unit performance table, export actions.
9. **Screen 9 - Services & Requests (الخدمات والطلبات)**: Guest request items (cleaning, towels, maintenance, TV) with status checkmarks.
10. **Screen 10 - Licenses & Docs (التراخيص والوثائق)**: Compliance circular gauge (96% ممتاز), license expiry alerts, document upload trigger.
11. **Screen 11 - Financial Center (المركز المالي)**: Balance card (12,560 ر.س), subscription invoice download, payout history.
12. **Screen 12 - Notifications (التنبيهات)**: Real-time notification listing (new bookings, pricing alerts, license warnings, checkouts) with mark read button.
13. **Screen 13 - Integrations (التكاملات)**: Third-party platform connections (Airbnb, Booking.com, Gatherin, Google Calendar, WhatsApp) with toggle switches.
14. **Screen 14 - Settings (الإعدادات)**: Profile details (محمد الحربي), settings menu list, language selector, logout action.

---

## 🚀 Key Implemented Features

- **Click-to-Upload Images/Icons**: Every image placeholder, avatar, logo, property thumbnail, and icon (`.uploadable-img` & `.uploadable-icon`) opens a native file dialog to replace graphics dynamically in-place via HTML5 `FileReader`.
- **Flowchart Map Key**: Legend bar explaining main screens, sub-screens, actions, decisions, popups, and flow arrows.
- **Modal Screen Inspector & Sub-Flows**: Clicking any phone mockup opens a magnified interactive modal view. Includes "More Menu" drawer, Forgot Password modal, Revenue Details, Occupancy Report, Booking Details, AI Recommendation Details, and Notification Details popups.
- **Quick Actions (+)**: Toolbar for adding units, manual bookings, price edits, guest notifications, document uploads, photo uploads, and delete dialog.
- **System Popups & Toast Engine**: Interactive test buttons for Success, Error, Warning, Info toasts and status chips (`triggerToast`).

---

## 💻 How to Run & Serve

```bash
# Serve static files on port 8085 from project root (/home/basel/Work/flutter/nazel)
python3 -m http.server 8085
```

- **Local URL**: [http://localhost:8085/](http://localhost:8085/)

---

## 🔮 Next Steps for Future Agents / Developers

1. Connect backend APIs or Flutter app endpoints if transitioning to a live production application.
2. Integrate WebSockets for real-time live notification pushes and dynamic booking synchronization.
