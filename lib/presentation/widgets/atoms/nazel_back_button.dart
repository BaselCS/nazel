import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import 'nazel_icon.dart';

class NazelBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final double? size;
  final String? tooltip;
  final IconData? icon;

  const NazelBackButton({
    super.key,
    this.onPressed,
    this.color,
    this.size,
    this.tooltip,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon ?? NazelDirectionalIcons.back(context),
        color: color ?? NazelColors.surfaceWhite,
        size: size ?? 22.0.r,
      ),
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      splashRadius: 24.0.r,
      tooltip: tooltip,
    );
  }
}
