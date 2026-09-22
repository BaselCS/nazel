import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import '../atoms/nazel_icon.dart';
import '../atoms/nazel_rating_badge.dart';

class NazelGridProductCard extends StatelessWidget {
  final String title;
  final double price;
  final double rating;
  final VoidCallback onTap;
  final bool isSelected;
  final Widget? thumbnail;
  final double? width;
  final double? height;

  const NazelGridProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.rating,
    required this.onTap,
    this.isSelected = false,
    this.thumbnail,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 189.0.w,
      height: height ?? 269.0.h,
      decoration: BoxDecoration(
        color: NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
        border: Border.all(
          color: isSelected
              ? NazelColors.gold
              : NazelColors.borderLight.withValues(alpha: 0.8),
          width: isSelected ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: NazelColors.primary.withValues(alpha: 0.04),
            offset: Offset(0, 4.h),
            blurRadius: 12.0.r,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
          child: Padding(
            padding: EdgeInsets.all(NazelDimens.space16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail / 3D Icon container
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: NazelColors.purpleSoft,
                      borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
                    ),
                    alignment: Alignment.center,
                    child: thumbnail ??
                        NazelIcon(
                          type: NazelIconType.delivery,
                          size: NazelDimens.iconLarge,
                        ),
                  ),
                ),
                SizedBox(height: NazelDimens.space12),
                // Title
                AutoSizeText(
                  title,
                  style: NazelTypography.arabic(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  minFontSize: 11,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: NazelDimens.space6),
                // Rating & Price row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NazelRatingBadge(rating: rating),
                    Text(
                      '$price رس',
                      style: NazelTypography.arabic(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w900,
                        color: NazelColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
