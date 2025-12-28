
import 'package:flutter_spareparts_store/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_spareparts_store/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'dart:async';
class MachinesRepo {
  final DioClient? dioClient;

  MachinesRepo({required this.dioClient});



  Future<ApiResponse> getMachineEmergencyList(int machineid,int? level) async {
    try {

      final response = await dioClient!.get('${AppConstants.machineEmergencyUri}$machineid&level=$level');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> searchAsset(String assetCode) async {
    try {
      final response = await dioClient!.post(AppConstants.searchAsset,
          data: {'asset_code': assetCode,

          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getMachineTechnicalDocList(int machineid) async {
    try {

      final response = await dioClient!.get('${AppConstants.machineTechnicalDocUri}$machineid');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> getMachineParametersList(int machineid) async {
    try {

      final response = await dioClient!.get('${AppConstants.machineParametersUri}$machineid');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getMachineMaintenanceList(int machineid,int? maintenance) async {
    try {

      final response = await dioClient!.get('${AppConstants.machineMaintenanceUri}$machineid&maintenance=$maintenance');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getMachineAssemblyList(int machineid) async {
    try {

      final response = await dioClient!.get('${AppConstants.machineAssemblyListUri}$machineid');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getMachineAssemblyParts(int machineid,String assemblycode) async {
    try {

      final response = await dioClient!.get('${AppConstants.machineAssemblyPartsUri}$machineid&assemblycode=$assemblycode');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
