// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Nazel - Khuzama Touch';

  @override
  String get appTagline => 'Your journey needs a screen';

  @override
  String get language => 'Language';

  @override
  String get arabic => 'عربي';

  @override
  String get english => 'English';

  @override
  String get done => 'Done';

  @override
  String get back => 'Back';

  @override
  String get cancel => 'Cancel';

  @override
  String get continueText => 'Continue';

  @override
  String get orderNow => 'Order Now';

  @override
  String get bookNow => 'Book Now';

  @override
  String get viewAll => 'View All';

  @override
  String get completed => 'Completed';

  @override
  String get currencySar => 'SAR';

  @override
  String get currencyRiyal => 'Riyal';

  @override
  String get total => 'Total';

  @override
  String get expectedTotal => 'Expected Total';

  @override
  String get call => 'Call';

  @override
  String get searchHint => 'Search...';

  @override
  String get sendRequest => 'Send Request';

  @override
  String get guestGreeting => 'Welcome Faisal';

  @override
  String get guestWish => 'We wish you a pleasant stay';

  @override
  String get timeDetails => 'Time Details';

  @override
  String get checkInTime => 'Check-in Time';

  @override
  String get checkInTimeValue => '2027/02/01 - 00:00 PM';

  @override
  String get checkOutTime => 'Check-out Time';

  @override
  String get checkOutTimeValue => '2027/02/04 - 4:30 PM';

  @override
  String get remainingTime => 'Remaining Time';

  @override
  String get remainingTimeValue => '01:01:40:00';

  @override
  String get networkDetails => 'Network Details';

  @override
  String get networkName => 'Network Name';

  @override
  String get networkNameValue => 'Khuzama Touch';

  @override
  String get networkPassword => 'Password';

  @override
  String get networkPasswordValue => 'Khuzama Flower';

  @override
  String get wifi => 'Wi-Fi';

  @override
  String get serviceCleaning => 'Cleaning Request';

  @override
  String get serviceCleaningDesc => 'Request cleaning service';

  @override
  String get serviceDelivery => 'Delivery Orders';

  @override
  String get serviceDeliveryDesc => 'Restaurants, groceries, pharmacies';

  @override
  String get serviceAmenities => 'Nearby Amenities';

  @override
  String get serviceAmenitiesDesc => 'Discover nearby places';

  @override
  String get serviceTourism => 'Tourism & Experiences';

  @override
  String get serviceTourismDesc => 'Activities & guided tours';

  @override
  String get serviceExtendStay => 'Extend Booking';

  @override
  String get serviceExtendStayDesc => 'Extend your stay duration';

  @override
  String get serviceApartmentInfo => 'Booking Info';

  @override
  String get serviceApartmentInfoDesc => 'Booking guide & instructions';

  @override
  String get serviceEmergency => 'Emergency';

  @override
  String get serviceEmergencyDesc => 'Quick emergency contact';

  @override
  String get serviceAds => 'Offers & Ads';

  @override
  String get serviceAdsDesc => 'Special offers & featured services';

  @override
  String get promoDiscount20Cleaning => '20% off\non Cleaning Services';

  @override
  String get promoDiscount15Cruises => '15% off\non Sea Cruises';

  @override
  String get promoDiscount10Grocery => '10% off\non Grocery Delivery';

  @override
  String get promoDiscount10CarRental => '10% off\non Car Rental';

  @override
  String get cleaningSelectService => 'Select Service Type';

  @override
  String get cleaningQuick => 'Quick Clean';

  @override
  String get cleaningDeep => 'Deep Clean';

  @override
  String get cleaningLinen => 'Linen & Towel Change';

  @override
  String get previousOrders => 'Previous Orders';

  @override
  String get sampleOrderDate => '9:20 - 11 May 9:00 AM';

  @override
  String get selectSuitableTime => 'Select Suitable Time';

  @override
  String get timeSlotToday11AM => 'Today 11:00 AM (Earliest)';

  @override
  String get timeSlotToday2PM => 'Today 02:00 PM';

  @override
  String get timeSlotToday5PM => 'Today 05:00 PM';

  @override
  String get additionalNotesOptional => 'Additional Notes (Optional)';

  @override
  String get notesPlaceholder => 'Write your notes here...';

  @override
  String get orderReceived => 'Order Received';

  @override
  String cleaningOrderDoneDesc(String timeSlot) {
    return 'The cleaning team will arrive at the scheduled time ($timeSlot).';
  }

  @override
  String get bookingInfo => 'Booking Information';

  @override
  String get departureDate => 'Departure Date';

  @override
  String get sampleDepartureDate => '15 May 2026';

  @override
  String get departureTime => 'Departure Time';

  @override
  String get sampleDepartureTime => '12:30 PM';

  @override
  String get bookingNumber => 'Booking Number';

  @override
  String get sampleBookingNumber => '#NZE-2024-1258';

  @override
  String get dailyRate => 'Daily Rate';

  @override
  String get extensionDays => 'Extension Days';

  @override
  String get extend => 'Extend';

  @override
  String get extendApprovalNotice =>
      'We will send your request to the owner for approval';

  @override
  String get extendRequestSent => 'Extension Request Sent';

  @override
  String extendRequestDoneDesc(int days) {
    return 'We sent the request to the owner to approve extending your booking for $days days.';
  }

  @override
  String get nearestPlacesTitle => 'Nearby Amenities';

  @override
  String get placeGrocery => 'Grocery Store';

  @override
  String get placeGroceryFull => 'Neighborhood Grocery & Mini Market';

  @override
  String get placeBus => 'Bus Station';

  @override
  String get placeBusFull => 'Public Transit Bus Station';

  @override
  String get placeHospital => 'Al Salam Hospital';

  @override
  String get placeHospitalFull => 'Al Salam Medical Hospital';

  @override
  String get placeMosque => 'Neighborhood Mosque';

  @override
  String get placeMosqueFull => 'Al Huda Grand Mosque';

  @override
  String get placePharmacy => 'Al Nahdi Pharmacy';

  @override
  String get placePharmacyFull => 'Al Nahdi 24/7 Pharmacy';

  @override
  String distUnitKm(String dist) {
    return '$dist km';
  }

  @override
  String timeUnitMinutes(String mins) {
    return '$mins mins';
  }

  @override
  String get deliveryTitle => 'Delivery Orders';

  @override
  String get catRestaurants => 'Restaurants';

  @override
  String get catGrocery => 'Grocery';

  @override
  String get catCafes => 'Cafes';

  @override
  String get catBuffets => 'Buffets';

  @override
  String get catJuices => 'Juices';

  @override
  String get catOther => 'Other';

  @override
  String get nearbyRestaurants => 'Nearby Restaurants';

  @override
  String cartItemsCount(int count) {
    return 'Cart ($count items)';
  }

  @override
  String get deliveryOrderReceived => 'Order Received';

  @override
  String get deliveryOrderDoneDesc =>
      'Your delivery request has been sent successfully and will be delivered to your room promptly.';

  @override
  String get restaurantHerfy => 'Herfy';

  @override
  String get restaurantHerfyTags => 'Burgers, Sandwiches';

  @override
  String get restaurantAlbaik => 'Albaik';

  @override
  String get restaurantAlbaikTags => 'Fried Chicken';

  @override
  String get restaurantMcDonalds => 'McDonald\'s';

  @override
  String get restaurantMcDonaldsTags => 'Burgers, Sandwiches';

  @override
  String get restaurantRaeq => 'Raeq';

  @override
  String get restaurantRaeqTags => 'Shawarma, Meals';

  @override
  String get restaurantShallal => 'Al Shallal';

  @override
  String get restaurantShallalTags => 'Bakery, Meals';

  @override
  String get restaurantKudu => 'Kudu';

  @override
  String get restaurantKuduTags => 'Burgers, Chicken';

  @override
  String get emergencyTitle => 'Emergency';

  @override
  String get directEmergencyNumbers => 'Direct Fast Contact Numbers';

  @override
  String get emergencyPolice => 'Police & Security';

  @override
  String get emergencyAmbulance => 'Ambulance & Medical Emergency';

  @override
  String get emergencyMaintenance => 'Facility & Property Maintenance';

  @override
  String get apartmentInfoTitle => 'Apartment Information';

  @override
  String get deviceInstructions => 'Appliance Instructions';

  @override
  String get deviceInstructionsDesc => 'Guide for using electrical appliances';

  @override
  String get checkoutPolicy => 'Checkout Policy';

  @override
  String get checkoutPolicyDesc => 'Check out before 12:00 PM';

  @override
  String get importantContacts => 'Important Contacts';

  @override
  String get importantContactsDesc => 'Contact numbers & services';

  @override
  String get aboutApartment => 'About Apartment';

  @override
  String get aboutApartmentDesc => 'Apartment features & information';

  @override
  String get applianceAC => 'Air Conditioner';

  @override
  String get applianceACDesc =>
      'Recommended temperature is (22°C - 24°C). You can use the Quiet button for silent mode while sleeping.';

  @override
  String get applianceTV => 'Smart TV';

  @override
  String get applianceTVDesc =>
      'Netflix, Shahid, and YouTube apps are pre-installed. To share your screen, choose AirPlay or Screen Cast on the same Wi-Fi.';

  @override
  String get applianceWasher => 'Washing Machine & Dryer';

  @override
  String get applianceWasherDesc =>
      'Quick 30m program is ideal for fast daily laundry. Extra laundry detergents are in the bathroom cabinet under the sink.';

  @override
  String get applianceCoffee => 'Coffee Maker & Kettle';

  @override
  String get applianceCoffeeDesc =>
      'Complimentary coffee capsules, tea, and pure water are provided daily. Please fill the tank with fresh water before use.';

  @override
  String get applianceMicrowave => 'Microwave & Oven';

  @override
  String get applianceMicrowaveDesc =>
      'Please use designated glassware and oven-safe cookware, and avoid inserting metal or aluminum foil.';

  @override
  String get checkoutTimeHighlight => 'Checkout Time: 12:00 PM';

  @override
  String get checkoutTimeNote =>
      'Please hand over the apartment on time so we can prepare it for the next guest';

  @override
  String get policySmartKey => 'Hand in Smart Key';

  @override
  String get policySmartKeyDesc =>
      'Please leave the smart access card inside the reception box upon departure or hand it to the receptionist.';

  @override
  String get policyLuggage => 'Check Luggage & Safe';

  @override
  String get policyLuggageDesc =>
      'Make sure not to leave any personal belongings in the wardrobes and empty the digital safe before leaving.';

  @override
  String get policyPower => 'Turn Off Appliances & Lights';

  @override
  String get policyPowerDesc =>
      'Please turn off air conditioning and lights to preserve the environment and ensure general safety.';

  @override
  String get policyExtendStay => 'Request Stay Extension';

  @override
  String get policyExtendStayDesc =>
      'If you wish to extend your stay, you can request it via the Extend Booking service before 10:00 AM.';

  @override
  String get contactReception => 'Reception & Guest Service';

  @override
  String get contactRoomService => 'Room Service & Orders';

  @override
  String get contactMaintenance => 'Maintenance & Technical Support';

  @override
  String get contactSecurity => 'Safety & Security';

  @override
  String extensionExt(String number) {
    return 'Ext: $number';
  }

  @override
  String get aboutUnitNumber => 'Unit Number';

  @override
  String get aboutUnitNumberVal => 'Suite 402 - 4th Floor';

  @override
  String get aboutStayType => 'Stay Type';

  @override
  String get aboutStayTypeVal => 'Luxury Executive Hotel Suite';

  @override
  String get aboutArea => 'Area';

  @override
  String get aboutAreaVal => '85 sq m';

  @override
  String get aboutCapacity => 'Capacity';

  @override
  String get aboutCapacityVal => 'Up to 4 Persons';

  @override
  String get aboutFacilities => 'Facilities';

  @override
  String get aboutFacilitiesVal =>
      'Master Bedroom, Living Room, Fitted Kitchen, 2 Bathrooms';

  @override
  String get aboutInternet => 'Internet Network';

  @override
  String get aboutInternetVal => 'Ultra High Speed Fiber Optic';

  @override
  String get aboutSmoking => 'Smoking Policy';

  @override
  String get aboutSmokingVal => 'Strictly No Smoking Inside the Unit';

  @override
  String get aboutQuietHours => 'Quiet Hours';

  @override
  String get aboutQuietHoursVal => 'From 11:00 PM to 07:00 AM';

  @override
  String get tourismTitle => 'Tourism & Experiences';

  @override
  String get catAll => 'All';

  @override
  String get catSeaTrips => 'Sea Cruises';

  @override
  String get catTours => 'Tours';

  @override
  String get catCars => 'Cars';

  @override
  String get catMarkets => 'Markets';

  @override
  String get catOtherTours => 'Other';

  @override
  String get tourSeaCruises => 'Private Sea Cruises';

  @override
  String get tourSeaCruisesDesc =>
      'Enjoy a private sea cruise with scenic views and refreshing drinks throughout the trip.';

  @override
  String get tourDiriyah => 'Historical Diriyah Tour';

  @override
  String get tourDiriyahDesc =>
      'A rich cultural tour of the top landmarks of historic Diriyah and the UNESCO-listed At-Turaif district.';

  @override
  String get tourDiriyahSub =>
      'Includes certified tour guide & visit to heritage At-Turaif district';

  @override
  String get tourSafari => 'Luxury Desert Safari & Camping';

  @override
  String get tourSafariDesc =>
      'An exceptional experience among golden dunes with premium BBQ dining and live entertainment.';

  @override
  String get tourSafariSub => 'Includes dinner & live entertainment shows';

  @override
  String get tourLuxuryCar => 'Luxury Car Rental with Private Chauffeur';

  @override
  String get tourLuxuryCarDesc =>
      'Upscale and comfortable transport service with a private chauffeur knowledgeable of all destinations.';

  @override
  String get tourLuxuryCarSub => 'Mercedes S-Class with professional chauffeur';

  @override
  String get tourShopping => 'Shopping Tour in Popular Souqs & Malls';

  @override
  String get tourShoppingDesc =>
      'Discover the best shops, traditional products, and modern shopping malls.';

  @override
  String get tourShoppingSub => 'Complete shopping tour with transfer';

  @override
  String get numberOfGuests => 'Number of Guests';

  @override
  String get preferredTime => 'Preferred Time';

  @override
  String get specialNotesOptional => 'Special Notes (Optional)';

  @override
  String get specialNotesHint =>
      'Any special requirements or additional inquiries...';

  @override
  String get confirmBookingRequest => 'Confirm Booking Request';

  @override
  String get bookingRequestReceived => 'Booking Request Received';

  @override
  String get bookingRequestDoneDesc =>
      'Your booking request was sent successfully and the receptionist will contact you to confirm the appointment.';

  @override
  String get perPerson => 'SAR / Person';

  @override
  String get fullDay => 'Full Day';

  @override
  String hoursCount(int count) {
    return '$count Hours';
  }

  @override
  String get timeSlotMorning => 'Morning (09:00 AM - 12:00 PM)';

  @override
  String get timeSlotAfternoon => 'Afternoon (01:00 PM - 04:00 PM)';

  @override
  String get timeSlotEvening => 'Evening (05:00 PM - 08:00 PM)';

  @override
  String get timeSlotNight => 'Night (08:30 PM - 11:30 PM)';

  @override
  String get featuredOffers => 'Special Offers';

  @override
  String get discount20Cleaning => '20% off\non Cleaning Services';

  @override
  String get discount15Cruises => '15% off\non Sea Cruises';

  @override
  String get discount10Grocery => '10% off\non Grocery Delivery';

  @override
  String get discount10CarRental => '10% off\non Car Rental';

  @override
  String get serviceSoonTitle => 'Service Coming Soon';

  @override
  String get serviceSoonDesc =>
      'We are currently preparing this feature to offer the best experience for your stay';

  @override
  String get backToHome => 'Back to Home';
}
