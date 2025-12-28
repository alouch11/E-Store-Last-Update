import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/sale/domain/model/service_info_model.dart';
import 'package:flutter_spareparts_store/features/sale/domain/model/service_result_model.dart';
import 'package:flutter_spareparts_store/helper/api_checker.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utill/app_constants.dart';
import '../domain/model/sale_details_model.dart';
import '../domain/model/sale_model.dart';
import '../domain/repo/sale_repo.dart';

class SaleProvider with ChangeNotifier {
  final SaleRepo? saleRepo;
  SaleProvider({required this.saleRepo});

  bool _isDeleting = false;
  bool get isDeleting => _isDeleting;


  bool _isLoading = false;
  bool _isService = false;
  bool get isService => _isService;
  bool get isLoading => _isLoading;

  XFile? _imageFile;
  XFile? get imageFile => _imageFile;
  List <XFile?>_serviceImage = [];
  List<XFile?> get serviceImage => _serviceImage;

  List <XFile?>_serviceCreateImage = [];
  List<XFile?> get serviceCreateImage => _serviceCreateImage;


  List<File> serviceImages = [];
  ServiceInfoModel? _serviceInfoModel;
  ServiceInfoModel? get serviceInfoModel => _serviceInfoModel;
  ServiceResultModel? _serviceResultModel;
  ServiceResultModel? get serviceResultModel => _serviceResultModel;


  String? usertype =  Provider.of<ProfileProvider>(Get.context!, listen: false).userInfoModel!.userType;

  ScrollController scrollControllerService  = ScrollController();


  String selectedServiceType = "allServices";

  final String _dropDownValue= "";
  String get dropDownValue => _dropDownValue;
  final List<String> statusTypeList = [ "ongoing", "completed" , "canceled"];

  bool _onlyDigital = true;
  bool get onlyDigital => _onlyDigital;

  void digitalOnly(bool value, {bool isUpdate = false}){
    _onlyDigital = value;
    if(isUpdate){
      notifyListeners();
    }

  }

  SaleModel? saleModel;
  SaleModel? deliveredsaleModel;
  Future<void> getSaleList(int offset, String status, String? usertype,{String? type,String? saleType,String? persons,String? lines,String? machines,String? startDate,String? endDate,String? serviceSelectedType}) async {
    if(offset == 1){
      saleModel = null;
    }
    ApiResponse apiResponse = await saleRepo!.getSaleList(offset, status,usertype, type: type,saleType: saleType,persons:persons,lines:lines,machines:machines,startDate:startDate,endDate:endDate,serviceSelectedType:serviceSelectedType);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        saleModel = SaleModel.fromJson(apiResponse.response?.data);
        if(type == 'resale'){
          deliveredsaleModel = SaleModel.fromJson(apiResponse.response?.data);
        }
      }else {
        saleModel!.sales!.addAll(SaleModel.fromJson(apiResponse.response?.data).sales!);
        saleModel!.offset = SaleModel.fromJson(apiResponse.response?.data).offset;
        saleModel!.totalSize = SaleModel.fromJson(apiResponse.response?.data).totalSize;
      }

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  SaleModel? saleModelByProduct;
   Future<void> getSaleListByProduct(int offset, String status, String product,String? usertype ,{String? type,String? saleType,String? persons,String? lines,String? machines,String? startDate,String? endDate}) async {
    if(offset == 1){
      saleModelByProduct = null;
    }
    ApiResponse apiResponse = await saleRepo!.getSaleListByProduct(offset, status,product,usertype,type: type,saleType: saleType,persons:persons,lines:lines,machines:machines,startDate:startDate,endDate:endDate);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        saleModelByProduct = SaleModel.fromJson(apiResponse.response?.data);
      }else {
        saleModelByProduct!.sales!.addAll(SaleModel.fromJson(apiResponse.response?.data).sales!);
        saleModelByProduct!.offset = SaleModel.fromJson(apiResponse.response?.data).offset;
        saleModelByProduct!.totalSize = SaleModel.fromJson(apiResponse.response?.data).totalSize;
        saleModelByProduct!.totalPending = SaleModel.fromJson(apiResponse.response?.data).totalPending;
        saleModelByProduct!.totalPartiallyServiced = SaleModel.fromJson(apiResponse.response?.data).totalPartiallyServiced;
        saleModelByProduct!.totalServiced = SaleModel.fromJson(apiResponse.response?.data).totalServiced;
        saleModelByProduct!.totalCanceled = SaleModel.fromJson(apiResponse.response?.data).totalCanceled;
        saleModelByProduct!.totalApproved = SaleModel.fromJson(apiResponse.response?.data).totalApproved;
      }

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  SaleModel? saleModelByMachine;
  Future<void> getSaleListByMachine(int offset, String status, String machine,String? usertype ,{String? type,String? saleType,String? persons,String? product,String? startDate,String? endDate}) async {
    if(offset == 1){
      saleModelByMachine = null;
    }
    ApiResponse apiResponse = await saleRepo!.getSaleListByMachine(offset, status,machine,usertype,type: type,saleType: saleType,persons:persons,startDate:startDate,endDate:endDate,product:product);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        saleModelByMachine = SaleModel.fromJson(apiResponse.response?.data);
      }else {
        saleModelByMachine!.sales!.addAll(SaleModel.fromJson(apiResponse.response?.data).sales!);
        saleModelByMachine!.offset = SaleModel.fromJson(apiResponse.response?.data).offset;
        saleModelByMachine!.totalSize = SaleModel.fromJson(apiResponse.response?.data).totalSize;
        saleModelByMachine!.totalPending = SaleModel.fromJson(apiResponse.response?.data).totalPending;
        saleModelByMachine!.totalPartiallyServiced = SaleModel.fromJson(apiResponse.response?.data).totalPartiallyServiced;
        saleModelByMachine!.totalServiced = SaleModel.fromJson(apiResponse.response?.data).totalServiced;
        saleModelByMachine!.totalCanceled = SaleModel.fromJson(apiResponse.response?.data).totalCanceled;
        saleModelByMachine!.totalApproved = SaleModel.fromJson(apiResponse.response?.data).totalApproved;
      }

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  DateTime? _startDate= null as DateTime?;
  DateTime? _endDate= null as DateTime?;
  final DateFormat _dateFormat = DateFormat('dd-MM-yyy hh:mm');
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  DateFormat get dateFormat => _dateFormat;

