import 'package:auto_size_text/auto_size_text.dart';
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

    List<BoxShadow>? shadow;

    switch (variant) {
      case NazelButtonVariant.primary:
      case NazelButtonVariant.gold:
        bg = NazelColors.primary;
        fg = NazelColors.surfaceWhite;
        shadow = [
          BoxShadow(
            color: NazelColors.primary.withValues(alpha: 0.25),
            blurRadius: 8.0.r,
            offset: const Offset(0, 3),
          ),
        ];
        break;
      case NazelButtonVariant.secondary:
        bg = NazelColors.purpleSoft;
        fg = NazelColors.primary;
        border = Border.all(
          color: NazelColors.purpleBorder.withValues(alpha: 0.3),
          width: 1.0,
        );
        break;
      case NazelButtonVariant.outline:
        bg = Colors.transparent;
        fg = NazelColors.primary;
        border = Border.all(color: NazelColors.primary, width: 1.4);
        break;
    }

    final buttonHeight = height ?? 52.0.h;
    final r = BorderRadius.circular(6.0.r);

    return SizedBox(
      width: width,
      height: buttonHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: r,
          child: Container(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: r,
              border: border,
              boxShadow: shadow,
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 18.0.w),
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
                  AutoSizeText(
                    text,
                    style: NazelTypography.arabic(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: fg,
                    ),
                    maxLines: 1,
                    minFontSize: 11,
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
