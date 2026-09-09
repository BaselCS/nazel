import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Fullscreen Luxury Ambient Background Image
          Image.asset(
            'assets/images/ipad_image_14_4038baab.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [NazelColors.primaryDark, NazelColors.primary],
                  ),
                ),
              );
            },
          ),

          // 2. Subtle Dark Gradient Overlay for optimal contrast
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.25),
                ],
              ),
            ),
          ),

          // 3. Foreground Content
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: NazelDimens.space32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Center Brand Logo (Vertical)
                    Image.asset(
                      'assets/icons/app Icon Verticel.png',
                      width: 260.0.r,
                      height: 260.0.r,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 140.0.r,
                          height: 140.0.r,
                          decoration: BoxDecoration(
                            color: NazelColors.surfaceWhite.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.hotel_class_rounded,
                            size: 80.0.r,
                            color: NazelColors.gold,
                          ),
                        );
                      },
                    ),

                    SizedBox(height: NazelDimens.space24),

                    // Tagline: "رحلتك تحتاج شاشة"
                    Text(
                      'رحلتك تحتاج شاشة',
                      style: NazelTypography.arabic(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w900,
                        color: NazelColors.surfaceWhite,
                      ).copyWith(
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            offset: Offset(0, 3.h),
                            blurRadius: 10.0.r,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: NazelDimens.space48),

                    // Dual Language Pill Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Arabic Button
                        _buildLanguagePillButton(
                          context: context,
                          label: 'عربي',
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                        ),

                        SizedBox(width: NazelDimens.space24),

                        // English Button
                        _buildLanguagePillButton(
                          context: context,
                          label: 'English',
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguagePillButton({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 240.0.w,
      height: 80.0.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF2BD70),
        borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            offset: Offset(0, 6.h),
            blurRadius: 16.0.r,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
          splashColor: Colors.white.withValues(alpha: 0.2),
          highlightColor: Colors.white.withValues(alpha: 0.1),
          child: Center(
            child: Text(
              label,
              style: NazelTypography.arabic(
                fontSize: 32.0,
                fontWeight: FontWeight.w800,
                color: NazelColors.surfaceWhite,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
