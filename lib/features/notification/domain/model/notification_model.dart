import 'package:flutter_spareparts_store/features/sale/domain/model/sale_model.dart';

class NotificationItemModel {
  int? totalSize;
  int? limit;
  int? offset;
  int? newNotificationItem;
  int? newNotificationServiceItem;
  List<NotificationItem>? notification;

  NotificationItemModel(
      {this.totalSize,
        this.limit,
        this.offset,
        this.newNotificationItem,
        this.newNotificationServiceItem,
        this.notification});

  NotificationItemModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    newNotificationItem = json['new_notification'];
    newNotificationServiceItem = json['new_notification_service'];
    if (json['notification'] != null) {
      notification = <NotificationItem>[];
      json['notification'].forEach((v) {
        notification!.add(NotificationItem.fromJson(v));
      });
    }
  }


}

class NotificationItem {
  int? id;
  String? sentBy;
  String? sentTo;
  String? title;
  String? description;
  int? notificationCount;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? sourceId;
  String? notificationType;
  int? seen;
  String? userImage;
  Sales? service;



  NotificationItem(
      {this.id,
        this.sentBy,
        this.sentTo,
        this.title,
        this.description,
        this.notificationCount,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.sourceId,
        this.notificationType,
        this.seen,
        this.userImage,
        this.service,
      });

  NotificationItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sentBy = json['sent_by'];
    sentTo = json['sent_to'];
    title = json['title'];
    description = json['description'];
    notificationCount = int.parse(json['notification_count'].toString());
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sourceId = json['source_id'];
    notificationType = json['notification_type'];
    seen = json['notification_seen_by'];
    userImage = json['user_image'];
    service = json['service'] != null ? Sales.fromJson(json['service']) : null;

  }
}
