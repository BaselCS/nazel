import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import 'nazel_icon.dart';

class NazelRatingBadge extends StatelessWidget {
  final double rating;
  final int? reviewsCount;

  const NazelRatingBadge({
    super.key,
    required this.rating,
    this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: NazelDimens.space8,
        vertical: NazelDimens.space4,
      ),
      decoration: BoxDecoration(
        color: NazelColors.gold.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(NazelDimens.radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NazelIcon(
            type: NazelIconType.star,
            size: 16.0.r,
            color: NazelColors.goldDark,
          ),
          SizedBox(width: NazelDimens.space4),
          Text(
            rating.toStringAsFixed(1),
            style: NazelTypography.latin(
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              color: NazelColors.goldDark,
            ),
          ),
          if (reviewsCount != null) ...[
            SizedBox(width: NazelDimens.space2),
            Text(
              '($reviewsCount)',
              style: NazelTypography.latin(
                fontSize: 12.0,
                color: NazelColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
