import 'dart:convert';

class UserInfoModel {
  int? id;
  String? name;
  String? method;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  double? walletBalance;
  double? loyaltyPoint;
  String? referCode;
  int? referCount;
  double? totalOrder;
  String? seeqty;
  String? seeorder;
  String? seeprice;
  String? seepackage;
  String? seetransactions;
  String? seeservice;
  //int? authlevel;
  List<int>? userauthlevel;
  //List<int>? userseeproducts;
  String? userType;
  String? userServiceName;
  String? searchByLocation;
  String? expandservices;


  UserInfoModel(
      {this.id,
        this.name,
        this.method,
        this.fName,
        this.lName,
        this.phone,
        this.image,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.walletBalance,
        this.loyaltyPoint,
        this.referCode,
        this.referCount,
        this.totalOrder,
        this.seeqty,
        this.seeorder,
        this.seeprice,
        this.userType,
        this.seepackage,
        this.seetransactions,
        this.userauthlevel,
        this.seeservice,
        this.userServiceName,
        this.searchByLocation,
        this.expandservices,
       // this.userseeproducts

      });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    method = json['_method'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
    seeqty = json['see_qty'];
    seeorder = json['see_order'];
    seeprice = json['see_price'];
    userType = json['user_type'];
    expandservices = json['expand_services'];
    userServiceName= json['user_service_name'];
    seepackage = json['see_package'];
    seeservice = json['see_service'];
    seetransactions = json['see_transactions'];
    searchByLocation = json['search_by_location'];
    if(json['auth_level'] != null){
      try{
        userauthlevel = json['auth_level'] != null ? json['auth_level'].cast<int>() : [];
      }catch(e){
        userauthlevel = json['auth_level'] != null ? jsonDecode(json['auth_level']).cast<int>() : [];
      }
    }
 /*   if(json['see_products'] != null){
      try{
        userseeproducts = json['see_products'] != null ? json['see_products'].cast<int>() : [];
      }catch(e){
        userseeproducts = json['see_products'] != null ? jsonDecode(json['see_products']).cast<int>() : [];
      }
    }*/
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if(json['wallet_balance'] != null){
      walletBalance = json['wallet_balance'].toDouble();
    }
    if(json['loyalty_point'] != null){
      loyaltyPoint = json['loyalty_point'].toDouble();
    }else{
      loyaltyPoint = 0.0;
    }
    if(json['referral_code'] != null){
      referCode = json['referral_code'];
    }
    if(json['referral_user_count'] != null){
      try{
        referCount = json['referral_user_count'];
      }catch(e){
        referCount = int.parse(json['referral_user_count'].toString());
      }

    }
    if(json['orders_count'] != null){
      try{
        totalOrder = json['orders_count'].toDouble();
      }catch(e){
        totalOrder = double.parse(json['orders_count'].toString());
      }

    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['_method'] = method;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['image'] = image;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['wallet_balance'] = walletBalance;
    data['loyalty_point'] = loyaltyPoint;
    data['see_qty'] = seeqty;
    data['see_order'] = seeorder;
    data['see_price'] = seeprice;
    data['user_type'] = userType;
    data['user_service_name'] = userServiceName;
    data['see_package'] = seepackage;
    data['see_transactions'] = seetransactions;
    data['search_by_location'] = searchByLocation;
    data['auth_level'] = userauthlevel;
    data['expand_services'] = expandservices;
    //data['see_products'] = userseeproducts;
    return data;
  }
}
