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
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const NazelIncrementField({
    super.key,
    required this.value,
    this.minValue = 1,
    this.maxValue = 99,
    required this.onChanged,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? NazelColors.purpleSoft;
    final border = borderColor ?? NazelColors.purpleBorder.withValues(alpha: 0.3);
    final textCol = textColor ?? NazelColors.primary;
    final iconCol = iconColor ?? NazelColors.textPrimary;
    final r = borderRadius ?? BorderRadius.circular(NazelDimens.radiusSm);

    return Container(
      width: width ?? NazelDimens.incrementFieldWidth,
      height: height ?? NazelDimens.incrementFieldHeight,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: r,
        border: Border.all(
          color: border,
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
            icon: NazelIcon(type: NazelIconType.plus, size: 20.0.r, color: iconCol),
            splashRadius: 20.0.r,
          ),
          // Center numeric value
          Text(
            '$value',
            style: NazelTypography.latin(
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
              color: textCol,
            ),
          ),
          // Minus button
          IconButton(
            onPressed: value > minValue ? () => onChanged(value - 1) : null,
            icon: NazelIcon(type: NazelIconType.minus, size: 20.0.r, color: iconCol),
            splashRadius: 20.0.r,
          ),
        ],
      ),
    );
  }
}
