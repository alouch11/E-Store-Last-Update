
import 'package:flutter_spareparts_store/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_spareparts_store/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class SaleRepo {
  final DioClient? dioClient;

  SaleRepo({required this.dioClient});

  Future<ApiResponse> getSaleList(int offset, String status, String? usertype,{String? type,String? saleType,String? persons,String? lines,String? machines,String? startDate,String? endDate,String? serviceSelectedType}) async {
    try {

      final response = await dioClient!.get('${AppConstants.saleUri}$offset&status=$status&type=$type&usertype=$usertype&saleType=$saleType&persons=$persons&lines=$lines&machines=$machines&startDate=$startDate&endDate=$endDate&serviceSelectedType=$serviceSelectedType');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getSaleListByProduct(int offset, String status,String product , String? usertype,{String? type,String? saleType,String? persons,String? lines,String? machines,String? startDate,String? endDate}) async {
    try {
      final response = await dioClient!.get('${AppConstants.saleUriByProduct}$offset&status=$status&product_id=$product&type=$type&usertype=$usertype&saleType=$saleType&persons=$persons&lines=$lines&machines=$machines&startDate=$startDate&endDate=$endDate');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getSaleListByMachine(int offset, String status,String machine , String? usertype,{String? type,String? saleType,String? persons,String? product,String? startDate,String? endDate}) async {
    try {
      final response = await dioClient!.get('${AppConstants.saleUriByMachine}$offset&status=$status&type=$type&usertype=$usertype&saleType=$saleType&product_id=$product&persons=$persons&machine_id=$machine&startDate=$startDate&endDate=$endDate');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getSaleDetails(String saleID) async {
    try {
      final response = await dioClient!.get(
        AppConstants.saleDetailsUri+saleID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSaleFromSaleId(String saleID) async {
    try {
      final response = await dioClient!.get('${AppConstants.getSaleFromSaleId}$saleID&guest_id=${Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getServiceFromServiceId(String saleID) async {
    try {
      final response = await dioClient!.get('${AppConstants.getServiceFromServiceId}$saleID&guest_id=${Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getTrackingSaleInfo(String saleID) async {
    try {
      final response = await dioClient!.get(AppConstants.trackingsaleUri+saleID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<http.StreamedResponse> serviceClose(int? saleId, String startDate,String startTime, String endDate, String endTime,String duration,int? duringProduction, String refundReason, List<XFile?> file, String token) async {

    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.closeServiceUri}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    for(int i=0; i<file.length;i++){
      Uint8List list = await file[i]!.readAsBytes();
      var part = http.MultipartFile('images[]', file[i]!.readAsBytes().asStream(), list.length, filename: basename(file[i]!.path), contentType: MediaType('image', 'jpg'));
      request.files.add(part);
    }


    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'sale_id': saleId.toString(),
      'start_date': startDate.toString(),
      'start_time': startTime.toString(),
      'end_date': endDate.toString(),
      'end_time': endTime.toString(),
      'duration': duration.toString(),
      'during_production':duringProduction.toString(),
      'service_place':refundReason

    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;

  }




  Future<http.StreamedResponse> serviceCreate(String line,String machine,String serviceType,String startDate,String startTime, String endDate,String endTime,String duration,int? duringProduction, String refundReason, List<XFile?> file, String token) async {

    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.createServiceUri}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    for(int i=0; i<file.length;i++){
      Uint8List list = await file[i]!.readAsBytes();
      var part = http.MultipartFile('images[]', file[i]!.readAsBytes().asStream(), list.length, filename: basename(file[i]!.path), contentType: MediaType('image', 'jpg'));
      request.files.add(part);
    }

    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'line': line.toString(),
      'machine': machine.toString(),
      'service_type': serviceType.toString(),
      'start_date': startDate.toString(),
      'start_time': startTime.toString(),
      'end_date': endDate.toString(),
      'end_time': endTime.toString(),
      'duration': duration.toString(),
      'during_production':duringProduction.toString(),
      'service_place':refundReason

    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
  }


  Future<http.StreamedResponse> serviceUpdate(int? serviceId, String startDate,String startTime, String endDate, String endTime,String duration,int? duringProduction, String refundReason, String type,List<XFile?> file, String token) async {

    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.updateServiceUri}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    for(int i=0; i<file.length;i++){
      Uint8List list = await file[i]!.readAsBytes();
      var part = http.MultipartFile('images[]', file[i]!.readAsBytes().asStream(), list.length, filename: basename(file[i]!.path), contentType: MediaType('image', 'jpg'));
      request.files.add(part);
    }


    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'service_id': serviceId.toString(),
      'start_date': startDate.toString(),
      'start_time': startTime.toString(),
      'end_date': endDate.toString(),
      'end_time': endTime.toString(),
      'duration': duration.toString(),
      'during_production':duringProduction.toString(),
      'service_place':refundReason,
      'service_type':type

    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
  }


  Future<ApiResponse> getServiceInfo(int? saleId) async {
    try {
      final response = await dioClient!.get('${AppConstants.saleRequestPreReqUri}?sale_id=$saleId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }


  Future<ApiResponse> deleteService(int? serviceId) async {
    try {
      final response = await dioClient!.get('${AppConstants.deleteService}/$serviceId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getServiceResult(int? saleDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.refundResultUri}?id=$saleDetailsId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> cancelSale(int? saleId) async {
    try {
      final response = await dioClient!.get('${AppConstants.cancelSaleUri}?sale_id=$saleId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> approveSale(int? saleId,String? serviceMan) async {
    try {
      final response = await dioClient!.get('${AppConstants.approveSaleUri}?sale_id=$saleId&service_man=$serviceMan');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> trackYourSale(String saleNo) async {
    try {
      final response = await dioClient!.post(AppConstants.saleTrack,
          data: {'sale_number': saleNo,

      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> downloadDigitalProduct(int saleDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.downloadDigitalProduct}$saleDetailsId?guest_id=${Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resendOtpForDigitalProduct(int saleId) async {
    try {
      final response = await dioClient!.post(AppConstants.otpVResendForDigitalProduct,
      data: {'sale_details_id' : saleId});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> otpVerificationForDigitalProduct(int saleId, String otp) async {
    try {
      final response = await dioClient!.get('${AppConstants.otpVerificationForDigitalProduct}?sale_details_id=$saleId&otp=$otp&guest_id=1',);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resale(String saleId) async {
    try {
      final response = await dioClient!.post(AppConstants.resale,
          data: {'sale_id': saleId,
          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




}
