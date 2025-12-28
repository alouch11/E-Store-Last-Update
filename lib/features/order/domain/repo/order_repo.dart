
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

class OrderRepo {
  final DioClient? dioClient;

  OrderRepo({required this.dioClient});

  Future<ApiResponse> getOrderList(int offset, String status,int orderType, {String? types,String? suppliers,String? persons,String? lines,String? machines,String? startDate,String? endDate}) async {
    try {
      final response = await dioClient!.get('${AppConstants.orderUri}$offset&status=$status&ordertype=$orderType&types=$types&suppliers=$suppliers&persons=$persons&lines=$lines&machines=$machines&startDate=$startDate&endDate=$endDate');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getOrderListByProduct(int offset, String status,String product ,{String? types,String? suppliers,String? persons,String? lines,String? machines,String? startDate,String? endDate}) async {
    try {
      final response = await dioClient!.get('${AppConstants.orderUriByProduct}$offset&status=$status&product_id=$product&type=$types&suppliers=$suppliers&persons=$persons&lines=$lines&machines=$machines&startDate=$startDate&endDate=$endDate');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getOrderDetails(String orderID) async {
    try {
      final response = await dioClient!.get(
        AppConstants.orderDetailsUri+orderID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderFromOrderId(String orderID) async {
    try {
      final response = await dioClient!.get('${AppConstants.getOrderFromOrderId}$orderID&guest_id=${Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getTrackingInfo(String orderID) async {
    try {
      final response = await dioClient!.get(AppConstants.trackingUri+orderID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<http.StreamedResponse> refundRequest(int? orderDetailsId, double? amount, String refundReason, List<XFile?> file, String token) async {

    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.refundRequestUri}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    for(int i=0; i<file.length;i++){
      Uint8List list = await file[i]!.readAsBytes();
      var part = http.MultipartFile('images[]', file[i]!.readAsBytes().asStream(), list.length, filename: basename(file[i]!.path), contentType: MediaType('image', 'jpg'));
      request.files.add(part);
    }
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'order_details_id': orderDetailsId.toString(),
      'amount': amount.toString(),
      'refund_reason':refundReason
    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<ApiResponse> getRefundInfo(int? orderDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.refundRequestPreReqUri}?order_details_id=$orderDetailsId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }
  Future<ApiResponse> getRefundResult(int? orderDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.refundResultUri}?id=$orderDetailsId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> cancelOrder(int? orderId) async {
    try {
      final response = await dioClient!.get('${AppConstants.cancelOrderUri}?order_id=$orderId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> trackYourOrder(String orderNo, String orderType) async {
    try {
      final response = await dioClient!.post(AppConstants.orderTrack,
          data: {'order_number': orderNo,
                 'order_type' : orderType

      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> downloadDigitalProduct(int orderDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.downloadDigitalProduct}$orderDetailsId?guest_id=${Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resendOtpForDigitalProduct(int orderId) async {
    try {
      final response = await dioClient!.post(AppConstants.otpVResendForDigitalProduct,
      data: {'order_details_id' : orderId});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> otpVerificationForDigitalProduct(int orderId, String otp) async {
    try {
      final response = await dioClient!.get('${AppConstants.otpVerificationForDigitalProduct}?order_details_id=$orderId&otp=$otp&guest_id=1',);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> reorder(String orderId) async {
    try {
      final response = await dioClient!.post(AppConstants.reorder,
          data: {'order_id': orderId,
          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




}
