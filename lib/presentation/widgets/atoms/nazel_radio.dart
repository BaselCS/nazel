import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class NazelRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;

  const NazelRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 33.0.r,
        height: 33.0.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? NazelColors.primary : NazelColors.borderLight,
            width: isSelected ? 2.5 : 2.0,
          ),
          color: isSelected ? NazelColors.surfaceWhite : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: isSelected
            ? Container(
                width: 17.0.r,
                height: 17.0.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: NazelColors.primary,
                ),
              )
            : null,
      ),
    );
  }
}
