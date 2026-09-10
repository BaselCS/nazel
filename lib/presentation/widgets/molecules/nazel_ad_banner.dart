import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../atoms/nazel_button.dart';

class NazelAdBanner extends StatelessWidget {
  final String title;
  final String discount;
  final String description;
  final String? buttonText;
  final VoidCallback onAction;
  final double? height;
  final LinearGradient gradient;

  const NazelAdBanner({
    super.key,
    required this.title,
    required this.discount,
    required this.description,
    this.buttonText,
    required this.onAction,
    this.height,
    this.gradient = NazelColors.primaryGradient,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final effectiveButton = buttonText ?? l10n?.bookNow ?? 'احجز الآن';

    return Container(
      height: height ?? 200.0.h,
      margin: EdgeInsets.symmetric(vertical: NazelDimens.space8),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(NazelDimens.radiusXl),
        boxShadow: [
          BoxShadow(
            color: NazelColors.primary.withValues(alpha: 0.15),
            offset: Offset(0, 8.h),
            blurRadius: 20.0.r,
          ),
        ],
      ),
      padding: EdgeInsets.all(NazelDimens.space24),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Discount tag
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: NazelDimens.space12,
                    vertical: NazelDimens.space4,
                  ),
                  decoration: BoxDecoration(
                    color: NazelColors.gold,
                    borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
                  ),
                  child: Text(
                    discount,
                    style: NazelTypography.arabic(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w900,
                      color: NazelColors.surfaceWhite,
                    ),
                  ),
                ),
                SizedBox(height: NazelDimens.space12),
                // Title
                Text(
                  title,
                  style: NazelTypography.arabic(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                    color: NazelColors.surfaceWhite,
                  ),
                ),
                SizedBox(height: NazelDimens.space6),
                // Description
                Text(
                  description,
                  style: NazelTypography.arabic(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: NazelColors.purpleTint,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: NazelDimens.space16),
          // Action CTA
          NazelButton(
            text: effectiveButton,
            variant: NazelButtonVariant.gold,
            onPressed: onAction,
            height: 48.0.h,
          ),
        ],
      ),
    );
  }
}
