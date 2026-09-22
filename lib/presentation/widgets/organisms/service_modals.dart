import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../atoms/nazel_button.dart';
import '../atoms/nazel_icon.dart';
import '../atoms/nazel_increment_field.dart';
import '../atoms/nazel_rating_badge.dart';
import '../molecules/nazel_app_bar.dart';
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

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final services = [
      {'title': l10n.cleaningQuick, 'subtitle': l10n.cleaningQuick},
      {'title': l10n.cleaningDeep, 'subtitle': l10n.cleaningDeep},
      {
        'title': l10n.cleaningLinen,
        'subtitle': l10n.cleaningLinen,
      },
    ];

    final times = [
      l10n.timeSlotToday11AM,
      l10n.timeSlotToday2PM,
      l10n.timeSlotToday5PM,
    ];

    if (_step == 2) {
      return StateDoneView(
        title: l10n.orderReceived,
        description: l10n.cleaningOrderDoneDesc(times[_selectedTime]),
        onDone: () => Navigator.of(context).pop(),
      );
    }

    if (_step == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.selectSuitableTime,
            style: NazelTypography.arabic(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: NazelColors.primaryDark,
            ),
          ),
          SizedBox(height: NazelDimens.space12),
          ...List.generate(times.length, (index) {
            return NazelTimeTile(
              timeText: times[index],
              isSelected: _selectedTime == index,
              onTap: () => setState(() => _selectedTime = index),
            );
          }),
          SizedBox(height: NazelDimens.space20),
          Text(
            l10n.additionalNotesOptional,
            style: NazelTypography.arabic(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: NazelColors.primaryDark,
            ),
          ),
          SizedBox(height: NazelDimens.space8),
          TextField(
            controller: _notesController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: l10n.notesPlaceholder,
              hintStyle: NazelTypography.bodySmall,
              filled: true,
              fillColor: NazelColors.surfaceWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0.r),
                borderSide: BorderSide(
                  color: NazelColors.purpleBorder.withValues(alpha: 0.35),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0.r),
                borderSide: BorderSide(
                  color: NazelColors.purpleBorder.withValues(alpha: 0.35),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0.r),
                borderSide: const BorderSide(
                  color: NazelColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(height: NazelDimens.space24),
          Row(
            children: [
              Expanded(
                child: NazelButton(
                  text: l10n.orderNow,
                  onPressed: () => setState(() => _step = 2),
                ),
              ),
              SizedBox(width: NazelDimens.space12),
              NazelButton(
                text: l10n.back,
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
            l10n.cleaningSelectService,
            style: NazelTypography.arabic(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: NazelColors.primaryDark,
            ),
          ),
          SizedBox(height: NazelDimens.space12),
          ...List.generate(services.length, (index) {
            return NazelChooseCard.selectable(
              title: services[index]['title']!,
              subtitle: services[index]['subtitle']!,
              isSelected: _selectedService == index,
              onTap: () {
                setState(() => _selectedService = index);
              },
            );
          }),
          SizedBox(height: NazelDimens.space24),
          Row(
            children: [
              NazelIcon(
                type: NazelIconType.clock,
                size: 20.0.r,
                color: NazelColors.primaryDark,
              ),
              SizedBox(width: NazelDimens.space8),
              Text(
                l10n.previousOrders,
                style: NazelTypography.arabic(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: NazelColors.primaryDark,
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
              borderRadius: BorderRadius.circular(8.0.r),
              border: Border.all(
                color: NazelColors.purpleBorder.withValues(alpha: 0.35),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: NazelColors.primary.withValues(alpha: 0.04),
                  offset: const Offset(0, 2),
                  blurRadius: 6.0.r,
                ),
              ],
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
                        l10n.cleaningQuick,
                        style: NazelTypography.arabic(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: NazelColors.primaryDark,
                        ),
                      ),
                      SizedBox(height: NazelDimens.space4),
                      Text(
                        l10n.sampleOrderDate,
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
                    l10n.completed,
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
            alignment: AlignmentDirectional.centerStart,
            child: NazelButton(
              text: l10n.continueText,
              onPressed: () => setState(() => _step = 1),
              width: 140.0.w,
            ),
          ),
        ],
      ),
    );
  }
}

/// 1b. Contracted Services Hub Modal ("اطلب خدمة")
class ServicesHubModal extends StatefulWidget {
  const ServicesHubModal({super.key});

  @override
  State<ServicesHubModal> createState() => _ServicesHubModalState();
}

class _ServicesHubModalState extends State<ServicesHubModal> {
  String? _activeCategory; // null: catalog, 'laundry', 'grocery', 'cleaning', 'delivery', 'extra_services'
  bool _isDone = false;
  String _currentServiceName = '';
  String _currentProviderName = '';
  String _currentOrderDetails = '';
  final String _orderId = '#NZ-8412';

  // Laundry state
  int _selectedLaundryPkg = 0;
  final TextEditingController _laundryNotes = TextEditingController();

  // Grocery state
  int _selectedGroceryBasket = 0;
  final TextEditingController _groceryNotes = TextEditingController();

  // Cleaning state
  int _selectedCleaningType = 0;
  int _selectedCleaningTime = 0;
  final TextEditingController _cleaningNotes = TextEditingController();

  // Delivery state
  int _selectedDeliveryOption = 0;
  final TextEditingController _deliveryNotes = TextEditingController();

  // Extra services state
  int _selectedExtraService = 0;
  final TextEditingController _extraServiceNotes = TextEditingController();

  @override
  void dispose() {
    _laundryNotes.dispose();
    _groceryNotes.dispose();
    _cleaningNotes.dispose();
    _deliveryNotes.dispose();
    _extraServiceNotes.dispose();
    super.dispose();
  }

