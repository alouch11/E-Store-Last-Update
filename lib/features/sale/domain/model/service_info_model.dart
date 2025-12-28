class ServiceInfoModel {
  bool? alreadyServiced;
  bool? expired;
  Service? service;

  ServiceInfoModel({this.alreadyServiced, this.expired, this.service});

  ServiceInfoModel.fromJson(Map<String, dynamic> json) {
    alreadyServiced = json['already_serviced'];
    expired = json['expired'];
    service = json['sales'] != null ? Service.fromJson(json['sales']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['already_serviced'] = alreadyServiced;
    data['expired'] = expired;
    if (service != null) {
      data['sales'] = service!.toJson();
    }
    return data;
  }
}

class Service {
  double? productPrice;
  int? quantity;
  double? productTotalDiscount;
  double? productTotalTax;
  double? subtotal;
  double? couponDiscount;
  double? serviceAmount;
  String? startDateTime;
  String? endDateTime;

  Service(
      {this.productPrice,
        this.quantity,
        this.productTotalDiscount,
        this.productTotalTax,
        this.subtotal,
        this.couponDiscount,
        this.serviceAmount,
        this.startDateTime,
        this.endDateTime,
      });

  Service.fromJson(Map<String, dynamic> json) {
    productPrice = json['product_price'].toDouble();
    quantity = json['quntity'];
    productTotalDiscount = json['product_total_discount'].toDouble();
    productTotalTax = json['product_total_tax'].toDouble();
    subtotal = json['subtotal'].toDouble();
    couponDiscount = json['coupon_discount'].toDouble();
    serviceAmount = json['refund_amount'].toDouble();
    startDateTime = json['start_date_time'];
    endDateTime = json['end_date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_price'] = productPrice;
    data['quntity'] = quantity;
    data['product_total_discount'] = productTotalDiscount;
    data['product_total_tax'] = productTotalTax;
    data['subtotal'] = subtotal;
    data['coupon_discount'] = couponDiscount;
    data['refund_amount'] = serviceAmount;
    data['start_date_time'] = startDateTime;
    data['end_date_time'] = endDateTime;
    return data;
  }
}
