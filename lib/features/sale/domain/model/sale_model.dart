
import 'dart:convert';

class SaleModel {
  int? totalSize;
  int? totalPending;
  int? totalApproved;
  int? totalServiced;
  int? totalPartiallyServiced;
  int? totalCanceled;
  int? totalSales;
  String? limit;
  String? offset;
  List<Sales>? sales;

  SaleModel({this.totalSize, this.limit, this.offset, this.sales});

  SaleModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    totalPending = json['total_pending'];
    totalApproved = json['total_approved'];
    totalServiced = json['total_serviced'];
    totalPartiallyServiced = json['total_partially_serviced'];
    totalCanceled = json['total_canceled'];
    totalSales = json['total_sales'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['sales'] != null) {
      sales = <Sales>[];
      json['sales'].forEach((v) {
        sales!.add(Sales.fromJson(v));
      });
    }
  }

}

class Sales {
  int? id;
  int? customerId;
  String? saleStatus;
  int? saleCategory;
  double? saleAmount;
  String? createdAt;
  String? updatedAt;
  String? saleNote;
  String? saleType;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  String? duration;
  int? alreadyServiced;
  String? servicePlace;
  List<String>? attachments;
  int? duringProduction;
  String? serviceman;
  String? saleNumber;
  String? department;
  String? machine;
  String? createdBy ;
  //int? hasdetails ;



  Sales(
      {this.id,
        this.customerId,
        this.saleStatus,
        this.saleCategory,
        this.saleAmount,
        this.createdAt,
        this.updatedAt,
        this.saleNote,
        this.saleType,
        this.alreadyServiced,
        this.servicePlace,
        this.attachments,
        this.duringProduction,
        this.duration,
        this.serviceman,
        this.saleNumber,
        this.department,
        this.machine,
        this.startDate,
        this.startTime,
        this.endDate,
        this.endTime,
        this.createdBy,
        //this.hasdetails,
      });


  Sales.fromJson(Map<String, dynamic> json) {
    id = json['BLKODU'];
    customerId = json['BLCRKODU'];
    saleStatus = json['SIPARIS_DURUMU'].toString();
    saleCategory = json['SIPARIS_TURU'];
    saleAmount = json['TOPLAM_GENEL_DVZ'].toDouble();
    createdAt = json['TARIHI'];
    updatedAt = json['VADESI'];
    startDate = json['OZELALANTANIM_119'];
    startTime = json['OZELALANTANIM_121'];
    endDate = json['OZELALANTANIM_120'];
    endTime = json['OZELALANTANIM_122'];
    duringProduction = json['OZELALANTANIM_126']??0;
    saleNote = json['ACIKLAMA_2'];
    saleType = json['OZELALANTANIM_17'];
    alreadyServiced = json['OZELALANTANIM_130'];
    servicePlace = json['OZELALANTANIM_124'];
    if(json['OZELALANTANIM_131'] != null ){
      try{
        attachments = (json['OZELALANTANIM_131'] != null ) ? json['OZELALANTANIM_131'].cast<String>() : [];
      }catch(e){
        attachments = (json['OZELALANTANIM_131'] != null ) ? jsonDecode(json['OZELALANTANIM_131']).cast<String>() : [];
      }

    }
    //duration = json['OZELALANTANIM_123'];
    duration = json['OZELALANTANIM_132'];
    serviceman = json['OZELALANTANIM_19'];
    saleNumber = json['SIPARIS_NO'];
    department = json['OZELALANTANIM_20'];
    machine = json['ADI_SOYADI'];
    createdBy= json['KAYDEDEN'];

  /*  if(json['hasdetails'] != null) {
      hasdetails = 0;
    }
    else {
      hasdetails = 1;
    }*/





    //hasdetails= json['hasdetails'];



/*    id = json['id'];
    customerId = json['customerId'];
    saleStatus = json['saleStatus'].toString();
    saleAmount = json['saleAmount'].toDouble();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    endDate = json['endDate'];
    endTime = json['endTime'];
    duringProduction = json['duringProduction']??0;
    saleNote = json['saleNote'];
    saleType = json['saleType'];
    alreadyServiced = json['alreadyServiced'];
    servicePlace = json['servicePlace'];
    if(json['attachments'] != null ){
      try{
        attachments = (json['attachments'] != null ) ? json['attachments'].cast<String>() : [];
      }catch(e){
        attachments = (json['attachments'] != null ) ? jsonDecode(json['attachments']).cast<String>() : [];
      }

    }

    duration = json['duration'];
    serviceman = json['serviceman'];
    saleNumber = json['saleNumber'];
    department = json['department'];
    machine = json['machine'];
    createdBy= json['createdBy'];*/










  }



}

