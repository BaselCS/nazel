import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class NazelCategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NazelCategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 8.0.h),
        decoration: BoxDecoration(
          color: isSelected ? NazelColors.primary : NazelColors.surfaceWhite,
          borderRadius: BorderRadius.circular(6.0.r),
          border: Border.all(
            color: isSelected
                ? NazelColors.primary
                : NazelColors.purpleBorder.withValues(alpha: 0.35),
            width: 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: NazelColors.primary.withValues(alpha: 0.25),
                    blurRadius: 6.0.r,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: NazelTypography.arabic(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : NazelColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
