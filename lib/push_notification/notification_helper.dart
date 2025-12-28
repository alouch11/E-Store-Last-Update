import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spareparts_store/features/home/view/home_screens.dart';
import 'package:flutter_spareparts_store/features/home/widget/notifications_widget_home_page.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/push_notification/model/notification_body.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'package:flutter_spareparts_store/features/notification/view/notification_screen.dart';
import 'package:flutter_spareparts_store/features/order/view/order_details_screen.dart';
import 'package:flutter_spareparts_store/features/sale/view/sale_details_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../features/notification/view/notifications_tab_screen.dart';
import 'package:flutter_spareparts_store/features/dashboard/dashboard_screen.dart';
import 'package:flutter_spareparts_store/features/chat/view/inbox_screen.dart';

class NotificationHelper {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings, onDidReceiveNotificationResponse: (NotificationResponse load) async {
      try{
        log("tyyuuyypee88=11=>$load");
        log("==Payload=11=>${load.payload}");
        NotificationBody payload;
        if(load.payload!.isNotEmpty) {
          payload = NotificationBody.fromJson(jsonDecode(load.payload!));
          if(payload.type == 'order') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  OrderDetailsScreen(orderId: payload.orderId, isNotification: true,)));
          }
          else if(payload.type == 'sale') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  SaleDetailsScreen(saleId: payload.saleId, isNotification: true,)));

          }
          else if(payload.type == 'notification') {
            //Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const NotificationScreen(fromNotification: true,)));
            //Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const NotificationsTabsScreen()));
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const NotificationsWidgetHomePage()));

          }
          else if(payload.type  == 'chatting') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const InboxScreen(isBackButtonExist: true,)));

          }
          else{
           // Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const InboxScreen(isBackButtonExist: true,)));
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>   const HomePage()));

          }
        }
      }catch (_) {}
      return;
    });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
        print("onMessage type: ${message.data['type']}/${message.data}");
      }
      NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);

       try{
         if(message.data.isNotEmpty) {
           NotificationBody notificationBody = convertNotification(message.data);
           if(notificationBody.type == 'order') {
             Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  OrderDetailsScreen(orderId: notificationBody.orderId, isNotification: true,)));

           }
           else if(notificationBody.type == 'sale') {
             Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  SaleDetailsScreen(saleId: notificationBody.saleId, isNotification: true,)));

           }
           else if(notificationBody.type == 'notification') {
             Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const NotificationScreen()));
           }
           else if(notificationBody.type == 'chatting') {
             Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const InboxScreen(isBackButtonExist: true,)));

           }
           else{
             //Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const InboxScreen(isBackButtonExist: true,)));
             Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const HomePage()));

           }
          }
       }catch (_) {}

    });

   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      }
      try{
        if(message.data.isNotEmpty) {
          NotificationBody notificationBody = convertNotification(message.data);
          if(notificationBody.type == 'order') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  OrderDetailsScreen(orderId: notificationBody.orderId, isNotification: true,)));
           }
          else if (notificationBody.type == 'sale') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  SaleDetailsScreen(saleId: notificationBody.saleId,isNotification: true,)));
          }
          else if(notificationBody.type == 'notification') {
            //Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const NotificationScreen()));
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const NotificationsTabsScreen()));

          }
          else if(notificationBody.type == 'chatting') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const InboxScreen(isBackButtonExist: true,)));

          } else{
            //Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const InboxScreen(isBackButtonExist: true,)));
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>   const HomePage()));
           // Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const NotificationsTabsScreen()));

          }
        }
      }catch (_) {}
    });
  }

  static Future<void> showNotification(RemoteMessage message, FlutterLocalNotificationsPlugin fln, bool data) async {
    if(!Platform.isIOS) {
      String? title;
      String? body;
      String? orderID;
      String? saleID;
      String? image;
      NotificationBody notificationBody = convertNotification(message.data);
      if(data) {
        title = message.data['title'];
        body = message.data['body'];
        orderID = message.data['order_id'];
        saleID = message.data['sale_id'];
        image = (message.data['image'] != null && message.data['image'].isNotEmpty)
            ? message.data['image'].startsWith('http') ? message.data['image']
            : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}' : null;
      }else {
        title = message.notification!.title;
        body = message.notification!.body;
        orderID = message.notification!.titleLocKey;
        saleID = message.notification!.titleLocKey;
        if(Platform.isAndroid) {
          image = (message.notification!.android!.imageUrl != null && message.notification!.android!.imageUrl!.isNotEmpty)
              ? message.notification!.android!.imageUrl!.startsWith('http') ? message.notification!.android!.imageUrl
              : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.android!.imageUrl}' : null;
        }else if(Platform.isIOS) {
          image = (message.notification!.apple!.imageUrl != null && message.notification!.apple!.imageUrl!.isNotEmpty)
              ? message.notification!.apple!.imageUrl!.startsWith('http') ? message.notification!.apple!.imageUrl
              : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.apple!.imageUrl}' : null;
        }
      }

      if(image != null && image.isNotEmpty) {
        try{
          await showBigPictureNotificationHiddenLargeIcon(title, body, orderID,saleID, notificationBody, image, fln);
        }catch(e) {
          await showBigTextNotification(title, body!, orderID, saleID,notificationBody, fln);
        }
      }else {
        await showBigTextNotification(title, body!, orderID,saleID, notificationBody, fln);
      }
    }
  }

  static Future<void> showTextNotification(String title, String body, String orderID,String saleID, NotificationBody? notificationBody, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'E-Store', 'E-Store', playSound: true,
      importance: Importance.max, priority: Priority.max, sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static Future<void> showBigTextNotification(String? title, String body, String? orderID,String? saleID, NotificationBody? notificationBody, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body, htmlFormatBigText: true,
      contentTitle: title, htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'E-Store', 'E-Store', importance: Importance.max,
      styleInformation: bigTextStyleInformation, priority: Priority.max, playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(String? title, String? body, String? orderID, String? saleID, NotificationBody? notificationBody, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
      contentTitle: title, htmlFormatContentTitle: true,
      summaryText: body, htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'E-Store', 'E-Store',
      largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.max, playSound: true,
      styleInformation: bigPictureStyleInformation, importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static NotificationBody convertNotification(Map<String, dynamic> data){
    if(data['type'] == 'notification') {
      return NotificationBody(type: 'notification');
    }else if(data['type'] == 'order') {
      return NotificationBody(type: 'order', orderId: int.parse(data['order_id']));
    }else if(data['type'] == 'sale') {
      return NotificationBody(type: 'sale', saleId: int.parse(data['sale_id']));
    }
    else {
      return NotificationBody(type: 'chatting');
    }
  }

}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  }
 /* var androidInitialize = new AndroidInitializationSettings('notification_icon');

   //var iOSInitialize = new IOSInitializationSettings();
     var iOSInitialize = new DarwinInitializationSettings();

  var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      //onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {}
  );

   var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
   flutterLocalNotificationsPlugin.initialize(initializationsSettings);
   NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);*/

}