import 'package:flutter_spareparts_store/features/chat/domain/model/chat_model.dart';
import 'package:flutter_spareparts_store/features/profile/domain/model/user_info_model.dart';

class MessageModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<Message>? message;

  MessageModel({this.totalSize, this.limit, this.offset, this.message});

  MessageModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(Message.fromJson(v));
      });
    }
  }

}

class Message {
  int? id;
  String? message;
  bool? sentByCustomer;
  bool? sentBySeller;
  bool? sentByAdmin;
  bool? seenByDeliveryMan;
  String? createdAt;
  DeliveryMan? deliveryMan;
  UserInfoModel? user;
  SellerInfo? sellerInfo;
  //List<String>? attachment;
  int? userId;
  int? userId2;
  List<Attachment>? attachment;

  Message(
      {this.id,
        this.message,
        this.sentByCustomer,
        this.sentBySeller,
        this.sentByAdmin,
        this.seenByDeliveryMan,
        this.createdAt,
        this.deliveryMan,
        this.user,
        this.sellerInfo,
        this.attachment,
        this.userId,
        this.userId2,
      });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    sentByCustomer = json['sent_by_customer'];
    sentBySeller = json['sent_by_seller'];
    sentByAdmin = json['sent_by_admin'];
    if(json['seen_by_delivery_man'] != null){
      seenByDeliveryMan = json['seen_by_delivery_man']??false;
    }

    createdAt = json['created_at'];
    deliveryMan = json['delivery_man'] != null ? DeliveryMan.fromJson(json['delivery_man']) : null;
    user = json['user'] != null ? UserInfoModel.fromJson(json['user']) : null;
    sellerInfo = json['seller_info'] != null ? SellerInfo.fromJson(json['seller_info']) : null;
   /* if(json['attachment'] != null && json['attachment'] != "[]"){
      attachment = json['attachment'].cast<String>();
    }else{
      attachment = [];
    }*/
    userId = json['user_id'];
    userId2 = json['user_id_2'];
    if (json['attachment'] != null) {
      attachment = <Attachment>[];
      json['attachment'].forEach((v) {
        attachment!.add(Attachment.fromJson(v));
      });
    }
  }

}

class Attachment {
  String? filename;
  String? type;
  String? key;
  //String? path;
  String? size;

  Attachment({this.filename,
    this.type,
    this.key,
    //this.path,
    this.size});

  Attachment.fromJson(Map<String, dynamic> json) {
    filename = json['file_name'];
    type = json['type'];
    key = json['key'];
   // path = json['path'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_name'] = filename;
    data['type'] = type;
    data['key'] = key;
    //data['path'] = path;
    data['size'] = size;
    return data;
  }
}


