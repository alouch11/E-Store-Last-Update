import 'package:flutter_spareparts_store/localization/model/language_model.dart';
import 'package:flutter_spareparts_store/utill/images.dart';

class AppConstants {
  static const String appName = 'Spare Parts Store';
  static const String slogan = 'E-Store';
  static const String appVersion = '25.12.24';
  static const String baseUrl = 'http://192.168.155.137:8080/estore';
  static const String userId = 'userId';
  static const String name = 'name';
  static const String categoriesUri = '/api/v1/categories?guest_id=1';
  static const String brandUri = '/api/v1/brands?guest_id=1';
  static const String brandProductUri = '/api/v1/brands/products/';
  static const String categoryProductUri = '/api/v1/categories/products/';
  static const String registrationUri = '/api/v1/auth/register';
  static const String loginUri = '/api/v1/auth/login';
  static const String logOut = '/api/v1/auth/logout';
  static const String latestProductUri = '/api/v1/products/latest?guest_id=1&limit=10&&offset=';
  static const String newArrivalProductUri = '/api/v1/products/new-arrival?guest_id=1&limit=10&&offset=';
  static const String topProductUri = '/api/v1/products/top-rated?guest_id=1&limit=10&&offset=';
  static const String bestSellingProductUri = '/api/v1/products/best-sellings?guest_id=1&limit=10&offset=';
  static const String discountedProductUri = '/api/v1/products/discounted-product?guest_id=1&limit=10&&offset=';
  static const String featuredProductUri = '/api/v1/products/featured?guest_id=1&limit=10&&offset=';
  static const String homeCategoryProductUri = '/api/v1/products/home-categories?guest_id=1';
  static const String productDetailsUri = '/api/v1/products/details/';
  static const String productDetailsByCodeUri = '/api/v1/products/detailsbycode/';
  static const String productReviewUri = '/api/v1/products/reviews/';
  static const String searchUri = '/api/v1/products/filter';
  static const String getSuggestionProductName = '/api/v1/products/suggestion-product?guest_id=1&name=';
  static const String configUri = '/api/v1/config';
  static const String addWishListUri = '/api/v1/customer/wish-list/add?product_id=';
  static const String removeWishListUri = '/api/v1/customer/wish-list/remove?product_id=';
  static const String sendNotifiationsUri = '/api/v1/customer/notifications/add?title=';
  static const String updateProfileUri = '/api/v1/customer/update-profile';
  static const String customerUri = '/api/v1/customer/info';
  static const String addressListUri = '/api/v1/customer/address/list';
  static const String removeAddressUri = '/api/v1/customer/address';
  static const String addAddressUri = '/api/v1/customer/address/add';
  static const String getWishListUri = '/api/v1/customer/wish-list';
  static const String supportTicketUri = '/api/v1/customer/support-ticket/create';
  static const String getBannerList = '/api/v1/banners';
  static const String relatedProductUri = '/api/v1/products/related-products/';
  static const String alternativeProductUri = '/api/v1/products/alternative-products/';
  static const String productTransactionsList = '/api/v1/products/transactions-products/';
  static const String orderUri = '/api/v1/customer/order/list?limit=10&offset=';
  static const String orderUriByProduct = '/api/v1/customer/order/product/list?limit=10&offset=';
  static const String saleUri = '/api/v1/customer/sale/list?limit=10&offset=';
  static const String linesUri = '/api/v1/customer/lines/list?limit=10&offset=';
  static const String linesMachinesGroupUri = '/api/v1/customer/lines/linesmachinesgroup?limit=10&site=';
  static const String machineEmergencyUri = '/api/v1/customer/machine/emergencylist?machineid=';
  static const String machineTechnicalDocUri = '/api/v1/customer/machine/technicaldoclist?machineid=';
  static const String machineParametersUri = '/api/v1/customer/machine/parameterslist?machineid=';
  static const String machineMaintenanceUri = '/api/v1/customer/machine/maintenancelist?machineid=';
  static const String machineAssemblyListUri = '/api/v1/customer/machine/assemblylist?machineid=';
  static const String machineAssemblyPartsUri = '/api/v1/customer/machine/assemblyparts?machineid=';
  static const String searchAsset = '/api/v1/customer/machine/assetcode';



