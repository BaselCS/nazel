import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import '../atoms/nazel_icon.dart';
import '../atoms/nazel_radio.dart';

class NazelTimeTile extends StatelessWidget {
  final String timeText;
  final String? label;
  final bool isSelected;
  final VoidCallback onTap;
  final double? height;

  const NazelTimeTile({
    super.key,
    required this.timeText,
    this.label,
    required this.isSelected,
    required this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 73.0.h,
      margin: EdgeInsets.symmetric(vertical: NazelDimens.space6),
      decoration: BoxDecoration(
        color: isSelected ? NazelColors.purpleSoft : NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(NazelDimens.radiusMd),
        border: Border.all(
          color: isSelected ? NazelColors.primary : NazelColors.borderLight.withValues(alpha: 0.6),
          width: isSelected ? 2.0 : 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(NazelDimens.radiusMd),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(NazelDimens.radiusMd),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: NazelDimens.space16),
            child: Row(
              children: [
                NazelIcon(type: NazelIconType.clock, size: 24.0.r),
                SizedBox(width: NazelDimens.space12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timeText,
                        style: NazelTypography.arabic(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w800,
                          color: NazelColors.textPrimary,
                        ),
                      ),
                      if (label != null)
                        Text(
                          label!,
                          style: NazelTypography.bodySmall,
                        ),
                    ],
                  ),
                ),
                NazelRadio<bool>(
                  value: true,
                  groupValue: isSelected,
                  onChanged: (_) => onTap(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
