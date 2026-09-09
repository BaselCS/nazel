import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';

class NazelAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const NazelAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: NazelDimens.appBarHeight,
      padding: EdgeInsets.symmetric(horizontal: NazelDimens.space24),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Centered Title
          Text(
            title,
            style: NazelTypography.modalTitle,
            textAlign: TextAlign.center,
          ),
          // Back button on the leading side
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: onBack ?? () => Navigator.maybePop(context),
              icon: Container(
                padding: EdgeInsets.all(NazelDimens.space8),
                decoration: BoxDecoration(
                  color: NazelColors.purpleSoft,
                  borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20.0.r,
                  color: NazelColors.primary,
                ),
              ),
              splashRadius: 24.0.r,
            ),
          ),
          // Actions on the trailing side
          if (actions != null)
            Positioned(
              left: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              ),
            ),
        ],
      ),
    );
  }
}
