import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import '../atoms/nazel_button.dart';

class StateSoonView extends StatelessWidget {
  final String message;
  final VoidCallback? onBack;

  const StateSoonView({
    super.key,
    this.message = 'ستتوفر الخدمة قريباً',
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: NazelDimens.space40,
          horizontal: NazelDimens.space20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 3D Luggage Graphic Container
            Container(
              width: 140.0.r,
              height: 140.0.r,
              decoration: const BoxDecoration(
                color: NazelColors.purpleSoft,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.luggage_rounded,
                size: 72.0.r,
                color: NazelColors.primary,
              ),
            ),
            SizedBox(height: NazelDimens.space24),
            // Message
            Text(
              message,
              style: NazelTypography.arabic(
                fontSize: 28.0,
                fontWeight: FontWeight.w900,
                color: NazelColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: NazelDimens.space12),
            Text(
              'نعمل حالياً على تجهيز هذه الميزة لتقديم أفضل تجربة لإقامتك',
              style: NazelTypography.serviceSubtitle,
              textAlign: TextAlign.center,
            ),
            if (onBack != null) ...[
              SizedBox(height: NazelDimens.space32),
              NazelButton(
                text: 'العودة للرئيسية',
                variant: NazelButtonVariant.secondary,
                onPressed: onBack,
                width: 220.0.w,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
