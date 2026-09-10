import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';

enum NazelButtonVariant {
  primary,
  gold,
  secondary,
  outline,
}

class NazelButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final NazelButtonVariant variant;
  final double? width;
  final double? height;
  final Widget? icon;

  const NazelButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = NazelButtonVariant.primary,
    this.width,
    this.height,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    Border? border;

    switch (variant) {
      case NazelButtonVariant.primary:
        bg = NazelColors.primary;
        fg = NazelColors.surfaceWhite;
        break;
      case NazelButtonVariant.gold:
        bg = NazelColors.gold;
        fg = NazelColors.surfaceWhite;
        break;
      case NazelButtonVariant.secondary:
        bg = NazelColors.purpleSoft;
        fg = NazelColors.primary;
        break;
      case NazelButtonVariant.outline:
        bg = Colors.transparent;
        fg = NazelColors.primary;
        border = Border.all(color: NazelColors.primary, width: 1.5);
        break;
    }

    final buttonHeight = height ?? 56.0.h;

    return SizedBox(
      width: width,
      height: buttonHeight,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
              border: border,
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: NazelDimens.space20),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: NazelDimens.space8),
                  ],
                  Text(
                    text,
                    style: NazelTypography.arabic(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                      color: fg,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
