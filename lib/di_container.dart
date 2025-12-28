import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spareparts_store/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_spareparts_store/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_spareparts_store/features/banner/controllers/banner_controller.dart';
import 'package:flutter_spareparts_store/features/banner/domain/repositories/banner_repository.dart';
import 'package:flutter_spareparts_store/features/brand/domain/repositories/brand_repository.dart';
import 'package:flutter_spareparts_store/features/category/domain/repo/category_repo.dart';
import 'package:flutter_spareparts_store/features/chat/domain/repo/chat_repo.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/domain/repo/dashboard_repo.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/provider/dashboard_provider.dart';
import 'package:flutter_spareparts_store/features/lines/domain/repo/lines_repo.dart';
import 'package:flutter_spareparts_store/features/lines/provider/lines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/domain/repo/machines_repo.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/notification/domain/repo/notification_repo.dart';
import 'package:flutter_spareparts_store/features/product/domain/repo/product_details_repo.dart';
import 'package:flutter_spareparts_store/features/order/domain/repo/order_repo.dart';
import 'package:flutter_spareparts_store/features/package/domain/repo/package_repo.dart';
import 'package:flutter_spareparts_store/features/product/domain/repo/product_repo.dart';
import 'package:flutter_spareparts_store/features/profile/domain/repo/profile_repo.dart';
import 'package:flutter_spareparts_store/features/product/domain/repo/home_category_product_repo.dart';
import 'package:flutter_spareparts_store/features/product/domain/repo/search_repo.dart';
import 'package:flutter_spareparts_store/features/shop/domain/repo/shop_repo.dart';
import 'package:flutter_spareparts_store/features/shop/domain/repo/top_seller_repo.dart';
import 'package:flutter_spareparts_store/features/splash/domain/repo/splash_repo.dart';
import 'package:flutter_spareparts_store/features/wishlist/domain/repo/wishlist_repo.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/brand/controllers/brand_controller.dart';
import 'package:flutter_spareparts_store/features/category/controllers/category_controller.dart';
import 'package:flutter_spareparts_store/features/chat/provider/chat_provider.dart';
import 'package:flutter_spareparts_store/features/product/provider/home_category_product_provider.dart';
import 'package:flutter_spareparts_store/localization/provider/localization_provider.dart';
import 'package:flutter_spareparts_store/features/notification/provider/notification_provider.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/features/package/provider/package_provider.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_provider.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/product/provider/search_provider.dart';
import 'package:flutter_spareparts_store/features/shop/provider/shop_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/features/shop/provider/top_seller_provider.dart';
import 'package:flutter_spareparts_store/features/wishlist/provider/wishlist_provider.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'features/sale/domain/repo/sale_repo.dart';
import 'package:flutter_spareparts_store/helper/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(AppConstants.baseUrl, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository // Reports
  sl.registerLazySingleton(() => ProfileRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => CategoryRepository(dioClient: sl()));
  sl.registerLazySingleton(() => HomeCategoryProductRepo(dioClient: sl()));
  sl.registerLazySingleton(() => TopSellerRepo(dioClient: sl()));
  sl.registerLazySingleton(() => BrandRepository(dioClient: sl()));
  sl.registerLazySingleton(() => ProductRepo(dioClient: sl()));
  sl.registerLazySingleton(() => BannerRepository(dioClient: sl()));
  sl.registerLazySingleton(() => AuthRepository(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ProductDetailsRepo(dioClient: sl()));
  sl.registerLazySingleton(() => SearchRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => OrderRepo(dioClient: sl()));
  sl.registerLazySingleton(() => SaleRepo(dioClient: sl()));
  sl.registerLazySingleton(() => LinesRepo(dioClient: sl()));
  sl.registerLazySingleton(() => MachinesRepo(dioClient: sl()));
  sl.registerLazySingleton(() => PackageRepo(dioClient: sl()));
  sl.registerLazySingleton(() => SellerRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ChatRepo(dioClient: sl()));
  sl.registerLazySingleton(() => NotificationRepo(dioClient: sl()));
  sl.registerLazySingleton(() => WishListRepo(dioClient: sl()));
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => DashboardRepo(dioClient: sl()));


  // Provider
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => CategoryController(categoryRepo: sl()));
  sl.registerFactory(() => HomeCategoryProductProvider(homeCategoryProductRepo: sl()));
  sl.registerFactory(() => TopSellerProvider(topSellerRepo: sl()));
  sl.registerFactory(() => BrandController(brandRepo: sl()));
  sl.registerFactory(() => ProductProvider(productRepo: sl()));
  sl.registerFactory(() => BannerController(bannerRepo: sl()));
  sl.registerFactory(() => AuthController(authRepo: sl()));
  sl.registerFactory(() => ProductDetailsProvider(productDetailsRepo: sl()));
  sl.registerFactory(() => SearchProvider(searchRepo: sl()));
  sl.registerFactory(() => OrderProvider(orderRepo: sl()));
  sl.registerFactory(() => SaleProvider(saleRepo: sl()));
  sl.registerFactory(() => LinesProvider(linesRepo: sl()));
  sl.registerFactory(() => MachinesProvider(machinesRepo: sl()));
  sl.registerFactory(() => PackageProvider(packageRepo: sl()));
  sl.registerFactory(() => SellerProvider(sellerRepo: sl()));
  sl.registerFactory(() => ChatProvider(chatRepo: sl()));
  sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));
  sl.registerFactory(() => WishListProvider(wishListRepo: sl(), productDetailsRepo: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl(), dioClient: sl()));
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => DashboardProvider(dashboardRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());



/*
  //Serviceman Repository
  Get.lazyPut(()=> AuthController(authRepo: sl()));
  Get.lazyPut(()=> SplashProvider(splashRepo: sl()));
  Get.lazyPut(()=> AuthRepository(dioClient: sl(), sharedPreferences: sl()));
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));
  Get.lazyPut(() => BookingListController(bookingListRepo: BookingListRepo(apiClient: Get.find())));
  Get.lazyPut(() => DashboardController(dashboardRepository: DashboardRepository(apiClient: Get.find())));
  Get.lazyPut(() => HtmlViewController(htmlRepository: HtmlRepository(apiClient: Get.find())));
  Get.lazyPut(() => BookingHistoryController(bookingHistoryRepo: BookingHistoryRepo(apiClient: Get.find())));

  // service Man
  sl.registerLazySingleton(() => BookingListRepo(apiClient: sl()));
  sl.registerFactory(() => BookingListController(bookingListRepo: sl()));*/

}
