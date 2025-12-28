import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spareparts_store/features/banner/controllers/banner_controller.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/provider/dashboard_provider.dart';
import 'package:flutter_spareparts_store/features/dashboard/dashboard_screen.dart';
import 'package:flutter_spareparts_store/features/lines/provider/lines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/order/view/order_details_screen.dart';
import 'package:flutter_spareparts_store/features/sale/view/sale_details_screen.dart';
import 'package:flutter_spareparts_store/push_notification/model/notification_body.dart';
import 'package:flutter_spareparts_store/features/product/provider/home_category_product_provider.dart';
import 'package:flutter_spareparts_store/features/shop/provider/top_seller_provider.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/brand/controllers/brand_controller.dart';
import 'package:flutter_spareparts_store/features/category/controllers/category_controller.dart';
import 'package:flutter_spareparts_store/features/chat/provider/chat_provider.dart';
import 'package:flutter_spareparts_store/localization/provider/localization_provider.dart';
import 'package:flutter_spareparts_store/features/notification/provider/notification_provider.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/features/package/provider/package_provider.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/product/provider/search_provider.dart';
import 'package:flutter_spareparts_store/features/shop/provider/shop_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/push_notification/notification_helper.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/features/wishlist/provider/wishlist_provider.dart';
import 'package:flutter_spareparts_store/theme/dark_theme.dart';
import 'package:flutter_spareparts_store/theme/light_theme.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'package:flutter_spareparts_store/features/splash/view/splash_screen.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;
import 'helper/custom_delegate.dart';
import 'localization/app_localization.dart';
import 'features/product/provider/product_details_provider.dart';
import 'features/product/provider/product_provider.dart';
import 'package:receive_intent/receive_intent.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();




Future<void> main() async {


  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();


  ///await Firebase.initializeApp();
  if(Firebase.apps.isEmpty) {
    if(Platform.isAndroid) {
      try{
        ///todo you need to configure that firebase Option with your own firebase to run your app
        await Firebase.initializeApp(options: const FirebaseOptions(
            apiKey: "AIzaSyDxtyjvbrSojsujYRgNcUFwFdUFpGxwK8o",
            projectId: "1:53499485752:android:58702b5c27e928b6ced0cd",
            messagingSenderId: "53499485752",
            appId: "e-store-be1b9"
        ));
      }finally{
        await Firebase.initializeApp();
      }
    }else{
      await Firebase.initializeApp();
    }
  }
  await FlutterDownloader.initialize(debug: true , ignoreSsl: true);
  await di.init();




  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.pendingNotificationRequests();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  FlutterNativeSplash.remove();

  NotificationBody? body;
  try {
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        body = NotificationHelper.convertNotification(remoteMessage.data);
      }
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  }catch(_) {}



    await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);




  runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CategoryController>()),
      ChangeNotifierProvider(create: (context) => di.sl<HomeCategoryProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<TopSellerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BrandController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BannerController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductDetailsProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthController>()),
      ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SellerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SaleProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LinesProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<MachinesProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<PackageProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<WishListProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<DashboardProvider>()),

    ],
    child: MyApp(body: body),
  ));
}

class MyApp extends StatelessWidget {
  final NotificationBody? body;
  const MyApp({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in AppConstants.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    return MaterialApp(
      title: AppConstants.appName,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackLocalizationDelegate()
      ],
      builder:(context,child){
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling), child: child!);
      },
      supportedLocales: locals,
      home: SplashScreen(body: body,),

    );
  }
}

class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}


