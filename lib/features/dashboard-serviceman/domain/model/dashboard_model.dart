class DashboardModel {
  String? responseCode;
  String? message;
  List<Content>? content;


  DashboardModel({this.responseCode, this.message, this.content});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(Content.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Content {
  TopCards? topCards;
  List<StatsMonthly>? serviceStats;
  List<DashboardService>? services;

  Content({this.topCards, this.serviceStats, this.services});

  Content.fromJson(Map<String, dynamic> json) {
    topCards = json['top_cards'] != null
        ? TopCards.fromJson(json['top_cards'])
        : null;
    if (json['service_stats'] != null) {
      serviceStats = <StatsMonthly>[];
      json['service_stats'].forEach((v) {
        serviceStats!.add(StatsMonthly.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <DashboardService>[];
      json['services'].forEach((v) {
        services!.add(DashboardService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topCards != null) {
      data['top_cards'] = topCards!.toJson();
    }
    if (serviceStats != null) {
      data['service_stats'] =
          serviceStats!.map((v) => v.toJson()).toList();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopCards {
  int? pendingServices;
  int? ongoingServices;
  int? completedServices;
  int? canceledServices;

  TopCards(
      {this.pendingServices,
        this.ongoingServices,
        this.completedServices,
        this.canceledServices});

  TopCards.fromJson(Map<String, dynamic> json) {
    pendingServices = int.parse(json['total_services'].toString());
    ongoingServices = int.parse(json['ongoing_services'].toString());
    completedServices = int.parse(json['completed_services'].toString());
    canceledServices = int.parse(json['canceled_services'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pending_services'] = pendingServices;
    data['ongoing_services'] = ongoingServices;
    data['completed_services'] = completedServices;
    data['canceled_services'] = canceledServices;
    return data;
  }
}

///Mothly Stats
class StatsMonthly{
  int? total;
  int? year;
  String? month;
  int? day;

  StatsMonthly({this.total, this.year, this.month, this.day});

  StatsMonthly.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    year = json['year'];
    month = json['month'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['year'] = year;
    data['month'] = month;
    data['day'] = day;
    return data;
  }
}

class DashboardService {
  int? id;
  String? serviceNo;
  String? customerId;
  String? providerId;
  String? machine;
  String? serviceStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  num? totalServiceAmount;
  num? totalTaxAmount;
  num? totalDiscountAmount;
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? categoryId;
  String? subCategoryId;
  String? serviceman;
  List<RecentSaleDetail>? detail;

  DashboardService(
      {
        this.id,
        this.serviceNo,
        this.customerId,
        this.providerId,
        this.machine,
        this.serviceStatus,
        this.isPaid,
        this.paymentMethod,
        this.transactionId,
        this.totalServiceAmount,
        this.totalTaxAmount,
        this.totalDiscountAmount,
        this.serviceSchedule,
        this.serviceAddressId,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.subCategoryId,
        this.serviceman,
        this.detail,
      });

  DashboardService.fromJson(Map<String, dynamic> json) {
    id = json['BLKODU'];
    serviceNo = json['SIPARIS_NO'];
    customerId = json['customer_id'];
    providerId = json['provider_id'];
    machine = json['ADI_SOYADI'];
    serviceStatus = json['SIPARIS_DURUMU'].toString();
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    totalServiceAmount = json['total_service_amount'];
    totalTaxAmount = json['total_tax_amount'];
    totalDiscountAmount = json['total_discount_amount'];
    serviceSchedule = json['service_schedule'];
    serviceAddressId = json['service_address_id'];
    createdAt = json['TARIHI'];
    updatedAt = json['VADESI'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    serviceman = json['OZELALANTANIM_19'];
    if (json['sale_details'] != null) {
      detail = <RecentSaleDetail>[];
      json['sale_details'].forEach((v) {
        detail!.add(RecentSaleDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BLKODU'] = id;
    data['SIPARIS_NO'] = serviceNo;
    data['customer_id'] = customerId;
    data['provider_id'] = providerId;
    data['ADI_SOYADI'] = machine;
    data['SIPARIS_DURUMU'] = serviceStatus;
    data['is_paid'] = isPaid;
    data['payment_method'] = paymentMethod;
    data['transaction_id'] = transactionId;
    data['total_service_amount'] = totalServiceAmount;
    data['total_tax_amount'] = totalTaxAmount;
    data['total_discount_amount'] = totalDiscountAmount;
    data['service_schedule'] = serviceSchedule;
    data['service_address_id'] = serviceAddressId;
    data['TARIHI'] = createdAt;
    data['VADESI'] = updatedAt;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['OZELALANTANIM_19'] = serviceman;
    return data;
  }
}



class MonthlyStats {
  int? total;
  int? year;
  int? month;
  int? day;

  MonthlyStats({this.total, this.year, this.month, this.day});

  MonthlyStats.fromJson(Map<String, dynamic> json) {
    total = int.parse(json['total'].toString());
    year =int.parse( json['year'].toString());
    month = int.parse(json['month'].toString());
    day = int.parse(json['day'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['year'] = year;
    data['month'] = month;
    data['day'] = day;
    return data;
  }
}


class YearlyStats {
  int? total;
  int? year;
  int? month;

  YearlyStats({this.total, this.year, this.month});

  YearlyStats.fromJson(Map<String, dynamic> json) {
    total = int.parse(json['total'].toString());
    year = int.parse(json['year'].toString());
    month = int.parse(json['month'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['year'] = year;
    data['month'] = month;
    return data;
  }
}


class MonthlyAmounts {
  double? total;
  int? year;
  int? month;
  int? day;

  MonthlyAmounts({this.total, this.year, this.month, this.day});

  MonthlyAmounts.fromJson(Map<String, dynamic> json) {
    total = double.parse(json['total'].toString());
    year =int.parse( json['year'].toString());
    month = int.parse(json['month'].toString());
    day = int.parse(json['day'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['year'] = year;
    data['month'] = month;
    data['day'] = day;
    return data;
  }
}


class YearlyAmounts {
  double? total;
  int? year;
  int? month;

  YearlyAmounts({this.total, this.year, this.month});

  YearlyAmounts.fromJson(Map<String, dynamic> json) {
    total = double.parse(json['total'].toString());
    year = int.parse(json['year'].toString());
    month = int.parse(json['month'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['year'] = year;
    data['month'] = month;
    return data;
  }
}


class RecentSaleDetail {
  int? id;
  String? serviceId;
  String? variantKey;
  num? serviceCost;
  int? quantity;
  num? discountAmount;
  num? taxAmount;
  num? totalCost;
  String? createdAt;
  String? updatedAt;
  num? campaignDiscountAmount;
  num? overallCouponDiscountAmount;
  Service? service;

  RecentSaleDetail(
      {int? id,
        String? serviceId,
        String? variantKey,
        num? serviceCost,
        int? quantity,
        num? discountAmount,
        num? taxAmount,
        num? totalCost,
        String? createdAt,
        String? updatedAt,
        num? campaignDiscountAmount,
        num? overallCouponDiscountAmount,
        Service? service
      }) {
    if (id != null) {
      id = id;
    }
    if (serviceId != null) {
      serviceId = serviceId;
    }
    if (variantKey != null) {
      variantKey = variantKey;
    }
    if (serviceCost != null) {
      serviceCost = serviceCost;
    }
    if (quantity != null) {
      quantity = quantity;
    }
    if (discountAmount != null) {
      discountAmount = discountAmount;
    }
    if (taxAmount != null) {
      taxAmount = taxAmount;
    }
    if (totalCost != null) {
      totalCost = totalCost;
    }
    if (createdAt != null) {
      createdAt = createdAt;
    }
    if (updatedAt != null) {
      updatedAt = updatedAt;
    }
    if (campaignDiscountAmount != null) {
      campaignDiscountAmount = campaignDiscountAmount;
    }
    if (overallCouponDiscountAmount != null) {
      overallCouponDiscountAmount = overallCouponDiscountAmount;
    }
    if (service != null) {
      service = service;
    }
  }

  RecentSaleDetail.fromJson(Map<String, dynamic> json) {
    id = json['BLKODU'];
    serviceId = json['service_id'];
    variantKey = json['variant_key'];
    serviceCost = json['DVZ_FIYATI'];
    quantity = json['MIKTARI'];
    discountAmount = json['discount_amount'];
    taxAmount = json['tax_amount'];
    totalCost = json['DVZ_FIYATI'];
    createdAt = json['TARIHI'];
    updatedAt = json['VADESI'];
    campaignDiscountAmount = json['campaign_discount_amount'];
    overallCouponDiscountAmount = json['overall_coupon_discount_amount'];
    service = json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BLKODU'] = id;
    data['service_id'] = serviceId;
    data['variant_key'] = variantKey;
    data['service_cost'] = serviceCost;
    data['quantity'] = quantity;
    data['discount_amount'] = discountAmount;
    data['tax_amount'] = taxAmount;
    data['total_cost'] = totalCost;
    data['TARIHI'] = createdAt;
    data['VADESI'] = updatedAt;
    data['campaign_discount_amount'] = campaignDiscountAmount;
    data['overall_coupon_discount_amount'] = overallCouponDiscountAmount;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}

class Service {
  String? id;
  String? name;
  String? thumbnail;

  Service({String? id, String? name, String? thumbnail}) {
    if (id != null) {
      id = id;
    }
    if (name != null) {
      name = name;
    }
    if (thumbnail != null) {
      thumbnail = thumbnail;
    }
  }

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
