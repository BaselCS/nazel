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
      backgroundColor: NazelColors.sand,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SelectionArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.w,
                vertical: 16.0.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. TOP MAIN SCREEN CONTAINER (Kiosk Screen - Fills main space)
                  Expanded(
                    flex: 10,
                    child: Container(
                      padding: EdgeInsets.all(14.0.r),
                      decoration: BoxDecoration(
                        color: NazelColors.paper,
                        borderRadius: BorderRadius.circular(6.0.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // A. SIDEBAR (Right in RTL - .side)
                          SizedBox(width: 260.0.w, child: _buildSidebar()),

                          SizedBox(width: 14.0.w),

                          // B. MAIN CONTENT (Left in RTL - .main)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Top Day Card (.daycard)
                                _buildDayCard(context),

                                SizedBox(height: 12.0.h),

                                // Bottom 4 Action Buttons Grid (.btns) - Fills remaining space
                                Expanded(child: _buildFourButtonsGrid(context)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 14.0.h),

                  // 2. BOTTOM 3 EXPLANATORY CARDS (Matching .grid3 in design)
                  Expanded(flex: 4, child: _buildBottomInfoGrid()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- 1A. SIDEBAR (.side) ---
  Widget _buildSidebar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 18.0.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Greeting
          Expanded(
            flex: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'مرحبًا فيصل',
                  style: NazelTypography.display(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: NazelColors.ink,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 4.0.h),
                Text(
                  'من صاحب الوحدة: أي شيء\nتحتاجه أنا موجود',
                  style: NazelTypography.arabic(
                    fontSize: 13.5,
                    color: NazelColors.muted,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),

          _buildDivider(),

          // 2. Next Prayer
          Expanded(
            flex: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'الصلاة القادمة',
                  style: NazelTypography.arabic(
                    fontSize: 12.5,
                    color: NazelColors.muted,
                  ),
                ),
                SizedBox(height: 3.0.h),
                Text(
                  'العصر · ٣:٢٤',
                  style: NazelTypography.display(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: NazelColors.ink,
                  ),
                ),
                SizedBox(height: 2.0.h),
                Text(
                  'القبلة ٢٥٤°',
                  style: NazelTypography.arabic(
                    fontSize: 13.0,
                    color: NazelColors.muted,
                  ),
                ),
              ],
            ),
          ),

          _buildDivider(),

          // 3. Wi-Fi
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'الواي فاي',
                  style: NazelTypography.arabic(
                    fontSize: 12.5,
                    color: NazelColors.muted,
                  ),
                ),
                SizedBox(height: 4.0.h),
                Text(
                  'امسح الرمز واتصل',
                  style: NazelTypography.arabic(
                    fontSize: 14.5,
                    color: NazelColors.ink,
                  ),
                ),
              ],
            ),
          ),

          _buildDivider(),

          // 4. Checkout
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'الخروج',
                  style: NazelTypography.arabic(
                    fontSize: 12.5,
                    color: NazelColors.muted,
                  ),
                ),
                SizedBox(height: 4.0.h),
                Text(
                  'الأربعاء · ٤:٣٠ م',
                  style: NazelTypography.arabic(
                    fontSize: 14.5,
                    color: NazelColors.ink,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1.0, color: NazelColors.line);
  }

  // --- 1B. DAY CARD (.daycard) ---
  Widget _buildDayCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.0.w, vertical: 16.0.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0.r),
        border: const Border(
          right: BorderSide(color: NazelColors.khuzama, width: 4.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'بطاقة اليوم — تتغيّر حسب الوقت',
            style: NazelTypography.arabic(
              fontSize: 13.0,
              color: NazelColors.muted,
            ),
          ),
          SizedBox(height: 4.0.h),
          Text(
            'باقي على خروجك ٤ ساعات',
            style: NazelTypography.display(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: NazelColors.ink,
              height: 1.3,
            ),
          ),
          SizedBox(height: 2.0.h),
          Text(
            'تبي تقعد أكثر؟ الوحدة فاضية الليلة',
            style: NazelTypography.arabic(
              fontSize: 15.0,
              color: NazelColors.muted,
            ),
          ),
          SizedBox(height: 14.0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Filled Button: مدّد ليلة · ٣٥٠ ريال
              InkWell(
                onTap: () => _openModal(
                  context,
                  'تمديد الإقامة',
                  const ExtendBookingModal(),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 22.0.w,
                    vertical: 9.0.h,
                  ),
                  decoration: BoxDecoration(
                    color: NazelColors.khuzama,
                    borderRadius: BorderRadius.circular(3.0.r),
                  ),
                  child: Text(
                    'مدّد ليلة · ٣٥٠ ريال',
                    style: NazelTypography.arabic(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0.w),

              // Outlined Button: أخّر خروجي · ١٠٠ ريال
              InkWell(
                onTap: () => _openModal(
                  context,
                  'تأخير الخروج',
                  const ExtendBookingModal(),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 22.0.w,
                    vertical: 9.0.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(3.0.r),
                    border: Border.all(color: NazelColors.khuzama, width: 1.2),
                  ),
                  child: Text(
                    'أخّر خروجي · ١٠٠ ريال',
                    style: NazelTypography.arabic(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: NazelColors.khuzama,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 1C. 4 BUTTONS GRID (.btns) ---
  Widget _buildFourButtonsGrid(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              SizedBox(width: 12.0.w),
              Expanded(
                child: _buildActionBtn(
                  title: 'أبي أقعد أكثر',
                  onTap: () => _openModal(
                    context,
                    'تمديد الإقامة',
                    const ExtendBookingModal(),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0.h),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _buildActionBtn(
                  title: 'اطلب خدمة',
                  onTap: () => _openModal(
                    context,
                    'طلب خدمة',
                    const CleaningServiceModal(),
                  ),
                ),
              ),
              SizedBox(width: 12.0.w),
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
      color: Colors.white,
      borderRadius: BorderRadius.circular(3.0.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(3.0.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0.r),
            border: Border.all(color: NazelColors.line, width: 1.0),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: NazelTypography.arabic(
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
              color: NazelColors.ink,
            ),
          ),
        ),
      ),
    );
  }

  // --- 2. BOTTOM 3 EXPLANATORY CARDS (.grid3) ---
  Widget _buildBottomInfoGrid() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Right card in RTL: معلومات دايمة
        Expanded(
          child: _buildBottomCard(
            title: 'معلومات دايمة',
            body:
                'مواقيت الصلاة والقبلة، الواي فاي، وقت الخروج. مواقيت الصلاة وحدها ترجّع الضيف للشاشة خمس مرات يوميًا من غير ما نطلب منه شيئًا.',
          ),
        ),
        SizedBox(width: 14.0.w),

        // 2. Middle card: بطاقة اليوم
        Expanded(
          child: _buildBottomCard(
            title: 'بطاقة اليوم',
            body:
                'شيء واحد كبير في الوسط يتغيّر حسب الوقت. هنا مكان العروض الحقيقي — العرض يجي للضيف، ما ينتظره في تبويب.',
          ),
        ),
        SizedBox(width: 14.0.w),

        // 3. Left card in RTL: أربعة أزرار ثابتة
        Expanded(
          child: _buildBottomCard(
            title: 'أربعة أزرار ثابتة',
            body:
                'ما تتغيّر أبدًا، عشان الضيف يتعلّم مكانها في أول دقيقة ويرتاح. اللي يتغيّر هو البطاقة فقط.',
          ),
        ),
      ],
    );
  }

  Widget _buildBottomCard({required String title, required String body}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 14.0.h),
      decoration: BoxDecoration(
        color: NazelColors.paper,
        borderRadius: BorderRadius.circular(4.0.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: NazelTypography.display(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: NazelColors.ink,
            ),
          ),
          SizedBox(height: 6.0.h),
          Expanded(
            child: Text(
              body,
              style: NazelTypography.arabic(
                fontSize: 13.5,
                color: NazelColors.ink,
                height: 1.65,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
