import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../widgets/organisms/modal_sheet_wrapper.dart';
import '../widgets/organisms/service_modals.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openModal(BuildContext context, String title, Widget content) {
    ModalSheetWrapper.show(context, title: title, content: content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NazelColors.purpleSoft,
      body: SafeArea(
        child: SelectionArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 20.0.h),
            child: Container(
              padding: EdgeInsets.all(22.0.r),
              decoration: BoxDecoration(
                color: NazelColors.surfaceWhite,
                borderRadius: BorderRadius.circular(16.0.r),
                border: Border.all(
                  color: NazelColors.purpleBorder.withValues(alpha: 0.35),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: NazelColors.primary.withValues(alpha: 0.08),
                    blurRadius: 20.0.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. SIDEBAR (Left column in kiosk layout)
                  SizedBox(
                    width: 250.0.w,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: _buildSidebar(),
                    ),
                  ),

                  SizedBox(width: 20.0.w),

                  // 2. MAIN CONTENT (Right column in kiosk layout)
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top Day Card (.daycard)
                          _buildDayCard(context),

                          SizedBox(height: 28.0.h),

                          // Bottom 4 Action Buttons Grid (.btns) - Fills remaining space
                          Expanded(child: _buildFourButtonsGrid(context)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- 1. SIDEBAR (.side) ---
  Widget _buildSidebar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Greeting
          Expanded(
            flex: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  'مرحبًا فيصل',
                  style: NazelTypography.display(
                    fontSize: 64.0,
                    fontWeight: FontWeight.bold,
                    color: NazelColors.primaryDark,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  minFontSize: 18,
                ),
                SizedBox(height: 20.0.h),
                AutoSizeText(
                  'من صاحب الوحدة: أي شيء\nتحتاجه أنا موجود',
                  style: NazelTypography.arabic(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: NazelColors.textSecondary,
                    height: 1.45,
                  ),
                  maxLines: 2,
                  minFontSize: 12,
                ),
              ],
            ),
          ),

          _buildSidebarDivider(),

          // 2. Next Prayer
          Expanded(
            flex: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  'الصلاة القادمة',
                  style: NazelTypography.arabic(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: NazelColors.textSecondary,
                  ),
                  maxLines: 1,
                  minFontSize: 11,
                ),
                SizedBox(height: 3.0.h),
                AutoSizeText(
                  'العصر · ٣:٢٤',
                  style: NazelTypography.display(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: NazelColors.primaryDark,
                  ),
                  maxLines: 1,
                  minFontSize: 16,
                ),
                SizedBox(height: 2.0.h),
                AutoSizeText(
                  'القبلة ٢٥٤°',
                  style: NazelTypography.arabic(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: NazelColors.textSecondary,
                  ),
                  maxLines: 1,
                  minFontSize: 11,
                ),
              ],
            ),
          ),

          _buildSidebarDivider(),

          // 3. Wi-Fi
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  'الواي فاي',
                  style: NazelTypography.arabic(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: NazelColors.textSecondary,
                  ),
                  maxLines: 1,
                  minFontSize: 11,
                ),
                SizedBox(height: 4.0.h),
                AutoSizeText(
                  'امسح الرمز واتصل',
                  style: NazelTypography.arabic(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    color: NazelColors.textPrimary,
                  ),
                  maxLines: 1,
                  minFontSize: 12,
                ),
              ],
            ),
          ),

          _buildSidebarDivider(),

          // 4. Checkout
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  'الخروج',
                  style: NazelTypography.arabic(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: NazelColors.textSecondary,
                  ),
                  maxLines: 1,
                  minFontSize: 11,
                ),
                SizedBox(height: 4.0.h),
                AutoSizeText(
                  'الأربعاء · ٤:٣٠ م',
                  style: NazelTypography.arabic(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    color: NazelColors.textPrimary,
                  ),
                  maxLines: 1,
                  minFontSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarDivider() {
    return Container(
      height: 1.0,
      color: NazelColors.purpleBorder.withValues(alpha: 0.25),
    );
  }

  // --- 2. DAY CARD (.daycard) ---
  Widget _buildDayCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(
          color: NazelColors.purpleBorder.withValues(alpha: 0.35),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: NazelColors.primary.withValues(alpha: 0.05),
            blurRadius: 8.0.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Purple accent strip on the right edge
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 4.5,
            child: Container(color: NazelColors.primary),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(22.0.w, 16.0.h, 26.0.w, 16.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  'بطاقة اليوم — تتغيّر حسب الوقت',
                  style: NazelTypography.arabic(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: NazelColors.textSecondary,
                  ),
                  maxLines: 1,
                  minFontSize: 11,
                ),
                SizedBox(height: 5.0.h),
                AutoSizeText(
                  'باقي على خروجك ٤ ساعات',
                  style: NazelTypography.display(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: NazelColors.primaryDark,
                    height: 1.25,
                  ),
                  maxLines: 1,
                  minFontSize: 18,
                ),
                SizedBox(height: 10.0.h),
                AutoSizeText(
                  'تبي تقعد أكثر؟ الوحدة فاضية الليلة',
                  style: NazelTypography.arabic(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    color: NazelColors.textSecondary,
                  ),
                  maxLines: 1,
                  minFontSize: 12,
                ),
                SizedBox(height: 14.0.h),
                Wrap(
                  spacing: 24.0.w,
                  runSpacing: 16.0.h,
                  children: [
                    // Filled Button: مدّد ليلة · ٣٥٠ ريال
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _openModal(
                          context,
                          'تمديد الإقامة',
                          const ExtendBookingModal(initialTab: 0),
                        ),
                        borderRadius: BorderRadius.circular(6.0.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 22.0.w,
                            vertical: 10.0.h,
                          ),
                          decoration: BoxDecoration(
                            color: NazelColors.primary,
                            borderRadius: BorderRadius.circular(6.0.r),
                            boxShadow: [
                              BoxShadow(
                                color: NazelColors.primary.withValues(
                                  alpha: 0.25,
                                ),
                                blurRadius: 8.0.r,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: AutoSizeText(
                            'مدّد ليلة · ٣٥٠ ريال',
                            style: NazelTypography.arabic(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            minFontSize: 11,
                          ),
                        ),
                      ),
                    ),

                    // Outlined Button: أخّر خروجي · ١٠٠ ريال
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _openModal(
                          context,
                          'تأخير الخروج',
                          const ExtendBookingModal(initialTab: 1),
                        ),
                        borderRadius: BorderRadius.circular(6.0.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 22.0.w,
                            vertical: 10.0.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6.0.r),
                            border: Border.all(
                              color: NazelColors.primary,
                              width: 1.4,
                            ),
                          ),
                          child: AutoSizeText(
                            'أخّر خروجي · ١٠٠ ريال',
                            style: NazelTypography.arabic(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                              color: NazelColors.primary,
                            ),
                            maxLines: 1,
                            minFontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 3. 4 BUTTONS GRID (.btns) ---
  Widget _buildFourButtonsGrid(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Right button in RTL: تحتاج شيئًا؟
              Expanded(
                child: _buildActionBtn(
                  title: 'تحتاج شيئًا؟',
                  onTap: () => _openModal(
                    context,
                    'تحتاج شيئًا؟',
                    const EmergencyModal(),
                  ),
                ),
              ),
              SizedBox(width: 36.0.w),
              // Left button in RTL: أبي أقعد أكثر
              Expanded(
                child: _buildActionBtn(
                  title: 'أبي أقعد أكثر',
                  onTap: () => _openModal(
                    context,
                    'تمديد الإقامة أو تأخير الخروج',
                    const ExtendBookingModal(),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 36.0.h),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Right button in RTL: اطلب خدمة
              Expanded(
                child: _buildActionBtn(
                  title: 'اطلب خدمة',
                  onTap: () => _openModal(
                    context,
                    'طلب خدمة متعاقد عليها',
                    const ServicesHubModal(),
                  ),
                ),
              ),
              SizedBox(width: 36.0.w),
              // Left button in RTL: دليل الوحدة
              Expanded(
                child: _buildActionBtn(
                  title: 'دليل الوحدة',
                  onTap: () => _openModal(
                    context,
                    'دليل الوحدة',
                    const ApartmentInfoModal(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionBtn({required String title, required VoidCallback onTap}) {
    return Material(
      color: NazelColors.surfaceWhite,
      borderRadius: BorderRadius.circular(6.0.r),
      child: InkWell(
        onTap: onTap,
        splashColor: NazelColors.purpleTint.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6.0.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0.r),
            border: Border.all(
              color: NazelColors.purpleBorder.withValues(alpha: 0.45),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: NazelColors.primary.withValues(alpha: 0.04),
                blurRadius: 6.0.r,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
          child: AutoSizeText(
            title,
            style: NazelTypography.arabic(
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
              color: NazelColors.primaryDark,
            ),
            maxLines: 1,
            minFontSize: 16,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
