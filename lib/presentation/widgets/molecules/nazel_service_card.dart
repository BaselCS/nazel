import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import '../atoms/nazel_icon.dart';

class NazelServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final NazelIconType iconType;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final double? width;
  final double? height;

  const NazelServiceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconType,
    required this.onTap,
    this.backgroundColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? NazelDimens.serviceCardWidth,
      height: height ?? NazelDimens.serviceCardHeight,
      decoration: BoxDecoration(
        color: backgroundColor ?? NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
        boxShadow: [
          BoxShadow(
            color: NazelColors.primary.withValues(alpha: 0.06),
            offset: Offset(0, 8.h),
            blurRadius: 24.0.r,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: NazelDimens.space24,
              vertical: NazelDimens.space32,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon illustration container
                Container(
                  width: 100.0.r,
                  height: 100.0.r,
                  decoration: const BoxDecoration(
                    color: NazelColors.purpleSoft,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: NazelIcon(
                    type: iconType,
                    size: 52.0.r,
                    color: NazelColors.primary,
                  ),
                ),
                SizedBox(height: NazelDimens.space16),
                // Title
                Text(
                  title,
                  style: NazelTypography.serviceTitle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: NazelDimens.space6),
                // Subtitle
                Text(
                  subtitle,
                  style: NazelTypography.serviceSubtitle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
