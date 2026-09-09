import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import '../atoms/nazel_button.dart';

class StateDoneView extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onDone;

  const StateDoneView({
    super.key,
    this.title = 'أٌسلتم الطلب',
    required this.description,
    this.buttonText = 'تم',
    required this.onDone,
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
            // Success Checkmark Container
            Container(
              width: 140.0.r,
              height: 140.0.r,
              decoration: const BoxDecoration(
                color: NazelColors.successLight,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.check_circle_rounded,
                size: 80.0.r,
                color: NazelColors.success,
              ),
            ),
            SizedBox(height: NazelDimens.space24),
            // Title
            Text(
              title,
              style: NazelTypography.arabic(
                fontSize: 28.0,
                fontWeight: FontWeight.w900,
                color: NazelColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: NazelDimens.space12),
            // Description
            Text(
              description,
              style: NazelTypography.arabic(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: NazelColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: NazelDimens.space36),
            NazelButton(
              text: buttonText,
              variant: NazelButtonVariant.primary,
              onPressed: onDone,
              width: 240.0.w,
            ),
          ],
        ),
      ),
    );
  }
}
