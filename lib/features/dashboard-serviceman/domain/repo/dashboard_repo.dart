
import 'package:flutter_spareparts_store/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_spareparts_store/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'dart:async';

class DashboardRepo {
  final DioClient? dioClient;

  DashboardRepo({required this.dioClient});



  Future<ApiResponse> getDashboardData() async {
    try {
      final response = await dioClient!.get('${AppConstants.dashboardUrl}?sections=top_cards,recent_services');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getMonthlyChartData(String year,String month) async {
    try {
      final response = await dioClient!.get('${AppConstants.dashboardUrl}?sections=service_stats&stats_type=full_month&year=$year&month=$month');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getYearlyChartData(String year) async {
    try {
      final response = await dioClient!.get('${AppConstants.dashboardUrl}?sections=service_stats&stats_type=full_year&year=$year');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
///////////////////////Amounts/////////////////////////

  Future<ApiResponse> getMonthlyChartAmount(String year,String month) async {
    try {
      final response = await dioClient!.get('${AppConstants.dashboardUrl}?sections=service_amount&stats_type=full_month&year=$year&month=$month');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getYearlyChartAmount(String year) async {
    try {
      final response = await dioClient!.get('${AppConstants.dashboardUrl}?sections=service_amount&stats_type=full_year&year=$year');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}
