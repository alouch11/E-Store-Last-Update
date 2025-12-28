
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

class PackageRepo {
  final DioClient? dioClient;

  PackageRepo({required this.dioClient});

  Future<ApiResponse> getPackageList(int offset, String line, String? hour, String? machine) async {
    try {
      final response = await dioClient!.get('${AppConstants.packageUri}$offset&line=$line&hour=$hour&machine=$machine');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getPackageDetails(String packageID) async {
    try {
      final response = await dioClient!.get(
        AppConstants.packageDetailsUri+packageID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getPackageFromPackageId(String packageID) async {
    try {
      final response = await dioClient!.get('${AppConstants.getPackageFromPackageId}$packageID&guest_id=${Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getTrackingInfo(String packageID) async {
    try {
      final response = await dioClient!.get(AppConstants.trackingUri+packageID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<http.StreamedResponse> refundRequest(int? packageDetailsId, double? amount, String refundReason, List<XFile?> file, String token) async {

    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.refundRequestUri}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    for(int i=0; i<file.length;i++){
      Uint8List list = await file[i]!.readAsBytes();
      var part = http.MultipartFile('images[]', file[i]!.readAsBytes().asStream(), list.length, filename: basename(file[i]!.path), contentType: MediaType('image', 'jpg'));
      request.files.add(part);
    }
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'package_details_id': packageDetailsId.toString(),
      'amount': amount.toString(),
      'refund_reason':refundReason
    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<ApiResponse> getRefundInfo(int? packageDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.refundRequestPreReqUri}?package_details_id=$packageDetailsId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }
  Future<ApiResponse> getRefundResult(int? packageDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.refundResultUri}?id=$packageDetailsId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> cancelPackage(int? packageId) async {
    try {
      final response = await dioClient!.get('${AppConstants.cancelPackageUri}?package_id=$packageId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> trackYourPackage(String packageId, String phoneNumber) async {
    try {
      final response = await dioClient!.post(AppConstants.packageTrack,
          data: {'package_id': packageId,
            'phone_number' : phoneNumber

      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> downloadDigitalProduct(int packageDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.downloadDigitalProduct}$packageDetailsId?guest_id=${Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resendOtpForDigitalProduct(int packageId) async {
    try {
      final response = await dioClient!.post(AppConstants.otpVResendForDigitalProduct,
      data: {'package_details_id' : packageId});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> otpVerificationForDigitalProduct(int packageId, String otp) async {
    try {
      final response = await dioClient!.get('${AppConstants.otpVerificationForDigitalProduct}?package_details_id=$packageId&otp=$otp&guest_id=1',);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> repackage(String packageId) async {
    try {
      final response = await dioClient!.post(AppConstants.repackage,
          data: {'package_id': packageId,
          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




}
