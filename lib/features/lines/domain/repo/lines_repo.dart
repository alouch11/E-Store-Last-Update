
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

class LinesRepo {
  final DioClient? dioClient;

  LinesRepo({required this.dioClient});

  Future<ApiResponse> getLinesList(int offset,String? site) async {
    try {

      final response = await dioClient!.get('${AppConstants.linesUri}$offset&site=$site');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getLinesMachinesGroupList(String? site) async {
    try {

      final response = await dioClient!.get('${AppConstants.linesMachinesGroupUri}$site');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



}
