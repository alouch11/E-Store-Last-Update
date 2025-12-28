import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/add_service_model.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/image_model.dart';
import 'package:flutter_spareparts_store/features/sale/domain/model/sale_model.dart';


abstract class AddProductServiceInterface {
  Future<dynamic> getAttributeList(String languageCode);
  Future<dynamic> getBrandList(String languageCode);
  Future<dynamic> getEditProduct(int? id);
  Future<dynamic> getCategoryList(String languageCode);
  Future<dynamic> getSubCategoryList();
  Future<dynamic> getSubSubCategoryList();
  Future<dynamic> addImage(BuildContext context, ImageModel imageForUpload, bool colorActivate);
  Future<dynamic> addProduct(Sales product, AddServiceModel addProduct, Map<String, dynamic> attributes, List<Map<String, dynamic>>? productImages, String? thumbnail, String? metaImage, bool isAdd, bool isActiveColor, List<String?> tags, String? digitalFileReady, bool? isDigitalVariationActive, String? token);
  Future<dynamic> uploadDigitalProduct(File? filePath, String token);
  Future<dynamic> deleteProductImage(String id, String name, String? color );
  Future<dynamic> getProductImage(String id );
  Future<dynamic> deleteDigitalVariationFile(int? productId, String variantKey);
}