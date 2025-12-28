import 'dart:io';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/features/package/domain/model/package_details_model.dart';
import 'package:flutter_spareparts_store/features/package/domain/model/refund_info_model.dart';
import 'package:flutter_spareparts_store/features/package/domain/model/refund_result_model.dart';
import 'package:flutter_spareparts_store/features/package/domain/model/package_model.dart';
import 'package:flutter_spareparts_store/features/package/domain/repo/package_repo.dart';
import 'package:flutter_spareparts_store/helper/api_checker.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PackageProvider with ChangeNotifier {
  final PackageRepo? packageRepo;
  PackageProvider({required this.packageRepo});

  bool _isLoading = false;
  bool _isRefund = false;
  bool get isRefund => _isRefund;
  bool get isLoading => _isLoading;
  XFile? _imageFile;
  XFile? get imageFile => _imageFile;
  List <XFile?>_refundImage = [];
  List<XFile?> get refundImage => _refundImage;
  List<File> reviewImages = [];
  RefundInfoModel? _refundInfoModel;
  RefundInfoModel? get refundInfoModel => _refundInfoModel;
  RefundResultModel? _refundResultModel;
  RefundResultModel? get refundResultModel => _refundResultModel;



  bool _onlyDigital = true;
  bool get onlyDigital => _onlyDigital;

  void digitalOnly(bool value, {bool isUpdate = false}){
    _onlyDigital = value;
    if(isUpdate){
      notifyListeners();
    }

  }

  PackageModel? packageModel;
  PackageModel? deliveredPackageModel;
  Future<void> getPackageList(int offset, String type, String? hour, String? machine) async {
    if(offset == 1){
      packageModel = null;
    }
    ApiResponse apiResponse = await packageRepo!.getPackageList(offset, type, hour,machine);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        packageModel = PackageModel.fromJson(apiResponse.response?.data);
        if(type == 'repackage'){
          deliveredPackageModel = PackageModel.fromJson(apiResponse.response?.data);
        }
      }else {
        packageModel!.packages!.addAll(PackageModel.fromJson(apiResponse.response?.data).packages!);
        packageModel!.offset = PackageModel.fromJson(apiResponse.response?.data).offset;
        packageModel!.totalSize = PackageModel.fromJson(apiResponse.response?.data).totalSize;
      }

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  String _packageLineIndex = 'All';
  String get packageLineIndex => _packageLineIndex;


  void setLine(String index, {bool notify = true}) {
    _packageLineIndex = index;
    getPackageList(1, packageLineIndex,packageHourIndex,packageMachineIndex);
    if(notify) {
      notifyListeners();
    }
  }


/*  String selectedLine = 'All';
  void setIndex(String index, {bool notify = true}) {
    _packageLineIndex = index;
    if(_packageLineIndex == 'SBO10-1'){
      selectedLine = 'SBO10-1';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }else if(_packageLineIndex == 'SBO10-2'){
      selectedLine = 'SBO10-2';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }else if(_packageLineIndex == 'SBO14-1'){
      selectedLine = 'SBO14-1';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }
    else if(_packageLineIndex == 'SBO14-2'){
      selectedLine = 'SBO14-2';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }
    else if(_packageLineIndex == 'All'){
      selectedLine = 'All';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }
    if(notify) {
      notifyListeners();
    }
  }*/



  String _packageHourIndex = 'All';
  String get packageHourIndex => _packageHourIndex;

  void setHour(String index, {bool notify = true}) {
    _packageHourIndex = index;
    getPackageList(1, packageLineIndex,packageHourIndex,packageMachineIndex);
  if(notify) {
  notifyListeners();
  }
}


/*  String selectedHour = 'All';
  void setHour(String index, {bool notify = true}) {
    _packageHourIndex = index;
    if(_packageHourIndex == '3000H'){
      selectedHour = '3000H';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }else if(_packageHourIndex == '6000H'){
      selectedHour = '6000H';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }else if(_packageHourIndex == '9000H'){
      selectedHour = '9000H';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }
    else if(_packageHourIndex == '12000H'){
      selectedHour = '12000H';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }
    else if(_packageHourIndex == 'All'){
      selectedHour = 'All';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }
    if(notify) {
      notifyListeners();
    }
  }*/



  String _packageMachineIndex = 'All';
  String get packageMachineIndex => _packageMachineIndex;

  void setMachine(String index, {bool notify = true}) {
    _packageMachineIndex = index;
    getPackageList(1, packageLineIndex,packageHourIndex,packageMachineIndex);
    if(notify) {
      notifyListeners();
    }
  }
/*  String selectedMachine = 'All';
  void setMachine(String index, {bool notify = true}) {
    _packageMachineIndex = index;
    if(_packageMachineIndex == '3000H'){
      selectedMachine = '3000H';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }else if(_packageMachineIndex == '6000H'){
      selectedMachine = '6000H';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }else if(_packageMachineIndex == '9000H'){
      selectedMachine = '9000H';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }
    else if(_packageMachineIndex == '12000H'){
      selectedMachine = '12000H';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }
    else if(_packageHourIndex == 'All'){
      selectedHour = 'All';
      getPackageList(1, packageLineIndex,packageHourIndex);
    }
    if(notify) {
      notifyListeners();
    }
  }*/


      List<PackageDetailsModel>? _packageDetails;
  List<PackageDetailsModel>? get packageDetails => _packageDetails;

  Future <ApiResponse> getPackageDetails(String packageID) async {
    _packageDetails = null;
    ApiResponse apiResponse = await packageRepo!.getPackageDetails(packageID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _packageDetails = null;
      _packageDetails = [];
      apiResponse.response!.data.forEach((package) => _packageDetails!.add(PackageDetailsModel.fromJson(package)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }




  Packages? packages;
  Future <void> getPackageFromPackageId(String packageID) async {
    ApiResponse apiResponse = await packageRepo!.getPackageFromPackageId(packageID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      packages = Packages.fromJson(apiResponse.response!.data);
     // log("===Delivery MAN==> ${packages?.deliveryMan?.fName}");
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

/*
  Packages? trackingModel;
  Future<void> initTrackingInfo(String packageID) async {
      ApiResponse apiResponse = await packageRepo!.getTrackingInfo(packageID);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        trackingModel = Packages.fromJson(apiResponse.response!.data);
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
  }
*/



  bool searching = false;
  Future<ApiResponse> trackYourPackage({String? packageId, String? phoneNumber}) async {
    searching = true;
    notifyListeners();
    ApiResponse apiResponse = await packageRepo!.trackYourPackage(packageId!, phoneNumber!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      searching = false;
      _packageDetails = [];
      apiResponse.response!.data.forEach((package) => _packageDetails!.add(PackageDetailsModel.fromJson(package)));
    } else {
      searching = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }




}
