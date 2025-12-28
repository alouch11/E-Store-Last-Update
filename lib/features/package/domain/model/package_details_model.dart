
import 'package:flutter_spareparts_store/features/product/domain/model/product_model.dart';


class PackageDetailsModel {
  int? _id;
  int? _packageId;
  int? _productId;
  String? _productCode;
  String? _productDescription;
  //String? _productImage;
  int? _sellerId;
  //Product? _productDetails;
  double? _qty;
  double? _price;
  String? _priceUnit;
  //Package? package;
  Product? product;
  //String? _qtyunit;


  PackageDetailsModel(
      {int? id,
        int? packageId,
        int? productId,
        String? productCode,
        String? productDescription,
        //String? productImage,
        int? sellerId,
        //Product? productDetails,
        double? qty,
        double? price,
        String? priceUnit,
        //Package? package,
        Product? product,
       // String? qtyunit ,

      }) {
    _id = id;
    _packageId = packageId;
    _productId = productId;
    _productCode= productCode;
    _productDescription= productDescription;
    //_productImage= productImage;
    _sellerId = sellerId;
    //_productDetails = productDetails;
    _qty = qty;
    //_qtyunit = qtyunit;
    _price = price;
    _priceUnit = priceUnit;
    //this.package;
    this.product;

  }

  int? get id => _id;
  int? get packageId => _packageId;
  int? get productId => _productId;
  String? get productCode => _productCode;
  String? get productDescription => _productDescription;
 // String? get productImage => _productImage;
  int? get sellerId => _sellerId;
  //Product? get productDetails => _productDetails;
  double? get qty => _qty;
  double? get price => _price;
  String? get priceUnit => _priceUnit;

  //String? get qtyunit => _qtyunit;


  PackageDetailsModel.fromJson(Map<String, dynamic> json) {
    _id = json['BLKODU'];
    _packageId = json['BLMASKODU'];
    _productCode = json['STOKKODU'];
    _productDescription = json['STOK_ADI'];
    //_productImage = json['product_image'];
    _sellerId = json['seller_id'];
/*    if(json['product_details'] != null) {
      _productDetails = Product.fromJson(json['product_details']);
    }*/
    _qty = json['MIKTARI'].toDouble();
    //_qtyunit = json['qty_unit'];
    _price = json['FIYATI'].toDouble();
    _priceUnit = json['DOVIZ_BIRIMI'];
    //package = json['package'] != null ? Package.fromJson(json['package']) : null;
    if(json['product'] != null) {
      product = Product.fromJson(json['product']);
    }
  }
}

/*class Package {
  int? isShippingFree;
  Package({this.isShippingFree});
  Package.fromJson(Map<String, dynamic> json) {
    isShippingFree = json['is_shipping_free']?1:0;
  }
}*/