  void _triggerWhatsApp(String providerName, String serviceName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'جاري فتح واتساب مع $providerName ($serviceName)...',
          style: NazelTypography.arabic(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: NazelColors.surfaceWhite,
          ),
        ),
        backgroundColor: NazelColors.primaryDark,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _triggerCall(String providerName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'جاري الاتصال بـ $providerName لتأكيد تفاصيل الطلب...',
          style: NazelTypography.arabic(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: NazelColors.surfaceWhite,
          ),
        ),
        backgroundColor: NazelColors.primaryDark,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _submitOrder({
    required String serviceName,
    required String providerName,
    required String details,
  }) {
    setState(() {
      _currentServiceName = serviceName;
      _currentProviderName = providerName;
      _currentOrderDetails = details;
      _isDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isDone) {
      return _buildOrderStatusScreen();
    }

    if (_activeCategory == null) {
      return _buildServicesCatalog();
    }

    switch (_activeCategory) {
      case 'laundry':
        return _buildLaundryFlow();
      case 'grocery':
        return _buildGroceryFlow();
      case 'cleaning':
        return _buildCleaningFlow();
      case 'delivery':
        return _buildDeliveryFlow();
      case 'extra_services':
        return _buildExtraServicesFlow();
      default:
        return _buildServicesCatalog();
    }
  }

  // --- Main Catalog Menu ---
  Widget _buildServicesCatalog() {
    final services = [
      {
        'id': 'laundry',
        'title': 'مغسلة ملابس متنقلة',
        'desc': 'تجي لعند الباب، تاخذ الملابس، وترجّعها للوحدة — مناسبة للإقامات الطويلة والمعتمرين والعوائل',
        'icon': Icons.local_laundry_service_rounded,
        'badge': 'استلام من الباب',
      },
      {
        'id': 'grocery',
        'title': 'بقالة ٢٤ ساعة',
        'desc': 'تعاقد مع عدة بقالات في الحي، يوصل الطلب واتساب والتوصيل للباب بأي وقت من الليل',
        'icon': Icons.storefront_rounded,
        'badge': 'توصيل ليلي ٢٤/٧',
      },
      {
        'id': 'cleaning',
        'title': 'تنظيف الوحدة',
        'desc': 'تنظيف أثناء الإقامة، وتغيير مفارش، وتنظيف عميق عند الطلب',
        'icon': Icons.cleaning_services_rounded,
        'badge': 'خدمة فورية',
      },
      {
        'id': 'delivery',
        'title': 'توصيل عام',
        'desc': 'عبر ربط مع شركات التوصيل مثل نينجا بنظام API، أو عبر مندوب المزوّد مباشرة',
        'icon': Icons.delivery_dining_rounded,
        'badge': 'نينجا والمندوب',
      },
      {
        'id': 'extra_services',
        'title': 'خدمات إضافية',
        'desc': 'تُفتح واحدة واحدة حسب طلب الضيوف في كل منطقة — صيانة سريعة، ماء وغاز، نقل، وغيرها',
        'icon': Icons.handyman_rounded,
        'badge': 'حسب منطقتك',
      },
    ];

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        ...services.map((item) {
          final badge = item['badge'] as String?;
          return Container(
            margin: EdgeInsets.only(bottom: NazelDimens.space12),
            child: NazelChooseCard(
              height: 108.0.h,
              title: item['title'] as String,
              subtitle: item['desc'] as String,
              onTap: () {
                setState(() {
                  _activeCategory = item['id'] as String;
                });
              },
              leading: Container(
                width: 52.0.r,
                height: 52.0.r,
                decoration: BoxDecoration(
                  color: NazelColors.purpleSoft,
                  borderRadius: BorderRadius.circular(6.0.r),
                  border: Border.all(
                    color: NazelColors.purpleBorder.withValues(alpha: 0.25),
                    width: 1.0,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  item['icon'] as IconData,
                  size: 26.0.r,
                  color: NazelColors.primary,
                ),
              ),
              trailing: badge != null
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0.w,
                        vertical: 4.0.h,
                      ),
                      decoration: BoxDecoration(
                        color: NazelColors.purpleSoft,
                        borderRadius: BorderRadius.circular(4.0.r),
                        border: Border.all(
                          color: NazelColors.purpleBorder.withValues(alpha: 0.3),
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        badge,
                        style: NazelTypography.arabic(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: NazelColors.primaryDark,
                        ),
                      ),
                    )
                  : null,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSubHeader(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: NazelDimens.space16),
      child: Row(
        children: [
          Material(
            color: NazelColors.purpleSoft,
            borderRadius: BorderRadius.circular(6.0.r),
            child: InkWell(
              borderRadius: BorderRadius.circular(6.0.r),
              onTap: () => setState(() => _activeCategory = null),
              child: Padding(
                padding: EdgeInsets.all(NazelDimens.space8),
                child: Icon(
                  NazelDirectionalIcons.back(context),
                  size: 20.0.r,
                  color: NazelColors.primaryDark,
                ),
              ),
            ),
          ),
          SizedBox(width: NazelDimens.space12),
          Text(
            title,
            style: NazelTypography.arabic(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: NazelColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  // --- 1. مغسلة ملابس متنقلة ---
  Widget _buildLaundryFlow() {
    final packages = [
      {
        'title': 'غسيل وكوي كامل (١٠ قطع)',
        'subtitle': 'غسيل وكوي ملابس يومية وتسليم للباب — مثالي للإقامات الطويلة والعوائل',
        'price': '٦٠ ريال',
      },
      {
        'title': 'كوي بخار مستعجل (٥ قطع)',
        'subtitle': 'كوي احترافي وسريع وتسليم خلال ٩٠ دقيقة لباب الشقة',
        'price': '٣٠ ريال',
      },
      {
        'title': 'غسيل ملابس إحرام وأثواب خاصة',
        'subtitle': 'غسيل وتعقيم وعناية فائقة للأقمشة البيضاء ومناسك العمرة',
        'price': '٤٠ ريال',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubHeader('مغسلة ملابس متنقلة'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.all(NazelDimens.space14),
                decoration: BoxDecoration(
                  color: NazelColors.purpleSoft,
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded, color: NazelColors.primaryDark, size: 20.0.r),
                    SizedBox(width: 10.0.w),
                    Expanded(
                      child: Text(
                        'تجي لعند الباب، تاخذ الملابس، وترجّعها للوحدة. خدمة ما لها بديل في جوّال الضيف، ومناسبة للإقامات الطويلة والمعتمرين والعوائل.',
                        style: NazelTypography.arabic(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: NazelColors.primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: NazelDimens.space14),
              Text(
                'اختر باقة الغسيل والكوي المطلوبة',
                style: NazelTypography.arabic(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: NazelColors.primaryDark,
                ),
              ),
              SizedBox(height: NazelDimens.space10),
              ...List.generate(packages.length, (i) {
                final isSelected = _selectedLaundryPkg == i;
                final p = packages[i];
                return Container(
                  margin: EdgeInsets.only(bottom: NazelDimens.space8),
                  child: NazelChooseCard(
                    title: p['title']!,
                    subtitle: p['subtitle']!,
                    onTap: () => setState(() => _selectedLaundryPkg = i),
                    trailing: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 6.0.h),
                      decoration: BoxDecoration(
                        color: isSelected ? NazelColors.primary : NazelColors.purpleSoft,
                        borderRadius: BorderRadius.circular(4.0.r),
                      ),
                      child: Text(
                        p['price']!,
                        style: NazelTypography.arabic(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? Colors.white : NazelColors.primaryDark,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: NazelDimens.space10),
              TextField(
                controller: _laundryNotes,
                decoration: InputDecoration(
                  hintText: 'ملاحظات إضافية للمغسلة (مثل عدد القطع أو موعد محدد)...',
                  hintStyle: NazelTypography.arabic(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: NazelColors.textSecondary,
                  ),
                  filled: true,
                  fillColor: NazelColors.surfaceWhite,
                  contentPadding: EdgeInsets.all(NazelDimens.space12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0.r),
                    borderSide: BorderSide(color: NazelColors.purpleBorder.withValues(alpha: 0.4)),
                  ),
                ),
              ),
              SizedBox(height: NazelDimens.space16),
              Row(
                children: [
                  Expanded(
                    child: NazelButton(
                      text: 'إرسال طلب استلام الملابس',
                      variant: NazelButtonVariant.primary,
                      height: 48.h,
                      onPressed: () {
                        _submitOrder(
                          serviceName: 'مغسلة ملابس متنقلة',
                          providerName: 'مندوب المغسلة المتنقلة',
                          details: '${packages[_selectedLaundryPkg]['title']} — استلام من باب الوحدة رقم 402',
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 12.0.w),
                  Material(
                    color: const Color(0xFF25D366),
                    borderRadius: BorderRadius.circular(6.0.r),
                    child: InkWell(
                      onTap: () => _triggerWhatsApp('مغسلة ملابس متنقلة', packages[_selectedLaundryPkg]['title']!),
                      borderRadius: BorderRadius.circular(6.0.r),
                      child: Container(
                        height: 48.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Icon(Icons.chat_bubble_rounded, size: 16.0.r, color: Colors.white),
                            SizedBox(width: 6.0.w),
                            Text(
                              'واتساب المغسلة',
                              style: NazelTypography.arabic(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- 2. بقالة ٢٤ ساعة ---
  Widget _buildGroceryFlow() {
    final baskets = [
      {
        'title': 'كرتون مياه شرب معقمة (٤٠ عبوة مبردة)',
        'subtitle': 'مياه نقية تصل لباب شقتك مباشرة بأي وقت من الليل',
        'price': '١٨ ريال',
      },
      {
        'title': 'سلة سناكات ومشروبات خفيفة ليلية',
        'subtitle': 'شيبسات، شوكولاتة، عصائر ومشروبات غازية مبردة',
        'price': '٣٥ ريال',
      },
      {
        'title': 'مستلزمات شاي وقهوة وسكر وحليب',
        'subtitle': 'شاي فاخر، أظرف قهوة، حليب مبخر وسكر طازج',
        'price': '٢٥ ريال',
      },
      {
        'title': 'طلب مقاضي واحتياجات حرة للباب',
        'subtitle': 'حدد احتياجاتك الخاصة وسيقوم البقال بإحضارها لك فوراً',
        'price': 'حسب الفاتورة',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubHeader('بقالة ٢٤ ساعة'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.all(NazelDimens.space14),
                decoration: BoxDecoration(
                  color: NazelColors.purpleSoft,
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time_filled_rounded, color: NazelColors.primaryDark, size: 20.0.r),
                    SizedBox(width: 10.0.w),
                    Expanded(
                      child: Text(
                        'تعاقد مع عدة بقالات في كل حي. الطلب يوصل البقالة على الواتساب مباشرة، والتوصيل للباب بأي وقت من الليل.',
                        style: NazelTypography.arabic(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: NazelColors.primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: NazelDimens.space14),
              Text(
                'اختر السلة السريعة أو حدد طلبك',
                style: NazelTypography.arabic(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: NazelColors.primaryDark,
                ),
              ),
              SizedBox(height: NazelDimens.space10),
              ...List.generate(baskets.length, (i) {
                final isSelected = _selectedGroceryBasket == i;
                final b = baskets[i];
                return Container(
                  margin: EdgeInsets.only(bottom: NazelDimens.space8),
                  child: NazelChooseCard(
                    title: b['title']!,
                    subtitle: b['subtitle']!,
                    onTap: () => setState(() => _selectedGroceryBasket = i),
                    trailing: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 6.0.h),
                      decoration: BoxDecoration(
                        color: isSelected ? NazelColors.primary : NazelColors.purpleSoft,
                        borderRadius: BorderRadius.circular(4.0.r),
                      ),
                      child: Text(
                        b['price']!,
                        style: NazelTypography.arabic(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? Colors.white : NazelColors.primaryDark,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: NazelDimens.space10),
              TextField(
                controller: _groceryNotes,
                decoration: InputDecoration(
                  hintText: 'اكتب قائمة الأغراض المطلوبة إذا كان طلبك حراً...',
                  hintStyle: NazelTypography.arabic(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: NazelColors.textSecondary,
                  ),
                  filled: true,
                  fillColor: NazelColors.surfaceWhite,
                  contentPadding: EdgeInsets.all(NazelDimens.space12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0.r),
                    borderSide: BorderSide(color: NazelColors.purpleBorder.withValues(alpha: 0.4)),
                  ),
                ),
              ),
              SizedBox(height: NazelDimens.space16),
              Row(
                children: [
                  Expanded(
                    child: NazelButton(
                      text: 'إرسال طلب البقالة للباب',
                      variant: NazelButtonVariant.primary,
                      height: 48.h,
                      onPressed: () {
                        _submitOrder(
                          serviceName: 'بقالة ٢٤ ساعة',
                          providerName: 'بقالة الحي ٢٤ ساعة الشريكة',
                          details: '${baskets[_selectedGroceryBasket]['title']} — توصيل فوري لباب الوحدة رقم 402',
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 12.0.w),
                  Material(
                    color: const Color(0xFF25D366),
                    borderRadius: BorderRadius.circular(6.0.r),
                    child: InkWell(
                      onTap: () => _triggerWhatsApp('بقالة ٢٤ ساعة', baskets[_selectedGroceryBasket]['title']!),
                      borderRadius: BorderRadius.circular(6.0.r),
                      child: Container(
                        height: 48.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Icon(Icons.chat_bubble_rounded, size: 16.0.r, color: Colors.white),
                            SizedBox(width: 6.0.w),
                            Text(
                              'واتساب البقالة',
                              style: NazelTypography.arabic(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- 3. تنظيف الوحدة ---
  Widget _buildCleaningFlow() {
    final types = [
      {
        'title': 'تنظيف وترتيب أثناء الإقامة',
        'desc': 'ترتيب الأسرة، مسح الأسطح، وإفراغ السلات أثناء وجودك بالوحدة',
      },
      {
        'title': 'تغيير مفارش وشراشف ومناشف',
        'desc': 'استبدال كامل أطقم المفارش والمناشف بأطقم فندقية نظيفة ومعقمة',
      },
      {
        'title': 'تنظيف عميق عند الطلب',
        'desc': 'تنظيف شامل ومعقم للأرضيات والمطبخ ودورات المياه بالكامل',
      },
    ];
    final times = ['فوري — خلال ساعة', 'اليوم — ٢:٠٠ ظهراً', 'اليوم — ٥:٠٠ مساءً'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubHeader('تنظيف الوحدة'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.all(NazelDimens.space14),
                decoration: BoxDecoration(
                  color: NazelColors.purpleSoft,
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.cleaning_services_rounded, color: NazelColors.primaryDark, size: 20.0.r),
                    SizedBox(width: 10.0.w),
                    Expanded(
                      child: Text(
                        'تنظيف أثناء الإقامة، وتغيير مفارش، وتنظيف عميق عند الطلب.',
                        style: NazelTypography.arabic(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: NazelColors.primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: NazelDimens.space14),
              Text(
                'اختر نوع التنظيف المطلوب',
                style: NazelTypography.arabic(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: NazelColors.primaryDark,
                ),
              ),
              SizedBox(height: NazelDimens.space10),
              ...List.generate(types.length, (i) {
                final isSelected = _selectedCleaningType == i;
                return Container(
                  margin: EdgeInsets.only(bottom: NazelDimens.space8),
                  child: NazelChooseCard(
                    title: types[i]['title']!,
                    subtitle: types[i]['desc']!,
                    onTap: () => setState(() => _selectedCleaningType = i),
                    trailing: isSelected
                        ? Icon(Icons.check_circle_rounded, color: NazelColors.primary, size: 24.0.r)
                        : null,
                  ),
                );
              }),
              SizedBox(height: NazelDimens.space12),
              Text(
                'الوقت المفضل للخدمة',
                style: NazelTypography.arabic(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: NazelColors.primaryDark,
                ),
              ),
              SizedBox(height: NazelDimens.space8),
              Row(
                children: List.generate(times.length, (i) {
                  final isSelected = _selectedCleaningTime == i;
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                      child: Material(
                        color: isSelected ? NazelColors.purpleSoft : NazelColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(6.0.r),
                        child: InkWell(
                          onTap: () => setState(() => _selectedCleaningTime = i),
                          borderRadius: BorderRadius.circular(6.0.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0.r),
                              border: Border.all(
                                color: isSelected ? NazelColors.primary : NazelColors.purpleBorder.withValues(alpha: 0.3),
                                width: isSelected ? 1.4 : 1.0,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              times[i],
                              style: NazelTypography.arabic(
                                fontSize: 12.0,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? NazelColors.primaryDark : NazelColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: NazelDimens.space12),
              TextField(
                controller: _cleaningNotes,
                decoration: InputDecoration(
                  hintText: 'ملاحظات خاصة لفريق النظافة...',
                  hintStyle: NazelTypography.arabic(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: NazelColors.textSecondary,
                  ),
                  filled: true,
                  fillColor: NazelColors.surfaceWhite,
                  contentPadding: EdgeInsets.all(NazelDimens.space12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0.r),
                    borderSide: BorderSide(color: NazelColors.purpleBorder.withValues(alpha: 0.4)),
                  ),
                ),
              ),
              SizedBox(height: NazelDimens.space16),
              Row(
                children: [
                  Expanded(
                    child: NazelButton(
                      text: 'إرسال طلب التنظيف',
                      variant: NazelButtonVariant.primary,
                      height: 48.h,
                      onPressed: () {
                        _submitOrder(
                          serviceName: 'تنظيف الوحدة',
                          providerName: 'مشرف نظافة الوحدة',
                          details: '${types[_selectedCleaningType]['title']} في موعد (${times[_selectedCleaningTime]}) للوحدة رقم 402',
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 12.0.w),
                  Material(
                    color: const Color(0xFF25D366),
                    borderRadius: BorderRadius.circular(6.0.r),
                    child: InkWell(
                      onTap: () => _triggerWhatsApp('مشرف النظافة', types[_selectedCleaningType]['title']!),
                      borderRadius: BorderRadius.circular(6.0.r),
                      child: Container(
                        height: 48.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Icon(Icons.chat_bubble_rounded, size: 16.0.r, color: Colors.white),
                            SizedBox(width: 6.0.w),
                            Text(
                              'واتساب المشرف',
                              style: NazelTypography.arabic(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- 4. توصيل عام ---
  Widget _buildDeliveryFlow() {
    final deliveryPartners = [
      {
        'title': 'توصيل عبر نينجا (ربط مباشر API)',
        'subtitle': 'توصيل فوري فائق السرعة للسوبرماركت والصيدلية والمأكولات خلال ٢٠ دقيقة',
        'badge': 'ربط API مباشر',
      },
      {
        'title': 'مندوب المزوّد المباشر لباب الوحدة',
        'subtitle': 'شراء مستلزمات خاصة، نقل طلبات، أو استلام واسترجاع الشحنات',
        'badge': 'مندوب مخصص',
      },
      {
        'title': 'استلام طرود وشحنات من الاستقبال',
        'subtitle': 'توصيل طردك أو شحنتك المسلمة في الاستقبال إلى باب شقتك مباشرة',
        'badge': 'خدمة الاستقبال',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubHeader('توصيل عام ومشتريات'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.all(NazelDimens.space14),
                decoration: BoxDecoration(
                  color: NazelColors.purpleSoft,
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.electric_bolt_rounded, color: NazelColors.primaryDark, size: 20.0.r),
                    SizedBox(width: 10.0.w),
                    Expanded(
                      child: Text(
                        'عبر ربط مع شركات التوصيل مثل نينجا بنظام API، أو عبر مندوب المزوّد مباشرة.',
                        style: NazelTypography.arabic(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: NazelColors.primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: NazelDimens.space14),
              Text(
                'اختر طريقة التوصيل المطلوبة',
                style: NazelTypography.arabic(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: NazelColors.primaryDark,
                ),
              ),
              SizedBox(height: NazelDimens.space10),
              ...List.generate(deliveryPartners.length, (i) {
                final isSelected = _selectedDeliveryOption == i;
                final partner = deliveryPartners[i];
                return Container(
                  margin: EdgeInsets.only(bottom: NazelDimens.space8),
                  child: NazelChooseCard(
                    title: partner['title']!,
                    subtitle: partner['subtitle']!,
                    onTap: () => setState(() => _selectedDeliveryOption = i),
                    trailing: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 4.0.h),
                      decoration: BoxDecoration(
                        color: isSelected ? NazelColors.primary : NazelColors.purpleSoft,
                        borderRadius: BorderRadius.circular(4.0.r),
                      ),
                      child: Text(
                        partner['badge']!,
                        style: NazelTypography.arabic(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? Colors.white : NazelColors.primaryDark,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: NazelDimens.space10),
              TextField(
                controller: _deliveryNotes,
                decoration: InputDecoration(
                  hintText: 'تفاصيل ما تريد توصيله أو عنوان المتجر...',
                  hintStyle: NazelTypography.arabic(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: NazelColors.textSecondary,
                  ),
                  filled: true,
                  fillColor: NazelColors.surfaceWhite,
                  contentPadding: EdgeInsets.all(NazelDimens.space12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0.r),
                    borderSide: BorderSide(color: NazelColors.purpleBorder.withValues(alpha: 0.4)),
                  ),
                ),
              ),
              SizedBox(height: NazelDimens.space16),
              Row(
                children: [
                  Expanded(
                    child: NazelButton(
                      text: 'إرسال طلب التوصيل',
                      variant: NazelButtonVariant.primary,
                      height: 48.h,
                      onPressed: () {
                        _submitOrder(
                          serviceName: 'توصيل عام',
                          providerName: 'فريق التوصيل المباشر ونينجا',
                          details: '${deliveryPartners[_selectedDeliveryOption]['title']} — للوحدة رقم 402',
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 12.0.w),
                  Material(
                    color: const Color(0xFF25D366),
                    borderRadius: BorderRadius.circular(6.0.r),
                    child: InkWell(
                      onTap: () => _triggerWhatsApp('مندوب التوصيل', deliveryPartners[_selectedDeliveryOption]['title']!),
                      borderRadius: BorderRadius.circular(6.0.r),
                      child: Container(
                        height: 48.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Icon(Icons.chat_bubble_rounded, size: 16.0.r, color: Colors.white),
                            SizedBox(width: 6.0.w),
                            Text(
                              'واتساب المندوب',
                              style: NazelTypography.arabic(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- 5. خدمات إضافية ---
  Widget _buildExtraServicesFlow() {
    final extraServices = [
      {
        'title': 'صيانة سريعة وطوارئ مرافق',
        'subtitle': 'إصلاحات سباكة، كهرباء، صيانة تكييف أو أقفال عاجلة',
        'badge': 'صيانة فورية',
      },
      {
        'title': 'توفير ماء وغاز للوحدة',
        'subtitle': 'توصيل أسطوانة غاز جديدة أو جالون مياه نقي كبير للوحدة',
        'badge': 'مستلزمات أساسية',
      },
      {
        'title': 'نقل وتوصيل مشاوير خاصة',
        'subtitle': 'سيارة خاصة للنقل إلى المطار، محطة القطار، الحرم أو المعالم',
        'badge': 'مشاوير ونقل',
      },
      {
        'title': 'طلب خدمة مخصصة أخرى',
        'subtitle': 'أي طلب أو حاجة إضافية ترغب بها في هذه المنطقة',
        'badge': 'طلب مفتوح',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubHeader('خدمات إضافية'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.all(NazelDimens.space14),
                decoration: BoxDecoration(
                  color: NazelColors.purpleSoft,
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.handyman_rounded, color: NazelColors.primaryDark, size: 20.0.r),
                    SizedBox(width: 10.0.w),
                    Expanded(
                      child: Text(
                        'تُفتح واحدة واحدة حسب طلب الضيوف في كل منطقة — صيانة سريعة، ماء وغاز، نقل، وغيرها.',
                        style: NazelTypography.arabic(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: NazelColors.primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: NazelDimens.space14),
              Text(
                'اختر الخدمة الإضافية المطلوبة',
                style: NazelTypography.arabic(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: NazelColors.primaryDark,
                ),
              ),
              SizedBox(height: NazelDimens.space10),
              ...List.generate(extraServices.length, (i) {
                final isSelected = _selectedExtraService == i;
                final s = extraServices[i];
                return Container(
                  margin: EdgeInsets.only(bottom: NazelDimens.space8),
                  child: NazelChooseCard(
                    title: s['title']!,
                    subtitle: s['subtitle']!,
                    onTap: () => setState(() => _selectedExtraService = i),
                    trailing: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 4.0.h),
                      decoration: BoxDecoration(
                        color: isSelected ? NazelColors.primary : NazelColors.purpleSoft,
                        borderRadius: BorderRadius.circular(4.0.r),
                      ),
                      child: Text(
                        s['badge']!,
                        style: NazelTypography.arabic(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? Colors.white : NazelColors.primaryDark,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: NazelDimens.space10),
              TextField(
                controller: _extraServiceNotes,
                decoration: InputDecoration(
                  hintText: 'اكتب تفاصيل الخدمة أو المشكلة بالتحديد...',
                  hintStyle: NazelTypography.arabic(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: NazelColors.textSecondary,
                  ),
                  filled: true,
                  fillColor: NazelColors.surfaceWhite,
                  contentPadding: EdgeInsets.all(NazelDimens.space12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0.r),
                    borderSide: BorderSide(color: NazelColors.purpleBorder.withValues(alpha: 0.4)),
                  ),
                ),
              ),
              SizedBox(height: NazelDimens.space16),
              Row(
                children: [
                  Expanded(
                    child: NazelButton(
                      text: 'إرسال طلب الخدمة',
                      variant: NazelButtonVariant.primary,
                      height: 48.h,
                      onPressed: () {
                        _submitOrder(
                          serviceName: 'خدمات إضافية',
                          providerName: 'فريق الدعم الميداني',
                          details: '${extraServices[_selectedExtraService]['title']} — للوحدة رقم 402',
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 12.0.w),
                  Material(
                    color: const Color(0xFF25D366),
                    borderRadius: BorderRadius.circular(6.0.r),
                    child: InkWell(
                      onTap: () => _triggerWhatsApp('الدعم الميداني', extraServices[_selectedExtraService]['title']!),
                      borderRadius: BorderRadius.circular(6.0.r),
                      child: Container(
                        height: 48.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Icon(Icons.chat_bubble_rounded, size: 16.0.r, color: Colors.white),
                            SizedBox(width: 6.0.w),
                            Text(
                              'واتساب الدعم',
                              style: NazelTypography.arabic(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- شاشة متابعة حالة الطلب الحية للضيف على الشاشة ---
  Widget _buildOrderStatusScreen() {
    final steps = [
      {
        'title': 'الطلب مُرسل ومُسجّل',
        'desc': 'الضيف ضغط وأرسل — تم استلام الطلب وتوجيهه للنظام للوحدة رقم 402',
        'status': 'done',
      },
      {
        'title': 'تم إشعار المزوّد فوراً',
        'desc': 'الطلب وصل المزوّد فوراً عبر نظام الإشعارات والواتساب',
        'status': 'done',
      },
      {
        'title': 'المزوّد في الطريق أو يتواصل معك',
        'desc': 'يجي العامل للوحدة مباشرة، أو يتواصل معك على الواتساب، أو يدق عليك لتأكيد التفاصيل',
        'status': 'active',
      },
      {
        'title': 'وصول العامل وإتمام الخدمة',
        'desc': 'تسليم الملابس / الطلبات عند باب الوحدة أو إتمام أعمال التنظيف والصيانة',
        'status': 'pending',
      },
    ];

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        // Order Summary Card
        Container(
          padding: EdgeInsets.all(NazelDimens.space16),
          decoration: BoxDecoration(
            color: NazelColors.purpleSoft,
            borderRadius: BorderRadius.circular(8.0.r),
            border: Border.all(
              color: NazelColors.purpleBorder.withValues(alpha: 0.35),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 4.0.h),
                    decoration: BoxDecoration(
                      color: NazelColors.primary,
                      borderRadius: BorderRadius.circular(4.0.r),
                    ),
                    child: Text(
                      'الطلب قيد التنفيذ الآن',
                      style: NazelTypography.arabic(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'رقم الطلب: $_orderId',
                    style: NazelTypography.arabic(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: NazelColors.primaryDark,
                    ),
                  ),
                ],
              ),
              SizedBox(height: NazelDimens.space10),
              Text(
                _currentServiceName,
                style: NazelTypography.arabic(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: NazelColors.primaryDark,
                ),
              ),
              SizedBox(height: 4.0.h),
              Text(
                _currentOrderDetails,
                style: NazelTypography.arabic(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: NazelColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: NazelDimens.space16),

        Text(
          'حالة الطلب المباشرة على الشاشة',
          style: NazelTypography.arabic(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: NazelColors.primaryDark,
          ),
        ),

        SizedBox(height: NazelDimens.space12),

        // Timeline steps
        ...List.generate(steps.length, (i) {
          final s = steps[i];
          final isDone = s['status'] == 'done';
          final isActive = s['status'] == 'active';
          final isLast = i == steps.length - 1;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 28.0.r,
                      height: 28.0.r,
                      decoration: BoxDecoration(
                        color: isDone
                            ? NazelColors.primary
                            : isActive
                                ? NazelColors.primary.withValues(alpha: 0.15)
                                : NazelColors.purpleSoft,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDone || isActive
                              ? NazelColors.primary
                              : NazelColors.purpleBorder.withValues(alpha: 0.4),
                          width: 2.0,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: isDone
                          ? Icon(Icons.check_rounded, color: Colors.white, size: 16.0.r)
                          : isActive
                              ? Container(
                                  width: 10.0.r,
                                  height: 10.0.r,
                                  decoration: const BoxDecoration(
                                    color: NazelColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : Text(
                                  '${i + 1}',
                                  style: NazelTypography.arabic(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w700,
                                    color: NazelColors.textSecondary,
                                  ),
                                ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0.h),
                          color: isDone
                              ? NazelColors.primary
                              : NazelColors.purpleBorder.withValues(alpha: 0.35),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: NazelDimens.space12),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: NazelDimens.space14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s['title']!,
                          style: NazelTypography.arabic(
                            fontSize: 14.5,
                            fontWeight: isActive || isDone ? FontWeight.w700 : FontWeight.w600,
                            color: isActive
                                ? NazelColors.primaryDark
                                : isDone
                                    ? NazelColors.textPrimary
                                    : NazelColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 2.0.h),
                        Text(
                          s['desc']!,
                          style: NazelTypography.arabic(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: isActive ? NazelColors.primaryDark : NazelColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),

        SizedBox(height: NazelDimens.space16),

        // Quick action buttons for the guest
        Row(
          children: [
            Expanded(
              child: Material(
                color: const Color(0xFF25D366),
                borderRadius: BorderRadius.circular(6.0.r),
                child: InkWell(
                  onTap: () => _triggerWhatsApp(_currentProviderName, _currentServiceName),
                  borderRadius: BorderRadius.circular(6.0.r),
                  child: Container(
                    height: 46.h,
                    padding: EdgeInsets.symmetric(horizontal: 14.0.w),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_rounded, size: 16.0.r, color: Colors.white),
                        SizedBox(width: 6.0.w),
                        Text(
                          'تواصل واتساب مع المزوّد',
                          style: NazelTypography.arabic(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0.w),
            Expanded(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6.0.r),
                child: InkWell(
                  onTap: () => _triggerCall(_currentProviderName),
                  borderRadius: BorderRadius.circular(6.0.r),
                  child: Container(
                    height: 46.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0.r),
                      border: Border.all(
                        color: NazelColors.primary,
                        width: 1.2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone_in_talk_rounded, size: 16.0.r, color: NazelColors.primary),
                        SizedBox(width: 6.0.w),
                        Text(
                          'اتصال لتأكيد التفاصيل',
                          style: NazelTypography.arabic(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700,
                            color: NazelColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: NazelDimens.space12),

        NazelButton(
          text: 'الرجوع لقائمة الخدمات',
          variant: NazelButtonVariant.outline,
          height: 44.h,
          onPressed: () {
            setState(() {
              _isDone = false;
              _activeCategory = null;
            });
          },
        ),
      ],
    );
  }
}

/// 2. Extend Booking Modal (تمديد ليلة أو تأخير خروج)
class ExtendBookingModal extends StatefulWidget {
  final int initialTab;
  const ExtendBookingModal({super.key, this.initialTab = 0});

  @override
  State<ExtendBookingModal> createState() => _ExtendBookingModalState();
}

class _ExtendBookingModalState extends State<ExtendBookingModal> {
  late int _selectedTab; // 0: تمديد ليلة, 1: تأخير خروج
  int _extraDays = 1;
  int _selectedLateIndex = 1; // Default: 4 hours (100 SAR)
  bool _isDone = false;
  final double _pricePerDay = 350.0;

  final List<Map<String, dynamic>> _lateOptions = [
    {
      'title': 'تأخير ساعتين (المغادرة حتى ٦:٣٠ م)',
      'subtitle': 'وقت كافٍ للراحة وترتيب الأغراض براحة وهدوء',
      'price': 50,
      'hours': 'ساعتان',
    },
    {
      'title': 'تأخير ٤ ساعات (المغادرة حتى ٨:٣٠ م)',
      'subtitle': 'الخيار الأكثر طلباً — استمتع بنصف يوم إضافي في الشقة',
      'price': 100,
      'hours': '٤ ساعات',
    },
    {
      'title': 'خروج مسائي كامل (المغادرة حتى ١٠:٠٠ م)',
      'subtitle': 'إقامة ممتدة طوال المساء دون الحاجة لحجز ليلة كاملة',
      'price': 150,
      'hours': 'مسائي',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab.clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_isDone) {
      if (_selectedTab == 0) {
        return StateDoneView(
          title: 'تم إرسال طلب تمديد الإقامة',
          description:
              'تم إرسال طلب تمديد الإقامة لمدة $_extraDays ${_extraDays == 1 ? "ليلة" : "ليالٍ"} بنجاح. سيتم إشعارك فور تأكيد المضيف.',
          onDone: () => Navigator.of(context).pop(),
        );
      } else {
        return StateDoneView(
          title: 'تم إرسال طلب تأخير الخروج',
          description:
              'تم إرسال طلب ${_lateOptions[_selectedLateIndex]['title']} بنجاح. نتمنى لك إقامة ممتعة وسعيدة!',
          onDone: () => Navigator.of(context).pop(),
        );
      }
    }

    final total = _selectedTab == 0
        ? (_extraDays * _pricePerDay).toInt()
        : _lateOptions[_selectedLateIndex]['price'] as int;

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        // Tab Selector: تمديد ليلة vs تأخير خروج
        Container(
          padding: EdgeInsets.all(4.0.r),
          decoration: BoxDecoration(
            color: NazelColors.purpleSoft,
            borderRadius: BorderRadius.circular(8.0.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildTabButton(
                  title: 'تمديد ليلة كاملة · ٣٥٠ ريال',
                  icon: Icons.hotel_rounded,
                  isSelected: _selectedTab == 0,
                  onTap: () => setState(() => _selectedTab = 0),
                ),
              ),
              SizedBox(width: 6.0.w),
              Expanded(
                child: _buildTabButton(
                  title: 'تأخير الخروج · تبدأ من ٥٠ ريال',
                  icon: Icons.access_time_filled_rounded,
                  isSelected: _selectedTab == 1,
                  onTap: () => setState(() => _selectedTab = 1),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: NazelDimens.space16),

        // 1. Current Booking Information Card
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: NazelDimens.space20,
            vertical: NazelDimens.space16,
          ),
          decoration: BoxDecoration(
            color: NazelColors.surfaceWhite,
            borderRadius: BorderRadius.circular(8.0.r),
            border: Border.all(
              color: NazelColors.purpleBorder.withValues(alpha: 0.35),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: NazelColors.primary.withValues(alpha: 0.04),
                offset: const Offset(0, 2),
                blurRadius: 6.0.r,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.bookingInfo,
                style: NazelTypography.arabic(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: NazelColors.primaryDark,
                ),
              ),
              SizedBox(height: NazelDimens.space12),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoColumn(
                      l10n.departureDate,
                      l10n.sampleDepartureDate,
                      alignment: CrossAxisAlignment.start,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoColumn(
                      l10n.departureTime,
                      l10n.sampleDepartureTime,
                      alignment: CrossAxisAlignment.center,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoColumn(
                      l10n.bookingNumber,
                      l10n.sampleBookingNumber,
                      alignment: CrossAxisAlignment.end,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: NazelDimens.space16),

        // 2. Body based on selected tab
        if (_selectedTab == 0) _buildExtendNightsCard(l10n) else _buildLateCheckoutCard(),

        SizedBox(height: NazelDimens.space16),

        // 3. Summary & Submit Card
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: NazelDimens.space20,
            vertical: NazelDimens.space20,
          ),
          decoration: BoxDecoration(
            color: NazelColors.surfaceWhite,
            borderRadius: BorderRadius.circular(8.0.r),
            border: Border.all(
              color: NazelColors.purpleBorder.withValues(alpha: 0.35),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: NazelColors.primary.withValues(alpha: 0.04),
                offset: const Offset(0, 2),
                blurRadius: 6.0.r,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.total,
                        style: NazelTypography.arabic(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: NazelColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: NazelDimens.space4),
                      Text(
                        '$total ${l10n.currencySar}',
                        style: NazelTypography.arabic(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w700,
                          color: NazelColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.0.w,
                      vertical: 6.0.h,
                    ),
                    decoration: BoxDecoration(
                      color: NazelColors.purpleSoft,
                      borderRadius: BorderRadius.circular(6.0.r),
                    ),
                    child: Text(
                      _selectedTab == 0
                          ? 'مدة: $_extraDays ليلة'
                          : '${_lateOptions[_selectedLateIndex]['hours']} إضافية',
                      style: NazelTypography.arabic(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: NazelColors.primaryDark,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: NazelDimens.space16),
              NazelButton(
                text: _selectedTab == 0
                    ? 'إرسال طلب تمديد الإقامة'
                    : 'إرسال طلب تأخير الخروج',
                variant: NazelButtonVariant.primary,
                width: double.infinity,
                height: 50.h,
                onPressed: () => setState(() => _isDone = true),
              ),
              SizedBox(height: NazelDimens.space8),
              Text(
                'يتم إرسال الطلب مباشرة لصاحب الوحدة وتأكيده دون أي رسوم إضافية مخفية',
                textAlign: TextAlign.center,
                style: NazelTypography.arabic(
                  fontSize: 12.5,
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

  Widget _buildTabButton({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: isSelected ? NazelColors.surfaceWhite : Colors.transparent,
      borderRadius: BorderRadius.circular(6.0.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6.0.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0.r),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: NazelColors.primary.withValues(alpha: 0.08),
                      blurRadius: 4.0.r,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18.0.r,
                color: isSelected ? NazelColors.primary : NazelColors.textSecondary,
              ),
              SizedBox(width: 8.0.w),
              Text(
                title,
                style: NazelTypography.arabic(
                  fontSize: 14.0,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? NazelColors.primaryDark : NazelColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Extend nights selection card
  Widget _buildExtendNightsCard(AppLocalizations l10n) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: NazelDimens.space20,
        vertical: NazelDimens.space18,
      ),
      decoration: BoxDecoration(
        color: NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(
          color: NazelColors.purpleBorder.withValues(alpha: 0.35),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: NazelColors.primary.withValues(alpha: 0.04),
            offset: const Offset(0, 2),
            blurRadius: 6.0.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.serviceExtendStay,
            style: NazelTypography.arabic(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: NazelColors.primaryDark,
            ),
          ),
          SizedBox(height: NazelDimens.space14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.dailyRate,
                    style: NazelTypography.arabic(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: NazelColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: NazelDimens.space4),
                  Text(
                    '350 ${l10n.currencySar}',
                    style: NazelTypography.arabic(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: NazelColors.primaryDark,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    l10n.extensionDays,
                    style: NazelTypography.arabic(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: NazelColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: NazelDimens.space4),
                  NazelIncrementField(
                    value: _extraDays,
                    onChanged: (val) => setState(() => _extraDays = val),
                    backgroundColor: NazelColors.surfaceWhite,
                    borderColor: NazelColors.purpleBorder.withValues(
                      alpha: 0.35,
                    ),
                    width: 160.w,
                    height: 44.h,
                    borderRadius: BorderRadius.circular(6.0.r),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Late checkout options card
  Widget _buildLateCheckoutCard() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: NazelDimens.space20,
        vertical: NazelDimens.space18,
      ),
      decoration: BoxDecoration(
        color: NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(
          color: NazelColors.purpleBorder.withValues(alpha: 0.35),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: NazelColors.primary.withValues(alpha: 0.04),
            offset: const Offset(0, 2),
            blurRadius: 6.0.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اختر مدة تأخير وقت الخروج المريحة لك',
            style: NazelTypography.arabic(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: NazelColors.primaryDark,
            ),
          ),
          SizedBox(height: NazelDimens.space12),
          ...List.generate(_lateOptions.length, (index) {
            final opt = _lateOptions[index];
            final isSelected = _selectedLateIndex == index;
            return Container(
              margin: EdgeInsets.only(bottom: index == _lateOptions.length - 1 ? 0 : 8.0.h),
              child: Material(
                color: isSelected ? NazelColors.purpleSoft : NazelColors.surfaceWhite,
                borderRadius: BorderRadius.circular(6.0.r),
                child: InkWell(
                  onTap: () => setState(() => _selectedLateIndex = index),
                  borderRadius: BorderRadius.circular(6.0.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.0.w,
                      vertical: 12.0.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0.r),
                      border: Border.all(
                        color: isSelected
                            ? NazelColors.primary
                            : NazelColors.purpleBorder.withValues(alpha: 0.3),
                        width: isSelected ? 1.4 : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_off_rounded,
                          color: isSelected ? NazelColors.primary : NazelColors.textSecondary,
                          size: 20.0.r,
                        ),
                        SizedBox(width: 12.0.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                opt['title'] as String,
                                style: NazelTypography.arabic(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: NazelColors.primaryDark,
                                ),
                              ),
                              SizedBox(height: 2.0.h),
                              Text(
                                opt['subtitle'] as String,
                                style: NazelTypography.arabic(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                  color: NazelColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0.w,
                            vertical: 4.0.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? NazelColors.primary
                                : NazelColors.purpleSoft,
                            borderRadius: BorderRadius.circular(4.0.r),
                          ),
                          child: Text(
                            '${opt['price']} ريال',
                            style: NazelTypography.arabic(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? NazelColors.surfaceWhite
                                  : NazelColors.primaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
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
        SizedBox(height: NazelDimens.space4),
        Text(
          value,
          style: NazelTypography.arabic(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: NazelColors.primaryDark,
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
      barrierColor: NazelColors.sidebarBg.withValues(alpha: 0.45),
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

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final places = [
      {
        'title': l10n.placeGrocery,
        'fullTitle': l10n.placeGroceryFull,
        'dist': l10n.distUnitKm('0.3'),
        'time': l10n.timeUnitMinutes('5'),
        'icon': Icons.shopping_cart_outlined,
        'latLng': const LatLng(21.4232, 39.8250),
      },
      {
        'title': l10n.placeBus,
        'fullTitle': l10n.placeBusFull,
        'dist': l10n.distUnitKm('10'),
        'time': l10n.timeUnitMinutes('20'),
        'icon': Icons.directions_bus_outlined,
        'latLng': const LatLng(21.4255, 39.8282),
      },
      {
        'title': l10n.placeHospital,
        'fullTitle': l10n.placeHospitalFull,
        'dist': l10n.distUnitKm('30'),
        'time': l10n.timeUnitMinutes('60'),
        'icon': Icons.local_hospital_outlined,
        'latLng': const LatLng(21.4208, 39.8225),
      },
      {
        'title': l10n.placeMosque,
        'fullTitle': l10n.placeMosqueFull,
        'dist': l10n.distUnitKm('50'),
        'time': l10n.timeUnitMinutes('45'),
        'icon': Icons.mosque_outlined,
        'latLng': const LatLng(21.4270, 39.8298),
      },
      {
        'title': l10n.placePharmacy,
        'fullTitle': l10n.placePharmacyFull,
        'dist': l10n.distUnitKm('0.8'),
        'time': l10n.timeUnitMinutes('10'),
        'icon': Icons.local_pharmacy_outlined,
        'latLng': const LatLng(21.4220, 39.8268),
      },
    ];

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: NazelDimens.modalWidth,
            height: NazelDimens.modalHeight,
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
                // ── App Bar ──────────────────────────────────────────────────
                NazelAppBar(title: l10n.nearestPlacesTitle),

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
                        markers: List.generate(places.length, (index) {
                          final place = places[index];
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
                    itemCount: places.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: NazelDimens.space12),
                    itemBuilder: (context, index) {
                      final place = places[index];
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
            ? NazelColors.purpleSoft.withValues(alpha: 0.35)
            : NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(
          color: isSelected
              ? NazelColors.primary
              : NazelColors.purpleBorder.withValues(alpha: 0.35),
          width: isSelected ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: NazelColors.primary.withValues(alpha: 0.04),
            offset: const Offset(0, 2),
            blurRadius: 6.0.r,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0.r),
          onTap: () {
            setState(() => _selectedPlaceIndex = index);
            _mapController.move(place['latLng'] as LatLng, 16.0);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 12.0.h),
            child: Row(
              children: [
                // 1. Icon Badge
                Container(
                  width: 48.0.r,
                  height: 48.0.r,
                  decoration: BoxDecoration(
                    color: NazelColors.purpleSoft,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: NazelColors.purpleBorder.withValues(alpha: 0.35),
                      width: 1.0,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      place['icon'] as IconData,
                      color: NazelColors.primary,
                      size: 24.0.r,
                    ),
                  ),
                ),
                SizedBox(width: 14.0.w),

                // 2. Center - Title in bold purple
                Expanded(
                  child: Text(
                    place['title'] as String,
                    style: NazelTypography.arabic(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: NazelColors.primaryDark,
                    ),
                  ),
                ),

                // 3. Distance and Time
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
      barrierColor: NazelColors.sidebarBg.withValues(alpha: 0.45),
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final categories = [
      l10n.catRestaurants,
      l10n.catGrocery,
      l10n.catCafes,
      l10n.catBuffets,
      l10n.catJuices,
      l10n.catOther,
    ];

    final restaurants = [
      _DeliveryRestaurant(
        name: l10n.restaurantHerfy,
        tags: l10n.restaurantHerfyTags,
        rating: 4.5,
        logoPath: 'assets/images/restaurant_herfy.png',
      ),
      _DeliveryRestaurant(
        name: l10n.restaurantAlbaik,
        tags: l10n.restaurantAlbaikTags,
        rating: 5.0,
        logoPath: 'assets/images/restaurant_albaik.png',
      ),
      _DeliveryRestaurant(
        name: l10n.restaurantMcDonalds,
        tags: l10n.restaurantMcDonaldsTags,
        rating: 2.0,
        logoPath: 'assets/images/restaurant_mcdonalds.png',
      ),
      _DeliveryRestaurant(
        name: l10n.restaurantRaeq,
        tags: l10n.restaurantRaeqTags,
        rating: 4.6,
        logoPath: 'assets/images/restaurant_raeq.png',
      ),
      _DeliveryRestaurant(
        name: l10n.restaurantShallal,
        tags: l10n.restaurantShallalTags,
        rating: 4.4,
        logoPath: 'assets/images/restaurant_shallal.png',
      ),
      _DeliveryRestaurant(
        name: l10n.restaurantKudu,
        tags: l10n.restaurantKuduTags,
        rating: 4.8,
        logoPath: 'assets/images/restaurant_kudu.png',
      ),
    ];

    if (_isDone) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              width: NazelDimens.modalWidth,
              height: NazelDimens.modalHeight,
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
              child: StateDoneView(
                title: l10n.deliveryOrderReceived,
                description: l10n.deliveryOrderDoneDesc,
                onDone: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),
      );
    }
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: NazelDimens.modalWidth,
            height: NazelDimens.modalHeight,
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
                // ── App Bar ──────────────────────────────────────────────────
                NazelAppBar(title: l10n.deliveryTitle),

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
                      _buildSearchBar(l10n),
                      SizedBox(height: NazelDimens.space16),

                      // Category Chips
                      _buildCategoryChips(categories),
                      SizedBox(height: NazelDimens.space20),

                      // Section Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.nearbyRestaurants,
                            style: NazelTypography.arabic(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: NazelColors.primaryDark,
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {},
                            child: Text(
                              l10n.viewAll,
                              style: NazelTypography.arabic(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: NazelColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: NazelDimens.space12),

                      // Restaurant Grid (4 columns)
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: NazelDimens.space16,
                                mainAxisSpacing: NazelDimens.space16,
                                childAspectRatio: 0.6,
                              ),
                          itemCount: restaurants.length,
                          itemBuilder: (context, index) =>
                              _buildRestaurantCard(restaurants[index]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Cart Bar (full-width, outside padding) ─────────────────
              if (_cartCount > 0) _buildCartBar(l10n),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _buildSearchBar(AppLocalizations l10n) {
    return Container(
      height: 48.0.h,
      decoration: BoxDecoration(
        color: NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(6.0.r),
        border: Border.all(
          color: NazelColors.purpleBorder.withValues(alpha: 0.35),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: NazelDimens.space16),
          NazelIcon(
            type: NazelIconType.search,
            size: 20.0.r,
            color: NazelColors.textSecondary,
          ),
          SizedBox(width: NazelDimens.space12),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: NazelTypography.arabic(
                fontSize: 15.0,
                color: NazelColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                hintStyle: NazelTypography.arabic(
                  fontSize: 15.0,
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

  Widget _buildCategoryChips(List<String> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          final selected = _selectedCategory == index;
          return Padding(
            padding: EdgeInsetsDirectional.only(end: NazelDimens.space8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 18.0.w,
                  vertical: 8.0.h,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? NazelColors.primary
                      : NazelColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(6.0.r),
                  border: Border.all(
                    color: selected
                        ? NazelColors.primary
                        : NazelColors.purpleBorder.withValues(alpha: 0.35),
                    width: 1.0,
                  ),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: NazelColors.primary.withValues(alpha: 0.25),
                            blurRadius: 6.0.r,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  categories[index],
                  style: NazelTypography.arabic(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: selected
                        ? Colors.white
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
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(
          color: NazelColors.purpleBorder.withValues(alpha: 0.35),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: NazelColors.primary.withValues(alpha: 0.04),
            offset: const Offset(0, 2),
            blurRadius: 6.0.r,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0.r),
        child: InkWell(
          onTap: () => setState(() {
            _cartCount++;
            _cartTotal += 25.0;
          }),
          borderRadius: BorderRadius.circular(8.0.r),
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

  Widget _buildCartBar(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: NazelDimens.space24,
        vertical: NazelDimens.space14,
      ),
      decoration: const BoxDecoration(color: NazelColors.primaryDark),
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
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  top: -4.0.h,
                  end: -6.0.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0.w,
                      vertical: 2.0.h,
                    ),
                    decoration: BoxDecoration(
                      color: NazelColors.primaryLight,
                      borderRadius: BorderRadius.circular(10.0.r),
                    ),
                    child: Text(
                      '$_cartCount',
                      style: NazelTypography.arabic(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
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
                l10n.cartItemsCount(_cartCount),
                style: NazelTypography.arabic(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: NazelColors.purpleTint,
                ),
              ),
              Text(
                '${_cartTotal.toStringAsFixed(2)} ${l10n.currencyRiyal}',
                style: NazelTypography.arabic(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: NazelColors.surfaceWhite,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Send / Order Button
          NazelButton(
            text: l10n.sendRequest,
            variant: NazelButtonVariant.primary,
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

/// 5. Emergency & Direct Support Modal ("تحتاج شيئًا؟")
class EmergencyModal extends StatefulWidget {
  const EmergencyModal({super.key});

  @override
  State<EmergencyModal> createState() => _EmergencyModalState();
}

class _EmergencyModalState extends State<EmergencyModal> {
  void _triggerAction(String actionName, String detail) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'جاري فتح $actionName ($detail)',
          style: NazelTypography.arabic(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: NazelColors.surfaceWhite,
          ),
        ),
        backgroundColor: NazelColors.primaryDark,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final emergencyContacts = [
      {
        'title': 'الشرطة',
        'number': '999',
        'icon': NazelIconType.emergency,
      },
      {
        'title': 'الإسعاف',
        'number': '997',
        'icon': NazelIconType.ambulance,
      },
      {
        'title': 'الدفاع المدني',
        'number': '998',
        'icon': NazelIconType.emergency,
      },
    ];

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        // 1. First option: Official Emergency Numbers (الطوارئ أول خيار)
        Container(
          padding: EdgeInsets.all(NazelDimens.space16),
          decoration: BoxDecoration(
            color: NazelColors.danger.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0.r),
            border: Border.all(
              color: NazelColors.danger.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: NazelColors.danger,
                    size: 22.0.r,
                  ),
                  SizedBox(width: NazelDimens.space8),
                  Text(
                    'أرقام الطوارئ الرسمية (اتصال فوري مجاني)',
                    style: NazelTypography.arabic(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: NazelColors.danger,
                    ),
                  ),
                ],
              ),
              SizedBox(height: NazelDimens.space12),
              Row(
                children: emergencyContacts.map((c) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                      child: Material(
                        color: NazelColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(6.0.r),
                        child: InkWell(
                          onTap: () => _triggerAction(c['title'] as String, c['number'] as String),
                          borderRadius: BorderRadius.circular(6.0.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0.w,
                              vertical: 10.0.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0.r),
                              border: Border.all(
                                color: NazelColors.danger.withValues(alpha: 0.3),
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  c['title'] as String,
                                  style: NazelTypography.arabic(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: NazelColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: NazelDimens.space4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.phone_rounded,
                                      size: 14.0.r,
                                      color: NazelColors.danger,
                                    ),
                                    SizedBox(width: 4.0.w),
                                    Text(
                                      c['number'] as String,
                                      style: NazelTypography.display(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700,
                                        color: NazelColors.danger,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        SizedBox(height: NazelDimens.space16),

        // 2. Main Value: Direct WhatsApp with Unit Owner (واتساب صاحب الوحدة)
        Container(
          padding: EdgeInsets.all(NazelDimens.space20),
          decoration: BoxDecoration(
            color: NazelColors.surfaceWhite,
            borderRadius: BorderRadius.circular(8.0.r),
            border: Border.all(
              color: const Color(0xFF25D366).withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF25D366).withValues(alpha: 0.08),
                offset: const Offset(0, 3),
                blurRadius: 10.0.r,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 52.0.r,
                    height: 52.0.r,
                    decoration: BoxDecoration(
                      color: const Color(0xFF25D366).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8.0.r),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.chat_bubble_rounded,
                      color: const Color(0xFF25D366),
                      size: 28.0.r,
                    ),
                  ),
                  SizedBox(width: NazelDimens.space14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'واتساب صاحب الوحدة (المضيف)',
                              style: NazelTypography.arabic(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                color: NazelColors.primaryDark,
                              ),
                            ),
                            SizedBox(width: 8.0.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0.w,
                                vertical: 2.0.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF25D366).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4.0.r),
                              ),
                              child: Text(
                                'مباشر وسريع',
                                style: NazelTypography.arabic(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1E7E34),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: NazelDimens.space4),
                        Text(
                          'تواصل فوري مع المضيف لأي استفسار، طلب خاص، أو مساعدة بالوحدة',
                          style: NazelTypography.arabic(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: NazelColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: NazelDimens.space16),
              Row(
                children: [
                  Expanded(
                    child: NazelButton(
                      text: 'محادثة فورية عبر واتساب',
                      variant: NazelButtonVariant.primary,
                      height: 48.h,
                      onPressed: () => _triggerAction(
                        'واتساب المضيف',
                        'مرحباً، أنا نزيل الوحدة رقم 402، أحتاج مساعدة بخصوص...',
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0.w),
                  Material(
                    color: NazelColors.purpleSoft,
                    borderRadius: BorderRadius.circular(6.0.r),
                    child: InkWell(
                      onTap: () => _triggerAction('اتصال بالمضيف', '0501234567'),
                      borderRadius: BorderRadius.circular(6.0.r),
                      child: Container(
                        height: 48.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone_forwarded_rounded,
                              size: 18.0.r,
                              color: NazelColors.primaryDark,
                            ),
                            SizedBox(width: 6.0.w),
                            Text(
                              'اتصال',
                              style: NazelTypography.arabic(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: NazelColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: NazelDimens.space14),

        // 3. Customer Care & Technical Support (فريق خدمة النزلاء والدعم)
        NazelChooseCard(
          title: 'خدمة نزلاء نازل والدعم الفني ٢٤/٧',
          subtitle: 'فريق الدعم والمساندة جاهز لخدمتك وحل أي مشكلة تقنية أو استفسار',
          onTap: () => _triggerAction('دعم النزلاء', 'واتساب الدعم الفني المباشر'),
          leading: Container(
            width: 52.0.r,
            height: 52.0.r,
            decoration: BoxDecoration(
              color: NazelColors.purpleSoft,
              borderRadius: BorderRadius.circular(6.0.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.support_agent_rounded,
              size: 26.0.r,
              color: NazelColors.primary,
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0.w,
              vertical: 8.0.h,
            ),
            decoration: BoxDecoration(
              color: NazelColors.primary,
              borderRadius: BorderRadius.circular(6.0.r),
            ),
            child: Text(
              'واتساب الدعم',
              style: NazelTypography.arabic(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: NazelColors.surfaceWhite,
              ),
            ),
          ),
        ),

        SizedBox(height: NazelDimens.space12),

        // 4. In-building Maintenance (صيانة طوارئ المبنى)
        NazelChooseCard(
          title: 'صيانة طوارئ بالوحدة (سباكة / كهرباء)',
          subtitle: 'فني طوارئ متواجد بالقرب للتعامل مع أي عطل مفاجئ',
          onTap: () => _triggerAction('طوارئ الصيانة', '+966 50 000 0000'),
          leading: Container(
            width: 52.0.r,
            height: 52.0.r,
            decoration: BoxDecoration(
              color: NazelColors.purpleSoft,
              borderRadius: BorderRadius.circular(6.0.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.handyman_rounded,
              size: 26.0.r,
              color: NazelColors.primary,
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0.w,
              vertical: 8.0.h,
            ),
            decoration: BoxDecoration(
              color: NazelColors.purpleBorder.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6.0.r),
            ),
            child: Text(
              'طلب فني',
              style: NazelTypography.arabic(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: NazelColors.primaryDark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 6. Apartment Info Modal ("دليل الوحدة")
class ApartmentInfoModal extends StatefulWidget {
  const ApartmentInfoModal({super.key});

  @override
  State<ApartmentInfoModal> createState() => _ApartmentInfoModalState();
}

class _ApartmentInfoModalState extends State<ApartmentInfoModal> {
  String? _selectedCategory; // null: main menu, 'door', 'ac', 'washer', 'parking', 'trash', 'checkout'

  @override
  Widget build(BuildContext context) {
    if (_selectedCategory == null) {
      return _buildMainMenu();
    }

    switch (_selectedCategory) {
      case 'door':
        return _buildDoorDetail();
      case 'ac':
        return _buildAcDetail();
      case 'washer':
        return _buildWasherDetail();
      case 'parking':
        return _buildParkingDetail();
      case 'trash':
        return _buildTrashDetail();
      case 'checkout':
        return _buildCheckoutDetail();
      default:
        return _buildMainMenu();
    }
  }

  Widget _buildMainMenu() {
    final menuItems = [
      {
        'id': 'door',
        'title': 'كيف تفتح الباب من برّا (القفل الذكي)',
        'desc': 'طريقة إيقاظ الشاشة، إدخال الرمز السري، وقفل الباب عند الخروج',
        'icon': Icons.lock_open_rounded,
        'badge': 'الأكثر طلباً',
      },
      {
        'id': 'ac',
        'title': 'المكيّف وضبط درجة التبريد',
        'desc': 'زر التشغيل، التأكد من وضع التبريد (Cool)، ودرجة الحرارة المثالية',
        'icon': Icons.ac_unit_rounded,
        'badge': null,
      },
      {
        'id': 'washer',
        'title': 'الغسالة والنشّافة',
        'desc': 'مكان مسحوق الغسيل، برنامج الغسيل السريع، والتنشيف',
        'icon': Icons.local_laundry_service_rounded,
        'badge': null,
      },
      {
        'id': 'parking',
        'title': 'موقف السيارة المخصص',
        'desc': 'رقم الموقف المخصص لشقتك، بوابة القبو، وطريقة الدخول',
        'icon': Icons.local_parking_rounded,
        'badge': 'موقف #12',
      },
      {
        'id': 'trash',
        'title': 'الزبالة وتصريف النفايات',
        'desc': 'غرفة تصريف النفايات بالدور، والحاوية المركزية للكراتين',
        'icon': Icons.delete_outline_rounded,
        'badge': null,
      },
      {
        'id': 'checkout',
        'title': 'تعليمات المغادرة وقواعد الوحدة',
        'desc': 'وقت الخروج (٤:٣٠ م)، تسليم المفاتيح، والواي فاي',
        'icon': Icons.hotel_rounded,
        'badge': null,
      },
    ];

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        ...menuItems.map((item) {
          final badge = item['badge'] as String?;
          return Container(
            margin: EdgeInsets.only(bottom: NazelDimens.space12),
            child: NazelChooseCard(
              height: 106.0.h,
              title: item['title'] as String,
              subtitle: item['desc'] as String,
              onTap: () {
                setState(() {
                  _selectedCategory = item['id'] as String;
                });
              },
              leading: Container(
                width: 52.0.r,
                height: 52.0.r,
                decoration: BoxDecoration(
                  color: NazelColors.purpleSoft,
                  borderRadius: BorderRadius.circular(6.0.r),
                  border: Border.all(
                    color: NazelColors.purpleBorder.withValues(alpha: 0.25),
                    width: 1.0,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  item['icon'] as IconData,
                  size: 26.0.r,
                  color: NazelColors.primary,
                ),
              ),
              trailing: badge != null
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0.w,
                        vertical: 4.0.h,
                      ),
                      decoration: BoxDecoration(
                        color: NazelColors.purpleSoft,
                        borderRadius: BorderRadius.circular(4.0.r),
                        border: Border.all(
                          color: NazelColors.purpleBorder.withValues(alpha: 0.3),
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        badge,
                        style: NazelTypography.arabic(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: NazelColors.primaryDark,
                        ),
                      ),
                    )
                  : null,
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
            borderRadius: BorderRadius.circular(6.0.r),
            child: InkWell(
              borderRadius: BorderRadius.circular(6.0.r),
              onTap: () => setState(() => _selectedCategory = null),
              child: Padding(
                padding: EdgeInsets.all(NazelDimens.space8),
                child: Icon(
                  NazelDirectionalIcons.back(context),
                  size: 20.0.r,
                  color: NazelColors.primaryDark,
                ),
              ),
            ),
          ),
          SizedBox(width: NazelDimens.space12),
          Text(
            title,
            style: NazelTypography.arabic(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: NazelColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard({
    required int stepNumber,
    required String title,
    required String description,
    IconData? icon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: NazelDimens.space12),
      padding: EdgeInsets.all(NazelDimens.space16),
      decoration: BoxDecoration(
        color: NazelColors.surfaceWhite,
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(
          color: NazelColors.purpleBorder.withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38.0.r,
            height: 38.0.r,
            decoration: BoxDecoration(
              color: NazelColors.purpleSoft,
              borderRadius: BorderRadius.circular(6.0.r),
              border: Border.all(
                color: NazelColors.purpleBorder.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '$stepNumber',
              style: NazelTypography.display(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: NazelColors.primary,
              ),
            ),
          ),
          SizedBox(width: NazelDimens.space14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: NazelTypography.arabic(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                    color: NazelColors.primaryDark,
                  ),
                ),
                SizedBox(height: NazelDimens.space4),
                Text(
                  description,
                  style: NazelTypography.arabic(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    color: NazelColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (icon != null) ...[
            SizedBox(width: NazelDimens.space10),
            Icon(icon, size: 22.0.r, color: NazelColors.purpleBorder),
          ],
        ],
      ),
    );
  }

  Widget _buildHelpFooter() {
    return Container(
      margin: EdgeInsets.only(top: NazelDimens.space8, bottom: NazelDimens.space16),
      padding: EdgeInsets.all(NazelDimens.space14),
      decoration: BoxDecoration(
        color: NazelColors.purpleSoft,
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.help_outline_rounded,
            color: NazelColors.primaryDark,
            size: 22.0.r,
          ),
          SizedBox(width: NazelDimens.space10),
          Expanded(
            child: Text(
              'هل واجهت مشكلة أو تحتاج توضيحاً إضافياً؟',
              style: NazelTypography.arabic(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: NazelColors.primaryDark,
              ),
            ),
          ),
          Material(
            color: const Color(0xFF25D366),
            borderRadius: BorderRadius.circular(6.0.r),
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'جاري فتح واتساب المضيف للمساعدة...',
                      style: NazelTypography.arabic(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: NazelColors.surfaceWhite,
                      ),
                    ),
                    backgroundColor: NazelColors.primaryDark,
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(6.0.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 8.0.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_rounded,
                      size: 16.0.r,
                      color: NazelColors.surfaceWhite,
                    ),
                    SizedBox(width: 6.0.w),
                    Text(
                      'واتساب المضيف',
                      style: NazelTypography.arabic(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: NazelColors.surfaceWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 1. Door & Smart Lock Detail
  Widget _buildDoorDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailHeader('كيف تفتح الباب من برّا (القفل الذكي)'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildStepCard(
                stepNumber: 1,
                title: 'إيقاظ شاشة القفل',
                description:
                    'المس شاشة القفل الزجاجية بباطن يدك أو بأطراف أصابعك حتى تضيء أزرار الأرقام بالكامل.',
                icon: Icons.touch_app_rounded,
              ),
              _buildStepCard(
                stepNumber: 2,
                title: 'إدخال الرمز السري الخاص بك',
                description:
                    'أدخل الرمز المكون من ٤ أرقام المرسل لك في رسالة الدخول (رمز دخول الشقة: 4022).',
                icon: Icons.pin_rounded,
              ),
              _buildStepCard(
                stepNumber: 3,
                title: 'تأكيد الفتح ونزول المقبض',
                description:
                    'اضغط على زر النجمة (*) أو المربع (#). ستسمع صوت نغمة فتح القفل، ثم ادفع المقبض لأسفل وادخل.',
                icon: Icons.check_circle_outline_rounded,
              ),
              _buildStepCard(
                stepNumber: 4,
                title: 'قفل الباب عند الخروج من الشقة',
                description:
                    'عند مغادرة الشقة، اسحب الباب حتى يُغلق تماماً، ثم المس شاشة القفل لإغلاق اللسان تلقائياً.',
                icon: Icons.lock_outline_rounded,
              ),
              _buildHelpFooter(),
            ],
          ),
        ),
      ],
    );
  }

  // 2. AC Operation Detail
  Widget _buildAcDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailHeader('المكيّف وضبط درجة التبريد'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildStepCard(
                stepNumber: 1,
                title: 'التشغيل والإيقاف',
                description:
                    'اضغط على الزر الأحمر/البرتقالي (ON/OFF) في ريموت التكييف المثبت بجانب الباب أو على الطاولة.',
                icon: Icons.power_settings_new_rounded,
              ),
              _buildStepCard(
                stepNumber: 2,
                title: 'التأكد من وضع التبريد (Cool)',
                description:
                    'اضغط زر (Mode) حتى تظهر أيقونة ندفة الثلج (❄️ Cool) على شاشة الريموت. لا تتركه على وضع المروحة فقط (Fan).',
                icon: Icons.ac_unit_rounded,
              ),
              _buildStepCard(
                stepNumber: 3,
                title: 'درجة الحرارة المثالية الموصى بها',
                description:
                    'نوصي بضبط الحرارة بين ٢١°م إلى ٢٣°م لضمان تبريد سريع ومريح دون إجهاد الوحدة.',
                icon: Icons.thermostat_rounded,
              ),
              _buildStepCard(
                stepNumber: 4,
                title: 'توجيه الهواء وسرعة المروحة',
                description:
                    'استخدم زر (Swing) لتوزيع الهواء تلقائياً، وزر (Fan Speed) لضبط سرعة دفع الهواء حسب رغبتك.',
                icon: Icons.air_rounded,
              ),
              _buildHelpFooter(),
            ],
          ),
        ),
      ],
    );
  }

  // 3. Washer & Dryer Detail
  Widget _buildWasherDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailHeader('الغسالة والنشّافة'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildStepCard(
                stepNumber: 1,
                title: 'مسحوق الغسيل',
                description:
                    'تجد مسحوق وصابون الغسيل متوفراً في الخزانة أسفل الحوض. ضع مقدار غطاء واحد في الدرج الأيسر للغسالة.',
                icon: Icons.bubble_chart_rounded,
              ),
              _buildStepCard(
                stepNumber: 2,
                title: 'اختيار برنامج الغسيل السريع',
                description:
                    'أدر القرص الدائري إلى برنامج (Quick 15/30 min). هذا البرنامج الأنسب للملابس اليومية الخفيفة ويوفر الوقت.',
                icon: Icons.timer_outlined,
              ),
              _buildStepCard(
                stepNumber: 3,
                title: 'بدء الغسيل والتنشيف',
                description:
                    'اضغط زر (Start / Pause). تبدأ دورة الغسيل تلقائياً وتشمل العصر والتجفيف السريع (Spin 800-1000 rpm).',
                icon: Icons.play_arrow_rounded,
              ),
              _buildStepCard(
                stepNumber: 4,
                title: 'فتح الباب بعد انتهاء الدورة',
                description:
                    'عند انتهاء الغسيل وسماع الصافرة، انتظر لمدة دقيقتين حتى يفتح قفل الأمان للباب الزجاجي تلقائياً.',
                icon: Icons.lock_clock_rounded,
              ),
              _buildHelpFooter(),
            ],
          ),
        ),
      ],
    );
  }

  // 4. Parking Detail
  Widget _buildParkingDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailHeader('موقف السيارة المخصص للشقة'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildStepCard(
                stepNumber: 1,
                title: 'رقم الموقف المخصص لشقتك',
                description:
                    'موقفك المخصص هو موقف رقم (12) في طابق القبو الأول (B1)، وموضح برقم بارز على الأرضية والجدار.',
                icon: Icons.local_parking_rounded,
              ),
              _buildStepCard(
                stepNumber: 2,
                title: 'بوابة الدخول للقبو',
                description:
                    'مدخل مواقف السيارات يقع في الجهة الجنوبية للمبنى. تفتح البوابة تلقائياً عبر كاميرا اللوحات أو بريموت البوابة.',
                icon: Icons.garage_rounded,
              ),
              _buildStepCard(
                stepNumber: 3,
                title: 'الوصول للمصعد الداخلي',
                description:
                    'بعد إيقاف سيارتك، استخدم الباب المؤدي لردهة المصاعد في القبو؛ المصعد ينقلك مباشرة لدور وحدتك دون درج.',
                icon: Icons.elevator_rounded,
              ),
              _buildStepCard(
                stepNumber: 4,
                title: 'تنبيه هام بخصوص الجيران',
                description:
                    'يرجى الالتزام بالوقوف في الموقف رقم (12) حصراً لتجنب إيقاف سيارات السكان الآخرين أو مضايقة الجيران.',
                icon: Icons.warning_amber_rounded,
              ),
              _buildHelpFooter(),
            ],
          ),
        ),
      ],
    );
  }

  // 5. Trash Detail
  Widget _buildTrashDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailHeader('الزبالة وتصريف النفايات'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildStepCard(
                stepNumber: 1,
                title: 'غرفة النفايات بالدور (Trash Chute)',
                description:
                    'توجد غرفة مخصصة لتصريف النفايات في نفس دورك، بجوار المصاعد في نهاية الممر على اليمين.',
                icon: Icons.delete_outline_rounded,
              ),
              _buildStepCard(
                stepNumber: 2,
                title: 'أكياس القمامة الإضافية',
                description:
                    'تجد رول أكياس نفايات إضافية جديدة في الدولاب أسفل حوض المطبخ. يرجى إحكام ربط الكيس قبل رميه في الفتحة.',
                icon: Icons.shopping_bag_outlined,
              ),
              _buildStepCard(
                stepNumber: 3,
                title: 'الكراتين والمخلفات الكبيرة',
                description:
                    'للكراتين الكبيرة أو الأغراض التي لا تسع فتحة التصريف، يرجى وضعها في الحاوية المركزية الموجودة بالقبو بجانب مخرج السيارات.',
                icon: Icons.inventory_2_outlined,
              ),
              _buildHelpFooter(),
            ],
          ),
        ),
      ],
    );
  }

  // 6. Checkout Detail
  Widget _buildCheckoutDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailHeader('تعليمات المغادرة وقواعد الوحدة'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildStepCard(
                stepNumber: 1,
                title: 'موعد الخروج الرسمي',
                description:
                    'موعد المغادرة المحدد هو الأربعاء عند الساعة ٤:٣٠ م. في حال رغبتك بالبقاء، يمكنك تمديد ليلة أو تأخير خروجك من الشاشة الرئيسية.',
                icon: Icons.access_time_rounded,
              ),
              _buildStepCard(
                stepNumber: 2,
                title: 'تسليم المفاتيح والبطاقات',
                description:
                    'يرجى ترك بطاقة الدخول وريموت البوابة على طاولة الصالة الرئيسية، والتأكد من إقفال الباب عند مغادرتك.',
                icon: Icons.key_rounded,
              ),
              _buildStepCard(
                stepNumber: 3,
                title: 'إطفاء الأنوار والمكيفات',
                description:
                    'نرجو التكرم بإطفاء المكيفات والأجهزة الكهربائية عند خروجك للحفاظ على الطاقة وسلامة المكان.',
                icon: Icons.lightbulb_outline_rounded,
              ),
              _buildStepCard(
                stepNumber: 4,
                title: 'شبكة الواي فاي',
                description:
                    'اسم الشبكة: Nazel-Luxury-402 · كلمة المرور: Nazel@2026. متوفرة بسرعة ألياف بصرية عالية لنزلاء الوحدة.',
                icon: Icons.wifi_rounded,
              ),
              _buildHelpFooter(),
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final categories = [
      l10n.catAll,
      l10n.catSeaTrips,
      l10n.catTours,
      l10n.catCars,
      l10n.catMarkets,
      l10n.catOtherTours,
    ];

    final activities = [
      {
        'title': l10n.tourSeaCruises,
        'category': l10n.catSeaTrips,
        'duration': l10n.hoursCount(3),
        'rating': 5.0,
        'reviews': 94,
        'price': 350,
        'isHero': true,
        'image': 'assets/images/ipad_image_de8207a6.png',
        'description': l10n.tourSeaCruisesDesc,
      },
      {
        'title': l10n.tourDiriyah,
        'category': l10n.catTours,
        'duration': l10n.hoursCount(5),
        'rating': 4.6,
        'reviews': 120,
        'price': 250,
        'isHero': true,
        'image': 'assets/images/ipad_ads_ab02c289.png',
        'subtitle': l10n.tourDiriyahSub,
        'description': l10n.tourDiriyahDesc,
      },
      {
        'title': l10n.tourSafari,
        'category': l10n.catTours,
        'duration': l10n.hoursCount(5),
        'rating': 5.0,
        'reviews': 85,
        'price': 450,
        'isHero': false,
        'subtitle': l10n.tourSafariSub,
        'description': l10n.tourSafariDesc,
      },
      {
        'title': l10n.tourLuxuryCar,
        'category': l10n.catCars,
        'duration': l10n.fullDay,
        'rating': 4.8,
        'reviews': 42,
        'price': 600,
        'isHero': false,
        'subtitle': l10n.tourLuxuryCarSub,
        'description': l10n.tourLuxuryCarDesc,
      },
      {
        'title': l10n.tourShopping,
        'category': l10n.catMarkets,
        'duration': l10n.hoursCount(4),
        'rating': 4.7,
        'reviews': 63,
        'price': 180,
        'isHero': false,
        'subtitle': l10n.tourShoppingSub,
        'description': l10n.tourShoppingDesc,
      },
    ];

    final timeSlots = [
      l10n.timeSlotMorning,
      l10n.timeSlotAfternoon,
      l10n.timeSlotEvening,
      l10n.timeSlotNight,
    ];

    if (_step == 2) {
      return StateDoneView(
        title: l10n.bookingRequestReceived,
        description: l10n.bookingRequestDoneDesc,
        onDone: () => Navigator.of(context).pop(),
      );
    }

    if (_step == 1 && _selectedActivity != null) {
      return _buildBookingStep(l10n, timeSlots);
    }

    return _buildMainMenuStep(l10n, categories, activities);
  }

  Widget _buildMainMenuStep(
    AppLocalizations l10n,
    List<String> categories,
    List<Map<String, dynamic>> activities,
  ) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredActivities = activities.where((act) {
      final matchesCategory =
          _selectedCategory == 0 ||
          act['category'] == categories[_selectedCategory];
      final matchesQuery =
          query.isEmpty ||
          (act['title'] as String).toLowerCase().contains(query) ||
          (act['category'] as String).toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();

    final seaTrips = filteredActivities
        .where((a) => a['category'] == l10n.catSeaTrips)
        .toList();
    final otherTours = filteredActivities
        .where((a) => a['category'] != l10n.catSeaTrips)
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
                      hintText: l10n.searchHint,
                      hintStyle: NazelTypography.arabic(
                        fontSize: 16.0,
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
              itemCount: categories.length,
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
                      categories[index],
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

          // 3. Section 1: Sea Cruises
          if (seaTrips.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.catSeaTrips,
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
                    l10n.viewAll,
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
            ...seaTrips.map((act) => _buildHeroCard(act, l10n)),
            SizedBox(height: NazelDimens.space24),
          ],

          // 4. Section 2: Tours & Experiences
          if (otherTours.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.catTours,
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
                    l10n.viewAll,
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
                  child: _buildHeroCard(act, l10n),
                );
              }
              return NazelChooseCard(
                title: act['title'] as String,
                subtitle:
                    '${act['duration']} • ${act['subtitle'] ?? act['description']} • ${act['price']} ${l10n.currencySar}',
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

  Widget _buildHeroCard(Map<String, dynamic> act, AppLocalizations l10n) {
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
            // Luxury Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.centerStart,
                  end: AlignmentDirectional.centerEnd,
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
            // Text Content
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
                    '${act['price']} ${l10n.currencySar}',
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

  Widget _buildBookingStep(AppLocalizations l10n, List<String> timeSlots) {
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
                  '${act['price']} ${l10n.perPerson}',
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
            l10n.numberOfGuests,
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
            l10n.preferredTime,
            style: NazelTypography.arabic(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              color: NazelColors.primary,
            ),
          ),
          SizedBox(height: NazelDimens.space10),
          ...List.generate(timeSlots.length, (index) {
            return NazelTimeTile(
              timeText: timeSlots[index],
              isSelected: _selectedTimeSlot == index,
              onTap: () => setState(() => _selectedTimeSlot = index),
            );
          }),
          SizedBox(height: NazelDimens.space16),

          // 3. Special Notes
          Text(
            l10n.specialNotesOptional,
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
              hintText: l10n.specialNotesHint,
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
                      l10n.expectedTotal,
                      style: NazelTypography.arabic(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: NazelColors.textSecondary,
                      ),
                    ),
                    Text(
                      '$totalPrice ${l10n.currencySar}',
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
                text: l10n.confirmBookingRequest,
                onPressed: () => setState(() => _step = 2),
                width: 200.0.w,
              ),
              SizedBox(width: NazelDimens.space12),
              NazelButton(
                text: l10n.back,
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
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Featured Top Banner (Cleaning Offer)
          _buildFeaturedBanner(context, l10n),
          SizedBox(height: 16.0.h),

          // 2. Section Title
          Text(
            l10n.featuredOffers,
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
            titleText: l10n.discount15Cruises,
            actionText: l10n.bookNow,
            onTap: () {},
          ),
          SizedBox(height: 12.0.h),

          _buildOfferCard(
            context: context,
            image: 'assets/images/ipad_image_a92eb603.png',
            titleText: l10n.discount10Grocery,
            actionText: l10n.orderNow,
            onTap: () {},
          ),
          SizedBox(height: 12.0.h),

          _buildOfferCard(
            context: context,
            image: 'assets/images/ipad_image_33a2ad6d.png',
            titleText: l10n.discount10CarRental,
            actionText: l10n.bookNow,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedBanner(BuildContext context, AppLocalizations l10n) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final imageWidth = cardWidth * 0.68;
        final isRtl = Directionality.of(context) == TextDirection.rtl;

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
              // Image covering 68% with soft fade mask
              Positioned.directional(
                textDirection: Directionality.of(context),
                start: 0,
                top: 0,
                bottom: 0,
                width: imageWidth,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: isRtl
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      end: isRtl
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      stops: const [0.0, 0.40, 0.65, 0.85, 1.0],
                      colors: [
                        Colors.black,
                        Colors.black.withValues(alpha: 0.95),
                        Colors.black.withValues(alpha: 0.65),
                        Colors.black.withValues(alpha: 0.25),
                        Colors.transparent,
                      ],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    'assets/images/ipad_image_e6ced3cf.png',
                    fit: BoxFit.cover,
                    alignment: isRtl
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                  ),
                ),
              ),

              // Content
              Positioned.directional(
                textDirection: Directionality.of(context),
                end: 0,
                top: 0,
                bottom: 0,
                start: imageWidth * 0.70,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.bookNow,
                        style: NazelTypography.arabic(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w700,
                          color: NazelColors.goldLight,
                        ),
                      ),
                      SizedBox(height: 4.0.h),
                      Text(
                        l10n.discount20Cleaning,
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
                            l10n.bookNow,
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
    required String titleText,
    required String actionText,
    required VoidCallback onTap,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final imageWidth = cardWidth * 0.65;
        final isRtl = Directionality.of(context) == TextDirection.rtl;

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
                // Image covering ~65% with soft fade mask
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  start: 0,
                  top: 0,
                  bottom: 0,
                  width: imageWidth,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: isRtl ? Alignment.centerRight : Alignment.centerLeft,
                        end: isRtl ? Alignment.centerLeft : Alignment.centerRight,
                        stops: const [0.5, 0.8, 1.0],
                        colors: [
                          Colors.black,
                          Colors.black.withValues(alpha: 0.4),
                          Colors.transparent,
                        ],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
                    ),
                  ),
                ),

                // Middle offer text
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  start: imageWidth * 0.75,
                  end: 110.0.w,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Text(
                      titleText,
                      textAlign: TextAlign.center,
                      style: NazelTypography.arabic(
                        fontSize: 15.0.sp,
                        fontWeight: FontWeight.w800,
                        color: NazelColors.primary,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),

                // Action text
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 24.0.w,
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
