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
  /// Optional full-width footer rendered outside the padded content area.
  final Widget? footer;

  const ModalSheetWrapper({
    super.key,
    required this.title,
    required this.content,
    this.width,
    this.height,
    this.onClose,
    this.headerActions,
    this.footer,
  });

  static Future<T?> show<T>(BuildContext context, {
    required String title,
    required Widget content,
    double? width,
    double? height,
    List<Widget>? headerActions,
    Widget? footer,
  }) {
    return showDialog<T>(
      context: context,
      barrierColor: NazelColors.sidebarBg.withValues(alpha: 0.45),
      barrierDismissible: true,
      builder: (ctx) => ModalSheetWrapper(
        title: title,
        content: content,
        width: width ?? NazelDimens.modalWidth,
        height: height ?? NazelDimens.modalHeight,
        headerActions: headerActions,
        footer: footer,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: width ?? NazelDimens.modalWidth,
            height: height ?? NazelDimens.modalHeight,
            margin: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 20.0.h),
            decoration: BoxDecoration(
              color: NazelColors.surfaceWhite,
              borderRadius: BorderRadius.circular(16.0.r),
              border: Border.all(
                color: NazelColors.purpleBorder.withValues(alpha: 0.35),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: NazelColors.primary.withValues(alpha: 0.12),
                  offset: const Offset(0, 8),
                  blurRadius: 28.0.r,
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
                    padding: EdgeInsets.all(22.0.r),
                    child: content,
                  ),
                ),
                ?footer,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