  static const String saleUriByProduct = '/api/v1/customer/sale/product/list?limit=10&offset=';
  static const String saleUriByMachine = '/api/v1/customer/sale/machine/list?limit=10&offset=';
  static const String orderDetailsUri = '/api/v1/customer/order/details?order_id=';
  static const String saleDetailsUri = '/api/v1/customer/sale/details?sale_id=';
  static const String packageUri = '/api/v1/customer/package/list?limit=10&offset=';
  static const String packageDetailsUri = '/api/v1/customer/package/details?package_id=';
  static const String orderPlaceUri = '/api/v1/customer/order/place';
  static const String sellerUri = '/api/v1/seller?seller_id=/api/v1/seller?seller_id=';
  static const String sellerProductUri = '/api/v1/seller/';
  static const String topSeller = '/api/v1/seller/top';
  static const String trackingUri = '/api/v1/order/track?order_number=';
  static const String trackingsaleUri = '/api/v1/sale/track?sale_number=';
  static const String forgetPasswordUri = '/api/v1/auth/forgot-password';
  static const String getSupportTicketUri = '/api/v1/customer/support-ticket/get';
  static const String supportTicketConversationUri = '/api/v1/customer/support-ticket/conv/';
  static const String supportTicketReplyUri = '/api/v1/customer/support-ticket/reply/';
  static const String closeSupportTicketUri = '/api/v1/customer/support-ticket/close/';
  static const String submitNoteUri = '/api/v1/products/note/submit';
  static const String flashDealUri = '/api/v1/flash-deals';
  static const String featuredDealUri = '/api/v1/deals/featured';
  static const String flashDealProductUri = '/api/v1/flash-deals/products/';
  static const String counterUri = '/api/v1/products/counter/';
  static const String socialLinkUri = '/api/v1/products/social-share-link/';
  static const String shippingUri = '/api/v1/products/shipping-methods';
  static const String couponUri = '/api/v1/coupon/apply?code=';
  static const String messageUri = '/api/v1/customer/chat/get-messages/';
  static const String chatInfoUri = '/api/v1/customer/chat/list/';
  static const String userInfoUri = '/api/v1/customer/chat/user/list/';
  static const String searchChat = '/api/v1/customer/chat/search/';
  static const String searchUser = '/api/v1/customer/chat/user/search/';
  static const String sendMessageUri = '/api/v1/customer/chat/send-message/';
  static const String seenMessageUri = '/api/v1/customer/chat/seen-message/';
  static const String tokenUri = '/api/v1/customer/cm-firebase-token';
  static const String notificationUri = '/api/v1/notifications';
  static const String seenNotificationUri = '/api/v1/notifications/seen';
  static const String addNotificationUri = '/api/v1/notifications/add';
  static const String getCartDataUri = '/api/v1/cart';
  static const String addToCartUri = '/api/v1/cart/add';
  static const String updateCartQuantityUri = '/api/v1/cart/update';
  static const String removeFromCartUri = '/api/v1/cart/remove';
  static const String getShippingMethod = '/api/v1/shipping-method/by-seller';
  static const String chooseShippingMethod = '/api/v1/shipping-method/choose-for-order';
  static const String chosenShippingMethod = '/api/v1/shipping-method/chosen';
  static const String sendOtpToPhone = '/api/v1/auth/check-phone';
  static const String resendPhoneOtpUri = '/api/v1/auth/resend-otp-check-phone';
  static const String verifyPhoneUri = '/api/v1/auth/verify-phone';
  static const String socialLoginUri = '/api/v1/auth/social-login';
  static const String sendOtpToEmail = '/api/v1/auth/check-email';
  static const String resendEmailOtpUri = '/api/v1/auth/resend-otp-check-email';
  static const String verifyEmailUri = '/api/v1/auth/verify-email';
  static const String resetPasswordUri = '/api/v1/auth/reset-password';
  static const String verifyOtpUri = '/api/v1/auth/verify-otp';
  static const String refundRequestUri = '/api/v1/customer/sale/refund-store';
  static const String closeServiceUri = '/api/v1/customer/sale/close-service';
  static const String updateServiceUri = '/api/v1/customer/service/update-service';
  static const String createServiceUri = '/api/v1/customer/service/create-service';
  static const String refundRequestPreReqUri = '/api/v1/customer/order/refund';
  static const String saleRequestPreReqUri = '/api/v1/customer/sale/close';
  static const String refundResultUri = '/api/v1/customer/order/refund-details';
  static const String cancelOrderUri = '/api/v1/order/cancel-order';
  static const String cancelSaleUri = '/api/v1/sale/cancel-sale';
  static const String cancelPackageUri = '/api/v1/package/cancel-package';
  static const String getSelectedShippingTypeUri = '/api/v1/shipping-method/check-shipping-type';
  static const String dealOfTheDay = '/api/v1/dealsoftheday/deal-of-the-day';
  static const String walletTransactionUri = '/api/v1/customer/wallet/list?limit=10&offset=';
  static const String loyaltyPointUri = '/api/v1/customer/loyalty/list?limit=20&offset=';
  static const String loyaltyPointConvert = '/api/v1/customer/loyalty/loyalty-exchange-currency';
  static const String deleteCustomerAccount = '/api/v1/customer/account-delete';
  static const String deleteService = '/api/v1/customer/service/service-delete';
  static const String deliveryRestrictedCountryList = '/api/v1/customer/get-restricted-country-list';
  static const String deliveryRestrictedZipList = '/api/v1/customer/get-restricted-zip-list';
  static const String getOrderFromOrderId = '/api/v1/customer/order/get-order-by-id?order_id=';
  static const String getSaleFromSaleId = '/api/v1/customer/sale/get-sale-by-id?sale_id=';
  static const String getServiceFromServiceId = '/api/v1/customer/service/get-service-by-id?service_id=';
  static const String getPackageFromPackageId = '/api/v1/customer/package/get-package-by-id?package_id=';
  static const String offlinePayment = '/api/v1/customer/order/place-by-offline-payment';
  static const String walletPayment = '/api/v1/customer/order/place-by-wallet';
  static const String couponListApi = '/api/v1/coupon/list?limit=100&offset=';
  static const String sellerWiseCouponListApi = '/api/v1/coupons/';
  static const String sellerWiseBestSellingProduct = '/api/v1/seller/';
  static const String digitalPayment = '/api/v1/digital-payment';
  static const String offlinePaymentList = '/api/v1/customer/order/offline-payment-method-list';
  static const String sellerWiseCategoryList = '/api/v1/categories?seller_id=';
  static const String sellerWiseBrandList = '/api/v1/brands?seller_id=';
  static const String sellerallUri = '/api/v1/seller/all';
  static const String approveSaleUri = '/api/v1/sale/approve-sale';
  //address
  static const String updateAddressUri = '/api/v1/customer/address/update/';
  static const String geocodeUri = '/api/v1/mapapi/geocode-api';
  static const String searchLocationUri = '/api/v1/mapapi/place-api-autocomplete';
  static const String placeDetailsUri = '/api/v1/mapapi/place-api-details';
  static const String distanceMatrixUri = '/api/v1/mapapi/distance-api';
  static const String chatWithDeliveryMan = '/api/v1/mapapi/distance-api';

