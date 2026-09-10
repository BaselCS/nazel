import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';

enum NazelIconType {
  clean,
  delivery,
  nearest,
  tourism,
  extend,
  info,
  emergency,
  ads,
  wifi,
  clock,
  search,
  shoppingCart,
  hospital,
  bus,
  phone,
  home,
  vacuum,
  ambulance,
  wrench,
  plus,
  minus,
  star,
  back,
  forward,
}

class NazelDirectionalIcons {
  static IconData back(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return isRtl
        ? Icons.arrow_forward_ios_rounded
        : Icons.arrow_forward_ios_rounded;
  }

  static IconData forward(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return isRtl
        ? Icons.arrow_back_ios_new_rounded
        : Icons.arrow_back_ios_new_rounded;
  }

  static IconData chevronForward(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return isRtl ? Icons.chevron_left_rounded : Icons.chevron_left_rounded;
  }

  static IconData chevronBack(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return isRtl ? Icons.chevron_right_rounded : Icons.chevron_right_rounded;
  }
}

class NazelIcon extends StatelessWidget {
  final NazelIconType type;
  final double? size;
  final Color? color;

  const NazelIcon({
    super.key,
    required this.type,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? NazelColors.primary;
    final effectiveSize = size ?? NazelDimens.iconSmall;

    IconData getMaterialIcon() {
      switch (type) {
        case NazelIconType.back:
          return NazelDirectionalIcons.back(context);
        case NazelIconType.forward:
          return NazelDirectionalIcons.forward(context);
        case NazelIconType.clean:
          return Icons.cleaning_services_rounded;
        case NazelIconType.delivery:
          return Icons.delivery_dining_rounded;
        case NazelIconType.nearest:
          return Icons.location_on_rounded;
        case NazelIconType.tourism:
          return Icons.explore_rounded;
        case NazelIconType.extend:
          return Icons.calendar_month_rounded;
        case NazelIconType.info:
          return Icons.info_outline_rounded;
        case NazelIconType.emergency:
          return Icons.emergency_rounded;
        case NazelIconType.ads:
          return Icons.campaign_rounded;
        case NazelIconType.wifi:
          return Icons.wifi_rounded;
        case NazelIconType.clock:
          return Icons.access_time_rounded;
        case NazelIconType.search:
          return Icons.search_rounded;
        case NazelIconType.shoppingCart:
          return Icons.shopping_cart_outlined;
        case NazelIconType.hospital:
          return Icons.local_hospital_rounded;
        case NazelIconType.bus:
          return Icons.directions_bus_rounded;
        case NazelIconType.phone:
          return Icons.phone_rounded;
        case NazelIconType.home:
          return Icons.home_rounded;
        case NazelIconType.vacuum:
          return Icons.cleaning_services_outlined;
        case NazelIconType.ambulance:
          return Icons.medical_services_rounded;
        case NazelIconType.wrench:
          return Icons.build_rounded;
        case NazelIconType.plus:
          return Icons.add_rounded;
        case NazelIconType.minus:
          return Icons.remove_rounded;
        case NazelIconType.star:
          return Icons.star_rounded;
      }
    }

    return Icon(
      getMaterialIcon(),
      size: effectiveSize,
      color: effectiveColor,
    );
  }
}
