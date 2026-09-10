import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Nazel - Khuzama Touch'**
  String get appName;

  /// App promotional tagline
  ///
  /// In en, this message translates to:
  /// **'Your journey needs a screen'**
  String get appTagline;

  /// Language button text
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Arabic language selection label
  ///
  /// In en, this message translates to:
  /// **'عربي'**
  String get arabic;

  /// English language selection label
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Generic done button
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Generic back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Generic cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Generic continue button
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// Order now button
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get orderNow;

  /// Book now button
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// View all link
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// Completed status badge
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Saudi Riyal currency abbreviation
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get currencySar;

  /// Saudi Riyal full word
  ///
  /// In en, this message translates to:
  /// **'Riyal'**
  String get currencyRiyal;

  /// Total label
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Expected total label
  ///
  /// In en, this message translates to:
  /// **'Expected Total'**
  String get expectedTotal;

  /// Call action button
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// Search field hint
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// Send request button
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get sendRequest;

  /// Guest welcome heading
  ///
  /// In en, this message translates to:
  /// **'Welcome Faisal'**
  String get guestGreeting;

  /// Guest welcome sub-wish
  ///
  /// In en, this message translates to:
  /// **'We wish you a pleasant stay'**
  String get guestWish;

  /// Time details section title
  ///
  /// In en, this message translates to:
  /// **'Time Details'**
  String get timeDetails;

  /// Check-in time label
  ///
  /// In en, this message translates to:
  /// **'Check-in Time'**
  String get checkInTime;

  /// Check-in time value display
  ///
  /// In en, this message translates to:
  /// **'2027/02/01 - 00:00 PM'**
  String get checkInTimeValue;

  /// Check-out time label
  ///
  /// In en, this message translates to:
  /// **'Check-out Time'**
  String get checkOutTime;

  /// Check-out time value display
  ///
  /// In en, this message translates to:
  /// **'2027/02/04 - 4:30 PM'**
  String get checkOutTimeValue;

  /// Remaining stay countdown title
  ///
  /// In en, this message translates to:
  /// **'Remaining Time'**
  String get remainingTime;

  /// Remaining stay countdown value
  ///
  /// In en, this message translates to:
  /// **'01:01:40:00'**
  String get remainingTimeValue;

  /// Network section title
  ///
  /// In en, this message translates to:
  /// **'Network Details'**
  String get networkDetails;

  /// Wi-Fi SSID label
  ///
  /// In en, this message translates to:
  /// **'Network Name'**
  String get networkName;

  /// Default Wi-Fi SSID name
  ///
  /// In en, this message translates to:
  /// **'Khuzama Touch'**
  String get networkNameValue;

  /// Wi-Fi Password label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get networkPassword;

  /// Default Wi-Fi password
  ///
  /// In en, this message translates to:
  /// **'Khuzama Flower'**
  String get networkPasswordValue;

  /// Wi-Fi card title
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get wifi;

  /// Cleaning service grid title
  ///
  /// In en, this message translates to:
  /// **'Cleaning Request'**
  String get serviceCleaning;

  /// Cleaning service grid subtitle
  ///
  /// In en, this message translates to:
  /// **'Request cleaning service'**
  String get serviceCleaningDesc;

  /// Delivery orders grid title
  ///
  /// In en, this message translates to:
  /// **'Delivery Orders'**
  String get serviceDelivery;

  /// Delivery orders grid subtitle
  ///
  /// In en, this message translates to:
  /// **'Restaurants, groceries, pharmacies'**
  String get serviceDeliveryDesc;

  /// Nearby amenities grid title
  ///
  /// In en, this message translates to:
  /// **'Nearby Amenities'**
  String get serviceAmenities;

  /// Nearby amenities grid subtitle
  ///
  /// In en, this message translates to:
  /// **'Discover nearby places'**
  String get serviceAmenitiesDesc;

  /// Tourism grid title
  ///
  /// In en, this message translates to:
  /// **'Tourism & Experiences'**
  String get serviceTourism;

  /// Tourism grid subtitle
  ///
  /// In en, this message translates to:
  /// **'Activities & guided tours'**
  String get serviceTourismDesc;

  /// Extend stay grid title
  ///
  /// In en, this message translates to:
  /// **'Extend Booking'**
  String get serviceExtendStay;

  /// Extend stay grid subtitle
  ///
  /// In en, this message translates to:
  /// **'Extend your stay duration'**
  String get serviceExtendStayDesc;

  /// Apartment info grid title
  ///
  /// In en, this message translates to:
  /// **'Booking Info'**
  String get serviceApartmentInfo;

  /// Apartment info grid subtitle
  ///
  /// In en, this message translates to:
  /// **'Booking guide & instructions'**
  String get serviceApartmentInfoDesc;

  /// Emergency grid title
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get serviceEmergency;

  /// Emergency grid subtitle
  ///
  /// In en, this message translates to:
  /// **'Quick emergency contact'**
  String get serviceEmergencyDesc;

  /// Offers and ads grid title
  ///
  /// In en, this message translates to:
  /// **'Offers & Ads'**
  String get serviceAds;

  /// Offers and ads grid subtitle
  ///
  /// In en, this message translates to:
  /// **'Special offers & featured services'**
  String get serviceAdsDesc;

  /// Cleaning discount promo text
  ///
  /// In en, this message translates to:
  /// **'20% off\non Cleaning Services'**
  String get promoDiscount20Cleaning;

  /// Sea cruise discount promo text
  ///
  /// In en, this message translates to:
  /// **'15% off\non Sea Cruises'**
  String get promoDiscount15Cruises;

  /// Grocery discount promo text
  ///
  /// In en, this message translates to:
  /// **'10% off\non Grocery Delivery'**
  String get promoDiscount10Grocery;

  /// Car rental discount promo text
  ///
  /// In en, this message translates to:
  /// **'10% off\non Car Rental'**
  String get promoDiscount10CarRental;

  /// Title for selecting cleaning service
  ///
  /// In en, this message translates to:
  /// **'Select Service Type'**
  String get cleaningSelectService;

  /// Quick clean option
  ///
  /// In en, this message translates to:
  /// **'Quick Clean'**
  String get cleaningQuick;

  /// Deep clean option
  ///
  /// In en, this message translates to:
  /// **'Deep Clean'**
  String get cleaningDeep;

  /// Linen & towel change option
  ///
  /// In en, this message translates to:
  /// **'Linen & Towel Change'**
  String get cleaningLinen;

  /// Previous orders header
  ///
  /// In en, this message translates to:
  /// **'Previous Orders'**
  String get previousOrders;

  /// Sample previous order date
  ///
  /// In en, this message translates to:
  /// **'9:20 - 11 May 9:00 AM'**
  String get sampleOrderDate;

  /// Select suitable time title
  ///
  /// In en, this message translates to:
  /// **'Select Suitable Time'**
  String get selectSuitableTime;

  /// Time slot 11 AM
  ///
  /// In en, this message translates to:
  /// **'Today 11:00 AM (Earliest)'**
  String get timeSlotToday11AM;

  /// Time slot 2 PM
  ///
  /// In en, this message translates to:
  /// **'Today 02:00 PM'**
  String get timeSlotToday2PM;

  /// Time slot 5 PM
  ///
  /// In en, this message translates to:
  /// **'Today 05:00 PM'**
  String get timeSlotToday5PM;

  /// Additional notes header
  ///
  /// In en, this message translates to:
  /// **'Additional Notes (Optional)'**
  String get additionalNotesOptional;

  /// Notes input placeholder
  ///
  /// In en, this message translates to:
  /// **'Write your notes here...'**
  String get notesPlaceholder;

  /// Order received title
  ///
  /// In en, this message translates to:
  /// **'Order Received'**
  String get orderReceived;

  /// Cleaning order done description with time slot
  ///
  /// In en, this message translates to:
  /// **'The cleaning team will arrive at the scheduled time ({timeSlot}).'**
  String cleaningOrderDoneDesc(String timeSlot);

  /// Booking info card title
  ///
  /// In en, this message translates to:
  /// **'Booking Information'**
  String get bookingInfo;

  /// Departure date label
  ///
  /// In en, this message translates to:
  /// **'Departure Date'**
  String get departureDate;

  /// Sample departure date
  ///
  /// In en, this message translates to:
  /// **'15 May 2026'**
  String get sampleDepartureDate;

  /// Departure time label
  ///
  /// In en, this message translates to:
  /// **'Departure Time'**
  String get departureTime;

  /// Sample departure time
  ///
  /// In en, this message translates to:
  /// **'12:30 PM'**
  String get sampleDepartureTime;

  /// Booking number label
  ///
  /// In en, this message translates to:
  /// **'Booking Number'**
  String get bookingNumber;

  /// Sample booking number
  ///
  /// In en, this message translates to:
  /// **'#NZE-2024-1258'**
  String get sampleBookingNumber;

  /// Daily rate label
  ///
  /// In en, this message translates to:
  /// **'Daily Rate'**
  String get dailyRate;

  /// Extension days label
  ///
  /// In en, this message translates to:
  /// **'Extension Days'**
  String get extensionDays;

  /// Extend action button
  ///
  /// In en, this message translates to:
  /// **'Extend'**
  String get extend;

  /// Notice below extend button
  ///
  /// In en, this message translates to:
  /// **'We will send your request to the owner for approval'**
  String get extendApprovalNotice;

  /// Extension request sent title
  ///
  /// In en, this message translates to:
  /// **'Extension Request Sent'**
  String get extendRequestSent;

  /// Extension request confirmation message
  ///
  /// In en, this message translates to:
  /// **'We sent the request to the owner to approve extending your booking for {days} days.'**
  String extendRequestDoneDesc(int days);

  /// Nearby places title
  ///
  /// In en, this message translates to:
  /// **'Nearby Amenities'**
  String get nearestPlacesTitle;

  /// Grocery place name
  ///
  /// In en, this message translates to:
  /// **'Grocery Store'**
  String get placeGrocery;

  /// Grocery full title
  ///
  /// In en, this message translates to:
  /// **'Neighborhood Grocery & Mini Market'**
  String get placeGroceryFull;

  /// Bus station place name
  ///
  /// In en, this message translates to:
  /// **'Bus Station'**
  String get placeBus;

  /// Bus station full title
  ///
  /// In en, this message translates to:
  /// **'Public Transit Bus Station'**
  String get placeBusFull;

  /// Hospital place name
  ///
  /// In en, this message translates to:
  /// **'Al Salam Hospital'**
  String get placeHospital;

  /// Hospital full title
  ///
  /// In en, this message translates to:
  /// **'Al Salam Medical Hospital'**
  String get placeHospitalFull;

  /// Mosque place name
  ///
  /// In en, this message translates to:
  /// **'Neighborhood Mosque'**
  String get placeMosque;

  /// Mosque full title
  ///
  /// In en, this message translates to:
  /// **'Al Huda Grand Mosque'**
  String get placeMosqueFull;

  /// Pharmacy place name
  ///
  /// In en, this message translates to:
  /// **'Al Nahdi Pharmacy'**
  String get placePharmacy;

  /// Pharmacy full title
  ///
  /// In en, this message translates to:
  /// **'Al Nahdi 24/7 Pharmacy'**
  String get placePharmacyFull;

  /// Distance in kilometers
  ///
  /// In en, this message translates to:
  /// **'{dist} km'**
  String distUnitKm(String dist);

  /// Time in minutes
  ///
  /// In en, this message translates to:
  /// **'{mins} mins'**
  String timeUnitMinutes(String mins);

  /// Delivery modal title
  ///
  /// In en, this message translates to:
  /// **'Delivery Orders'**
  String get deliveryTitle;

  /// Restaurants category
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get catRestaurants;

  /// Grocery category
  ///
  /// In en, this message translates to:
  /// **'Grocery'**
  String get catGrocery;

  /// Cafes category
  ///
  /// In en, this message translates to:
  /// **'Cafes'**
  String get catCafes;

  /// Buffets category
  ///
  /// In en, this message translates to:
  /// **'Buffets'**
  String get catBuffets;

  /// Juices category
  ///
  /// In en, this message translates to:
  /// **'Juices'**
  String get catJuices;

  /// Other category
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get catOther;

  /// Nearby restaurants header
  ///
  /// In en, this message translates to:
  /// **'Nearby Restaurants'**
  String get nearbyRestaurants;

  /// Cart items count label
  ///
  /// In en, this message translates to:
  /// **'Cart ({count} items)'**
  String cartItemsCount(int count);

  /// Delivery order received title
  ///
  /// In en, this message translates to:
  /// **'Order Received'**
  String get deliveryOrderReceived;

  /// Delivery order success description
  ///
  /// In en, this message translates to:
  /// **'Your delivery request has been sent successfully and will be delivered to your room promptly.'**
  String get deliveryOrderDoneDesc;

  /// Herfy restaurant name
  ///
  /// In en, this message translates to:
  /// **'Herfy'**
  String get restaurantHerfy;

  /// Herfy tags
  ///
  /// In en, this message translates to:
  /// **'Burgers, Sandwiches'**
  String get restaurantHerfyTags;

  /// Albaik restaurant name
  ///
  /// In en, this message translates to:
  /// **'Albaik'**
  String get restaurantAlbaik;

  /// Albaik tags
  ///
  /// In en, this message translates to:
  /// **'Fried Chicken'**
  String get restaurantAlbaikTags;

  /// McDonalds restaurant name
  ///
  /// In en, this message translates to:
  /// **'McDonald\'\'s'**
  String get restaurantMcDonalds;

  /// McDonalds tags
  ///
  /// In en, this message translates to:
  /// **'Burgers, Sandwiches'**
  String get restaurantMcDonaldsTags;

  /// Raeq restaurant name
  ///
  /// In en, this message translates to:
  /// **'Raeq'**
  String get restaurantRaeq;

  /// Raeq tags
  ///
  /// In en, this message translates to:
  /// **'Shawarma, Meals'**
  String get restaurantRaeqTags;

  /// Shallal restaurant name
  ///
  /// In en, this message translates to:
  /// **'Al Shallal'**
  String get restaurantShallal;

  /// Shallal tags
  ///
  /// In en, this message translates to:
  /// **'Bakery, Meals'**
  String get restaurantShallalTags;

  /// Kudu restaurant name
  ///
  /// In en, this message translates to:
  /// **'Kudu'**
  String get restaurantKudu;

  /// Kudu tags
  ///
  /// In en, this message translates to:
  /// **'Burgers, Chicken'**
  String get restaurantKuduTags;

  /// Emergency modal title
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergencyTitle;

  /// Direct emergency numbers header
  ///
  /// In en, this message translates to:
  /// **'Direct Fast Contact Numbers'**
  String get directEmergencyNumbers;

  /// Police emergency contact
  ///
  /// In en, this message translates to:
  /// **'Police & Security'**
  String get emergencyPolice;

  /// Ambulance emergency contact
  ///
  /// In en, this message translates to:
  /// **'Ambulance & Medical Emergency'**
  String get emergencyAmbulance;

  /// Maintenance emergency contact
  ///
  /// In en, this message translates to:
  /// **'Facility & Property Maintenance'**
  String get emergencyMaintenance;

  /// Apartment info modal title
  ///
  /// In en, this message translates to:
  /// **'Apartment Information'**
  String get apartmentInfoTitle;

  /// Appliance instructions title
  ///
  /// In en, this message translates to:
  /// **'Appliance Instructions'**
  String get deviceInstructions;

  /// Appliance instructions subtitle
  ///
  /// In en, this message translates to:
  /// **'Guide for using electrical appliances'**
  String get deviceInstructionsDesc;

  /// Checkout policy title
  ///
  /// In en, this message translates to:
  /// **'Checkout Policy'**
  String get checkoutPolicy;

  /// Checkout policy subtitle
  ///
  /// In en, this message translates to:
  /// **'Check out before 12:00 PM'**
  String get checkoutPolicyDesc;

  /// Important contacts title
  ///
  /// In en, this message translates to:
  /// **'Important Contacts'**
  String get importantContacts;

  /// Important contacts subtitle
  ///
  /// In en, this message translates to:
  /// **'Contact numbers & services'**
  String get importantContactsDesc;

  /// About apartment title
  ///
  /// In en, this message translates to:
  /// **'About Apartment'**
  String get aboutApartment;

  /// About apartment subtitle
  ///
  /// In en, this message translates to:
  /// **'Apartment features & information'**
  String get aboutApartmentDesc;

  /// AC appliance name
  ///
  /// In en, this message translates to:
  /// **'Air Conditioner'**
  String get applianceAC;

  /// AC instructions
  ///
  /// In en, this message translates to:
  /// **'Recommended temperature is (22°C - 24°C). You can use the Quiet button for silent mode while sleeping.'**
  String get applianceACDesc;

  /// Smart TV name
  ///
  /// In en, this message translates to:
  /// **'Smart TV'**
  String get applianceTV;

  /// Smart TV instructions
  ///
  /// In en, this message translates to:
  /// **'Netflix, Shahid, and YouTube apps are pre-installed. To share your screen, choose AirPlay or Screen Cast on the same Wi-Fi.'**
  String get applianceTVDesc;

  /// Washer appliance name
  ///
  /// In en, this message translates to:
  /// **'Washing Machine & Dryer'**
  String get applianceWasher;

  /// Washer instructions
  ///
  /// In en, this message translates to:
  /// **'Quick 30m program is ideal for fast daily laundry. Extra laundry detergents are in the bathroom cabinet under the sink.'**
  String get applianceWasherDesc;

  /// Coffee maker appliance name
  ///
  /// In en, this message translates to:
  /// **'Coffee Maker & Kettle'**
  String get applianceCoffee;

  /// Coffee maker instructions
  ///
  /// In en, this message translates to:
  /// **'Complimentary coffee capsules, tea, and pure water are provided daily. Please fill the tank with fresh water before use.'**
  String get applianceCoffeeDesc;

  /// Microwave appliance name
  ///
  /// In en, this message translates to:
  /// **'Microwave & Oven'**
  String get applianceMicrowave;

  /// Microwave instructions
  ///
  /// In en, this message translates to:
  /// **'Please use designated glassware and oven-safe cookware, and avoid inserting metal or aluminum foil.'**
  String get applianceMicrowaveDesc;

  /// Checkout time highlight
  ///
  /// In en, this message translates to:
  /// **'Checkout Time: 12:00 PM'**
  String get checkoutTimeHighlight;

  /// Checkout note
  ///
  /// In en, this message translates to:
  /// **'Please hand over the apartment on time so we can prepare it for the next guest'**
  String get checkoutTimeNote;

  /// Smart key policy title
  ///
  /// In en, this message translates to:
  /// **'Hand in Smart Key'**
  String get policySmartKey;

  /// Smart key policy description
  ///
  /// In en, this message translates to:
  /// **'Please leave the smart access card inside the reception box upon departure or hand it to the receptionist.'**
  String get policySmartKeyDesc;

  /// Luggage policy title
  ///
  /// In en, this message translates to:
  /// **'Check Luggage & Safe'**
  String get policyLuggage;

  /// Luggage policy description
  ///
  /// In en, this message translates to:
  /// **'Make sure not to leave any personal belongings in the wardrobes and empty the digital safe before leaving.'**
  String get policyLuggageDesc;

  /// Power policy title
  ///
  /// In en, this message translates to:
  /// **'Turn Off Appliances & Lights'**
  String get policyPower;

  /// Power policy description
  ///
  /// In en, this message translates to:
  /// **'Please turn off air conditioning and lights to preserve the environment and ensure general safety.'**
  String get policyPowerDesc;

  /// Extend stay policy title
  ///
  /// In en, this message translates to:
  /// **'Request Stay Extension'**
  String get policyExtendStay;

  /// Extend stay policy description
  ///
  /// In en, this message translates to:
  /// **'If you wish to extend your stay, you can request it via the \'Extend Booking\' service before 10:00 AM.'**
  String get policyExtendStayDesc;

  /// Reception contact title
  ///
  /// In en, this message translates to:
  /// **'Reception & Guest Service'**
  String get contactReception;

  /// Room service contact title
  ///
  /// In en, this message translates to:
  /// **'Room Service & Orders'**
  String get contactRoomService;

  /// Maintenance contact title
  ///
  /// In en, this message translates to:
  /// **'Maintenance & Technical Support'**
  String get contactMaintenance;

  /// Security contact title
  ///
  /// In en, this message translates to:
  /// **'Safety & Security'**
  String get contactSecurity;

  /// Extension number format
  ///
  /// In en, this message translates to:
  /// **'Ext: {number}'**
  String extensionExt(String number);

  /// Unit number label
  ///
  /// In en, this message translates to:
  /// **'Unit Number'**
  String get aboutUnitNumber;

  /// Unit number value
  ///
  /// In en, this message translates to:
  /// **'Suite 402 - 4th Floor'**
  String get aboutUnitNumberVal;

  /// Stay type label
  ///
  /// In en, this message translates to:
  /// **'Stay Type'**
  String get aboutStayType;

  /// Stay type value
  ///
  /// In en, this message translates to:
  /// **'Luxury Executive Hotel Suite'**
  String get aboutStayTypeVal;

  /// Area label
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get aboutArea;

  /// Area value
  ///
  /// In en, this message translates to:
  /// **'85 sq m'**
  String get aboutAreaVal;

  /// Capacity label
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get aboutCapacity;

  /// Capacity value
  ///
  /// In en, this message translates to:
  /// **'Up to 4 Persons'**
  String get aboutCapacityVal;

  /// Facilities label
  ///
  /// In en, this message translates to:
  /// **'Facilities'**
  String get aboutFacilities;

  /// Facilities value
  ///
  /// In en, this message translates to:
  /// **'Master Bedroom, Living Room, Fitted Kitchen, 2 Bathrooms'**
  String get aboutFacilitiesVal;

  /// Internet label
  ///
  /// In en, this message translates to:
  /// **'Internet Network'**
  String get aboutInternet;

  /// Internet value
  ///
  /// In en, this message translates to:
  /// **'Ultra High Speed Fiber Optic'**
  String get aboutInternetVal;

  /// Smoking policy label
  ///
  /// In en, this message translates to:
  /// **'Smoking Policy'**
  String get aboutSmoking;

  /// Smoking policy value
  ///
  /// In en, this message translates to:
  /// **'Strictly No Smoking Inside the Unit'**
  String get aboutSmokingVal;

  /// Quiet hours label
  ///
  /// In en, this message translates to:
  /// **'Quiet Hours'**
  String get aboutQuietHours;

  /// Quiet hours value
  ///
  /// In en, this message translates to:
  /// **'From 11:00 PM to 07:00 AM'**
  String get aboutQuietHoursVal;

  /// Tourism modal title
  ///
  /// In en, this message translates to:
  /// **'Tourism & Experiences'**
  String get tourismTitle;

  /// All category filter
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get catAll;

  /// Sea cruises category
  ///
  /// In en, this message translates to:
  /// **'Sea Cruises'**
  String get catSeaTrips;

  /// Tours category
  ///
  /// In en, this message translates to:
  /// **'Tours'**
  String get catTours;

  /// Cars category
  ///
  /// In en, this message translates to:
  /// **'Cars'**
  String get catCars;

  /// Markets category
  ///
  /// In en, this message translates to:
  /// **'Markets'**
  String get catMarkets;

  /// Other tourism category
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get catOtherTours;

  /// Private sea cruise title
  ///
  /// In en, this message translates to:
  /// **'Private Sea Cruises'**
  String get tourSeaCruises;

  /// Private sea cruise description
  ///
  /// In en, this message translates to:
  /// **'Enjoy a private sea cruise with scenic views and refreshing drinks throughout the trip.'**
  String get tourSeaCruisesDesc;

  /// Diriyah tour title
  ///
  /// In en, this message translates to:
  /// **'Historical Diriyah Tour'**
  String get tourDiriyah;

  /// Diriyah tour description
  ///
  /// In en, this message translates to:
  /// **'A rich cultural tour of the top landmarks of historic Diriyah and the UNESCO-listed At-Turaif district.'**
  String get tourDiriyahDesc;

  /// Diriyah tour subtitle
  ///
  /// In en, this message translates to:
  /// **'Includes certified tour guide & visit to heritage At-Turaif district'**
  String get tourDiriyahSub;

  /// Desert safari tour title
  ///
  /// In en, this message translates to:
  /// **'Luxury Desert Safari & Camping'**
  String get tourSafari;

  /// Desert safari tour description
  ///
  /// In en, this message translates to:
  /// **'An exceptional experience among golden dunes with premium BBQ dining and live entertainment.'**
  String get tourSafariDesc;

  /// Desert safari tour subtitle
  ///
  /// In en, this message translates to:
  /// **'Includes dinner & live entertainment shows'**
  String get tourSafariSub;

  /// Luxury car rental title
  ///
  /// In en, this message translates to:
  /// **'Luxury Car Rental with Private Chauffeur'**
  String get tourLuxuryCar;

  /// Luxury car rental description
  ///
  /// In en, this message translates to:
  /// **'Upscale and comfortable transport service with a private chauffeur knowledgeable of all destinations.'**
  String get tourLuxuryCarDesc;

  /// Luxury car rental subtitle
  ///
  /// In en, this message translates to:
  /// **'Mercedes S-Class with professional chauffeur'**
  String get tourLuxuryCarSub;

  /// Shopping tour title
  ///
  /// In en, this message translates to:
  /// **'Shopping Tour in Popular Souqs & Malls'**
  String get tourShopping;

  /// Shopping tour description
  ///
  /// In en, this message translates to:
  /// **'Discover the best shops, traditional products, and modern shopping malls.'**
  String get tourShoppingDesc;

  /// Shopping tour subtitle
  ///
  /// In en, this message translates to:
  /// **'Complete shopping tour with transfer'**
  String get tourShoppingSub;

  /// Number of guests label
  ///
  /// In en, this message translates to:
  /// **'Number of Guests'**
  String get numberOfGuests;

  /// Preferred time label
  ///
  /// In en, this message translates to:
  /// **'Preferred Time'**
  String get preferredTime;

  /// Special notes label
  ///
  /// In en, this message translates to:
  /// **'Special Notes (Optional)'**
  String get specialNotesOptional;

  /// Special notes placeholder
  ///
  /// In en, this message translates to:
  /// **'Any special requirements or additional inquiries...'**
  String get specialNotesHint;

  /// Confirm booking request button
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking Request'**
  String get confirmBookingRequest;

  /// Booking request received title
  ///
  /// In en, this message translates to:
  /// **'Booking Request Received'**
  String get bookingRequestReceived;

  /// Booking request done description
  ///
  /// In en, this message translates to:
  /// **'Your booking request was sent successfully and the receptionist will contact you to confirm the appointment.'**
  String get bookingRequestDoneDesc;

  /// Per person price suffix
  ///
  /// In en, this message translates to:
  /// **'SAR / Person'**
  String get perPerson;

  /// Full day duration
  ///
  /// In en, this message translates to:
  /// **'Full Day'**
  String get fullDay;

  /// Hours duration
  ///
  /// In en, this message translates to:
  /// **'{count} Hours'**
  String hoursCount(int count);

  /// Morning time slot
  ///
  /// In en, this message translates to:
  /// **'Morning (09:00 AM - 12:00 PM)'**
  String get timeSlotMorning;

  /// Afternoon time slot
  ///
  /// In en, this message translates to:
  /// **'Afternoon (01:00 PM - 04:00 PM)'**
  String get timeSlotAfternoon;

  /// Evening time slot
  ///
  /// In en, this message translates to:
  /// **'Evening (05:00 PM - 08:00 PM)'**
  String get timeSlotEvening;

  /// Night time slot
  ///
  /// In en, this message translates to:
  /// **'Night (08:30 PM - 11:30 PM)'**
  String get timeSlotNight;

  /// Featured offers title
  ///
  /// In en, this message translates to:
  /// **'Special Offers'**
  String get featuredOffers;

  /// Discount 20% cleaning offer
  ///
  /// In en, this message translates to:
  /// **'20% off\non Cleaning Services'**
  String get discount20Cleaning;

  /// Discount 15% cruises offer
  ///
  /// In en, this message translates to:
  /// **'15% off\non Sea Cruises'**
  String get discount15Cruises;

  /// Discount 10% grocery offer
  ///
  /// In en, this message translates to:
  /// **'10% off\non Grocery Delivery'**
  String get discount10Grocery;

  /// Discount 10% car rental offer
  ///
  /// In en, this message translates to:
  /// **'10% off\non Car Rental'**
  String get discount10CarRental;

  /// State soon title
  ///
  /// In en, this message translates to:
  /// **'Service Coming Soon'**
  String get serviceSoonTitle;

  /// State soon description
  ///
  /// In en, this message translates to:
  /// **'We are currently preparing this feature to offer the best experience for your stay'**
  String get serviceSoonDesc;

  /// Back to home button
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
