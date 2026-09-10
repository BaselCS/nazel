import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import '../atoms/nazel_back_button.dart';
import '../atoms/nazel_button.dart';
import '../atoms/nazel_icon.dart';
import '../atoms/nazel_increment_field.dart';
import '../atoms/nazel_rating_badge.dart';
import '../molecules/nazel_choose_card.dart';
import '../molecules/nazel_time_tile.dart';
import 'state_done_view.dart';

/// 1. Cleaning Service Flow Modal
class CleaningServiceModal extends StatefulWidget {
  const CleaningServiceModal({super.key});

  @override
  State<CleaningServiceModal> createState() => _CleaningServiceModalState();
}

class _CleaningServiceModalState extends State<CleaningServiceModal> {
  int _step = 0; // 0: Select service, 1: Select time/notes, 2: Done
  int _selectedService = 0;
  int _selectedTime = 0;
  final TextEditingController _notesController = TextEditingController();

  final List<Map<String, String>> _services = [
    {'title': 'تنظيف سريع', 'subtitle': 'تنظيف سريع'},
    {'title': 'تنظيف شامل', 'subtitle': 'تنظيف شامل'},
    {
      'title': 'تغيير شراشف ومستلزمات حمام',
      'subtitle': 'تغيير شراشف ومستلزمات حمام',
    },
  ];

  final List<String> _times = [
    'اليوم 11:00 ص (أقرب موعد)',
    'اليوم 02:00 م',
    'اليوم 05:00 م',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_step == 2) {
      return StateDoneView(
        title: 'أٌستلم طلبك',
        description:
            'سيصل فريق النظافة في الموعد المحدد (${_times[_selectedTime]}).',
        onDone: () => Navigator.of(context).pop(),
      );
    }

