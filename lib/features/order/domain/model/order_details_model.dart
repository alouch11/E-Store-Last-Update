
import 'package:flutter_spareparts_store/features/product/domain/model/product_model.dart';
import 'package:flutter_spareparts_store/features/product/domain/model/product_transactions_model.dart';
import '../../../shop/domain/model/seller_model.dart';

class OrderDetailsModel {
  int? _id;
  int? _orderId;
  int? _productId;
  int? _sellerId;
  String? _productCode;
  String? _productDescription;
 // String? _digitalFileAfterSell;
  Product? _productDetails;
  //int? _qty;
  double? _qty;
  double? _qtydelivered;
  double? _qtyremaining;
  double? _price;
  double? _tax;
  String? _taxModel;
  double? _discount;
  //String? _deliveryStatus;
  //String? _paymentStatus;
  //String? _createdAt;
  //String? _updatedAt;
  //int? _shippingMethodId;
  String? _variant;
  int? _refundReq;
  Seller? _seller;
  //List<VerificationImages>? verificationImages;
  //Order? order;
  Product? product;
  String? _qtyunit;
  int? _position;
  String? _warehouse;
  String? _location;


  OrderDetailsModel(
      {int? id,
        int? orderId,
        int? productId,
        int? sellerId,
        String? productCode,
        String? productDescription,
        Product? productDetails,
        double? qty,
        double? price,
        double? tax,
        String? taxModel,
        double? discount,
        String? variant,
        int? refundReq,
        Seller? seller,
        Product? product,
        double? qtydelivered,
        double? qtyremaining,
        String? qtyunit ,
        int? position,
        String? warehouse,
        String? location,

      }) {
    _id = id;
    _orderId = orderId;
    _productId = productId;
    _productCode = productCode;
    _productDescription = productDescription;
    _productDetails = productDetails;
    _qty = qty;
    _qtyunit = qtyunit;
    _qtydelivered = qtydelivered;
    _qtyremaining = qtyremaining;
    _price = price;
    _tax = tax;
    _taxModel = taxModel;
    _discount = discount;
    _variant = variant;
    _refundReq = refundReq;
    if (seller != null) {
      _seller = seller;
    }
    _position = position;
    _warehouse=warehouse;
    _location=location;

    this.product;

  }

  int? get id => _id;
  int? get orderId => _orderId;
  int? get productId => _productId;
  String? get productCode => _productCode;
  String? get productDescription => _productDescription;
  Product? get productDetails => _productDetails;
  double? get qty => _qty;
  double? get price => _price;
  double? get tax => _tax;
  String? get taxModel => _taxModel;
  double? get discount => _discount;
  String? get variant => _variant;
  int? get refundReq => _refundReq;
  Seller? get seller => _seller;
  double? get qtydelivered => _qtydelivered;
  double? get qtyremaining => _qtyremaining;
  String? get qtyunit => _qtyunit;
  int? get position => _position;
  String? get warehouse => _warehouse;
  String? get location => _location;

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    _id = json['BLKODU'];
    _orderId = json['BLMASKODU'];
    _productId = json['BLSTKODU'];
    _productCode= json['STOKKODU'];
    _productDescription= json['STOK_ADI'];
    _productCode= json['STOKKODU'];
    _productDescription= json['STOK_ADI'];
    if(json['product_details'] != null) {
      _productDetails = Product.fromJson(json['product_details']);
    }
    _qty = json['MIKTARI'].toDouble();
    if(json['MIKTARI_TESLIM'] != null) {
      _qtydelivered = json['MIKTARI_TESLIM'].toDouble();
    }
    else {
      _qtydelivered =0;
    }
    if(json['MIKTARI_KALAN'] != null) {
      _qtyremaining = json['MIKTARI_KALAN'].toDouble();
    }
    else {
      _qtyremaining =0;
    }

    _qtyunit = json['BIRIMI'];
    if(json['DVZ_FIYATI'] != null) {
      _price = json['DVZ_FIYATI'].toDouble();
    }
    else {
      _price =0;
    }
    _tax = 0;
    _discount = 0;
    _variant = json['variant'];
    _refundReq = json['refund_request'];
    _position = json['SIRA_NO'];
    _seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    if(json['product'] != null) {
      product = Product.fromJson(json['product']);
    }
    _warehouse = json['DEPO_ADI'];
    _location = json['OZELALANTANIM_106'];
  }
}
