import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../atoms/nazel_button.dart';

class StateSoonView extends StatelessWidget {
  final String? message;
  final VoidCallback? onBack;

  const StateSoonView({
    super.key,
    this.message,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final effectiveMessage =
        message ?? l10n?.serviceSoonTitle ?? 'ستتوفر الخدمة قريباً';
    final effectiveDesc = l10n?.serviceSoonDesc ??
        'نعمل حالياً على تجهيز هذه الميزة لتقديم أفضل تجربة لإقامتك';
    final effectiveBack = l10n?.backToHome ?? 'العودة للرئيسية';

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
              effectiveMessage,
              style: NazelTypography.arabic(
                fontSize: 26.0,
                fontWeight: FontWeight.w700,
                color: NazelColors.primaryDark,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: NazelDimens.space12),
            Text(
              effectiveDesc,
              style: NazelTypography.arabic(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: NazelColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onBack != null) ...[
              SizedBox(height: NazelDimens.space32),
              NazelButton(
                text: effectiveBack,
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
