---
trigger: always_on
---

# Nazel (نازل) - Project Vision & System Architecture

## 1. Executive Summary & Vision
- **Product**: In-room smart hospitality SaaS platform for tablets (iPad / Android tablets).
- **Target Venues**: Hotels, motels, serviced apartments, luxury chalets, and boutique resorts.
- **Core Value**: Digital concierge kiosk replacing paper menus and brochures, allowing guests to order services, discover nearby places, book activities, and communicate with property staff.

## 2. Hardware & Device Setup
- **Dedicated Hardware**: 1 tablet per room / suite mounted or docked.
- **Device Identification**: Identified purely by unique `deviceId` (mapped to property tenant + room/unit number on backend).
- **Zero Friction**: No guest authentication, QR scan, or app download required to use basic in-room services.

## 3. Technology Stack & Backend Strategy
- **Frontend App**: Flutter (optimized for iPad / tablet landscape orientation, RTL Arabic & LTR English).
- **Backend**: Firebase (Cloud Firestore for real-time order streams, Firebase Storage, Cloud Functions for push notifications).
- **PMS / BMS**: No Property Management System integration required for current phase (planned for future enterprise phase).
- **Payment Processing**: No direct payment gateway integration for now (orders logged to room account / folio or submitted as requests).

## 4. Current Fixed Service Catalog (MVP Scope)
1. **Cleaning & Laundry (`طلب تنظيف وغسيل`)**:
   - Quick clean (ترتيب الغرف والأسطح)
   - Deep clean (تنظيف شامل ومرافق)
   - Linen & towel change (تغيير شراشف ومستلزمات الحمام)
   - Clothes laundry & ironing (غسيل وكوي الملابس)
   - Preferred time slot selection + custom guest notes.

2. **Food & Delivery (`طلبات التوصيل`)**:
   - Categories: Restaurants, supermarkets, cafes, juices, pharmacies.
   - Menu item selection + quantity + special request notes.

3. **Nearby Amenities (`مرافق قريبة`)**:
   - Categorized locations: Hospitals, public transport / buses, grocery stores, mosques.
   - Distance (km), walking/driving time estimates, and directions.

4. **Tourism & Local Experiences (`سياحة وتجارب`)**:
   - Featured experiences (private yacht cruise, desert safari, city heritage tours).
   - Duration, ratings, pricing, and direct booking request.
   - Dynamic QR Code for each attraction: Guest scans QR code with personal phone to open direct Google Maps navigation.

5. **Extend Stay (`تمديد الحجز`)**:
   - Room number and current checkout summary.
   - Dynamic day counter with automatic total price calculation.
   - Direct extension request sent to management.

6. **Apartment & Room Info (`معلومات الشقة / الحجز`)**:
   - Digital appliance manuals (AC, washer, smart TV).
   - Checkout policies and property rules.
   - Front desk and concierge contact info.

7. **Emergency Contacts (`طوارئ`)**:
   - One-tap quick emergency dial (Police 999, Ambulance 997, 24/7 Facility Maintenance).

8. **Exclusive Ads & Promotions (`عروض وإعلانات`)**:
   - Special promo banners, local tour discounts, and luxury partner perks.

9. **Sidebar Dashboard Information**:
   - Guest personalization & greeting.
   - Check-in time, check-out time, real-time remaining stay countdown.
   - In-room Wi-Fi details with auto-connect QR code + SSID and password.

## 5. Feature Scoping & Decisions (MVP vs Postponed)
### Step A: Core Guest Screen Features
- **[IN MVP]** Guest Welcome & Booking Info (Guest name, check-in/out times)
- **[IN MVP]** Language Auto-switch (Arabic / English based on booking info)
- **[IN MVP]** Wi-Fi QR Code & House Rules
- **[IN MVP]** Local Guide / Places nearby (Basic curated spots + Google Maps QR)
- **[IN MVP]** Direct Support / Help button

### Step B: Core Owner Dashboard Features
- **[IN MVP]** Property & Screen content editor
- **[IN MVP]** Basic access permissions / auth
- **[POSTPONED]** Advanced analytics / automated messaging (v2)

## 6. Future Roadmap & Iterations
- **Phase 2**: Real-time staff dispatch dashboard (web / mobile), advanced analytics, automated messaging, and Web Kiosk Simulator (under study - allows interacting with app on web without physical tablet connection).
- **Phase 3**: Payment gateway (Mada, Apple Pay, Credit Card) for instant paid services.
- **Phase 4**: PMS integrations (Opera, Cloudbeds, Mews) for automated check-in sync and billing folio integration.

