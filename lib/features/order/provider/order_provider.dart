import 'dart:convert';
import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/features/order/domain/model/order_details_model.dart';
import 'package:flutter_spareparts_store/features/order/domain/model/refund_info_model.dart';
import 'package:flutter_spareparts_store/features/order/domain/model/refund_result_model.dart';
import 'package:flutter_spareparts_store/features/order/domain/model/order_model.dart';
import 'package:flutter_spareparts_store/features/order/domain/repo/order_repo.dart';
import 'package:flutter_spareparts_store/helper/api_checker.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utill/app_constants.dart';

class OrderProvider with ChangeNotifier {
  final OrderRepo? orderRepo;
  OrderProvider({required this.orderRepo});

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

  OrderModel? orderModel;
  OrderModel? deliveredOrderModel;
  Future<void> getOrderList(int offset, String status,int orderType, {String? types,String? suppliers,String? persons,String? lines,String? machines,String? startDate,String? endDate}) async {
    if(offset == 1){
      orderModel = null;
    }
    ApiResponse apiResponse = await orderRepo!.getOrderList(offset, status,orderType, types: types, suppliers: suppliers, persons: persons, lines: lines, machines: machines,startDate:startDate,endDate:endDate);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        orderModel = OrderModel.fromJson(apiResponse.response?.data);
        if(types == 'reorder'){
          deliveredOrderModel = OrderModel.fromJson(apiResponse.response?.data);
        }
      }else {
        orderModel!.orders!.addAll(OrderModel.fromJson(apiResponse.response?.data).orders!);
        orderModel!.offset = OrderModel.fromJson(apiResponse.response?.data).offset;
        orderModel!.totalSize = OrderModel.fromJson(apiResponse.response?.data).totalSize;
      }

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }



  OrderModel? orderModelByProduct;
  Future<void> getOrderListByProduct(int offset, String status,String product, {String? types,String? suppliers,String? persons,String? lines,String? machines,String? startDate,String? endDate}) async {

    if(offset == 1){
      orderModelByProduct = null;
    }
    ApiResponse apiResponse = await orderRepo!.getOrderListByProduct(offset, status,product ,types: types, suppliers: suppliers, persons: persons, lines: lines, machines: machines,startDate:startDate,endDate:endDate);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        orderModelByProduct = OrderModel.fromJson(apiResponse.response?.data);
      }else {
        orderModelByProduct!.orders!.addAll(OrderModel.fromJson(apiResponse.response?.data).orders!);
        orderModelByProduct!.offset = OrderModel.fromJson(apiResponse.response?.data).offset;
        orderModelByProduct!.totalSize = OrderModel.fromJson(apiResponse.response?.data).totalSize;
        orderModelByProduct!.totalApproved = OrderModel.fromJson(apiResponse.response?.data).totalApproved;
        orderModelByProduct!.totalCanceled = OrderModel.fromJson(apiResponse.response?.data).totalCanceled;
        orderModelByProduct!.totalPending = OrderModel.fromJson(apiResponse.response?.data).totalPending;
        orderModelByProduct!.totalSigned = OrderModel.fromJson(apiResponse.response?.data).totalSigned;
        orderModelByProduct!.totalPartiallyDelivered = OrderModel.fromJson(apiResponse.response?.data).totalPartiallyDelivered;
      }

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  List<dynamic> selectedOrderLineList = [];
  List<dynamic> selectedOrderMachineList = [];
  List<dynamic> selectedOrderSupplierList = [];
  List<dynamic> selectedOrderTypeList = [];
  List<dynamic> selectedOrderPersonList =[];

  String selectedOrderStartDate ="2000-01-01";
  String selectedOrderEndDate = "2200-01-01";

  int _orderTypeIndex = 0;
  int get orderTypeIndex => _orderTypeIndex;

  String selectedType = 'pending';
  void setIndex(int index,{bool notify = true}) {
    _orderTypeIndex = index;
    if(_orderTypeIndex == 0){
      selectedType = 'pending';
      getOrderList(1, 'pending', 4,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }else if(_orderTypeIndex == 1){
      selectedType = 'approved';
      getOrderList(1, 'approved', 4,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList) :  null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }else if(_orderTypeIndex == 2){
      selectedType = 'delivered';
      getOrderList(1, 'delivered', 4,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }
    else if(_orderTypeIndex == 3){
      selectedType = 'canceled';
      getOrderList(1, 'canceled', 4,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }
    else if(_orderTypeIndex == 4){
      selectedType = 'lpending';
      getOrderList(1, 'lpending', 2,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }else if(_orderTypeIndex == 5){
      selectedType = 'lapproved';
      getOrderList(1, 'lapproved', 2,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList) :  null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList) : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }else if(_orderTypeIndex == 6){
      selectedType = 'ldelivered';
      getOrderList(1, 'ldelivered', 2,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList) : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }
    else if(_orderTypeIndex == 7){
      selectedType = 'lcanceled';
      getOrderList(1, 'lcanceled', 2,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList) : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }
    else if(_orderTypeIndex == 8){
      selectedType = 'partially_delivered';
      getOrderList(1, 'partially_delivered', 4,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList) : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }
    else if(_orderTypeIndex == 9){
      selectedType = 'lpartially_delivered';
      getOrderList(1, 'lpartially_delivered', 2,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }
    else if(_orderTypeIndex == 10){
      selectedType = 'signed';
      getOrderList(1, 'signed', 4,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }
    else if(_orderTypeIndex == 11){
      selectedType = 'lsigned';
      getOrderList(1, 'lsigned', 2,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }
    if(notify) {
      notifyListeners();
    }
  }


  int _orderTypeByProductIndex = 0;
  int get orderTypeByProductIndex => _orderTypeByProductIndex;

  String selectedTypeByProduct = 'pending';
  void setIndexByProduct(int index, String productId, {bool notify = true}) {
    _orderTypeByProductIndex = index;
    if(_orderTypeByProductIndex == 0){
      selectedTypeByProduct = 'pending';
      getOrderListByProduct(1, 'pending',productId,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }else if(_orderTypeByProductIndex == 1){
      selectedTypeByProduct = 'approved';
      getOrderListByProduct(1, 'approved',productId,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }else if(_orderTypeByProductIndex == 2){
      selectedTypeByProduct = 'delivered';
      getOrderListByProduct(1, 'delivered',productId,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }
    else if(_orderTypeByProductIndex == 3){
      selectedTypeByProduct = 'canceled';
      getOrderListByProduct(1, 'canceled',productId,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }
    else if(_orderTypeByProductIndex == 8){
      selectedTypeByProduct = 'partially_delivered';
      getOrderListByProduct(1, 'partially_delivered',productId,
          suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
          types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
          persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
          lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
          machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
          startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
          endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
      );
    }
    else if(_orderTypeByProductIndex == 10){
      selectedTypeByProduct = 'signed';
      getOrderListByProduct(1, 'signed',productId,
      suppliers: selectedOrderSupplierList.isNotEmpty ? jsonEncode(selectedOrderSupplierList)  : null,
    types: selectedOrderTypeList.isNotEmpty ? jsonEncode(selectedOrderTypeList)  : null,
    persons: selectedOrderPersonList.isNotEmpty ? jsonEncode(selectedOrderPersonList)  : null,
    lines:  selectedOrderLineList.isNotEmpty ? jsonEncode(selectedOrderLineList)  : null,
    machines: selectedOrderMachineList.isNotEmpty ? jsonEncode(selectedOrderMachineList)  : null,
    startDate: selectedOrderStartDate !="2000-01-01" ? selectedOrderStartDate : "2000-01-01",
    endDate: selectedOrderEndDate !="2200-01-01" ? selectedOrderEndDate : "2200-01-01"
    );
    }
    if(notify) {
      notifyListeners();
    }
  }



  List<OrderDetailsModel>? _orderDetails;
  List<OrderDetailsModel>? get orderDetails => _orderDetails;

  Future <ApiResponse> getOrderDetails(String orderID) async {
    _orderDetails = null;
    ApiResponse apiResponse = await orderRepo!.getOrderDetails(orderID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _orderDetails = null;
      _orderDetails = [];
      apiResponse.response!.data.forEach((order) => _orderDetails!.add(OrderDetailsModel.fromJson(order)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }




  Orders? orders;
  Future <void> getOrderFromOrderId(String orderID) async {
    ApiResponse apiResponse = await orderRepo!.getOrderFromOrderId(orderID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      orders = Orders.fromJson(apiResponse.response!.data);
     // log("===Delivery MAN==> ${orders?.deliveryMan?.fName}");
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



  Orders? trackingModel;
  Future<void> initTrackingInfo(String orderID) async {
      ApiResponse apiResponse = await orderRepo!.getTrackingInfo(orderID);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        trackingModel = Orders.fromJson(apiResponse.response!.data);
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
  }

  void pickImage(bool isRemove, {bool fromReview = false}) async {
    if(isRemove) {
      _imageFile = null;
      _refundImage = [];
      reviewImages = [];
    }else {
      _imageFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 20);
      if (_imageFile != null) {
        if(fromReview){
          reviewImages.add(File(_imageFile!.path));
        }else{
          _refundImage.add(_imageFile);
        }
      }
    }
    notifyListeners();
  }


  void removeImage(int index, {bool fromReview = false}){
    if(fromReview){
      reviewImages.removeAt(index);
    }else{
      _refundImage.removeAt(index);
    }

    notifyListeners();
  }

  Future<http.StreamedResponse> refundRequest(BuildContext context, int? orderDetailsId, double? amount, String refundReason, String token) async {
    _isLoading = true;
    notifyListeners();
    http.StreamedResponse response = await orderRepo!.refundRequest(orderDetailsId, amount, refundReason,refundImage, token);
    if (response.statusCode == 200) {
      getRefundReqInfo(orderDetailsId);
      _imageFile = null;
      _refundImage = [];
      _isLoading = false;

    } else {
      _isLoading = false;

    }
    _imageFile = null;
    _refundImage = [];
    _isLoading = false;
    notifyListeners();
    return response;
  }



  Future<ApiResponse> getRefundReqInfo(int? orderDetailId) async {
    _isRefund = true;
    ApiResponse apiResponse = await orderRepo!.getRefundInfo(orderDetailId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _refundInfoModel = RefundInfoModel.fromJson(apiResponse.response!.data);
      _isRefund = false;
    } else if(apiResponse.response!.statusCode == 202){
      _isRefund = false;
      showCustomSnackBar('${apiResponse.response!.data['message']}', Get.context!);
    }
    else {
      _isRefund = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> getRefundResult(BuildContext context, int? orderDetailId) async {
    _isLoading =true;

    ApiResponse apiResponse = await orderRepo!.getRefundResult(orderDetailId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      _refundResultModel = RefundResultModel.fromJson(apiResponse.response!.data);
    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> cancelOrder(BuildContext context, int? orderId) async {
    _isLoading = true;
    ApiResponse apiResponse = await orderRepo!.cancelOrder(orderId);
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
  Future<ApiResponse> trackYourOrder({String? orderNo, String? orderType}) async {
    searching = true;
    notifyListeners();
    ApiResponse apiResponse = await orderRepo!.trackYourOrder(orderNo!, orderType!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      searching = false;
      _orderDetails = [];
      apiResponse.response!.data.forEach((order) => _orderDetails!.add(OrderDetailsModel.fromJson(order)));
    } else {
      searching = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> downloadDigitalProduct({int? orderDetailsId}) async {
    ApiResponse apiResponse = await orderRepo!.downloadDigitalProduct(orderDetailsId!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Provider.of<AuthController>(Get.context!, listen: false).resendTime = (apiResponse.response!.data["time_count_in_second"]);
    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  Future<ApiResponse> resendOtpForDigitalProduct({int? orderId}) async {
    ApiResponse apiResponse = await orderRepo!.resendOtpForDigitalProduct(orderId!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> otpVerificationDigitalProduct({required int orderId, required String otp}) async {
    ApiResponse apiResponse = await orderRepo!.otpVerificationForDigitalProduct(orderId, otp);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Navigator.of(Get.context!).pop();
      _launchUrl(Uri.parse('${AppConstants.baseUrl}${AppConstants.otpVerificationForDigitalProduct}?order_details_id=$orderId&otp=$otp&guest_id=1&action=download'));

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


}
Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

