import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 22.0.w, vertical: 10.0.h),
        decoration: BoxDecoration(
          color: NazelColors.surfaceWhite,
          borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
          border: Border.all(
            color: isSelected
                ? NazelColors.gold
                : NazelColors.borderLight.withValues(alpha: 0.8),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: NazelTypography.arabic(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: isSelected ? NazelColors.primary : NazelColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
