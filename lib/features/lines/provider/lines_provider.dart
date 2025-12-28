import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/lines_model.dart';
import 'package:flutter_spareparts_store/features/lines/domain/repo/lines_repo.dart';
import 'package:flutter_spareparts_store/helper/api_checker.dart';
import 'dart:async';
import 'package:flutter/material.dart';



class LinesProvider with ChangeNotifier {
  final LinesRepo? linesRepo;

  LinesProvider({required this.linesRepo});



  LinesModel? linesModelBk;
  LinesModel? linesModelMk;
  Future<void> getLinesList(int offset,String? site) async {
    if (offset == 1) {
      linesModelBk = null;
      linesModelMk = null;
    }
    ApiResponse apiResponse = await linesRepo!.getLinesList(offset,site);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {

      if (site == 'Bekoko') {
      if (offset == 1) {
        linesModelBk = LinesModel.fromJson(apiResponse.response?.data);
      } else {
        linesModelBk!.lines!.addAll(LinesModel
            .fromJson(apiResponse.response?.data)
            .lines!);
        linesModelBk!.offset = LinesModel
            .fromJson(apiResponse.response?.data)
            .offset;
        linesModelBk!.totalLines = LinesModel
            .fromJson(apiResponse.response?.data)
            .totalLines;
      }
    }
      if (site == 'Muyuka') {
        if (offset == 1) {
          linesModelMk = LinesModel.fromJson(apiResponse.response?.data);
        } else {
          linesModelMk!.lines!.addAll(LinesModel
              .fromJson(apiResponse.response?.data)
              .lines!);
          linesModelMk!.offset = LinesModel
              .fromJson(apiResponse.response?.data)
              .offset;
          linesModelMk!.totalLines = LinesModel
              .fromJson(apiResponse.response?.data)
              .totalLines;
        }
      }
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }







  LinesMachinesModel? linesMachinesGroupModelBk;
  LinesMachinesModel? linesMachinesGroupModelMk;
  Future<void>getLinesMachinesGroupList(String? site) async {
      linesMachinesGroupModelBk = null;
      linesMachinesGroupModelMk = null;

    ApiResponse apiResponse = await linesRepo!.getLinesMachinesGroupList(site);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {

      if (site == 'Bekoko') {
          linesMachinesGroupModelBk = LinesMachinesModel.fromJson(apiResponse.response?.data);
      }
      if (site == 'Muyuka') {
        linesMachinesGroupModelMk = LinesMachinesModel.fromJson(apiResponse.response?.data);
      }
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

}










