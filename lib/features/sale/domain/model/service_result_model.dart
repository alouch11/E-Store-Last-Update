class ServiceResultModel {
  double? productPrice;
  int? quantity;
  double? productTotalDiscount;
  double? productTotalTax;
  double? subtotal;
  double? couponDiscount;
  double? serviceAmount;
  List<ServiceRequest>? serviceRequest;

  ServiceResultModel(
      {this.productPrice,
        this.quantity,
        this.productTotalDiscount,
        this.productTotalTax,
        this.subtotal,
        this.couponDiscount,
        this.serviceAmount,
        this.serviceRequest});

  ServiceResultModel.fromJson(Map<String, dynamic> json) {
    productPrice = json['product_price'].toDouble();
    quantity = json['service'];
    productTotalDiscount = json['product_total_discount'].toDouble();
    productTotalTax = json['product_total_tax'].toDouble();
    subtotal = json['subtotal'].toDouble();
    couponDiscount = json['coupon_discount'].toDouble();
    serviceAmount = json['refund_amount'].toDouble();
    if (json['refund_request'] != null) {
      serviceRequest = <ServiceRequest>[];
      json['refund_request'].forEach((v) {
        serviceRequest!.add(ServiceRequest.fromJson(v));
      });
    }
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
    if (serviceRequest != null) {
      data['refund_request'] =
          serviceRequest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceRequest {
  int? id;
  int? saleDetailsId;
  int? customerId;
  String? status;
  double? amount;
  int? productId;
  int? saleId;
  String? serviceReason;
  List<String>? images;
  String? startDateTime;
  String? endDateTime;
  String? approvedNote;
  String? rejectedNote;
  String? paymentInfo;
  String? changeBy;


  ServiceRequest(
      {this.id,
        this.saleDetailsId,
        this.customerId,
        this.status,
        this.amount,
        this.productId,
        this.saleId,
        this.serviceReason,
        this.images,
        this.startDateTime,
        this.endDateTime,
        this.approvedNote,
        this.rejectedNote,
        this.paymentInfo,
        this.changeBy});

  ServiceRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saleDetailsId = json['sale_details_id'];
    customerId = json['customer_id'];
    status = json['status'];
    amount = json['amount'].toDouble();
    productId = json['product_id'];
    saleId = json['sale_id'];
    serviceReason = json['refund_reason'];
    if(json['images'] != null){
      images = json['images'].cast<String>();
    }

    startDateTime = json['start_date_time'];
    endDateTime = json['end_date_time'];
    approvedNote = json['approved_note'];
    rejectedNote = json['rejected_note'];
    paymentInfo = json['payment_info'];
    changeBy = json['change_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sale_details_id'] = saleDetailsId;
    data['customer_id'] = customerId;
    data['status'] = status;
    data['amount'] = amount;
    data['product_id'] = productId;
    data['sale_id'] = saleId;
    data['refund_reason'] = serviceReason;
    data['images'] = images;
    data['start_date_time'] = startDateTime;
    data['end_date_time'] = endDateTime;
    data['approved_note'] = approvedNote;
    data['rejected_note'] = rejectedNote;
    data['payment_info'] = paymentInfo;
    data['change_by'] = changeBy;
    return data;
  }
}