  static const String getGuestIdUri = '/api/v1/get-guest-id';
  static const String mostDemandedProduct = '/api/v1/products/most-demanded-product?guest_id=1';
  static const String shopAgainFromRecentStore = '/api/v1/products/shop-again-product';
  static const String findWhatYouNeed = '/api/v1/categories/find-what-you-need';
  static const String orderTrack = '/api/v1/order/track-order';
  static const String saleTrack = '/api/v1/sale/track-sale';
  static const String packageTrack = '/api/v1/package/track-package';
  static const String addFundToWallet = '/api/v1/add-to-fund';
  static const String reorder = '/api/v1/customer/order/again';
  static const String resale = '/api/v1/customer/sale/again';
  static const String repackage = '/api/v1/customer/package/again';
  static const String walletBonusList = '/api/v1/customer/wallet/bonus-list';
  static const String moreStore = '/api/v1/seller/more';
  static const String justForYou = '/api/v1/products/just-for-you?guest_id=1';
  static const String mostSearching = '/api/v1/products/most-searching?guest_id=1';
  static const String contactUsUri = '/api/v1/contact-us';
  static const String attributeUri = '/api/v1/attributes';
  static const String availableCoupon = '/api/v1/coupon/applicable-list';
  static const String downloadDigitalProduct = '/api/v1/customer/order/digital-product-download/';
  static const String otpVResendForDigitalProduct = '/api/v1/customer/order/digital-product-download-otp-resend';
  static const String otpVerificationForDigitalProduct = '/api/v1/customer/order/digital-product-download-otp-verify';


  static const String getCompareList = '/api/v1/customer/compare/list';
  static const String addToCompareList = '/api/v1/customer/compare/product-store';
  static const String removeAllFromCompareList = '/api/v1/customer/compare/clear-all';
  static const String replaceFromCompareList = '/api/v1/customer/compare/product-replace';
  static const String setCurrentLanguage = '/api/v1/customer/language-change';


