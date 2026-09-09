import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import '../atoms/nazel_button.dart';
import '../atoms/nazel_chip.dart';
import '../atoms/nazel_icon.dart';
import '../atoms/nazel_increment_field.dart';
import '../atoms/nazel_rating_badge.dart';
import '../molecules/nazel_ad_banner.dart';
import '../molecules/nazel_choose_card.dart';
import '../molecules/nazel_grid_item.dart';
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
    return Column(
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
              // Broom / Cleaning Icon
              NazelIcon(
                type: NazelIconType.clean,
                size: 28.0.r,
                color: NazelColors.primary,
              ),
              SizedBox(width: NazelDimens.space16),
              // Title & Date
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
              // Status Done Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0.w,
                  vertical: 8.0.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF8EE),
                  borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
                ),
                child: Text(
                  'تم',
                  style: NazelTypography.arabic(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                    color: NazelColors.success,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        NazelButton(
          text: 'إرسال الطلب',
          onPressed: () => setState(() => _step = 1),
          width: double.infinity,
        ),
      ],
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

    final total = _extraDays * _pricePerDay;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Current Booking Summary Box
        Container(
          padding: EdgeInsets.all(NazelDimens.space20),
          decoration: BoxDecoration(
            color: NazelColors.purpleSoft,
            borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryCol('رقم الحجز', '#NZE-2024-1258'),
              _buildSummaryCol('تاريخ المغادرة', '15 مايو 2026'),
              _buildSummaryCol('وقت المغادرة', '12:30 م'),
            ],
          ),
        ),
        SizedBox(height: NazelDimens.space24),
        Text('أيام التمديد المطلوبة', style: NazelTypography.sectionTitle),
        SizedBox(height: NazelDimens.space12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NazelIncrementField(
              value: _extraDays,
              onChanged: (val) => setState(() => _extraDays = val),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('المبلغ الإجمالي', style: NazelTypography.bodySmall),
                Text(
                  '$total رس',
                  style: NazelTypography.arabic(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                    color: NazelColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        NazelButton(
          text: 'إرسال طلب التمديد للمالك',
          onPressed: () => setState(() => _isDone = true),
          width: double.infinity,
        ),
      ],
    );
  }

  Widget _buildSummaryCol(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: NazelTypography.bodySmall),
        SizedBox(height: NazelDimens.space4),
        Text(
          value,
          style: NazelTypography.arabic(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: NazelColors.primary,
          ),
        ),
      ],
    );
  }
}

/// 3. Nearest Places Modal
class NearestPlacesModal extends StatefulWidget {
  const NearestPlacesModal({super.key});

  @override
  State<NearestPlacesModal> createState() => _NearestPlacesModalState();
}

class _NearestPlacesModalState extends State<NearestPlacesModal> {
  int _selectedCategory = 0;
  final List<String> _categories = [
    'الكل',
    'مستشفيات',
    'حافلات',
    'تموينات',
    'مساجد',
  ];

