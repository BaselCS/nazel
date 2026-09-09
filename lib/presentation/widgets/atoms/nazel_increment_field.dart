import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import 'nazel_icon.dart';

class NazelIncrementField extends StatelessWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const NazelIncrementField({
    super.key,
    required this.value,
    this.minValue = 1,
    this.maxValue = 99,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: NazelDimens.incrementFieldWidth,
      height: NazelDimens.incrementFieldHeight,
      decoration: BoxDecoration(
        color: NazelColors.purpleSoft,
        borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
        border: Border.all(
          color: NazelColors.purpleBorder.withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: NazelDimens.space12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Plus button
          IconButton(
            onPressed: value < maxValue ? () => onChanged(value + 1) : null,
            icon: NazelIcon(type: NazelIconType.plus, size: 20.0.r),
            splashRadius: 20.0.r,
          ),
          // Center numeric value
          Text(
            '$value',
            style: NazelTypography.latin(
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
              color: NazelColors.primary,
            ),
          ),
          // Minus button
          IconButton(
            onPressed: value > minValue ? () => onChanged(value - 1) : null,
            icon: NazelIcon(type: NazelIconType.minus, size: 20.0.r),
            splashRadius: 20.0.r,
          ),
        ],
      ),
    );
  }
}
