import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/features/notification/domain/model/notification_model.dart';
import 'package:flutter_spareparts_store/features/notification/domain/repo/notification_repo.dart';
import 'package:flutter_spareparts_store/helper/api_checker.dart';
import 'package:provider/provider.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepo? notificationRepo;

  NotificationProvider({required this.notificationRepo});

  NotificationItemModel? notificationModel;

  String? notificationType ;

  Future<void> getNotificationList(int offset, String type) async {
    if(offset == 1){
      notificationModel = null;
    }
    ApiResponse apiResponse = await notificationRepo!.getNotificationList(offset,type);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        notificationModel = NotificationItemModel.fromJson(apiResponse.response?.data);
      }else{
        notificationModel?.notification?.addAll(NotificationItemModel.fromJson(apiResponse.response?.data).notification!);
        notificationModel?.offset = NotificationItemModel.fromJson(apiResponse.response?.data).offset!;
        notificationModel?.totalSize = NotificationItemModel.fromJson(apiResponse.response?.data).totalSize!;
      }

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }
  Future<void> seenNotification(int id) async {
    ApiResponse apiResponse = await notificationRepo!.seenNotification(id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
     //getNotificationList(1,'unread');
      getNotificationList(1,notificationType!);


    }
    notifyListeners();
  }
}
