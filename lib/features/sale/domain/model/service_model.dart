
import 'dart:convert';

class ServiceModel11 {
  int? totalSize;
  int? totalPending;
  int? totalApproved;
  int? totalServiced;
  int? totalPartiallyServiced;
  int? totalCanceled;
  int? totalServices;
  String? limit;
  String? offset;
  //List<Services>? services;

  ServiceModel11({this.totalSize, this.limit, this.offset,});

  ServiceModel11.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    totalPending = json['total_pending'];
    totalApproved = json['total_approved'];
    totalServiced = json['total_serviced'];
    totalPartiallyServiced = json['total_partially_serviced'];
    totalCanceled = json['total_canceled'];
    totalServices = json['total_services'];
    limit = json['limit'];
    offset = json['offset'];
/*    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }*/
  }

}

class ServiceModel {
  int? id;
  int? userId;
  String? serviceStatus;
  double? serviceAmount;
  String? createdAt;
  String? updatedAt;
  String? serviceNote;
  String? serviceType;
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
  String? serviceNumber;
  String? department;
  String? machine;
  String? createdBy ;


  ServiceModel(
      {
        this.id,
        this.userId,
        this.serviceStatus,
        this.createdAt,
        this.updatedAt,
        this.serviceNote,
        this.serviceType,
        this.alreadyServiced,
        this.servicePlace,
        this.attachments,
        this.duringProduction,
        this.duration,
        this.serviceman,
        this.serviceNumber,
        this.department,
        this.machine,
        this.startDate,
        this.startTime,
        this.endDate,
        this.endTime,
        this.createdBy,
      });


  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    serviceStatus = json['serviceStatus'].toString();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    endDate = json['endDate'];
    endTime = json['endTime'];
    duringProduction = json['duringProduction']??0;
    serviceNote = json['serviceNote'];
    serviceType = json['serviceType'];
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
    serviceNumber = json['serviceNumber'];
    department = json['department'];
    machine = json['machine'];
    createdBy= json['createdBy'];

  }



}

