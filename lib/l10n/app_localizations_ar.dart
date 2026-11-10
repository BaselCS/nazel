// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'نزيل - لمسة الخزامى';

  @override
  String get appTagline => 'رحلتك تحتاج شاشة';

  @override
  String get language => 'اللغة';

  @override
  String get arabic => 'عربي';

  @override
  String get english => 'English';

  @override
  String get done => 'تم';

  @override
  String get back => 'السابق';

  @override
  String get cancel => 'إلغاء';

  @override
  String get continueText => 'متابعة';

  @override
  String get orderNow => 'أطلب الآن';

  @override
  String get bookNow => 'احجز الآن';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get completed => 'مكتمل';

  @override
  String get currencySar => 'رس';

  @override
  String get currencyRiyal => 'ريال';

  @override
  String get total => 'الإجمالي :';

  @override
  String get expectedTotal => 'الإجمالي المتوقع';

  @override
  String get call => 'اتصال';

  @override
  String get searchHint => 'بحث...';

  @override
  String get sendRequest => 'إرسال الطلب';

  @override
  String get guestGreeting => 'مرحبًا فيصل';

  @override
  String get guestWish => 'نتمنى لك إقامة مريحة';

  @override
  String get timeDetails => 'تفاصيل الوقت';

  @override
  String get checkInTime => 'وقت الدخول';

  @override
  String get checkInTimeValue => '2027/02/01 - 00:00 PM';

  @override
  String get checkOutTime => 'وقت الخروج';

  @override
  String get checkOutTimeValue => '2027/02/04 - 4:30 PM';

  @override
  String get remainingTime => 'الوقت المتبقي';

  @override
  String get remainingTimeValue => '01:01:40:00';

  @override
  String get networkDetails => 'تفاصيل الشبكة';

  @override
  String get networkName => 'اسم الشبكة';

  @override
  String get networkNameValue => 'لمسة الخزامى';

  @override
  String get networkPassword => 'كلمة المرور';

  @override
  String get networkPasswordValue => 'زهرة الخزامى';

  @override
  String get wifi => 'الواي فاي';

  @override
  String get serviceCleaning => 'طلب تنظيف';

  @override
  String get serviceCleaningDesc => 'اطلب خدمة تنظيف';

  @override
  String get serviceDelivery => 'طلبات التوصيل';

  @override
  String get serviceDeliveryDesc => 'مطاعم، بقائل، صيدليات';

  @override
  String get serviceAmenities => 'مرافق قريبة';

  @override
  String get serviceAmenitiesDesc => 'اكتشف الأماكن القريبة';

  @override
  String get serviceTourism => 'سياحة وتجارب';

  @override
  String get serviceTourismDesc => 'أنشطة وجولات سياحية';

  @override
  String get serviceExtendStay => 'تمديد الحجز';

  @override
  String get serviceExtendStayDesc => 'إطالة مدة إقامتك';

  @override
  String get serviceApartmentInfo => 'معلومات الحجز';

  @override
  String get serviceApartmentInfoDesc => 'دليل وتعليمات الحجز';

  @override
  String get serviceEmergency => 'طوارئ';

  @override
  String get serviceEmergencyDesc => 'تواصل سريع للطوارئ';

  @override
  String get serviceAds => 'عروض وإعلانات';

  @override
  String get serviceAdsDesc => 'عروض وخدمات مميزة';

  @override
  String get promoDiscount20Cleaning => 'خصم 20% على\nخدمات التنظيف';

  @override
  String get promoDiscount15Cruises => 'خصم 15% على\nالرحلات البحرية';

  @override
  String get promoDiscount10Grocery => 'خصم 10% على\nتوصيل البقالة';

  @override
  String get promoDiscount10CarRental => 'خصم 10% على\nتأجير السيارات';

  @override
  String get cleaningSelectService => 'أختر نوع الخدمة';

  @override
  String get cleaningQuick => 'تنظيف سريع';

  @override
  String get cleaningDeep => 'تنظيف شامل';

  @override
  String get cleaningLinen => 'تغيير شراشف ومستلزمات حمام';

  @override
  String get previousOrders => 'الطلبات السابقة';

  @override
  String get sampleOrderDate => '9:20 - 11 مايو 90 ص';

  @override
  String get selectSuitableTime => 'أختر الوقت المناسب';

  @override
  String get timeSlotToday11AM => 'اليوم 11:00 ص (أقرب موعد)';

  @override
  String get timeSlotToday2PM => 'اليوم 02:00 م';

  @override
  String get timeSlotToday5PM => 'اليوم 05:00 م';

  @override
  String get additionalNotesOptional => 'ملاحظات إضافية (اختياري)';

  @override
  String get notesPlaceholder => 'اكتب ملاحظاتك هنا...';

  @override
  String get orderReceived => 'أٌستلم طلبك';

  @override
  String cleaningOrderDoneDesc(String timeSlot) {
    return 'سيصل فريق النظافة في الموعد المحدد ($timeSlot).';
  }

  @override
  String get bookingInfo => 'معلومات الحجز';

  @override
  String get departureDate => 'تاريخ المغادرة';

  @override
  String get sampleDepartureDate => '15 مايو 2026';

  @override
  String get departureTime => 'وقت المغادرة';

  @override
  String get sampleDepartureTime => '12 : 30 م';

  @override
  String get bookingNumber => 'رقم الحجز';

  @override
  String get sampleBookingNumber => '#NZE-2024-1258';

  @override
  String get dailyRate => 'سعر اليوم';

  @override
  String get extensionDays => 'أيام التمديد';

  @override
  String get extend => 'تمديد';

  @override
  String get extendApprovalNotice => 'سنرسل طلبك إلى المالك للموافقة';

  @override
  String get extendRequestSent => 'أٌرسل طلب تمديد';

  @override
  String extendRequestDoneDesc(int days) {
    return 'أرسلنا الطلب إلى المالك للموافقة على تمديد الحجز لمدة $days يوم.';
  }

  @override
  String get nearestPlacesTitle => 'مرافق قريبة';

  @override
  String get placeGrocery => 'بقالة';

  @override
  String get placeGroceryFull => 'بقالة وميني ماركت الحي';

  @override
  String get placeBus => 'محطة حافلات';

  @override
  String get placeBusFull => 'محطة حافلات النقل العام';

  @override
  String get placeHospital => 'مستشفى السلام';

  @override
  String get placeHospitalFull => 'مستشفى السلام الطبي';

  @override
  String get placeMosque => 'مسجد الحي';

  @override
  String get placeMosqueFull => 'جامع الهدى';

  @override
  String get placePharmacy => 'صيدلية النهدي';

  @override
  String get placePharmacyFull => 'صيدلية النهدي 24 ساعة';

  @override
  String distUnitKm(String dist) {
    return '$dist كم';
  }

  @override
  String timeUnitMinutes(String mins) {
    return '$mins دقيقة';
  }

  @override
  String get deliveryTitle => 'طلبات التوصيل';

  @override
  String get catRestaurants => 'مطاعم';

  @override
  String get catGrocery => 'بقالة';

  @override
  String get catCafes => 'كافيهات';

  @override
  String get catBuffets => 'بوافي';

  @override
  String get catJuices => 'عصائر';

  @override
  String get catOther => 'أمور أخرى';

  @override
  String get nearbyRestaurants => 'مطاعم قريبة';

  @override
  String cartItemsCount(int count) {
    return 'السلة ($count عناصر)';
  }

  @override
  String get deliveryOrderReceived => 'تم استلام طلبك';

  @override
  String get deliveryOrderDoneDesc =>
      'تم إرسال طلب التوصيل بنجاح وسيتم إيصاله إلى غرفتك بأسرع وقت.';

  @override
  String get restaurantHerfy => 'هرفي';

  @override
  String get restaurantHerfyTags => 'برجر، سندوشات';

  @override
  String get restaurantAlbaik => 'البيك';

  @override
  String get restaurantAlbaikTags => 'دجاج مقلي';

  @override
  String get restaurantMcDonalds => 'ماكدونالدز';

  @override
  String get restaurantMcDonaldsTags => 'برجر، سندوشات';

  @override
  String get restaurantRaeq => 'رايق';

  @override
  String get restaurantRaeqTags => 'شاورما، وجبات';

  @override
  String get restaurantShallal => 'الشلال';

  @override
  String get restaurantShallalTags => 'خبز، وجبات';

  @override
  String get restaurantKudu => 'كودو';

  @override
  String get restaurantKuduTags => 'برجر، دجاج';

  @override
  String get emergencyTitle => 'طوارئ';

  @override
  String get directEmergencyNumbers => 'أرقام الاتصال السريع المباشر';

  @override
  String get emergencyPolice => 'الشرطة والأمن';

  @override
  String get emergencyAmbulance => 'الإسعاف والطوارئ الطبية';

  @override
  String get emergencyMaintenance => 'طوارئ الصيانة والعقار';

  @override
  String get apartmentInfoTitle => 'معلومات الشقة';

  @override
  String get deviceInstructions => 'تعليمات الأجهزة';

  @override
  String get deviceInstructionsDesc => 'دليل استخدام الأجهزة الكهربائية';

  @override
  String get checkoutPolicy => 'سياسة الخروج';

  @override
  String get checkoutPolicyDesc => 'تسجيل الخروج قبل الساعة 12:00 م';

  @override
  String get importantContacts => 'أرقام مهمة';

  @override
  String get importantContactsDesc => 'أرقام التواصل و الخدمات';

  @override
  String get aboutApartment => 'عن الشقة';

  @override
  String get aboutApartmentDesc => 'معلومات و مميزات الشقة';

  @override
  String get applianceAC => 'المكيف';

  @override
  String get applianceACDesc =>
      'درجة الحرارة الموصى بها هي (22°C - 24°C). يمكنك استخدام زر Quiet لتفعيل الوضع الصامت أثناء النوم.';

  @override
  String get applianceTV => 'تلفزيون ذكي';

  @override
  String get applianceTVDesc =>
      'تطبيقات Netflix و Shahid و YouTube مثبتة مسبقاً. لمشاركة الشاشة، اختر AirPlay أو Screen Cast بنفس شبكة Wi-Fi.';

  @override
  String get applianceWasher => 'غسالة الملابس والمجفف';

  @override
  String get applianceWasherDesc =>
      'برنامج Quick 30m مناسب للغسيل اليومي السريع. مساحيق الغسيل الإضافية متوفرة في خزانة الحمام أسفل الحوض.';

  @override
  String get applianceCoffee => 'صانعة القهوة والغلاية';

  @override
  String get applianceCoffeeDesc =>
      'تتوفر كبسولات قهوة وشاي ومياه نقية مجاناً يومياً. يرجى ملء الخزان بالماء العذب قبل بدء التشغيل.';

  @override
  String get applianceMicrowave => 'الميكروويف والفرن';

  @override
  String get applianceMicrowaveDesc =>
      'يرجى استخدام الأواني الزجاجية والحرارية المخصصة، وتجنب إدخال أي أدوات معدنية أو قصدير.';

  @override
  String get checkoutTimeHighlight => 'موعد تسجيل الخروج: 12:00 م';

  @override
  String get checkoutTimeNote =>
      'نرجو تسليم الشقة بالوقت المحدد لتجهيزها للنزيل القادم';

  @override
  String get policySmartKey => 'تسليم المفتاح الذكي';

  @override
  String get policySmartKeyDesc =>
      'يرجى ترك بطاقة الدخول الذكية داخل صندوق الاستقبال عند المغادرة أو تسليمها لموظف الاستقبال.';

  @override
  String get policyLuggage => 'التأكد من الأمتعة والخزنة';

  @override
  String get policyLuggageDesc =>
      'تأكد من عدم نسيان أي مقتنيات شخصية في الدواليب أو تفريغ الخزنة الإلكترونية قبل الخروج.';

  @override
  String get policyPower => 'إطفاء الأجهزة والإضاءة';

  @override
  String get policyPowerDesc =>
      'يُرجى إيقاف تشغيل أجهزة التكييف والإنارة حفاظاً على البيئة والسلامة العامة.';

  @override
  String get policyExtendStay => 'طلب تمديد الإقامة';

  @override
  String get policyExtendStayDesc =>
      'في حال رغبتك بتمديد الإقامة، يمكنك طلب ذلك عبر خدمة \"تمديد الحجز\" قبل الساعة 10:00 صباحاً.';

  @override
  String get contactReception => 'الاستقبال وخدمة النزلاء';

  @override
  String get contactRoomService => 'خدمة الغرف وتوصيل الطلبات';

  @override
  String get contactMaintenance => 'الصيانة والدعم الفني';

  @override
  String get contactSecurity => 'الأمن والسلامة';

  @override
  String extensionExt(String number) {
    return 'تحويلة: $number';
  }

  @override
  String get aboutUnitNumber => 'رقم الوحدة';

  @override
  String get aboutUnitNumberVal => 'جناح 402 - الدور الرابع';

  @override
  String get aboutStayType => 'نوع الإقامة';

  @override
  String get aboutStayTypeVal => 'جناح فندقي تنفيذي فاخر';

  @override
  String get aboutArea => 'المساحة';

  @override
  String get aboutAreaVal => '85 متر مربع';

  @override
  String get aboutCapacity => 'الطاقة الاستيعابية';

  @override
  String get aboutCapacityVal => 'حتى 4 أشخاص';

  @override
  String get aboutFacilities => 'المرافق';

  @override
  String get aboutFacilitiesVal =>
      'غرفة ماستر، صالة معيشة، مطبخ مجهز، 2 دورات مياه';

  @override
  String get aboutInternet => 'شبكة الإنترنت';

  @override
  String get aboutInternetVal => 'ألياف بصرية فائقة السرعة';

  @override
  String get aboutSmoking => 'سياسة التدخين';

  @override
  String get aboutSmokingVal => 'ممنوع التدخين داخل الوحدة تماماً';

  @override
  String get aboutQuietHours => 'ساعات الهدوء';

  @override
  String get aboutQuietHoursVal => 'من الساعة 11:00 م حتى 07:00 ص';

  @override
  String get tourismTitle => 'سياحة وتجارب';

  @override
  String get catAll => 'الكل';

  @override
  String get catSeaTrips => 'رحلات بحرية';

  @override
  String get catTours => 'جولات';

  @override
  String get catCars => 'سيارات';

  @override
  String get catMarkets => 'أسواق';

  @override
  String get catOtherTours => 'اخرى';

  @override
  String get tourSeaCruises => 'رحلات بحرية خاصة';

  @override
  String get tourSeaCruisesDesc =>
      'استمتع برحلة بحرية خاصة مع إطلالات ساحرة ومشروبات منعشة طوال الجولة.';

  @override
  String get tourDiriyah => 'جولة الدرعية التاريخية';

  @override
  String get tourDiriyahDesc =>
      'جولة ثقافية ثرية لأبرز معالم الدرعية التاريخية وحي الطريف المسجل في اليونسكو.';

  @override
  String get tourDiriyahSub =>
      'شامل المرشد السياحي المعتمد وزيارة حي الطريف التراثي';

  @override
  String get tourSafari => 'رحلة سفاري وتخييم صحراوي فاخر';

  @override
  String get tourSafariDesc =>
      'تجربة استثنائية بين الكثبان الذهبية مع جلسة شواء راقية وعروض حية.';

  @override
  String get tourSafariSub => 'شامل العشاء وعروض الترفيه الحية';

  @override
  String get tourLuxuryCar => 'تأجير سيارة فاخرة مع سائق خاص';

  @override
  String get tourLuxuryCarDesc =>
      'خدمة تنقل راقية ومريحة مع سائق خاص على دراية تامة بكافة الوجهات.';

  @override
  String get tourLuxuryCarSub => 'سيارة مرسيدس S-Class مع سائق محترف';

  @override
  String get tourShopping => 'جولة تسوق في أشهر الأسواق الشعبية والمولات';

  @override
  String get tourShoppingDesc =>
      'اكتشف أفضل المتاجر والمنتجات التقليدية والمولات الحديثة.';

  @override
  String get tourShoppingSub => 'جولة تسوق متكاملة مع التوصيل';

  @override
  String get numberOfGuests => 'عدد الأشخاص';

  @override
  String get preferredTime => 'الوقت المفضل';

  @override
  String get specialNotesOptional => 'ملاحظات خاصة (اختياري)';

  @override
  String get specialNotesHint => 'أي متطلبات خاصة أو استفسارات إضافية...';

  @override
  String get confirmBookingRequest => 'تأكيد طلب الحجز';

  @override
  String get bookingRequestReceived => 'تم استلام طلب الحجز';

  @override
  String get bookingRequestDoneDesc =>
      'تم إرسال طلب الحجز بنجاح وسيتواصل معك موظف الاستقبال لتأكيد الموعد.';

  @override
  String get perPerson => 'رس / شخص';

  @override
  String get fullDay => 'يوم كامل';

  @override
  String hoursCount(int count) {
    return '$count ساعات';
  }

  @override
  String get timeSlotMorning => 'صباحاً (09:00 ص - 12:00 م)';

  @override
  String get timeSlotAfternoon => 'ظهراً (01:00 م - 04:00 م)';

  @override
  String get timeSlotEvening => 'مساءً (05:00 م - 08:00 م)';

  @override
  String get timeSlotNight => 'ليلاً (08:30 م - 11:30 م)';

  @override
  String get featuredOffers => 'عروض مميزة';

  @override
  String get discount20Cleaning => 'خصم 20% على\nلخدمات التنظيف';

  @override
  String get discount15Cruises => 'خصم 15% على\nالرحلات البحرية';

  @override
  String get discount10Grocery => 'خصم 10% على\nتوصيل البقالة';

  @override
  String get discount10CarRental => 'خصم 10% على\nتأجير السيارات';

  @override
  String get serviceSoonTitle => 'ستتوفر الخدمة قريباً';

  @override
  String get serviceSoonDesc =>
      'نعمل حالياً على تجهيز هذه الميزة لتقديم أفضل تجربة لإقامتك';

  @override
  String get backToHome => 'العودة للرئيسية';
}