  // sharePreference
  static const String userLoginToken = 'user_login_token';
  static const String guestId = 'guestId';
  static const String user = 'user';
  static const String userEmail = 'user_email';
  static const String userPassword = 'user_password';
  static const String homeAddress = 'home_address';
  static const String searchAddress = 'search_address';
  static const String officeAddress = 'office_address';
  static const String config = 'config';
  static const String guestMode = 'guest_mode';
  static const String currency = 'currency';
  static const String langKey = 'lang';
  static const String intro = 'intro';
  static const pi = 3.14;
  static const defaultSpread = 0.0872665;
  static const double minFilter = 0;
  static const double maxFilter = 1000000;

  // order status
  static const String pending = 'pending';
  static const String confirmed = 'confirmed';
  static const String approved = 'approved';
  static const String processing = 'processing';
  static const String processed = 'processed';
  static const String partiallyDelivery = 'partially_delivered';
  static const String delivered = 'delivered';
  static const String failed = 'failed';
  static const String returned = 'returned';
  static const String cancelled = 'canceled';

  //static const String outForDelivery = 'out_for_delivery';

  static const String lpending = 'lpending';
  static const String lconfirmed = 'lconfirmed';
  static const String lapproved = 'lapproved';
  static const String lpartiallyDelivery = 'lpartially_delivered';
  static const String ldelivered = 'ldelivered';
  static const String lcancelled = 'lcanceled';


  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String theme = 'theme';
  static const String topic = 'E-Store';
  static const String userAddress = 'user_address';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.en,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(imageUrl: Images.ar,
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
    LanguageModel(imageUrl: Images.hi,
        languageName: 'Hindi',
        countryCode: 'IN',
        languageCode: 'hi'),
    LanguageModel(imageUrl: Images.fr,
        languageName: 'French',
        countryCode: 'FR',
        languageCode: 'fr'),
    //LanguageModel(imageUrl: Images.bn, languageName: 'Bangla', countryCode: 'BD', languageCode: 'bn'),
    //LanguageModel(imageUrl: Images.es, languageName: 'Spanish', countryCode: 'ES', languageCode: 'es'),
  ];


  static const String token = 'eservice_token';
  static const String zoneId = 'zoneId';
  static const String localizationKey = 'X-localization';
  static const String pages = '/api/v1/customer/config/pages';
  static const String notificationCount = 'eservice_notification_count';
  static const String notificationUrl = '/api/v1/serviceman/push-notifications';
  static const String bookingRequestUrl = '/api/v1/serviceman/booking/list';
  static const String serviceImagePath = '/service/';
  static const String dashboardUrl = '/api/v1/serviceman/dashboard';
  static const String bookingDetailsUrl = '/api/v1/serviceman/booking/detail';
  static const String statusUpdateUrl = '/api/v1/serviceman/booking/status-update';
  static const String paymentStatusUpdate = '/api/v1/serviceman/booking/payment-status-update';
  static const String serviceListBasedOnSubCategory = '/api/v1/serviceman/service/data/sub-category-wise';
  static const String bookingOTPNotificationUri = '/api/v1/serviceman/booking/opt/notification-send';
  static const String getBookingPriceList = '/api/v1/serviceman/booking/service/info';
  static const String removeCartServiceFromServer = '/api/v1/serviceman/booking/service/edit/remove-service';
  static const String updateBooking = '/api/v1/serviceman/booking/service/edit/update-booking';
  static const String customerProfileImagePath = '/user/profile_image/';
  static const String providerProfileImagePath = '/provider/logo/';


  static const double maxSizeOfASingleFile = 10;
  static const double maxLimitOfTotalFileSent = 5;
  static const double maxLimitOfFileSentINConversation = 25;

  static const List<String> videoExtensions = [
    'mp4', 'mkv', 'avi', 'mov', 'wmv', 'flv', 'webm', 'mpeg', 'mpg', 'm4v', '3gp', 'ogv'
  ];

  static const List<String> imageExtensions = [
    'jpg', 'jpeg', 'jpe', 'jif', 'jfif', 'jfi', 'png', 'gif', 'webp', 'tiff', 'tif', 'bmp', 'svg',
  ];

  static const List<String> documentExtensions = [
    'doc', 'docx', 'txt', 'csv', 'xls', 'xlsx', 'rar', 'tar', 'targz', 'zip', 'pdf',
  ];

}



