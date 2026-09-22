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
        width: 52.0.r,
        height: 52.0.r,
        decoration: BoxDecoration(
          color: NazelColors.purpleSoft,
          borderRadius: BorderRadius.circular(6.0.r),
        ),
        alignment: Alignment.center,
        child: NazelIcon(type: iconType, size: 26.0.r),
      ),
      trailing: Builder(
        builder: (context) {
          return Icon(
            NazelDirectionalIcons.chevronForward(context),
            size: 24.0.r,
            color: NazelColors.textSecondary,
          );
        },
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
      height: 110.0.h,
      onTap: onTap,
      leading: Container(
        width: 72.0.r,
        height: 72.0.r,
        decoration: BoxDecoration(
          color: NazelColors.purpleSoft,
          borderRadius: BorderRadius.circular(6.0.r),
        ),
        alignment: Alignment.center,
        child: NazelIcon(type: NazelIconType.shoppingCart, size: 32.0.r),
      ),
      trailing: NazelRatingBadge(rating: rating),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(8.0.r);

    return Container(
      height: height ?? NazelDimens.chooseCardHeight,
      margin: EdgeInsets.symmetric(vertical: 6.0.h),
      decoration: BoxDecoration(
        color: isSelected
            ? NazelColors.purpleSoft.withValues(alpha: 0.35)
            : NazelColors.surfaceWhite,
        borderRadius: r,
        border: Border.all(
          color: isSelected
              ? NazelColors.primary
              : NazelColors.purpleBorder.withValues(alpha: 0.35),
          width: isSelected ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: NazelColors.primary.withValues(alpha: 0.04),
            offset: const Offset(0, 2),
            blurRadius: 6.0.r,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: r,
        child: InkWell(
          onTap: onTap,
          borderRadius: r,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 18.0.w,
              vertical: 12.0.h,
            ),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  SizedBox(width: 14.0.w),
                ],
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: NazelTypography.arabic(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: NazelColors.primaryDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 4.0.h),
                        Text(
                          subtitle!,
                          style: NazelTypography.arabic(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            color: NazelColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  SizedBox(width: 12.0.w),
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
