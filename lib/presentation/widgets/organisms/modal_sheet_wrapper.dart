import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../molecules/nazel_app_bar.dart';

class ModalSheetWrapper extends StatelessWidget {
  final String title;
  final Widget content;
  final double? width;
  final double? height;
  final VoidCallback? onClose;
  final List<Widget>? headerActions;

  const ModalSheetWrapper({
    super.key,
    required this.title,
    required this.content,
    this.width,
    this.height,
    this.onClose,
    this.headerActions,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    double? width,
    double? height,
    List<Widget>? headerActions,
  }) {
    return showDialog<T>(
      context: context,
      barrierColor: NazelColors.overlayDim,
      barrierDismissible: true,
      builder: (ctx) => ModalSheetWrapper(
        title: title,
        content: content,
        width: width ?? NazelDimens.modalWidth,
        height: height ?? NazelDimens.modalHeight,
        headerActions: headerActions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: width ?? NazelDimens.modalWidth,
          height: height ?? NazelDimens.modalHeight,
          margin: EdgeInsets.all(NazelDimens.space24),
          decoration: BoxDecoration(
            color: NazelColors.surfaceWhite,
            borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                offset: Offset(0, 16.h),
                blurRadius: 40.0.r,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NazelAppBar(
                title: title,
                onBack: onClose ?? () => Navigator.of(context).pop(),
                actions: headerActions,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(NazelDimens.space24),
                  child: content,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
