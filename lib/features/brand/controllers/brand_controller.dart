import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/features/brand/domain/models/brand_model.dart';
import 'package:flutter_spareparts_store/features/brand/domain/repositories/brand_repository.dart';
import 'package:flutter_spareparts_store/helper/api_checker.dart';

class BrandController extends ChangeNotifier {
  final BrandRepository? brandRepo;

  BrandController({required this.brandRepo});

  List<BrandModel>? _brandList;

  List<BrandModel>? get brandList => _brandList;

  final List<BrandModel> _originalBrandList = [];

  Future<void> getBrandList(bool reload) async {
    if (_brandList == null || reload) {
      ApiResponse apiResponse = await brandRepo!.getBrandList();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _originalBrandList.clear();
        apiResponse.response!.data.forEach((brand) => _originalBrandList.add(BrandModel.fromJson(brand)));
        _brandList = [];
        apiResponse.response!.data.forEach((brand) => _brandList?.add(BrandModel.fromJson(brand)));
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
    }
  }

  Future<void> getSellerWiseBrandList(int sellerId) async {

      ApiResponse apiResponse = await brandRepo!.getSellerWiseBrandList(sellerId);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _originalBrandList.clear();
        apiResponse.response!.data.forEach((brand) => _originalBrandList.add(BrandModel.fromJson(brand)));
        _brandList = [];
        apiResponse.response!.data.forEach((brand) => _brandList?.add(BrandModel.fromJson(brand)));
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();

  }


  void checkedToggleBrand(int index){
    _brandList![index].checked = !_brandList![index].checked!;
    notifyListeners();
  }


  bool isAZ = true;
  bool isZA = false;
  bool isTopBrand = false;

  void sortBrandLis(int value) {
    if (value == 0) {
      _brandList = [];
      _brandList?.addAll(_originalBrandList);
      _brandList?.sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      isAZ = true;
      isZA = false;
      isTopBrand = false;
    } else if (value == 1) {
      _brandList = [];
      _brandList?.addAll(_originalBrandList);
      _brandList?.sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      Iterable iterable = _brandList!.reversed;
      _brandList = iterable.toList() as List<BrandModel>;
      isAZ = false;
      isZA = true;
      isTopBrand = false;
    } else if (value == 2) {
      _brandList = [];
      _brandList?.addAll(_originalBrandList);
      isAZ = false;
      isZA = false;
      isTopBrand = true;
    }

    notifyListeners();
  }
}
