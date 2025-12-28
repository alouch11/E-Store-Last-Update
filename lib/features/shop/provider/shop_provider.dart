import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/features/shop/domain/model/seller_model.dart';
import 'package:flutter_spareparts_store/features/shop/domain/repo/shop_repo.dart';
import 'package:flutter_spareparts_store/helper/api_checker.dart';
import 'package:flutter_spareparts_store/features/home/model/more_store_model.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../brand/controllers/brand_controller.dart';
import '../../product/provider/product_provider.dart';

class SellerProvider extends ChangeNotifier {
  final SellerRepo? sellerRepo;
  SellerProvider({required this.sellerRepo});

  List<SellerModel> _orderSellerList = [];
  SellerModel? _sellerModel;

  List<SellerModel> get orderSellerList => _orderSellerList;
  SellerModel? get sellerModel => _sellerModel;

  void initSeller(String sellerId, BuildContext context) async {
    _orderSellerList =[];
    ApiResponse apiResponse = await sellerRepo!.getSeller(sellerId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _orderSellerList =[];
      _orderSellerList.add(SellerModel.fromJson(apiResponse.response!.data));
      _sellerModel = SellerModel.fromJson(apiResponse.response!.data);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


    bool sellerLoading = false;

    List<SellerModel> sellerList =[];
    Future<ApiResponse> getAllSellerList() async {
      sellerList = [];
      sellerLoading = true;
      ApiResponse apiResponse = await sellerRepo!.getAllSellerList();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        apiResponse.response?.data.forEach((store)=> sellerList.add(SellerModel.fromJson(store)));
      } else {
        sellerLoading = false;
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
      return apiResponse;
    }


  List<SellerModel>? _sellersList;
  List<SellerModel>? get sellersList => _sellersList;
  List<int> selectedSellers = [];
  void checkedToggleSeller(int index){
    _sellersList![index].seller?.isSelected = _sellersList![index].seller?.isSelected;
    notifyListeners();
  }



  void resetChecked(int? id, bool fromShop){
    if(fromShop){
      getAllSellerList();
      Provider.of<BrandController>(Get.context!, listen: false).getSellerWiseBrandList(id!);
      Provider.of<ProductProvider>(Get.context!, listen: false).getSellerProductList(id.toString(), 1, Get.context!);
    }else{
      getAllSellerList();
      Provider.of<BrandController>(Get.context!, listen: false).getBrandList(true);
    }
  }

  int get filterIndex => _filterIndex;
  int _filterIndex = 0;
  String sortText = 'low-high';
  void setFilterIndex(int index) {
    _filterIndex = index;
    if(index == 0){
      sortText = 'latest';
    }else if(index == 1){
      sortText = 'a-z';
    }else if(index == 2){
      sortText = 'z-a';
    }
    else if(index == 3){
      sortText = 'low-high';
    }else if(index ==4){
      sortText = 'high-low';
    }


    notifyListeners();
  }



  int shopMenuIndex = 0;
  void setMenuItemIndex(int index, {bool notify = true}){
    debugPrint('===================index is ===> ${index.toString()}');
    shopMenuIndex = index;
    if(notify){
      notifyListeners();
    }

  }

  bool isLoading = false;

  List<MoreStoreModel> moreStoreList =[];
  Future<ApiResponse> getMoreStore() async {
    moreStoreList = [];
    isLoading = true;
    ApiResponse apiResponse = await sellerRepo!.getMoreStore();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      apiResponse.response?.data.forEach((store)=> moreStoreList.add(MoreStoreModel.fromJson(store)));
    } else {
      isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

}
