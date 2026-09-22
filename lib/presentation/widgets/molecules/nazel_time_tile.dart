import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
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
    final r = BorderRadius.circular(8.0.r);

    return Container(
      height: height ?? 68.0.h,
      margin: EdgeInsets.symmetric(vertical: 5.0.h),
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
            color: NazelColors.primary.withValues(alpha: 0.03),
            offset: const Offset(0, 2),
            blurRadius: 4.0.r,
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
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Row(
              children: [
                NazelIcon(
                  type: NazelIconType.clock,
                  size: 22.0.r,
                  color: NazelColors.primary,
                ),
                SizedBox(width: 12.0.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timeText,
                        style: NazelTypography.arabic(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w700,
                          color: NazelColors.primaryDark,
                        ),
                      ),
                      if (label != null) ...[
                        SizedBox(height: 2.0.h),
                        Text(
                          label!,
                          style: NazelTypography.arabic(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: NazelColors.textSecondary,
                          ),
                        ),
                      ],
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
