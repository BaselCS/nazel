import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import '../atoms/nazel_icon.dart';
import '../atoms/nazel_radio.dart';
import '../atoms/nazel_rating_badge.dart';

class NazelChooseCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? leading;
  final Widget? trailing;
  final double? height;

  const NazelChooseCard({
    super.key,
    required this.title,
    this.subtitle,
    this.isSelected = false,
    required this.onTap,
    this.leading,
    this.trailing,
    this.height,
  });

  // Factory for Radio Selection Card (Cleaning, Booking, etc.)
  factory NazelChooseCard.selectable({
    required String title,
    String? subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    Widget? icon,
  }) {
    return NazelChooseCard(
      title: title,
      subtitle: subtitle,
      isSelected: isSelected,
      onTap: onTap,
      leading: icon,
      trailing: NazelRadio<bool>(
        value: true,
        groupValue: isSelected,
        onChanged: (_) => onTap(),
      ),
    );
  }

  // Factory for Nearest Facilities (Hospital, Bus, Store)
  factory NazelChooseCard.facility({
    required String title,
    required String distance,
    required String time,
    required NazelIconType iconType,
    required VoidCallback onTap,
  }) {
    return NazelChooseCard(
      title: title,
      subtitle: '$distance • $time',
      onTap: onTap,
      leading: Container(
        width: 56.0.r,
        height: 56.0.r,
        decoration: BoxDecoration(
          color: NazelColors.purpleSoft,
          borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
        ),
        alignment: Alignment.center,
        child: NazelIcon(type: iconType, size: 28.0.r),
      ),
      trailing: Icon(
        Icons.chevron_left_rounded,
        size: 28.0.r,
        color: NazelColors.textSecondary,
      ),
    );
  }

  // Factory for Restaurants / Delivery Shops
  factory NazelChooseCard.restaurant({
    required String title,
    required String category,
    required double rating,
    required String deliveryTime,
    required VoidCallback onTap,
  }) {
    return NazelChooseCard(
      title: title,
      subtitle: '$category • $deliveryTime',
      height: 120.0.h,
      onTap: onTap,
      leading: Container(
        width: 80.0.r,
        height: 80.0.r,
        decoration: BoxDecoration(
          color: NazelColors.purpleSoft,
          borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
        ),
        alignment: Alignment.center,
        child: NazelIcon(type: NazelIconType.shoppingCart, size: 36.0.r),
      ),
      trailing: NazelRatingBadge(rating: rating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? NazelDimens.chooseCardHeight,
      margin: EdgeInsets.symmetric(vertical: NazelDimens.space6),
      decoration: BoxDecoration(
        color: NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
        border: Border.all(
          color: isSelected ? NazelColors.primary : NazelColors.borderLight.withValues(alpha: 0.5),
          width: isSelected ? 2.0 : 1.0,
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
            padding: EdgeInsets.symmetric(
              horizontal: NazelDimens.space20,
              vertical: NazelDimens.space12,
            ),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  SizedBox(width: NazelDimens.space16),
                ],
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: NazelTypography.bodyLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: NazelDimens.space4),
                        Text(
                          subtitle!,
                          style: NazelTypography.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  SizedBox(width: NazelDimens.space12),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
