
import 'package:flutter_spareparts_store/features/product/domain/model/product_model.dart';
import '../../../shop/domain/model/seller_model.dart';

class ProductsTransactionsModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<TransactionsModel>? transactionsDetails;

  ProductsTransactionsModel({this.totalSize, this.limit, this.offset, this.transactionsDetails});

  ProductsTransactionsModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['transactions_details'] != null) {
      transactionsDetails = <TransactionsModel>[];
      json['transactions_details'].forEach((v) {
        transactionsDetails!.add(TransactionsModel.fromJson(v));
      });
    }
  }

}



class TransactionsModel {
  int? _id;
  int? _orderId;
  int? _productId;
  int? _sellerId;
  String? _digitalFileAfterSell;
  Product? _productDetails;
  double? _qty;
  double? _qtydelivered;
  double? _qtyremaining;
  double? _price;
  double? _tax;
  String? _taxModel;
  double? _discount;
  String? _deliveryStatus;
  String? _paymentStatus;
  String? _createdAt;
  String? _updatedAt;
  int? _shippingMethodId;
  String? _variant;
  int? _refundReq;
  Seller? _seller;
  List<VerificationImages>? verificationImages;
  //Order? order;
  Product? product;
  String? _qtyunit;

  TransactionsModel(
      {int? id,
        int? orderId,
        int? productId,
        int? sellerId,
        String? digitalFileAfterSell,
        Product? productDetails,
        double? qty,
        double? price,
        double? tax,
        String? taxModel,
        double? discount,
        String? deliveryStatus,
        String? paymentStatus,
        String? createdAt,
        String? updatedAt,
        int? shippingMethodId,
        String? variant,
        int? refundReq,
        Seller? seller,
        List<VerificationImages>? verificationImages,
        //Order? order,
        Product? product,
        double? qtydelivered,
        double? qtyremaining,
        String? qtyunit ,

      }) {
    _id = id;
    _orderId = orderId;
    _productId = productId;
    _sellerId = sellerId;
    if(digitalFileAfterSell != null){
      _digitalFileAfterSell = digitalFileAfterSell;
    }
    _productDetails = productDetails;
    _qty = qty;
    _qtyunit = qtyunit;
    _qtydelivered = qtydelivered;
    _qtyremaining = qtyremaining;
    _price = price;
    _tax = tax;
    _taxModel = taxModel;
    _discount = discount;
    _deliveryStatus = deliveryStatus;
    _paymentStatus = paymentStatus;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _shippingMethodId = shippingMethodId;
    _variant = variant;
    _refundReq = refundReq;
    if (seller != null) {
      _seller = seller;
    }
    this.verificationImages;
    //this.order;
    this.product;
  }

  int? get id => _id;
  int? get orderId => _orderId;
  int? get productId => _productId;
  int? get sellerId => _sellerId;
  String? get digitalFileAfterSell => _digitalFileAfterSell;
  Product? get productDetails => _productDetails;
  double? get qty => _qty;
  double? get price => _price;
  double? get tax => _tax;
  String? get taxModel => _taxModel;
  double? get discount => _discount;
  String? get deliveryStatus => _deliveryStatus;
  String? get paymentStatus => _paymentStatus;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get shippingMethodId => _shippingMethodId;
  String? get variant => _variant;
  int? get refundReq => _refundReq;
  Seller? get seller => _seller;
  double? get qtydelivered => _qtydelivered;
  double? get qtyremaining => _qtyremaining;
  String? get qtyunit => _qtyunit;


  TransactionsModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _productId = json['product_id'];
    _sellerId = json['seller_id'];
    if(json['digital_file_after_sell'] != null) {
      _digitalFileAfterSell = json['digital_file_after_sell'];
    }
    if(json['product_details'] != null) {
      _productDetails = Product.fromJson(json['product_details']);
    }
    _qty = json['qty'].toDouble();
    _qtydelivered = json['qty_delivered'].toDouble();
    _qtyremaining = json['qty_remaining'].toDouble();
    _qtyunit = json['qty_unit'];
    _price = json['price'].toDouble();
    _tax = json['tax'].toDouble();
    _taxModel = json['tax_model'];
    _discount = json['discount'].toDouble();
    _deliveryStatus = json['delivery_status'];
    _paymentStatus = json['payment_status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _shippingMethodId = json['shipping_method_id'];
    _variant = json['variant'];
    _refundReq = json['refund_request'];
    _seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    if (json['verification_images'] != null) {
      verificationImages = <VerificationImages>[];
      json['verification_images'].forEach((v) {
        verificationImages!.add(VerificationImages.fromJson(v));
      });
    }
/*     if (json['itemlist'] != null) {
      itemlist = <List>[];
      json['itemlist'].forEach((v) {
        itemlist!.add(v);
      });
    }

   if (json['itemlist'] != null) {
      itemlist = [];
      itemlist = List<dynamic>.from(itemlist!.map((x) => x));
    }*/

    //order = json['order'] != null ? Order.fromJson(json['order']) : null;
    if(json['product'] != null) {
      product = Product.fromJson(json['product']);
    }
  }
}


class VerificationImages {
  int? id;
  int? orderId;
  String? image;
  String? createdAt;
  String? updatedAt;
  VerificationImages({this.id, this.orderId, this.image, this.createdAt, this.updatedAt});
  VerificationImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

/*class Order {
  int? isShippingFree;
  Order({this.isShippingFree});
  Order.fromJson(Map<String, dynamic> json) {
    isShippingFree = json['is_shipping_free']?1:0;
  }
}*/
