import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
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
      height: 72.0.h,
      decoration: BoxDecoration(
        color: backgroundColor ?? NazelColors.primary,
      ),
      padding: EdgeInsets.symmetric(horizontal: NazelDimens.space24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Centered Title
          Center(
            child: Text(
              title,
              style: NazelTypography.arabic(
                fontSize: 22.0,
                fontWeight: FontWeight.w900,
                color: NazelColors.surfaceWhite,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Back button on left with forward arrow for Arabic RTL
          Positioned(
            left: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onBack ?? () => Navigator.maybePop(context),
              child: Container(
                padding: EdgeInsets.all(NazelDimens.space12),
                color: Colors.transparent,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 22.0.r,
                  color: NazelColors.surfaceWhite,
                ),
              ),
            ),
          ),
          // Actions on the right side
          if (actions != null)
            Positioned(
              right: 0,
              child: Row(mainAxisSize: MainAxisSize.min, children: actions!),
            ),
        ],
      ),
    );
  }
}