  final List<Map<String, dynamic>> _places = [
    {
      'title': 'بقالة وميني ماركت الحي',
      'dist': '0.3 كم',
      'time': '5 دقائق',
      'icon': NazelIconType.shoppingCart,
    },
    {
      'title': 'محطة حافلات النقل العام',
      'dist': '1.0 كم',
      'time': '12 دقيقة',
      'icon': NazelIconType.bus,
    },
    {
      'title': 'مستشفى السلام الطبي',
      'dist': '3.5 كم',
      'time': '8 دقائق بالسيارة',
      'icon': NazelIconType.hospital,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_categories.length, (index) {
              return Padding(
                padding: EdgeInsets.only(left: NazelDimens.space8),
                child: NazelCategoryChip(
                  label: _categories[index],
                  isSelected: _selectedCategory == index,
                  onTap: () => setState(() => _selectedCategory = index),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: NazelDimens.space20),
        Text('المرافق القريبة من موقعك', style: NazelTypography.sectionTitle),
        SizedBox(height: NazelDimens.space12),
        Expanded(
          child: ListView.builder(
            itemCount: _places.length,
            itemBuilder: (context, index) {
              final p = _places[index];
              return NazelChooseCard.facility(
                title: p['title'],
                distance: p['dist'],
                time: p['time'],
                iconType: p['icon'],
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}

/// 4. Delivery Service Modal
class DeliveryServiceModal extends StatefulWidget {
  const DeliveryServiceModal({super.key});

  @override
  State<DeliveryServiceModal> createState() => _DeliveryServiceModalState();
}

class _DeliveryServiceModalState extends State<DeliveryServiceModal> {
  int _selectedCategory = 0;
  final List<String> _categories = [
    'مطاعم',
    'بقالة',
    'كافيهات',
    'عصائر',
    'أخرى',
  ];

  final List<Map<String, dynamic>> _items = [
    {'title': 'وجبة برجر فاخر', 'price': 45.0, 'rating': 4.8},
    {'title': 'بيتزا إيطالية مشكلة', 'price': 60.0, 'rating': 4.9},
    {'title': 'قهوة مختصة فلات وايت', 'price': 18.0, 'rating': 5.0},
    {'title': 'سلة فواكه طازجة', 'price': 35.0, 'rating': 4.7},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Categories
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_categories.length, (index) {
              return Padding(
                padding: EdgeInsets.only(left: NazelDimens.space8),
                child: NazelCategoryChip(
                  label: _categories[index],
                  isSelected: _selectedCategory == index,
                  onTap: () => setState(() => _selectedCategory = index),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: NazelDimens.space20),
        Text(
          'المتاجر والوجبات الموصى بها',
          style: NazelTypography.sectionTitle,
        ),
        SizedBox(height: NazelDimens.space12),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: NazelDimens.space16,
              mainAxisSpacing: NazelDimens.space16,
              childAspectRatio: 1.3,
            ),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final it = _items[index];
              return NazelGridProductCard(
                title: it['title'],
                price: it['price'],
                rating: it['rating'],
                onTap: () {},
              );
            },
          ),
        ),
      ],
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
class ApartmentInfoModal extends StatelessWidget {
  const ApartmentInfoModal({super.key});

  @override
  Widget build(BuildContext context) {
    final infoItems = [
      {
        'title': 'دليل استخدام الأجهزة',
        'desc': 'تعليمات تشغيل التكييف والغسالة وشاشة التلفاز',
        'icon': NazelIconType.wrench,
      },
      {
        'title': 'سياسة تسجيل الخروج',
        'desc': 'يرجى تسجيل الخروج قبل الساعة 12:00 ظهراً',
        'icon': NazelIconType.clock,
      },
      {
        'title': 'أرقام التواصل والخدمات',
        'desc': 'فريق خدمة النزلاء متاح على مدار الساعة',
        'icon': NazelIconType.phone,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('دليل ومعلومات الشقة', style: NazelTypography.sectionTitle),
        SizedBox(height: NazelDimens.space16),
        ...infoItems.map((item) {
          return NazelChooseCard(
            title: item['title'] as String,
            subtitle: item['desc'] as String,
            onTap: () {},
            leading: Container(
              width: 52.0.r,
              height: 52.0.r,
              decoration: BoxDecoration(
                color: NazelColors.purpleSoft,
                borderRadius: BorderRadius.circular(NazelDimens.radiusSm),
              ),
              alignment: Alignment.center,
              child: NazelIcon(
                type: item['icon'] as NazelIconType,
                size: 26.0.r,
              ),
            ),
          );
        }),
      ],
    );
  }
}

/// 7. Tourism Modal
class TourismModal extends StatelessWidget {
  const TourismModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NazelAdBanner(
          title: 'رحلات بحرية وتجارب استثنائية',
          discount: 'خصم 20%',
          description: 'استمتع بأجمل الجولات البحرية بأسعار خاصة لنزلاء خزامى',
          onAction: () {},
        ),
        SizedBox(height: NazelDimens.space16),
        Text('الأنشطة الموصى بها اليوم', style: NazelTypography.sectionTitle),
        SizedBox(height: NazelDimens.space12),
        NazelChooseCard(
          title: 'جولة سياحية تاريخية في وسط المدينة',
          subtitle: 'مدة الجولة: 3 ساعات • شامل المرشد والمواصلات',
          onTap: () {},
          trailing: const NazelRatingBadge(rating: 4.9, reviewsCount: 120),
        ),
        NazelChooseCard(
          title: 'رحلة سفاري وتخييم صحراوي فاخر',
          subtitle: 'شامل العشاء وعروض الترفيه الحية',
          onTap: () {},
          trailing: const NazelRatingBadge(rating: 5.0, reviewsCount: 85),
        ),
      ],
    );
  }
}

/// 8. Ads Modal
class AdsModal extends StatelessWidget {
  const AdsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NazelAdBanner(
          title: 'عروض حصرية على خدمات التنظيف',
          discount: 'خصم 20%',
          description:
              'احصل على تنظيف شامل مجاني عند تمديد الإقامة لأكثر من يومين',
          onAction: () {},
        ),
        SizedBox(height: NazelDimens.space16),
        NazelAdBanner(
          title: 'تأجير سيارات فاخرة بأسعار مميزة',
          discount: 'خصم 15%',
          description: 'خدمة التوصيل من وإلى بوابة الشقة مباشرة',
          onAction: () {},
          gradient: NazelColors.goldGradient,
        ),
      ],
    );
  }
}
