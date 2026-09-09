import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import '../atoms/nazel_icon.dart';

class NazelWifiCard extends StatelessWidget {
  final String networkName;
  final String password;
  final VoidCallback? onScanQr;
  final double? width;

  const NazelWifiCard({
    super.key,
    required this.networkName,
    required this.password,
    this.onScanQr,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 280.0.w,
      padding: EdgeInsets.all(NazelDimens.space20),
      decoration: BoxDecoration(
        color: NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
        boxShadow: [
          BoxShadow(
            color: NazelColors.primary.withValues(alpha: 0.06),
            offset: Offset(0, 8.h),
            blurRadius: 24.0.r,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(NazelDimens.space8),
                decoration: BoxDecoration(
                  color: NazelColors.purpleSoft,
                  borderRadius: BorderRadius.circular(NazelDimens.radiusXs),
                ),
                child: NazelIcon(type: NazelIconType.wifi, size: 22.0.r),
              ),
              SizedBox(width: NazelDimens.space12),
              Text(
                'الواي فاي',
                style: NazelTypography.arabic(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: NazelColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: NazelDimens.space16),
          // QR Code representation
          GestureDetector(
            onTap: onScanQr,
            child: Container(
              width: 160.0.r,
              height: 160.0.r,
              decoration: BoxDecoration(
                color: NazelColors.purpleSoft,
                borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
                border: Border.all(color: NazelColors.purpleBorder.withValues(alpha: 0.4)),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.qr_code_2_rounded,
                size: 110.0.r,
                color: NazelColors.primary,
              ),
            ),
          ),
          SizedBox(height: NazelDimens.space16),
          // Network Info Rows
          _buildInfoRow('اسم الشبكة', networkName),
          SizedBox(height: NazelDimens.space8),
          _buildInfoRow('كلمة المرور', password),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: NazelDimens.space12,
        vertical: NazelDimens.space8,
      ),
      decoration: BoxDecoration(
        color: NazelColors.background,
        borderRadius: BorderRadius.circular(NazelDimens.radiusXs),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: NazelTypography.bodySmall),
          Text(
            value,
            style: NazelTypography.arabic(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: NazelColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
