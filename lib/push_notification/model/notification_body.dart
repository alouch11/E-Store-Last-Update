

class NotificationBody {
  int? orderId;
  int? saleId;
  String? type;


  NotificationBody({
    this.orderId,
    this.saleId,
    this.type,
  });

  NotificationBody.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    saleId = json['sale_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['sale_id'] = saleId;
    data['type'] = type;
    return data;
  }


}
