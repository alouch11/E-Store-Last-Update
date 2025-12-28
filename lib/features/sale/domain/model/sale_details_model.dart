
import 'dart:convert';

import '../../../shop/domain/model/seller_model.dart';
import 'sale_model.dart';

class SaleDetailsModel {
  int? _id;
  int? _saleId;
  int? _productId;
  String? _productCode;
  String? _productDescription;
  double? _qty;
  double? _qtydelivered;
  double? _qtyremaining;
  double? _price;
  String? _qtyunit;
  String? _comment;
  List<String>? _attachments;
  int? _alreadyComment;
  int? _position;
  String? _warehouse;
  String? _location;
  Sales? _sale;


  SaleDetailsModel(
      {int? id,
        int? saleId,
        int? productId,
        String? productCode,
        String? productDescription,
        double? qty,
        double? price,
        double? discount,
        Seller? seller,
        double? qtydelivered,
        double? qtyremaining,
        String? qtyunit ,
        String? comment,
        List<String>? attachments,
        int? alreadyComment,
        int? position,
        String? warehouse,
        String? location,
        Sales? sale,

      }) {
    _id = id;
    _saleId = saleId;
    _productId = productId;
    _productCode = productCode;
    _productDescription = productDescription;
    _qty = qty;
    _qtyunit = qtyunit;
    _qtydelivered = qtydelivered;
    _qtyremaining = qtyremaining;
    _price = price;
    _comment=comment;
    _alreadyComment = alreadyComment;
    _attachments=attachments;
    _position=position;
    _warehouse=warehouse;
    _location=location;
     _sale=sale;

  }

  int? get id => _id;
  int? get saleId => _saleId;
  int? get productId => _productId;
  String? get productCode => _productCode;
  String? get productDescription => _productDescription;
  double? get qty => _qty;
  double? get price => _price;
  double? get qtydelivered => _qtydelivered;
  double? get qtyremaining => _qtyremaining;
  String? get qtyunit => _qtyunit;
  String? get comment => _comment;
  List<String>? get attachments => _attachments;
  int? get alreadyComment => _alreadyComment;
  int? get position => _position;
  String? get warehouse => _warehouse;
  String? get location => _location;
  Sales? get sale => _sale;


  SaleDetailsModel.fromJson(Map<String, dynamic> json) {
    _id = json['BLKODU'];
    _saleId = json['BLMASKODU'];
    _productId = json['BLSTKODU'];
    _productCode= json['STOKKODU'];
    _productDescription= json['STOK_ADI'];
    _qty = json['MIKTARI'].toDouble();
    _qtydelivered = json['MIKTARI_TESLIM']!= null ? json['MIKTARI_TESLIM'].toDouble():0;
    _qtyremaining = json['MIKTARI_KALAN']!= null ?json['MIKTARI_KALAN']!.toDouble():0;
    _qtyunit = json['BIRIMI'];
    _price = json['DVZ_FIYATI'].toDouble();
    if(json['OZELALANTANIM_127'] != null){
      try{
        _attachments = json['OZELALANTANIM_127'] != null ? json['OZELALANTANIM_127'].cast<String>() : [];
      }catch(e){
        _attachments = json['OZELALANTANIM_127'] != null ? jsonDecode(json['OZELALANTANIM_127']).cast<String>() : [];
      }

    }

    if(json['OZELALANTANIM_58'] != null) {
      _alreadyComment = 1;
    }
    else {
      _alreadyComment = 0;
    }

    _comment= json['OZELALANTANIM_58'];
    _position = json['SIRA_NO'];
    _warehouse = json['DEPO_ADI'];
    _location = json['OZELALANTANIM_106'];
    if(json['sale'] != null) {
      _sale = Sales.fromJson(json['sale']);
    }

  }


}