import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';
import '../widgets/organisms/modal_sheet_wrapper.dart';
import '../widgets/organisms/service_modals.dart';
import 'welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openModal(BuildContext context, String title, Widget content) {
    ModalSheetWrapper.show(context: context, title: title, content: content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1E9F8),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. RIGHT SIDEBAR (In RTL Row, 1st child is on the RIGHT side: 300px width in Figma)
            _buildRightSidebar(context),

            // 2. MAIN DASHBOARD CONTENT (In RTL Row, 2nd child is on the LEFT side)
            Expanded(
              child: Container(
                color: const Color(0xFFF1E9F8),
                padding: EdgeInsets.fromLTRB(24.0.w, 12.0.h, 24.0.w, 14.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Section 1: Top Header Bar (flex: 1) - Language button & Brand Logo
                    Expanded(flex: 1, child: _buildTopHeader(context)),
                    SizedBox(height: 8.0.h),

                    // Section 2: 8 Service Cards Grid (flex: 6)
                    Expanded(flex: 6, child: _buildServiceCardsGrid(context)),
                    SizedBox(height: 22.0.h),

                    // Section 3: Bottom Cruise Promotion Banner (flex: 2)
                    Expanded(flex: 2, child: _buildBottomCruiseBanner(context)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- TOP HEADER (App Icon & Tagline centered, Language button at edge) ---
  Widget _buildTopHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Far Edge Language Pill Button
        Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: const Color(0xFF532093),
            borderRadius: BorderRadius.circular(NazelDimens.radiusFull),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(NazelDimens.radiusFull),
              child: Container(
                width: 110.0.w,
                height: 44.0.h,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.language_rounded,
                      size: 18.0.r,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6.0.w),
                    Text(
                      'اللغة',
                      style: NazelTypography.arabic(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Center: Brand Logo (Horizontal) + Golden Tagline ("رحلتك تحتاج شاشة")
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/app Icon Horzintal.png',
                height: 50.0.h,
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.hotel_class_rounded,
                  size: 40.0.r,
                  color: NazelColors.primary,
                ),
              ),
              SizedBox(height: 2.0.h),
              Text(
                'رحلتك تحتاج شاشة',
                style: NazelTypography.arabic(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFDBBD75),
                  letterSpacing: 0.1,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- 8 SERVICES GRID (4x2) EXPANDED TO EXACT PROPORTIONS ---
  Widget _buildServiceCardsGrid(BuildContext context) {
    final services = [
      // Row 1
      {
        'title': 'طلب تنظيف',
        'subtitle': 'اطلب خدمة تنظيف',
        'image': 'assets/images/component_clean_681b0f2d.png',
        'action': () =>
            _openModal(context, 'طلب تنظيف', const CleaningServiceModal()),
      },
      {
        'title': 'طلبات التوصيل',
        'subtitle': 'مطاعم، بقائل، صيدليات',
        'image': 'assets/images/component_delviery_a7c0cea2.png',
        'action': () =>
            _openModal(context, 'طلبات التوصيل', const DeliveryServiceModal()),
      },
      {
        'title': 'مرافق قريبة',
        'subtitle': 'اكتشف الأماكن القريبة',
        'image': 'assets/images/component_location_43ee054e.png',
        'action': () =>
            _openModal(context, 'مرافق قريبة', const NearestPlacesModal()),
      },
      {
        'title': 'سياحة وتجارب',
        'subtitle': 'أنشطة وجولات سياحية',
        'image': 'assets/images/component_toursim_5618ef5e.png',
        'action': () =>
            _openModal(context, 'سياحة وتجارب', const TourismModal()),
      },
      // Row 2
      {
        'title': 'تمديد الحجز',
        'subtitle': 'إطالة مدة إقامتك',
        'image':
            'assets/images/component_copilot_20260613_195934_1_3fe84186.png',
        'action': () =>
            _openModal(context, 'تمديد الحجز', const ExtendBookingModal()),
      },
      {
        'title': 'معلومات الحجز',
        'subtitle': 'دليل وتعليمات الحجز',
        'image':
            'assets/images/component_copilot_20260613_195800_1_fcc7a387.png',
        'action': () =>
            _openModal(context, 'معلومات الشقة', const ApartmentInfoModal()),
      },
      {
        'title': 'طوارئ',
        'subtitle': 'تواصل سريع للطوارئ',
        'image':
            'assets/images/component_copilot_20260613_195408_1_d80dbf9a.png',
        'action': () => _openModal(context, 'طوارئ', const EmergencyModal()),
      },
      {
        'title': 'عروض وإعلانات',
        'subtitle': 'عروض وخدمات مميزة',
        'image':
            'assets/images/component_copilot_20260613_150121_2_7763537f.png',
        'action': () => _openModal(context, 'عروض وإعلانات', const AdsModal()),
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;
        final crossAxisSpacing = 20.0.w;
        final mainAxisSpacing = 16.0.h;
        final itemWidth = (availableWidth - (3 * crossAxisSpacing)) / 4.0;
        final itemHeight = (availableHeight - mainAxisSpacing) / 2.0;
        final dynamicAspectRatio = itemHeight > 0
            ? (itemWidth / itemHeight)
            : (225.0 / 275.0);

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: dynamicAspectRatio,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final s = services[index];
            return _buildServiceCard(
              title: s['title'] as String,
              subtitle: s['subtitle'] as String,
              imagePath: s['image'] as String,
              onTap: s['action'] as VoidCallback,
            );
          },
        );
      },
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String subtitle,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            offset: Offset(0, 4.h),
            blurRadius: 10.0.r,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
          splashColor: NazelColors.primary.withValues(alpha: 0.1),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Prominent Big 3D Icon (Figma 175x150 scale)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(2.0.r),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.category_rounded,
                          size: NazelDimens.iconLarge,
                          color: const Color(0xFF532093),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 6.0.h),
                Text(
                  title,
                  style: NazelTypography.arabic(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF532093),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.0.h),
                Text(
                  subtitle,
                  style: NazelTypography.arabic(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: NazelColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.0.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- BOTTOM CRUISE BANNER WITH FIGMA LINEAR OVERLAY (flex: 2) ---
  Widget _buildBottomCruiseBanner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF532093),
        borderRadius: BorderRadius.circular(28.0.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            offset: Offset(0, 6.h),
            blurRadius: 16.0.r,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openModal(context, 'سياحة وتجارب', const TourismModal()),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Left Ocean Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/ipad_image_ac159ff3.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.teal.shade900,
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.directions_boat_rounded,
                      size: 50.0.r,
                      color: Colors.white24,
                    ),
                  );
                },
              ),
            ),

            // Figma Linear Gradient Overlay (Solid Purple on Right, Fading over Ocean to Left in RTL)
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    stops: [0.0, 0.35, 0.55, 0.75, 1.0],
                    colors: [
                      Color(0xFF532093),
                      Color(0xFF532093),
                      Color(0xEE532093),
                      Color(0x66532093),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Content on Right Side (in RTL start)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.0.w,
                vertical: 8.0.h,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'رحلات بحرية خاصة',
                            style: NazelTypography.arabic(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.15,
                            ),
                          ),
                          SizedBox(height: 6.0.h),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '3 ساعات',
                                style: NazelTypography.arabic(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  height: 1.1,
                                ),
                              ),
                              SizedBox(width: 14.0.w),
                              Icon(
                                Icons.star_rounded,
                                size: 18.0.r,
                                color: const Color(0xFFDBBD75),
                              ),
                              SizedBox(width: 4.0.w),
                              Text(
                                '5',
                                style: NazelTypography.arabic(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFFDBBD75),
                                  height: 1.1,
                                ),
                              ),
                              SizedBox(width: 24.0.w),
                              Text(
                                '350',
                                style: NazelTypography.arabic(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  height: 1.1,
                                ),
                              ),
                              SizedBox(width: 4.0.w),
                              Text(
                                'رس',
                                style: NazelTypography.arabic(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white70,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- RIGHT SIDEBAR PANEL WITH FIGMA LINEAR COLORS & BOTTOM WI-FI ---
  Widget _buildRightSidebar(BuildContext context) {
    return Container(
      width: NazelDimens.sidebarWidth,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.22, 0.35, 1.0],
          colors: [
            Color(0xFF1A0A2D),
            Color(0xFF532093),
            Color(0xFF1A0A2D),
            Color(0xFF1A0A2D),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 90.0.h),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Top Guest Welcome Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'مرحبًا فيصل',
                    style: NazelTypography.arabic(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.0.h),
                  Text(
                    'نتمنى لك إقامة مريحة',
                    style: NazelTypography.arabic(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFDBBD75),
                      height: 1.1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.0.h),

            // Luxury Purple Sofa 3D Illustration (Figma: 300x159)
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/images/component_copilot_20260428_032411_2_47d6250f.png',
                width: double.infinity,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(height: 120.0.h);
                },
              ),
            ),
            SizedBox(height: 6.0.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: const Divider(color: Color(0x40DBBD75), height: 1.0),
            ),
            SizedBox(height: 8.0.h),

            // 2. Time Details Section ("تفاصيل الوقت")
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/ipad_clock_3819d9ee.png',
                        width: 20.0.r,
                        height: 20.0.r,
                        errorBuilder: (c, e, s) => Icon(
                          Icons.access_time_rounded,
                          size: 20.0.r,
                          color: const Color(0xFFDBBD75),
                        ),
                      ),
                      SizedBox(width: 8.0.w),
                      Text(
                        'تفاصيل الوقت',
                        style: NazelTypography.arabic(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFDBBD75),
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0.h),

                  // Check-in, Check-out, Remaining Tiles (Figma Neon Border #8A38F5 & Gold Icon Rings #DBBD75)
                  _buildFigmaTimeTile(
                    title: 'وقت الدخول',
                    value: '2027/02/01 - 00:00 PM',
                    iconPath:
                        'assets/images/component_calendar_plus_4b5f6e87.png',
                  ),
                  SizedBox(height: 6.0.h),
                  _buildFigmaTimeTile(
                    title: 'وقت الخروج',
                    value: '2027/02/04 - 4:30 PM',
                    iconPath:
                        'assets/images/component_calendar_minus_86ede528.png',
                  ),
                  SizedBox(height: 6.0.h),
                  _buildFigmaTimeTile(
                    title: 'الوقت المتبقي',
                    value: '01:01:40:00',
                    iconPath: 'assets/images/component_hourglass_53fb8db1.png',
                    isCountdown: true,
                  ),
                ],
              ),
            ),

            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: const Divider(color: Color(0x40DBBD75), height: 1.0),
            ),
            SizedBox(height: 8.0.h),

            // 3. Network Details Section at the BOTTOM ("تفاصيل الشبكة")
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/component_wi_fi_80c067aa.png',
                        width: 20.0.r,
                        height: 20.0.r,
                        errorBuilder: (c, e, s) => Icon(
                          Icons.wifi_rounded,
                          size: 20.0.r,
                          color: const Color(0xFFDBBD75),
                        ),
                      ),
                      SizedBox(width: 8.0.w),
                      Text(
                        'تفاصيل الشبكة',
                        style: NazelTypography.arabic(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFDBBD75),
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0.h),

                  // Wi-Fi Container with QR code & SSID/Password
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0.w,
                      vertical: 8.0.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF14022A).withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(15.0.r),
                      border: Border.all(
                        color: const Color(0xFF8A38F5),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      children: [
                        // QR Code Square (Responsive)
                        Container(
                          width: 90.0.r,
                          height: 90.0.r,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 8.0.r,
                                offset: Offset(0, 3.h),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(4.0.r),
                          child: Image.asset(
                            "assets/images/QR code.png",
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.qr_code_2_rounded,
                              size: 80.0.r,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0.w),

                        // SSID & Password
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'اسم الشبكة',
                                style: NazelTypography.arabic(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFDBBD75),
                                  height: 1.15,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'الاسم',
                                style: NazelTypography.arabic(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  height: 1.15,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.0.h),
                              Text(
                                'كلمة المرور',
                                style: NazelTypography.arabic(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFDBBD75),
                                  height: 1.15,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'الرقم السري',
                                      style: NazelTypography.arabic(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        height: 1.15,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Figma Time Tile with Purple Border #8A38F5 & Gold Circular Icon Frame #DBBD75
  Widget _buildFigmaTimeTile({
    required String title,
    required String value,
    required String iconPath,
    bool isCountdown = false,
  }) {
    return Container(
      constraints: BoxConstraints(minHeight: 68.0.h),
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.0.h),
      decoration: BoxDecoration(
        color: const Color(0xFF14022A).withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(15.0.r),
        border: Border.all(color: const Color(0xFF8A38F5), width: 1.2),
      ),
      child: Row(
        children: [
          // Circular Icon on start with Golden Outline Frame
          Container(
            width: 42.0.r,
            height: 42.0.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFDBBD75), width: 1.2),
              color: const Color(0xFF260D49),
            ),
            padding: EdgeInsets.all(6.0.r),
            child: Image.asset(
              iconPath,
              fit: BoxFit.contain,
              errorBuilder: (c, e, s) => Icon(
                Icons.event_note_rounded,
                size: 20.0.r,
                color: const Color(0xFFDBBD75),
              ),
            ),
          ),
          SizedBox(width: 10.0.w),

          // Title & Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: NazelTypography.arabic(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.0.h),
                Text(
                  value,
                  style: isCountdown
                      ? NazelTypography.arabic(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFDBBD75),
                          height: 1.15,
                        )
                      : NazelTypography.latin(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                          height: 1.15,
                        ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
