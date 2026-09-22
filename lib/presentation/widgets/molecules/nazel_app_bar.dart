import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class NazelAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const NazelAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64.0.h,
      decoration: BoxDecoration(
        color: backgroundColor ?? NazelColors.surfaceWhite,
        border: Border(
          bottom: BorderSide(
            color: NazelColors.purpleBorder.withValues(alpha: 0.25),
            width: 1.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Centered Title
          Center(
            child: Text(
              title,
              style: NazelTypography.arabic(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: NazelColors.primaryDark,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Pop-up back button: on end edge (left in Arabic RTL)
          Positioned.directional(
            textDirection: Directionality.of(context),
            end: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onBack ?? () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(8.0.r),
                child: Container(
                  padding: EdgeInsets.all(8.0.r),
                  decoration: BoxDecoration(
                    color: NazelColors.purpleSoft.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8.0.r),
                    border: Border.all(
                      color: NazelColors.purpleBorder.withValues(alpha: 0.25),
                      width: 1.0,
                    ),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: NazelColors.primaryDark,
                    size: 20.0.r,
                  ),
                ),
              ),
            ),
          ),
          // Actions on opposite edge (start edge)
          if (actions != null)
            Positioned.directional(
              textDirection: Directionality.of(context),
              start: 0,
              child: Row(mainAxisSize: MainAxisSize.min, children: actions!),
            ),
        ],
      ),
    );
  }
}