  void selectDate(String type, BuildContext context){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2100),
    ).then((date) {
      if (type == 'start'){
        _startDate = date;
      }else{
        _endDate = date;
      }
      if(date == null){

      }
      notifyListeners();
    });
  }

  List<dynamic> selectedSaleLineList = [];
  String? selectedSaleLine ;
  List<dynamic> selectedSaleMachineList = [];
 // String? selectedSaleMachine ;
  List<dynamic> selectedSaleSupplierList = [];
  List<dynamic> selectedSaleTypeList = [];
  List<dynamic> selectedSalePersonList =[];

  String selectedSaleStartDate ="2000-01-01";
  String selectedSaleEndDate = "2200-01-01";

  bool _searchType = false;
  String selectedSearchType = '';
  void setSearchType(bool type) {
    _searchType = type;
    if(_searchType == true){
      selectedSearchType = '';
    }else{
      selectedSearchType = usertype!;
    }
  }


  int _saleTypeIndex = 0;
  int get saleTypeIndex => _saleTypeIndex;

  String selectedType = 'pending';
  void setIndex(int index,{bool notify = true}) {
    _saleTypeIndex = index;
    if(_saleTypeIndex == 0){
      selectedType = 'pending';
      getSaleList(1, 'pending', selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          lines: selectedSaleLineList.isNotEmpty ? jsonEncode(selectedSaleLineList) : null,
          machines: selectedSaleMachineList.isNotEmpty ? jsonEncode(selectedSaleMachineList) : null,
          startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
         endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01",
          serviceSelectedType:selectedServiceType
      );
    }else if(_saleTypeIndex == 1){
      selectedType = 'approved';
      getSaleList(1, 'approved', selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          lines: selectedSaleLineList.isNotEmpty ? jsonEncode(selectedSaleLineList) : null,
          machines: selectedSaleMachineList.isNotEmpty ? jsonEncode(selectedSaleMachineList) : null,
        startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
        endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01",
          serviceSelectedType:selectedServiceType
      );
    }else if(_saleTypeIndex == 2){
      selectedType = 'serviced';
      getSaleList(1, 'serviced', selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          lines: selectedSaleLineList.isNotEmpty ? jsonEncode(selectedSaleLineList) : null,
          machines: selectedSaleMachineList.isNotEmpty ? jsonEncode(selectedSaleMachineList) : null,
        startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
        endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01",
          serviceSelectedType:selectedServiceType
      );
    }
    else if(_saleTypeIndex == 3){
      selectedType = 'canceled';
      getSaleList(1, 'canceled', selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          lines: selectedSaleLineList.isNotEmpty ? jsonEncode(selectedSaleLineList): null,
          machines: selectedSaleMachineList.isNotEmpty ? jsonEncode(selectedSaleMachineList) : null,
        startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
        endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01",
          serviceSelectedType:selectedServiceType
      );
    }
    else if(_saleTypeIndex == 4){
      selectedType = 'partially_serviced';
      getSaleList(1, 'partially_serviced', selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList): null,
          lines: selectedSaleLineList.isNotEmpty ? jsonEncode(selectedSaleLineList) : null,
          machines: selectedSaleMachineList.isNotEmpty ? jsonEncode(selectedSaleMachineList) : null,
        startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
        endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01",
          serviceSelectedType:selectedServiceType
      );
    }
    if(notify) {
      notifyListeners();
    }
  }

  int _saleTypeByProductIndex = 0;
  int get saleTypeByProductIndex => _saleTypeByProductIndex;

  String selectedTypeByProduct = 'pending';
  void setIndexByProduct(int index, String productId, {bool notify = true}) {
    _saleTypeByProductIndex = index;
    if(_saleTypeByProductIndex == 0){
      selectedTypeByProduct = 'pending';
      getSaleListByProduct(1, 'pending',productId,selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          lines: selectedSaleLineList.isNotEmpty ? jsonEncode(selectedSaleLineList) : null,
          machines: selectedSaleMachineList.isNotEmpty ? jsonEncode(selectedSaleMachineList) : null,
          startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
          endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01"
      );
    }else if(_saleTypeByProductIndex == 1){
      selectedTypeByProduct = 'approved';
      getSaleListByProduct(1, 'approved',productId,selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          lines: selectedSaleLineList.isNotEmpty ? jsonEncode(selectedSaleLineList) : null,
          machines: selectedSaleMachineList.isNotEmpty ? jsonEncode(selectedSaleMachineList) : null,
          startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
          endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01"
      );
    }else if(_saleTypeByProductIndex == 2){
      selectedTypeByProduct = 'serviced';
      getSaleListByProduct(1, 'serviced',productId,selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          lines: selectedSaleLineList.isNotEmpty ? jsonEncode(selectedSaleLineList) : null,
          machines: selectedSaleMachineList.isNotEmpty ? jsonEncode(selectedSaleMachineList) : null,
          startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
          endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01"
      );
    }
    else if(_saleTypeByProductIndex == 3){
      selectedTypeByProduct = 'canceled';
      getSaleListByProduct(1, 'canceled',productId,selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          lines: selectedSaleLineList.isNotEmpty ? jsonEncode(selectedSaleLineList) : null,
          machines: selectedSaleMachineList.isNotEmpty ? jsonEncode(selectedSaleMachineList) : null,
          startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
          endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01"
      );
    }
    else if(_saleTypeByProductIndex == 4){
      selectedTypeByProduct = 'partially_serviced';
      getSaleListByProduct(1, 'partially_serviced',productId,selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          lines: selectedSaleLineList.isNotEmpty ? jsonEncode(selectedSaleLineList) : null,
          machines: selectedSaleMachineList.isNotEmpty ? jsonEncode(selectedSaleMachineList) : null,
          startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
          endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01"
      );
    }
    if(notify) {
      notifyListeners();
    }
  }


  int _saleTypeByMachineIndex = 0;
  int get saleTypeByMachineIndex => _saleTypeByMachineIndex;

  String selectedTypeByMachine = 'pending';
  void setIndexByMachine(int index, String machineId, {bool notify = true}) {
    _saleTypeByMachineIndex = index;
    if(_saleTypeByMachineIndex == 0){
      selectedTypeByMachine = 'pending';
      getSaleListByMachine(1, 'pending',machineId,selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
          endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01"
      );
    }else if(_saleTypeByMachineIndex == 1){
      selectedTypeByMachine = 'approved';
      getSaleListByMachine(1, 'approved',machineId,selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
          endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01"
      );
    }else if(_saleTypeByMachineIndex == 2){
      selectedTypeByMachine = 'serviced';
      getSaleListByMachine(1, 'serviced',machineId,selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
          endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01"
      );
    }
    else if(_saleTypeByMachineIndex == 3){
      selectedTypeByMachine = 'canceled';
      getSaleListByMachine(1, 'canceled',machineId,selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
          endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01"
      );
    }
    else if(_saleTypeByMachineIndex == 4){
      selectedTypeByMachine = 'partially_serviced';
      getSaleListByMachine(1, 'partially_serviced',machineId,selectedSearchType,
          saleType: selectedSaleTypeList.isNotEmpty ? jsonEncode(selectedSaleTypeList) : null,
          persons: selectedSalePersonList.isNotEmpty ? jsonEncode(selectedSalePersonList) : null,
          startDate: selectedSaleStartDate !="2000-01-01" ? selectedSaleStartDate : "2000-01-01",
          endDate: selectedSaleEndDate !="2200-01-01" ? selectedSaleEndDate : "2200-01-01"
      );
    }
    if(notify) {
      notifyListeners();
    }
  }





  List<SaleDetailsModel>? _saleDetails;
  List<SaleDetailsModel>? get saleDetails => _saleDetails;

  Future <ApiResponse> getSaleDetails(String saleID) async {
    _saleDetails = null;
    ApiResponse apiResponse = await saleRepo!.getSaleDetails(saleID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _saleDetails = null;
      _saleDetails = [];
      apiResponse.response!.data.forEach((sale) => _saleDetails!.add(SaleDetailsModel.fromJson(sale)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }



  Sales? sales;
  Future <void> getSaleFromSaleId(String saleID) async {
    ApiResponse apiResponse = await saleRepo!.getSaleFromSaleId(saleID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      sales = Sales.fromJson(apiResponse.response!.data);
      //log("===Delivery MAN==> ${sales?.deliveryMan?.fName}");
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  Sales? service;
  Future <void> getServiceFromServiceId(String saleID) async {
    ApiResponse apiResponse = await saleRepo!.getServiceFromServiceId(saleID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      service = Sales.fromJson(apiResponse.response!.data);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  void stopLoader({bool notify = true}) {
    _isLoading = false;
    if(notify){
      notifyListeners();
    }

  }



/*  Sales? trackingModel;
  Future<void> initTrackingSaleInfo(String saleID) async {
      ApiResponse apiResponse = await saleRepo!.getTrackingSaleInfo(saleID);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        trackingModel = Sales.fromJson(apiResponse.response!.data);
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
  }*/



  void pickImage(bool isRemove, {bool fromService = false}) async {
    if(isRemove) {
      _imageFile = null;
      _serviceImage = [];
      serviceImages = [];
    }else {
      _imageFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 20);
      if (_imageFile != null) {
        if(fromService){
          serviceImages.add(File(_imageFile!.path));
        }else{
          _serviceImage.add(_imageFile);
        }
      }
    }
    notifyListeners();
  }


  void removeImage(int index, {bool fromService = false}){
    if(fromService){
      serviceImages.removeAt(index);
    }else{
      _serviceImage.removeAt(index);
    }

    notifyListeners();
  }

  Future<http.StreamedResponse> serviceClose(BuildContext context, int? saleId, String startDate, String startTime, String endDate,String endTime,String duration,int? duringProduction, String serviceReason, String token) async {
    _isLoading = true;
    notifyListeners();
    http.StreamedResponse response = await saleRepo!.serviceClose(saleId,startDate,startTime,endDate,endTime, duration,duringProduction, serviceReason,serviceImage, token);

    if (response.statusCode == 200) {
      _imageFile = null;
      _serviceImage = [];
      _isLoading = false;

    } else {
      _isLoading = false;

    }
    _imageFile = null;
    _serviceImage = [];
    _isLoading = false;
    notifyListeners();
    return response;
  }



  Future<http.StreamedResponse> serviceCreate(BuildContext context,String line,String machine, String serviceType, String startDate,String startTime, String endDate, String endTime,String duration,int? duringProduction, String servicePlace, String token) async {
    _isLoading = true;
    notifyListeners();
    http.StreamedResponse response = await saleRepo!.serviceCreate(line,machine,serviceType,startDate,startTime,endDate,endTime, duration,duringProduction, servicePlace,serviceImage, token);
    if (response.statusCode == 200) {
      _imageFile = null;
      _serviceImage = [];
      _isLoading = false;

    } else {
      _isLoading = false;

    }
    _imageFile = null;
    _serviceImage = [];
    _isLoading = false;
    notifyListeners();
    return response;
  }


  Future<http.StreamedResponse> serviceUpdate(BuildContext context, int? serviceId, String startDate, String startTime, String endDate,String endTime,String duration,int? duringProduction, String serviceReason, String type,String token) async {
    _isLoading = true;
    notifyListeners();
    http.StreamedResponse response = await saleRepo!.serviceUpdate(serviceId,startDate,startTime,endDate,endTime, duration,duringProduction, serviceReason,type,serviceImage, token);
    if (response.statusCode == 200) {
      _imageFile = null;
      _serviceImage = [];
      _isLoading = false;

    } else {
      _isLoading = false;

    }
    _imageFile = null;
    _serviceImage = [];
    _isLoading = false;
    notifyListeners();
    return response;
  }


  Future<ApiResponse> getServiceInfo(int? saleId) async {
    _isService = true;
    ApiResponse apiResponse = await saleRepo!.getServiceInfo(saleId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _serviceInfoModel = ServiceInfoModel.fromJson(apiResponse.response!.data);
      _isService = false;
    } else if(apiResponse.response!.statusCode == 202){
      _isService = false;
      showCustomSnackBar('${apiResponse.response!.data['message']}', Get.context!);
    }
    else {
      _isService = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> getServiceResult(BuildContext context, int? saleDetailId) async {
    _isLoading =true;

    ApiResponse apiResponse = await saleRepo!.getServiceResult(saleDetailId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      _serviceResultModel = ServiceResultModel.fromJson(apiResponse.response!.data);
    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> cancelSale(BuildContext context, int? saleId) async {
    _isLoading = true;
    ApiResponse apiResponse = await saleRepo!.cancelSale(saleId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  Future<ApiResponse> apporveSale(BuildContext context, int? saleId, String? serviceMan) async {
    _isLoading = true;
    ApiResponse apiResponse = await saleRepo!.approveSale(saleId,serviceMan);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  void downloadFile(String url, String dir) async {
    await FlutterDownloader.enqueue(
      url: url,
      savedDir: dir,
      showNotification: true,
      saveInPublicStorage: true,
      openFileFromNotification: true,
    );
  }



  bool searching = false;
  Future<ApiResponse> trackYourSale({String? saleNo}) async {
    searching = true;
    notifyListeners();
    ApiResponse apiResponse = await saleRepo!.trackYourSale(saleNo!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      searching = false;
      _saleDetails = [];
      apiResponse.response!.data.forEach((sale) => _saleDetails!.add(SaleDetailsModel.fromJson(sale)));
    } else {
    searching = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> downloadDigitalProduct({int? saleDetailsId}) async {
    ApiResponse apiResponse = await saleRepo!.downloadDigitalProduct(saleDetailsId!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Provider.of<AuthController>(Get.context!, listen: false).resendTime = (apiResponse.response!.data["time_count_in_second"]);
    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  Future<ApiResponse> resendOtpForDigitalProduct({int? saleId}) async {
    ApiResponse apiResponse = await saleRepo!.resendOtpForDigitalProduct(saleId!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> otpVerificationDigitalProduct({required int saleId, required String otp}) async {
    ApiResponse apiResponse = await saleRepo!.otpVerificationForDigitalProduct(saleId, otp);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Navigator.of(Get.context!).pop();
      _launchUrl(Uri.parse('${AppConstants.baseUrl}${AppConstants.otpVerificationForDigitalProduct}?sale_details_id=$saleId&otp=$otp&guest_id=1&action=download'));

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }



  Future<ApiResponse> deleteService(BuildContext context, int? serviceId) async {
    _isDeleting = true;
    notifyListeners();
    ApiResponse apiResponse = await saleRepo!.deleteService(serviceId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      Map map = apiResponse.response!.data;
      String message = map ['message'];
      showCustomSnackBar(message, Get.context!, isError: false);

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  void updateSelectedServiceType({String? type}){
    if(type!=null){
      selectedServiceType = type;
    }else{
      selectedServiceType ='allServices';
    }
  }



  int? _imageSliderIndex=0;

  int? get imageSliderIndex => _imageSliderIndex;

  void setImageSliderSelectedIndex(int selectedIndex) {
    _imageSliderIndex = selectedIndex;
  }



}
Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}













