
import '../../../shop/domain/model/seller_model.dart';

class OrderModel {
  int? totalSize;
  int? totalPending;
  int? totalSigned;
  int? totalApproved;
  int? totalDelivered;
  int? totalPartiallyDelivered;
  int? totalCanceled;
  int? totalOrders;
  ///Local Order
  int? totalLPending;
  int? totalLSigned;
  int? totalLApproved;
  int? totalLDelivered;
  int? totalLPartiallyDelivered;
  int? totalLCanceled;
  int? totalLOrders;

  String? limit;
  String? offset;
  List<Orders>? orders;

  OrderModel({this.totalSize, this.limit, this.offset, this.orders});

  OrderModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    totalPending = json['total_pending'];
    totalSigned = json['total_signed'];
    totalApproved = json['total_approved'];
    totalDelivered = json['total_delivered'];
    totalPartiallyDelivered = json['total_partially_delivered'];
    totalCanceled = json['total_canceled'];
    totalOrders = json['total_orders'];
    ///Local Order
    totalLPending = json['total_lpending'];
    totalLSigned = json['total_lsigned'];
    totalLApproved = json['total_lapproved'];
    totalLDelivered = json['total_ldelivered'];
    totalLPartiallyDelivered = json['total_lpartially_delivered'];
    totalLCanceled = json['total_lcanceled'];
    totalLOrders = json['total_lorders'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

}

class Orders {
  int? id;
  int? customerId;
  String? orderStatus;
  String? orderMachine;
  double? orderAmount;
  String? createdAt;
  String? updatedAt;
  double? shippingCost;
  int? sellerId;
  String? orderNote;
  String? orderType;
  String? orderPerson;
  String? orderVendorNumber;
  String? orderVendorName;
  String? orderVendorPhone;
  String? orderVendorAddress;
  String? orderVendorCountry;
  String? orderVendorContactPerson;
  String? orderNumber;
  String? accDocNumber;
  String? accDate;
  int? orderDetailsCount;
  List<Details>? details;
  Seller? seller;
  String? saleNumber;
  String? department ;
  String? machine ;
  String? createdBy ;
  OrderDelivery? orderDelivery;


  Orders(
      {this.id,
        this.customerId,
        this.orderStatus,
        this.orderMachine,
        this.orderAmount,
        this.createdAt,
        this.updatedAt,
        this.shippingCost,
        this.sellerId,
        this.orderNote,
        this.orderType,
        this.orderPerson,
        this.orderVendorNumber,
        this.orderVendorName,
        this.orderVendorPhone,
        this.orderVendorContactPerson,
        this.orderVendorAddress,
        this.orderVendorCountry,
        this.orderNumber,
        this.accDocNumber,
        this.accDate,
        this.orderDetailsCount,
        this.details,
        this.seller,
        this.saleNumber,
        this.department ,
        this.machine ,
        this.createdBy,
        this.orderDelivery,
       });

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['BLKODU'];
    customerId = json['BLCRKODU'];
    orderStatus = json['SIPARIS_DURUMU'].toString();

    if(json['TOPLAM_GENEL_DVZ'] != null) {
      orderAmount = json['TOPLAM_GENEL_DVZ'].toDouble();
    }
    else{
      orderAmount = 0;
    }
    createdAt = json['TARIHI'];
    updatedAt = json['VADESI'];
    if(json['TOPLAM_KDV_DVZ'] != null) {
      shippingCost = json['TOPLAM_KDV_DVZ'].toDouble();
    }
    else{
      shippingCost = 0;
    }
    sellerId = json['BLCRKODU'];
    orderNote = json['ACIKLAMA_2'];
    orderType = json['OZELALANTANIM_17'];
    orderNumber = json['SIPARIS_NO'];
    accDocNumber = json['MUH_EVRAK_NO'];
    accDate = json['MUH_EVRAK_TARIHI'];
    if(json['order_details_count'] != null){
      orderDetailsCount = int.parse(json['order_details_count'].toString());
    }else{
      orderDetailsCount = 0;
    }

    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;

    orderNumber = json['SIPARIS_NO'];
    department = json['OZELALANTANIM_20'];
    machine = json['OZELALANTANIM_29'];
    orderMachine = json['OZELALANTANIM_29'];
    orderPerson= json['OZELALANTANIM_19'];
    orderVendorNumber= json['OZELALANTANIM_18'];
    orderVendorName= json['TICARI_UNVANI'];
    orderVendorContactPerson= json['TICARI_UNVANI'];
    orderVendorAddress= json['ADRESI'];
    orderVendorPhone= json['TEL1'];
    orderVendorCountry= json['ULKESI'];
    orderVendorContactPerson= json['ADI_SOYADI'];
    createdBy= json['KAYDEDEN'];

    orderDelivery = json['orderdelivery'] != null ? OrderDelivery.fromJson(json['orderdelivery']) : null;

  }

}


class Details {
  Product? product;

  Details(
      {this.product});

  Details.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

}

class Product {
  String? thumbnail;
  String? productType;


  Product(
      {this.thumbnail, this.productType});

  Product.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    productType = json['product_type'];

  }


}

class OrderDelivery {
  int? orderId;
  int? deliverId;
  Delivery? delivery;

  OrderDelivery(
      {this.orderId, this.deliverId,this.delivery});

  OrderDelivery.fromJson(Map<String, dynamic> json) {
    orderId = json['BLDMKODU'];
    deliverId = json['BLIRKODU'];
    delivery = json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null;

  }
}


class Delivery {
  int? id;
  String? createdBy;
  String? modifiedBy;

  Delivery(
      {this.id, this.createdBy, this.modifiedBy});

  Delivery.fromJson(Map<String, dynamic> json) {
    id = json['BLKODU'];
    createdBy = json['KAYDEDEN'];
    modifiedBy = json['DEGISTIREN'];

  }
}