    if (_step == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'أختر الوقت المناسب',
            style: NazelTypography.arabic(
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
              color: NazelColors.primary,
            ),
          ),
          SizedBox(height: NazelDimens.space12),
          ...List.generate(_times.length, (index) {
            return NazelTimeTile(
              timeText: _times[index],
              isSelected: _selectedTime == index,
              onTap: () => setState(() => _selectedTime = index),
            );
          }),
          SizedBox(height: NazelDimens.space20),
          Text(
            'ملاحظات إضافية (اختياري)',
            style: NazelTypography.arabic(
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
              color: NazelColors.primary,
            ),
          ),
          SizedBox(height: NazelDimens.space8),
          TextField(
            controller: _notesController,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: 'اكتب ملاحظاتك هنا...',
              hintStyle: NazelTypography.bodySmall,
              filled: true,
              fillColor: NazelColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(NazelDimens.radiusMd),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: NazelDimens.space24),
          Row(
            children: [
              Expanded(
                child: NazelButton(
                  text: 'أطلب الآن',
                  onPressed: () => setState(() => _step = 2),
                ),
              ),
              SizedBox(width: NazelDimens.space12),
              NazelButton(
                text: 'السابق',
                variant: NazelButtonVariant.secondary,
                onPressed: () => setState(() => _step = 0),
                width: 120.0.w,
              ),
            ],
          ),
        ],
      );
    }

    // Step 0: Main Cleaning Menu
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'أختر نوع الخدمة',
            style: NazelTypography.arabic(
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
              color: NazelColors.primary,
            ),
          ),
          SizedBox(height: NazelDimens.space12),
          ...List.generate(_services.length, (index) {
            return NazelChooseCard.selectable(
              title: _services[index]['title']!,
              subtitle: _services[index]['subtitle']!,
              isSelected: _selectedService == index,
              onTap: () {
                setState(() => _selectedService = index);
              },
            );
          }),
          SizedBox(height: NazelDimens.space20),
          // Previous Orders Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الطلبات السابقة',
                style: NazelTypography.arabic(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                  color: NazelColors.primary,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: Text(
                  'عرض الكل',
                  style: NazelTypography.arabic(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    color: NazelColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: NazelDimens.space12),
          // Previous Order Card
          Container(
            height: NazelDimens.chooseCardHeight,
            decoration: BoxDecoration(
              color: NazelColors.surfaceWhite,
              borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
              border: Border.all(
                color: NazelColors.borderLight.withValues(alpha: 0.8),
                width: 1.0,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: NazelDimens.space20,
              vertical: NazelDimens.space12,
            ),
            child: Row(
              children: [
                NazelIcon(
                  type: NazelIconType.clean,
                  size: 28.0.r,
                  color: NazelColors.primary,
                ),
                SizedBox(width: NazelDimens.space16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تنظيف سريع',
                        style: NazelTypography.arabic(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: NazelColors.primary,
                        ),
                      ),
                      SizedBox(height: NazelDimens.space4),
                      Text(
                        '9:20 - 11 مايو 90 ص',
                        style: NazelTypography.arabic(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: NazelColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: NazelDimens.space12,
                    vertical: NazelDimens.space6,
                  ),
                  decoration: BoxDecoration(
                    color: NazelColors.success.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
                  ),
                  child: Text(
                    'مكتمل',
                    style: NazelTypography.arabic(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: NazelColors.success,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: NazelDimens.space20),
          Align(
            alignment: Alignment.centerLeft,
            child: NazelButton(
              text: 'متابعة',
              onPressed: () => setState(() => _step = 1),
              width: 140.0.w,
            ),
          ),
        ],
      ),
    );
  }
}

/// 2. Extend Booking Modal
class ExtendBookingModal extends StatefulWidget {
  const ExtendBookingModal({super.key});

  @override
  State<ExtendBookingModal> createState() => _ExtendBookingModalState();
}

class _ExtendBookingModalState extends State<ExtendBookingModal> {
  int _extraDays = 1;
  bool _isDone = false;
  final double _pricePerDay = 350.0;

  @override
  Widget build(BuildContext context) {
    if (_isDone) {
      return StateDoneView(
        title: 'أٌرسل طلب تمديد',
        description:
            'أرسلنا الطلب إلى المالك للموافقة على تمديد الحجز لمدة $_extraDays يوم.',
        onDone: () => Navigator.of(context).pop(),
      );
    }

    final total = (_extraDays * _pricePerDay).toInt();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Current Booking Information Card
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: NazelDimens.space24,
            vertical: NazelDimens.space20,
          ),
          decoration: BoxDecoration(
            color: NazelColors.surfaceWhite,
            borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
            border: Border.all(color: NazelColors.borderLight, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'معلومات الحجز',
                style: NazelTypography.arabic(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: NazelColors.primary,
                ),
              ),
              SizedBox(height: NazelDimens.space18),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoColumn(
                      'تاريخ المغادرة',
                      '15 مايو 2026',
                      alignment: CrossAxisAlignment.start,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoColumn(
                      'وقت المغادرة',
                      '12 : 30 م',
                      alignment: CrossAxisAlignment.center,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoColumn(
                      'رقم الحجز',
                      '#NZE-2024-1258',
                      alignment: CrossAxisAlignment.end,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // 2. Extend Booking Selection Card
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: NazelDimens.space24,
            vertical: NazelDimens.space20,
          ),
          decoration: BoxDecoration(
            color: NazelColors.surfaceWhite,
            borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
            border: Border.all(color: NazelColors.borderLight, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تمديد الحجز',
                style: NazelTypography.arabic(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: NazelColors.primary,
                ),
              ),
              SizedBox(height: NazelDimens.space16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Daily Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'سعر اليوم',
                        style: NazelTypography.arabic(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: NazelColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: NazelDimens.space6),
                      Text(
                        '350 رس',
                        style: NazelTypography.arabic(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w900,
                          color: NazelColors.primary,
                        ),
                      ),
                    ],
                  ),
                  // Extension Days Counter
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'أيام التمديد',
                        style: NazelTypography.arabic(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: NazelColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: NazelDimens.space6),
                      NazelIncrementField(
                        value: _extraDays,
                        onChanged: (val) => setState(() => _extraDays = val),
                        backgroundColor: NazelColors.surfaceWhite,
                        borderColor: NazelColors.borderLight,
                        width: 175.w,
                        height: 48.h,
                        borderRadius: BorderRadius.circular(
                          NazelDimens.radiusSm,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // 3. Summary & Submit Card
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: NazelDimens.space24,
            vertical: NazelDimens.space24,
          ),
          decoration: BoxDecoration(
            color: NazelColors.surfaceWhite,
            borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
            border: Border.all(color: NazelColors.borderLight, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الإجمالي :',
                      style: NazelTypography.arabic(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: NazelColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: NazelDimens.space4),
                    Text(
                      '$total رس',
                      style: NazelTypography.arabic(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w900,
                        color: NazelColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: NazelDimens.space20),
              NazelButton(
                text: 'تمديد',
                variant: NazelButtonVariant.gold,
                width: double.infinity,
                height: 56.h,
                onPressed: () => setState(() => _isDone = true),
              ),
              SizedBox(height: NazelDimens.space12),
              Text(
                'سنرسل طلبك إلى المالك للموافقة',
                textAlign: TextAlign.center,
                style: NazelTypography.arabic(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: NazelColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoColumn(
    String label,
    String value, {
    CrossAxisAlignment alignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: NazelTypography.arabic(
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
            color: NazelColors.textSecondary,
          ),
        ),
        SizedBox(height: NazelDimens.space6),
        Text(
          value,
          style: NazelTypography.arabic(
            fontSize: 15.0,
            fontWeight: FontWeight.w800,
            color: NazelColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

/// 3. Nearest Places Modal — Matches Figma "Nearest Main Menu Ar"
class NearestPlacesModal extends StatefulWidget {
  const NearestPlacesModal({super.key});

  /// Opens the modal as a full dialog with embedded map and places list.
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: NazelColors.overlayDim,
      barrierDismissible: true,
      builder: (ctx) => const NearestPlacesModal(),
    );
  }

  @override
  State<NearestPlacesModal> createState() => _NearestPlacesModalState();
}

class _NearestPlacesModalState extends State<NearestPlacesModal> {
  final MapController _mapController = MapController();
  int _selectedPlaceIndex = -1;

  final List<Map<String, dynamic>> _places = [
    {
      'title': 'بقالة',
      'fullTitle': 'بقالة وميني ماركت الحي',
      'dist': '0.3 كم',
      'time': '5 دقائق',
      'icon': Icons.shopping_cart_outlined,
      'latLng': const LatLng(21.4232, 39.8250),
    },
    {
      'title': 'محطة حافلات',
      'fullTitle': 'محطة حافلات النقل العام',
      'dist': '10 كم',
      'time': '20 دقيقة',
      'icon': Icons.directions_bus_outlined,
      'latLng': const LatLng(21.4255, 39.8282),
    },
    {
      'title': 'مستشفى السلام',
      'fullTitle': 'مستشفى السلام الطبي',
      'dist': '30 كم',
      'time': '60 دقيقة',
      'icon': Icons.local_hospital_outlined,
      'latLng': const LatLng(21.4208, 39.8225),
    },
    {
      'title': 'مسجد الحي',
      'fullTitle': 'جامع الهدى',
      'dist': '50 كم',
      'time': '45 دقيقة',
      'icon': Icons.mosque_outlined,
      'latLng': const LatLng(21.4270, 39.8298),
    },
    {
      'title': 'صيدلية النهدي',
      'fullTitle': 'صيدلية النهدي 24 ساعة',
      'dist': '0.8 كم',
      'time': '10 دقائق',
      'icon': Icons.local_pharmacy_outlined,
      'latLng': const LatLng(21.4220, 39.8268),
    },
  ];

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: NazelDimens.modalWidth,
          height: NazelDimens.modalHeight,
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
              // ── App Bar ──────────────────────────────────────────────────
              Container(
                width: double.infinity,
                height: 72.0.h,
                color: NazelColors.primary,
                padding: EdgeInsets.symmetric(horizontal: NazelDimens.space20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Text(
                        'مرافق قريبة',
                        style: NazelTypography.arabic(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w900,
                          color: NazelColors.surfaceWhite,
                        ),
                      ),
                    ),
                    Positioned(left: 0, child: const NazelBackButton()),
                  ],
                ),
              ),

              // ── Embedded Google Map ───────────────────────────────────────
              SizedBox(
                height: 310.0.h,
                child: ClipRect(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: const LatLng(21.4235, 39.8260),
                      initialZoom: 15.3,
                      maxZoom: 18.0,
                      minZoom: 11.0,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.all,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                        userAgentPackageName: 'com.nazel.app',
                      ),
                      MarkerLayer(
                        markers: List.generate(_places.length, (index) {
                          final place = _places[index];
                          final isSelected = _selectedPlaceIndex == index;
                          return Marker(
                            point: place['latLng'] as LatLng,
                            width: isSelected ? 48.0.r : 34.0.r,
                            height: isSelected ? 48.0.r : 34.0.r,
                            child: GestureDetector(
                              onTap: () {
                                setState(() => _selectedPlaceIndex = index);
                                _mapController.move(
                                  place['latLng'] as LatLng,
                                  16.0,
                                );
                              },
                              child: _buildMapPin(isSelected),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Nearby Places List ────────────────────────────────────────
              Expanded(
                child: Container(
                  color: NazelColors.surfaceWhite,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: NazelDimens.space24,
                      vertical: NazelDimens.space16,
                    ),
                    itemCount: _places.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: NazelDimens.space12),
                    itemBuilder: (context, index) {
                      final place = _places[index];
                      final isSelected = _selectedPlaceIndex == index;
                      return _buildPlaceCard(place, isSelected, index);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapPin(bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: NazelColors.primary,
        shape: BoxShape.circle,
        border: Border.all(
          color: NazelColors.surfaceWhite,
          width: isSelected ? 2.5 : 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: NazelColors.primary.withValues(alpha: 0.35),
            blurRadius: isSelected ? 12.0.r : 6.0.r,
            offset: Offset(0, isSelected ? 4.h : 2.h),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: isSelected ? 12.0.r : 8.0.r,
          height: isSelected ? 12.0.r : 8.0.r,
          decoration: const BoxDecoration(
            color: NazelColors.surfaceWhite,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceCard(
    Map<String, dynamic> place,
    bool isSelected,
    int index,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected
            ? NazelColors.purpleSoft.withValues(alpha: 0.5)
            : NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
        border: Border.all(
          color: isSelected
              ? NazelColors.primary
              : NazelColors.borderLight.withValues(alpha: 0.8),
          width: isSelected ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            offset: Offset(0, 2.h),
            blurRadius: 6.0.r,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
        child: InkWell(
          borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
          onTap: () {
            setState(() => _selectedPlaceIndex = index);
            _mapController.move(place['latLng'] as LatLng, 16.0);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 14.0.h),
            child: Row(
              children: [
                // 1. In RTL: Right Side - Circular Icon Badge
                Container(
                  width: 52.0.r,
                  height: 52.0.r,
                  decoration: BoxDecoration(
                    color: NazelColors.surfaceWhite,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: NazelColors.borderLight.withValues(alpha: 0.8),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        offset: Offset(0, 2.h),
                        blurRadius: 6.0.r,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      place['icon'] as IconData,
                      color: NazelColors.textPrimary,
                      size: 26.0.r,
                    ),
                  ),
                ),
                SizedBox(width: 16.0.w),

                // 2. Center - Title in bold purple
                Expanded(
                  child: Text(
                    place['title'] as String,
                    style: NazelTypography.arabic(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                      color: NazelColors.primary,
                    ),
                  ),
                ),

                // 3. Left Side - Distance and Time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      place['dist'] as String,
                      style: NazelTypography.arabic(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: NazelColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 3.0.h),
                    Text(
                      place['time'] as String,
                      style: NazelTypography.arabic(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: NazelColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 4. Delivery Service Modal — matches Figma "Delivery Main Menu Ar"
class DeliveryServiceModal extends StatefulWidget {
  const DeliveryServiceModal({super.key});

  /// Opens the modal as a full dialog with cart bar edge-to-edge at bottom.
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: NazelColors.overlayDim,
      barrierDismissible: true,
      builder: (ctx) => const DeliveryServiceModal(),
    );
  }

  @override
  State<DeliveryServiceModal> createState() => _DeliveryServiceModalState();
}

class _DeliveryRestaurant {
  final String name;
  final String tags;
  final double rating;
  final String logoPath;
  const _DeliveryRestaurant({
    required this.name,
    required this.tags,
    required this.rating,
    required this.logoPath,
  });
}

class _DeliveryServiceModalState extends State<DeliveryServiceModal> {
  int _selectedCategory = 0;
  int _cartCount = 2;
  double _cartTotal = 70.00;
  bool _isDone = false;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'مطاعم',
    'بقالة',
    'كافيهات',
    'بوافي',
    'عصائر',
    'أمور أخرى',
  ];

  final List<_DeliveryRestaurant> _restaurants = const [
    _DeliveryRestaurant(
      name: 'هرفي',
      tags: 'برجر، سندوشات',
      rating: 4.5,
      logoPath: 'assets/images/restaurant_herfy.png',
    ),
    _DeliveryRestaurant(
      name: 'البيك',
      tags: 'دجاج مقلي',
      rating: 5.0,
      logoPath: 'assets/images/restaurant_albaik.png',
    ),
    _DeliveryRestaurant(
      name: 'ماكدونالدز',
      tags: 'برجر، سندوشات',
      rating: 2.0,
      logoPath: 'assets/images/restaurant_mcdonalds.png',
    ),
    _DeliveryRestaurant(
      name: 'رايق',
      tags: 'شاورما، وجبات',
      rating: 4.6,
      logoPath: 'assets/images/restaurant_raeq.png',
    ),
    _DeliveryRestaurant(
      name: 'الشلال',
      tags: 'خبز، وجبات',
      rating: 4.4,
      logoPath: 'assets/images/restaurant_shallal.png',
    ),
    _DeliveryRestaurant(
      name: 'كودو',
      tags: 'برجر، دجاج',
      rating: 4.8,
      logoPath: 'assets/images/restaurant_kudu.png',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isDone) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: NazelDimens.modalWidth,
            height: NazelDimens.modalHeight,
            margin: EdgeInsets.all(NazelDimens.space24),
            decoration: BoxDecoration(
              color: NazelColors.surfaceWhite,
              borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
            ),
            clipBehavior: Clip.antiAlias,
            child: StateDoneView(
              title: 'تم استلام طلبك',
              description:
                  'تم إرسال طلب التوصيل بنجاح وسيتم إيصاله إلى غرفتك بأسرع وقت.',
              onDone: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      );
    }
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: NazelDimens.modalWidth,
          height: NazelDimens.modalHeight,
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
              // ── App Bar ──────────────────────────────────────────────────
              Container(
                width: double.infinity,
                height: 72.0.h,
                color: NazelColors.primary,
                padding: EdgeInsets.symmetric(horizontal: NazelDimens.space24),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Text(
                        'طلبات التوصيل',
                        style: NazelTypography.arabic(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w900,
                          color: NazelColors.surfaceWhite,
                        ),
                      ),
                    ),
                    Positioned(left: 0, child: const NazelBackButton()),
                  ],
                ),
              ),

              // ── Scrollable Content ────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    NazelDimens.space24,
                    NazelDimens.space20,
                    NazelDimens.space24,
                    NazelDimens.space12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                      _buildSearchBar(),
                      SizedBox(height: NazelDimens.space16),

                      // Category Chips
                      _buildCategoryChips(),
                      SizedBox(height: NazelDimens.space20),

                      // Section Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'مطاعم قريبة',
                            style: NazelTypography.arabic(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w900,
                              color: NazelColors.primary,
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {},
                            child: Text(
                              'عرض الكل',
                              style: NazelTypography.arabic(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w800,
                                color: NazelColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: NazelDimens.space12),

                      // Restaurant Grid (3 columns)
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: NazelDimens.space16,
                                mainAxisSpacing: NazelDimens.space16,
                                childAspectRatio: 0.6,
                              ),
                          itemCount: _restaurants.length,
                          itemBuilder: (context, index) =>
                              _buildRestaurantCard(_restaurants[index]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Cart Bar (full-width, outside padding) ─────────────────
              if (_cartCount > 0) _buildCartBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 52.0.h,
      decoration: BoxDecoration(
        color: NazelColors.background,
        borderRadius: BorderRadius.circular(NazelDimens.radiusFull),
        border: Border.all(
          color: NazelColors.borderLight.withValues(alpha: 0.5),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: NazelDimens.space16),
          NazelIcon(
            type: NazelIconType.search,
            size: 22.0.r,
            color: NazelColors.textSecondary,
          ),
          SizedBox(width: NazelDimens.space12),
          Expanded(
            child: TextField(
              controller: _searchController,
              textDirection: TextDirection.rtl,
              style: NazelTypography.arabic(
                fontSize: 16.0,
                color: NazelColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: '...',
                hintStyle: NazelTypography.arabic(
                  fontSize: 16.0,
                  color: NazelColors.textSecondary,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          SizedBox(width: NazelDimens.space16),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_categories.length, (index) {
          final selected = _selectedCategory == index;
          return Padding(
            padding: EdgeInsets.only(left: NazelDimens.space8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 22.0.w,
                  vertical: 10.0.h,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? NazelColors.primary
                      : NazelColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(NazelDimens.radiusFull),
                  border: Border.all(
                    color: selected
                        ? NazelColors.primary
                        : NazelColors.borderLight.withValues(alpha: 0.8),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  _categories[index],
                  style: NazelTypography.arabic(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: selected
                        ? NazelColors.surfaceWhite
                        : NazelColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildRestaurantCard(_DeliveryRestaurant r) {
    final ratingStr = r.rating == r.rating.floorToDouble()
        ? r.rating.toInt().toString()
        : r.rating.toStringAsFixed(1);
    return Container(
      decoration: BoxDecoration(
        color: NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
        border: Border.all(
          color: NazelColors.borderLight.withValues(alpha: 0.6),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: NazelColors.primary.withValues(alpha: 0.04),
            offset: Offset(0, 4.h),
            blurRadius: 10.0.r,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
        child: InkWell(
          onTap: () => setState(() {
            _cartCount++;
            _cartTotal += 25.0;
          }),
          borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
          child: Padding(
            padding: EdgeInsets.all(NazelDimens.space14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo container
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(NazelDimens.radiusMd),
                    ),
                    padding: EdgeInsets.all(NazelDimens.space8),
                    child: Image.asset(
                      r.logoPath,
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) => NazelIcon(
                        type: NazelIconType.delivery,
                        size: 40.0.r,
                        color: NazelColors.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: NazelDimens.space10),
                // Name
                Expanded(
                  flex: 2,
                  child: Text(
                    r.name,
                    style: NazelTypography.arabic(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w900,
                      color: NazelColors.primary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Tags
                Expanded(
                  flex: 2,
                  child: Text(
                    r.tags,
                    style: NazelTypography.arabic(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: NazelColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Rating row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ratingStr,
                      style: NazelTypography.arabic(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: NazelColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: NazelDimens.space4),
                    NazelIcon(
                      type: NazelIconType.star,
                      size: 16.0.r,
                      color: NazelColors.goldDark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCartBar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: NazelDimens.space24,
        vertical: NazelDimens.space14,
      ),
      decoration: BoxDecoration(color: NazelColors.primaryDark),
      child: Row(
        children: [
          // Cart icon + count badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 28.0.r,
                color: NazelColors.surfaceWhite,
              ),
              if (_cartCount > 0)
                Positioned(
                  top: -4.0.h,
                  right: -6.0.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0.w,
                      vertical: 2.0.h,
                    ),
                    decoration: BoxDecoration(
                      color: NazelColors.gold,
                      borderRadius: BorderRadius.circular(
                        NazelDimens.radiusFull,
                      ),
                    ),
                    child: Text(
                      '$_cartCount',
                      style: NazelTypography.arabic(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w900,
                        color: NazelColors.primaryDark,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: NazelDimens.space14),
          // Total price & label
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'السلة ($_cartCount عناصر)',
                style: NazelTypography.arabic(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: NazelColors.gold,
                ),
              ),
              Text(
                '${_cartTotal.toStringAsFixed(2)} ريال',
                style: NazelTypography.arabic(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  color: NazelColors.surfaceWhite,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Send / Order Button
          NazelButton(
            text: 'إرسال الطلب',
            variant: NazelButtonVariant.gold,
            height: 44.0.h,
            onPressed: () {
              setState(() => _isDone = true);
            },
          ),
        ],
      ),
    );
  }
}

/// 5. Emergency Modal
class EmergencyModal extends StatelessWidget {
  const EmergencyModal({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {
        'title': 'الشرطة والأمن',
        'number': '999',
        'icon': NazelIconType.emergency,
      },
      {
        'title': 'الإسعاف والطوارئ الطبية',
        'number': '997',
        'icon': NazelIconType.ambulance,
      },
      {
        'title': 'طوارئ الصيانة والعقار',
        'number': '+966 50 000 0000',
        'icon': NazelIconType.wrench,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أرقام الاتصال السريع المباشر',
          style: NazelTypography.sectionTitle,
        ),
        SizedBox(height: NazelDimens.space16),
        ...contacts.map((c) {
          return NazelChooseCard(
            title: c['title'] as String,
            subtitle: c['number'] as String,
            onTap: () {},
            leading: Container(
              width: 52.0.r,
              height: 52.0.r,
              decoration: BoxDecoration(
                color: NazelColors.danger.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
              ),
              alignment: Alignment.center,
              child: NazelIcon(
                type: c['icon'] as NazelIconType,
                size: 26.0.r,
                color: NazelColors.danger,
              ),
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(
                horizontal: NazelDimens.space16,
                vertical: NazelDimens.space8,
              ),
              decoration: BoxDecoration(
                color: NazelColors.danger,
                borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
              ),
              child: Text(
                'اتصال',
                style: NazelTypography.arabic(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  color: NazelColors.surfaceWhite,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

/// 6. Apartment Info Modal
class ApartmentInfoModal extends StatefulWidget {
  const ApartmentInfoModal({super.key});

  @override
  State<ApartmentInfoModal> createState() => _ApartmentInfoModalState();
}

class _ApartmentInfoModalState extends State<ApartmentInfoModal> {
  String?
  _selectedCategory; // null: main menu, 'devices', 'checkout', 'contacts', 'about'

  final List<Map<String, dynamic>> _menuItems = const [
    {
      'id': 'devices',
      'title': 'تعليمات الأجهزة',
      'desc': 'دليل استخدام الأجهزة الكهربائية',
      'icon': Icons.iron_outlined,
    },
    {
      'id': 'checkout',
      'title': 'سياسة الخروج',
      'desc': 'تسجيل الخروج قبل الساعة 12:00 م',
      'icon': Icons.hotel_rounded,
    },
    {
      'id': 'contacts',
      'title': 'أرقام مهمة',
      'desc': 'أرقام التواصل و الخدمات',
      'icon': Icons.phone_rounded,
    },
    {
      'id': 'about',
      'title': 'عن الشقة',
      'desc': 'معلومات و مميزات الشقة',
      'icon': Icons.home_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (_selectedCategory == null) {
      return _buildMainMenu();
    }

    switch (_selectedCategory) {
      case 'devices':
        return _buildDevicesDetail();
      case 'checkout':
        return _buildCheckoutDetail();
      case 'contacts':
        return _buildContactsDetail();
      case 'about':
        return _buildAboutDetail();
      default:
        return _buildMainMenu();
    }
  }

  Widget _buildMainMenu() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        ..._menuItems.map((item) {
          return NazelChooseCard(
            height: 104.0.h,
            title: item['title'] as String,
            subtitle: item['desc'] as String,
            onTap: () {
              setState(() {
                _selectedCategory = item['id'] as String;
              });
            },
            leading: Container(
              width: 56.0.r,
              height: 56.0.r,
              decoration: BoxDecoration(
                color: NazelColors.surfaceWhite,
                shape: BoxShape.circle,
                border: Border.all(color: NazelColors.borderLight, width: 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    offset: Offset(0, 2.h),
                    blurRadius: 6.0.r,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(
                item['icon'] as IconData,
                size: 26.0.r,
                color: NazelColors.primary,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDetailHeader(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: NazelDimens.space16),
      child: Row(
        children: [
          Material(
            color: NazelColors.purpleSoft,
            borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
            child: InkWell(
              borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
              onTap: () => setState(() => _selectedCategory = null),
              child: Padding(
                padding: EdgeInsets.all(NazelDimens.space8),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 20.0.r,
                  color: NazelColors.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: NazelDimens.space12),
          Text(
            title,
            style: NazelTypography.arabic(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: NazelColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  // 1. Devices Instruction Detail
  Widget _buildDevicesDetail() {
    final devices = [
      {
        'name': 'المكيف',
        'icon': Icons.ac_unit_rounded,
        'instructions':
            'درجة الحرارة الموصى بها هي (22°C - 24°C). يمكنك استخدام زر Quiet لتفعيل الوضع الصامت أثناء النوم.',
      },
      {
        'name': 'تلفزيون ذكي',
        'icon': Icons.tv_rounded,
        'instructions':
            'تطبيقات Netflix و Shahid و YouTube مثبتة مسبقاً. لمشاركة الشاشة، اختر AirPlay أو Screen Cast بنفس شبكة Wi-Fi.',
      },
      {
        'name': 'غسالة الملابس والمجفف',
        'icon': Icons.local_laundry_service_rounded,
        'instructions':
            'برنامج Quick 30m مناسب للغسيل اليومي السريع. مساحيق الغسيل الإضافية متوفرة في خزانة الحمام أسفل الحوض.',
      },
      {
        'name': 'صانعة القهوة والغلاية',
        'icon': Icons.coffee_maker_rounded,
        'instructions':
            'تتوفر كبسولات قهوة وشاي ومياه نقية مجاناً يومياً. يرجى ملء الخزان بالماء العذب قبل بدء التشغيل.',
      },
      {
        'name': 'الميكروويف والفرن',
        'icon': Icons.microwave_rounded,
        'instructions':
            'يرجى استخدام الأواني الزجاجية والحرارية المخصصة، وتجنب إدخال أي أدوات معدنية أو قصدير.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailHeader('دليل استخدام الأجهزة الكهربائية'),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: devices.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: NazelDimens.space12),
            itemBuilder: (context, index) {
              final d = devices[index];
              return Container(
                padding: EdgeInsets.all(NazelDimens.space16),
                decoration: BoxDecoration(
                  color: NazelColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
                  border: Border.all(color: NazelColors.borderLight),
                  boxShadow: [
                    BoxShadow(
                      color: NazelColors.primary.withValues(alpha: 0.03),
                      offset: Offset(0, 3.h),
                      blurRadius: 8.0.r,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48.0.r,
                      height: 48.0.r,
                      decoration: BoxDecoration(
                        color: NazelColors.purpleSoft,
                        borderRadius: BorderRadius.circular(
                          NazelDimens.radiusSm,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        d['icon'] as IconData,
                        size: 24.0.r,
                        color: NazelColors.primary,
                      ),
                    ),
                    SizedBox(width: NazelDimens.space16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d['name'] as String,
                            style: NazelTypography.arabic(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w800,
                              color: NazelColors.primary,
                            ),
                          ),
                          SizedBox(height: NazelDimens.space6),
                          Text(
                            d['instructions'] as String,
                            style: NazelTypography.arabic(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                              color: NazelColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // 2. Checkout Policy Detail
  Widget _buildCheckoutDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailHeader('سياسة تسجيل الخروج'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              // Highlight card
              Container(
                padding: EdgeInsets.all(NazelDimens.space20),
                decoration: BoxDecoration(
                  color: NazelColors.purpleSoft,
                  borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
                  border: Border.all(
                    color: NazelColors.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56.0.r,
                      height: 56.0.r,
                      decoration: BoxDecoration(
                        color: NazelColors.primary,
                        borderRadius: BorderRadius.circular(
                          NazelDimens.radiusSm,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.access_time_filled_rounded,
                        size: 28.0.r,
                        color: NazelColors.surfaceWhite,
                      ),
                    ),
                    SizedBox(width: NazelDimens.space16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'موعد تسجيل الخروج: 12:00 م',
                            style: NazelTypography.arabic(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w800,
                              color: NazelColors.primary,
                            ),
                          ),
                          SizedBox(height: NazelDimens.space4),
                          Text(
                            'نرجو تسليم الشقة بالوقت المحدد لتجهيزها للنزيل القادم',
                            style: NazelTypography.arabic(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                              color: NazelColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: NazelDimens.space16),

              // Checklist points
              _buildPolicyCard(
                icon: Icons.key_rounded,
                title: 'تسليم المفتاح الذكي',
                desc:
                    'يرجى ترك بطاقة الدخول الذكية داخل صندوق الاستقبال عند المغادرة أو تسليمها لموظف الاستقبال.',
              ),
              SizedBox(height: NazelDimens.space10),
              _buildPolicyCard(
                icon: Icons.luggage_rounded,
                title: 'التأكد من الأمتعة والخزنة',
                desc:
                    'تأكد من عدم نسيان أي مقتنيات شخصية في الدواليب أو تفريغ الخزنة الإلكترونية قبل الخروج.',
              ),
              SizedBox(height: NazelDimens.space10),
              _buildPolicyCard(
                icon: Icons.power_settings_new_rounded,
                title: 'إطفاء الأجهزة والإضاءة',
                desc:
                    'يُرجى إيقاف تشغيل أجهزة التكييف والإنارة حفاظاً على البيئة والسلامة العامة.',
              ),
              SizedBox(height: NazelDimens.space10),
              _buildPolicyCard(
                icon: Icons.update_rounded,
                title: 'طلب تمديد الإقامة',
                desc:
                    'في حال رغبتك بتمديد الإقامة، يمكنك طلب ذلك عبر خدمة "تمديد الحجز" قبل الساعة 10:00 صباحاً.',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPolicyCard({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: EdgeInsets.all(NazelDimens.space16),
      decoration: BoxDecoration(
        color: NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
        border: Border.all(color: NazelColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22.0.r, color: NazelColors.primary),
          SizedBox(width: NazelDimens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: NazelTypography.arabic(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    color: NazelColors.primary,
                  ),
                ),
                SizedBox(height: NazelDimens.space4),
                Text(
                  desc,
                  style: NazelTypography.arabic(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: NazelColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. Important Contacts Detail
  Widget _buildContactsDetail() {
    final contacts = [
      {
        'title': 'الاستقبال وخدمة النزلاء',
        'ext': 'تحويلة: 100',
        'phone': '0551234567',
        'icon': Icons.desk_rounded,
      },
      {
        'title': 'خدمة الغرف وتوصيل الطلبات',
        'ext': 'تحويلة: 102',
        'phone': '0551234568',
        'icon': Icons.room_service_rounded,
      },
      {
        'title': 'الصيانة والدعم الفني',
        'ext': 'تحويلة: 104',
        'phone': '0551234569',
        'icon': Icons.build_rounded,
      },
      {
        'title': 'الأمن والسلامة',
        'ext': 'تحويلة: 109',
        'phone': '0551234570',
        'icon': Icons.security_rounded,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailHeader('أرقام التواصل والخدمات'),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: contacts.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: NazelDimens.space12),
            itemBuilder: (context, index) {
              final c = contacts[index];
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: NazelDimens.space16,
                  vertical: NazelDimens.space12,
                ),
                decoration: BoxDecoration(
                  color: NazelColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
                  border: Border.all(color: NazelColors.borderLight),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48.0.r,
                      height: 48.0.r,
                      decoration: BoxDecoration(
                        color: NazelColors.purpleSoft,
                        borderRadius: BorderRadius.circular(
                          NazelDimens.radiusSm,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        c['icon'] as IconData,
                        size: 24.0.r,
                        color: NazelColors.primary,
                      ),
                    ),
                    SizedBox(width: NazelDimens.space16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c['title'] as String,
                            style: NazelTypography.arabic(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w800,
                              color: NazelColors.primary,
                            ),
                          ),
                          SizedBox(height: NazelDimens.space4),
                          Text(
                            '${c['ext']}  •  ${c['phone']}',
                            style: NazelTypography.arabic(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                              color: NazelColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: NazelDimens.space16,
                        vertical: NazelDimens.space8,
                      ),
                      decoration: BoxDecoration(
                        color: NazelColors.primary,
                        borderRadius: BorderRadius.circular(
                          NazelDimens.radiusSm,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone_in_talk_rounded,
                            size: 16.0.r,
                            color: NazelColors.surfaceWhite,
                          ),
                          SizedBox(width: NazelDimens.space6),
                          Text(
                            'اتصال',
                            style: NazelTypography.arabic(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w800,
                              color: NazelColors.surfaceWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // 4. About Apartment Detail
  Widget _buildAboutDetail() {
    final specs = [
      {'label': 'رقم الوحدة', 'val': 'جناح 402 - الدور الرابع'},
      {'label': 'نوع الإقامة', 'val': 'جناح فندقي تنفيذي فاخر'},
      {'label': 'المساحة', 'val': '85 متر مربع'},
      {'label': 'الطاقة الاستيعابية', 'val': 'حتى 4 أشخاص'},
      {
        'label': 'المرافق',
        'val': 'غرفة ماستر، صالة معيشة، مطبخ مجهز، 2 دورات مياه',
      },
      {'label': 'شبكة الإنترنت', 'val': 'ألياف بصرية فائقة السرعة'},
      {'label': 'سياسة التدخين', 'val': 'ممنوع التدخين داخل الوحدة تماماً'},
      {'label': 'ساعات الهدوء', 'val': 'من الساعة 11:00 م حتى 07:00 ص'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailHeader('عن الشقة والمميزات'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.all(NazelDimens.space16),
                decoration: BoxDecoration(
                  color: NazelColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
                  border: Border.all(color: NazelColors.borderLight),
                ),
                child: Column(
                  children: specs.map((s) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: NazelDimens.space8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            s['label']!,
                            style: NazelTypography.arabic(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: NazelColors.primary,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              s['val']!,
                              textAlign: TextAlign.end,
                              style: NazelTypography.arabic(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                color: NazelColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 7. Tourism Modal (Toursim Main Menu Ar)
class TourismModal extends StatefulWidget {
  const TourismModal({super.key});

  @override
  State<TourismModal> createState() => _TourismModalState();
}

class _TourismModalState extends State<TourismModal> {
  int _step = 0; // 0: Main Menu, 1: Booking Details, 2: Done
  int _selectedCategory = 0;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  int _guestsCount = 2;
  int _selectedTimeSlot = 0;
  Map<String, dynamic>? _selectedActivity;

  final List<String> _categories = [
    'الكل',
    'رحلات بحرية',
    'جولات',
    'سيارات',
    'أسواق',
    'اخرى',
  ];

  final List<Map<String, dynamic>> _activities = [
    {
      'title': 'رحلات بحرية خاصة',
      'category': 'رحلات بحرية',
      'duration': '3 ساعات',
      'rating': 5.0,
      'reviews': 94,
      'price': 350,
      'isHero': true,
      'image': 'assets/images/ipad_image_de8207a6.png',
      'description':
          'استمتع برحلة بحرية خاصة مع إطلالات ساحرة ومشروبات منعشة طوال الجولة.',
    },
    {
      'title': 'جولة الدرعية التاريخية',
      'category': 'جولات',
      'duration': '5 ساعات',
      'rating': 4.6,
      'reviews': 120,
      'price': 250,
      'isHero': true,
      'image': 'assets/images/ipad_ads_ab02c289.png',
      'subtitle': 'شامل المرشد السياحي المعتمد وزيارة حي الطريف التراثي',
      'description':
          'جولة ثقافية ثرية لأبرز معالم الدرعية التاريخية وحي الطريف المسجل في اليونسكو.',
    },
    {
      'title': 'رحلة سفاري وتخييم صحراوي فاخر',
      'category': 'جولات',
      'duration': '5 ساعات',
      'rating': 5.0,
      'reviews': 85,
      'price': 450,
      'isHero': false,
      'subtitle': 'شامل العشاء وعروض الترفيه الحية',
      'description':
          'تجربة استثنائية بين الكثبان الذهبية مع جلسة شواء راقية وعروض حية.',
    },
    {
      'title': 'تأجير سيارة فاخرة مع سائق خاص',
      'category': 'سيارات',
      'duration': 'يوم كامل',
      'rating': 4.8,
      'reviews': 42,
      'price': 600,
      'isHero': false,
      'subtitle': 'سيارة مرسيدس S-Class مع سائق محترف',
      'description':
          'خدمة تنقل راقية ومريحة مع سائق خاص على دراية تامة بكافة الوجهات.',
    },
    {
      'title': 'جولة تسوق في أشهر الأسواق الشعبية والمولات',
      'category': 'أسواق',
      'duration': '4 ساعات',
      'rating': 4.7,
      'reviews': 63,
      'price': 180,
      'isHero': false,
      'subtitle': 'جولة تسوق متكاملة مع التوصيل',
      'description': 'اكتشف أفضل المتاجر والمنتجات التقليدية والمولات الحديثة.',
    },
  ];

  final List<String> _timeSlots = [
    'صباحاً (09:00 ص - 12:00 م)',
    'ظهراً (01:00 م - 04:00 م)',
    'مساءً (05:00 م - 08:00 م)',
    'ليلاً (08:30 م - 11:30 م)',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _startBooking(Map<String, dynamic> activity) {
    setState(() {
      _selectedActivity = activity;
      _step = 1;
    });
  }

  List<Map<String, dynamic>> get _filteredActivities {
    final query = _searchController.text.trim().toLowerCase();
    return _activities.where((act) {
      final matchesCategory =
          _selectedCategory == 0 ||
          act['category'] == _categories[_selectedCategory];
      final matchesQuery =
          query.isEmpty ||
          (act['title'] as String).toLowerCase().contains(query) ||
          (act['category'] as String).toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_step == 2) {
      return StateDoneView(
        title: 'تم استلام طلب الحجز',
        description:
            'تم إرسال طلب الحجز بنجاح وسيتواصل معك موظف الاستقبال لتأكيد الموعد.',
        onDone: () => Navigator.of(context).pop(),
      );
    }

    if (_step == 1 && _selectedActivity != null) {
      return _buildBookingStep();
    }

    return _buildMainMenuStep();
  }

  Widget _buildMainMenuStep() {
    final seaTrips = _filteredActivities
        .where((a) => a['category'] == 'رحلات بحرية')
        .toList();
    final otherTours = _filteredActivities
        .where((a) => a['category'] != 'رحلات بحرية')
        .toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Search Bar
          Container(
            height: 48.0.h,
            decoration: BoxDecoration(
              color: NazelColors.surfaceWhite,
              borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
              border: Border.all(
                color: NazelColors.borderLight.withValues(alpha: 0.9),
                width: 1.0,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: NazelDimens.space16),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  color: NazelColors.textSecondary,
                  size: 22.0.r,
                ),
                SizedBox(width: NazelDimens.space12),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    textAlignVertical: TextAlignVertical.center,
                    style: NazelTypography.arabic(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: NazelColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: '...',
                      hintStyle: NazelTypography.arabic(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: NazelColors.textSecondary.withValues(alpha: 0.5),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: NazelDimens.space16),

          // 2. Filter Categories Row
          SizedBox(
            height: 42.0.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _categories.length,
              separatorBuilder: (_, _) => SizedBox(width: NazelDimens.space10),
              itemBuilder: (context, index) {
                final isSelected = _selectedCategory == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0.w,
                      vertical: 8.0.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? NazelColors.primary
                          : NazelColors.surfaceWhite,
                      borderRadius: BorderRadius.circular(
                        NazelDimens.radiusFull,
                      ),
                      border: Border.all(
                        color: isSelected
                            ? NazelColors.primary
                            : NazelColors.borderLight.withValues(alpha: 0.8),
                        width: 1.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _categories[index],
                      style: NazelTypography.arabic(
                        fontSize: 15.0,
                        fontWeight: isSelected
                            ? FontWeight.w800
                            : FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : NazelColors.textSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: NazelDimens.space20),

          // 3. Section 1: رحلات بحرية (Sea Trips Hero Card)
          if (seaTrips.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'رحلات بحرية',
                  style: NazelTypography.arabic(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w900,
                    color: NazelColors.primary,
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _selectedCategory = 1),
                  child: Text(
                    'عرض الكل',
                    style: NazelTypography.arabic(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: NazelColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: NazelDimens.space12),
            ...seaTrips.map((act) => _buildHeroCard(act)),
            SizedBox(height: NazelDimens.space24),
          ],

          // 4. Section 2: جولات سياحية (Tours & Experiences)
          if (otherTours.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'جولات سياحية',
                  style: NazelTypography.arabic(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w900,
                    color: NazelColors.primary,
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _selectedCategory = 2),
                  child: Text(
                    'عرض الكل',
                    style: NazelTypography.arabic(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: NazelColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: NazelDimens.space12),
            ...otherTours.map((act) {
              if (act['isHero'] == true) {
                return Padding(
                  padding: EdgeInsets.only(bottom: NazelDimens.space12),
                  child: _buildHeroCard(act),
                );
              }
              return NazelChooseCard(
                title: act['title'] as String,
                subtitle:
                    '${act['duration']} • ${act['subtitle'] ?? act['description']} • ${act['price']} رس',
                onTap: () => _startBooking(act),
                trailing: NazelRatingBadge(
                  rating: (act['rating'] as num).toDouble(),
                  reviewsCount: act['reviews'] as int,
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildHeroCard(Map<String, dynamic> act) {
    return GestureDetector(
      onTap: () => _startBooking(act),
      child: Container(
        height: 220.0.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
          boxShadow: [
            BoxShadow(
              color: NazelColors.primary.withValues(alpha: 0.15),
              offset: Offset(0, 8.h),
              blurRadius: 20.0.r,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              act['image'] ?? 'assets/images/ipad_image_de8207a6.png',
              fit: BoxFit.cover,
            ),
            // Luxury RTL Purple Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    NazelColors.primary.withValues(alpha: 0.95),
                    NazelColors.primary.withValues(alpha: 0.85),
                    NazelColors.primary.withValues(alpha: 0.40),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.40, 0.65, 0.90],
                ),
              ),
            ),
            // Text Content (RTL Right side)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: NazelDimens.space24,
                vertical: NazelDimens.space20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        act['title'] as String,
                        style: NazelTypography.arabic(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: NazelDimens.space6),
                      Text(
                        act['duration'] as String,
                        style: NazelTypography.arabic(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                      SizedBox(height: NazelDimens.space8),
                      // Rating Badge
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: NazelColors.gold,
                            size: 20.0.r,
                          ),
                          SizedBox(width: NazelDimens.space4),
                          Text(
                            '${act['rating']}',
                            style: NazelTypography.arabic(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Price Tag
                  Text(
                    '${act['price']} رس',
                    style: NazelTypography.arabic(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingStep() {
    final act = _selectedActivity!;
    final totalPrice = (act['price'] as int) * _guestsCount;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Activity Summary Header
          Container(
            padding: EdgeInsets.all(NazelDimens.space16),
            decoration: BoxDecoration(
              color: NazelColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
              border: Border.all(
                color: NazelColors.primary.withValues(alpha: 0.15),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        act['title'] as String,
                        style: NazelTypography.arabic(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: NazelColors.primary,
                        ),
                      ),
                      SizedBox(height: NazelDimens.space4),
                      Text(
                        '${act['duration']} • ${act['category']}',
                        style: NazelTypography.arabic(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: NazelColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${act['price']} رس / شخص',
                  style: NazelTypography.arabic(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                    color: NazelColors.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: NazelDimens.space20),

          // 1. Number of Guests
          Text(
            'عدد الأشخاص',
            style: NazelTypography.arabic(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              color: NazelColors.primary,
            ),
          ),
          SizedBox(height: NazelDimens.space10),
          NazelIncrementField(
            value: _guestsCount,
            minValue: 1,
            maxValue: 20,
            onChanged: (val) => setState(() => _guestsCount = val),
          ),
          SizedBox(height: NazelDimens.space20),

          // 2. Preferred Time Slot
          Text(
            'الوقت المفضل',
            style: NazelTypography.arabic(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              color: NazelColors.primary,
            ),
          ),
          SizedBox(height: NazelDimens.space10),
          ...List.generate(_timeSlots.length, (index) {
            return NazelTimeTile(
              timeText: _timeSlots[index],
              isSelected: _selectedTimeSlot == index,
              onTap: () => setState(() => _selectedTimeSlot = index),
            );
          }),
          SizedBox(height: NazelDimens.space16),

          // 3. Special Notes
          Text(
            'ملاحظات خاصة (اختياري)',
            style: NazelTypography.arabic(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: NazelColors.textPrimary,
            ),
          ),
          SizedBox(height: NazelDimens.space8),
          TextField(
            controller: _notesController,
            maxLines: 2,
            style: NazelTypography.arabic(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: NazelColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'أي متطلبات خاصة أو استفسارات إضافية...',
              hintStyle: NazelTypography.arabic(
                fontSize: 14.0,
                color: NazelColors.textSecondary.withValues(alpha: 0.7),
              ),
              filled: true,
              fillColor: NazelColors.surfaceWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
                borderSide: BorderSide(
                  color: NazelColors.borderLight.withValues(alpha: 0.8),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
                borderSide: BorderSide(
                  color: NazelColors.borderLight.withValues(alpha: 0.8),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(NazelDimens.radiusCard),
                borderSide: const BorderSide(
                  color: NazelColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(height: NazelDimens.space24),

          // Total Price & Actions
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الإجمالي المتوقع',
                      style: NazelTypography.arabic(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: NazelColors.textSecondary,
                      ),
                    ),
                    Text(
                      '$totalPrice رس',
                      style: NazelTypography.arabic(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w900,
                        color: NazelColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              NazelButton(
                text: 'تأكيد طلب الحجز',
                onPressed: () => setState(() => _step = 2),
                width: 200.0.w,
              ),
              SizedBox(width: NazelDimens.space12),
              NazelButton(
                text: 'رجوع',
                variant: NazelButtonVariant.secondary,
                onPressed: () => setState(() => _step = 0),
                width: 110.0.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 8. Ads Modal
class AdsModal extends StatelessWidget {
  const AdsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Featured Top Banner (Cleaning Offer)
          _buildFeaturedBanner(context),
          SizedBox(height: 16.0.h),

          // 2. Section Title
          Text(
            'عروض مميزة',
            style: NazelTypography.arabic(
              fontSize: 18.0.sp,
              fontWeight: FontWeight.w800,
              color: NazelColors.primary,
            ),
          ),
          SizedBox(height: 12.0.h),

          // 3. Special Offer Cards
          _buildOfferCard(
            context: context,
            image: 'assets/images/ipad_image_ac159ff3.png',
            titleLine1: 'خصم 15% على',
            titleLine2: 'للرحلات للبحرية',
            actionText: 'احجز الآن',
            onTap: () {},
          ),
          SizedBox(height: 12.0.h),

          _buildOfferCard(
            context: context,
            image: 'assets/images/ipad_image_a92eb603.png',
            titleLine1: 'خصم 10% على',
            titleLine2: 'توصيل البقالة',
            actionText: 'اطلب الآن',
            onTap: () {},
          ),
          SizedBox(height: 12.0.h),

          _buildOfferCard(
            context: context,
            image: 'assets/images/ipad_image_33a2ad6d.png',
            titleLine1: 'خصم 10% على',
            titleLine2: 'تأجير السيارات',
            actionText: 'احجز الآن',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedBanner(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final imageWidth = cardWidth * 0.50;

        return Container(
          height: cardWidth * 0.20,
          decoration: BoxDecoration(
            color: NazelColors.primary,
            borderRadius: BorderRadius.circular(16.0.r),
            boxShadow: [
              BoxShadow(
                color: NazelColors.primary.withValues(alpha: 0.15),
                offset: Offset(0, 4.h),
                blurRadius: 10.0.r,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Left side image covering half width with fade mask
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: imageWidth,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.0, 0.65, 1.0],
                      colors: [Colors.black, Colors.black, Colors.transparent],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    'assets/images/ipad_image_e6ced3cf.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ),

              // Right side content
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                left: imageWidth * 0.85,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'احجز الآن',
                        style: NazelTypography.arabic(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w700,
                          color: NazelColors.goldLight,
                        ),
                      ),
                      SizedBox(height: 4.0.h),
                      Text(
                        'خصم 20% على\nلخدمات التنظيف',
                        textAlign: TextAlign.center,
                        style: NazelTypography.arabic(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.25,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(6.0.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.0.w,
                            vertical: 6.0.h,
                          ),
                          decoration: BoxDecoration(
                            color: NazelColors.goldDark,
                            borderRadius: BorderRadius.circular(6.0.r),
                          ),
                          child: Text(
                            'احجز الان',
                            style: NazelTypography.arabic(
                              fontSize: 13.0.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOfferCard({
    required BuildContext context,
    required String image,
    required String titleLine1,
    required String titleLine2,
    required String actionText,
    required VoidCallback onTap,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final imageWidth = cardWidth * 0.48;

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0.r),
          child: Container(
            height: 130.0.h,
            decoration: BoxDecoration(
              color: NazelColors.surfaceWhite,
              borderRadius: BorderRadius.circular(16.0.r),
              border: Border.all(color: NazelColors.borderLight, width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  offset: Offset(0, 2.h),
                  blurRadius: 6.0.r,
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Left image covering ~50% with fade mask
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: imageWidth,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.0, 0.65, 1.0],
                        colors: [
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                        ],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),

                // Middle offer text
                Positioned(
                  left: imageWidth * 0.75,
                  right: 110.0.w,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          titleLine1,
                          textAlign: TextAlign.center,
                          style: NazelTypography.arabic(
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.w800,
                            color: NazelColors.primary,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          titleLine2,
                          textAlign: TextAlign.center,
                          style: NazelTypography.arabic(
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.w800,
                            color: NazelColors.primary,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Right action text
                Positioned(
                  right: 24.0.w,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Text(
                      actionText,
                      style: NazelTypography.arabic(
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.w800,
                        color: NazelColors.goldDark,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
