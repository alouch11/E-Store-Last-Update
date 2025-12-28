class SellerModel {
  Seller? _seller;
  String? _avgRating;
  int? _totalReview;
  int? _totalOrder;
  int? _totalProduct;
  double? minimumOrderAmount;

  SellerModel(
      {Seller? seller, String? avgRating, int? totalReview, int? totalOrder, int? totalProduct, double? minimumOrderAmount}) {
    if (seller != null) {
      _seller = seller;
    }
    if (avgRating != null) {
      _avgRating = avgRating;
    }
    if (totalReview != null) {
      _totalReview = totalReview;
    }
    if (totalOrder != null) {
      _totalOrder = totalOrder;
    }
    if (totalProduct != null) {
      _totalProduct = totalProduct;
    }
    if (minimumOrderAmount != null) {
      minimumOrderAmount = minimumOrderAmount;
    }
  }

  Seller? get seller => _seller;
  String? get avgRating => _avgRating;
  int? get totalReview => _totalReview;
  int? get totalOrder => _totalOrder;
  int? get totalProduct => _totalProduct;


  SellerModel.fromJson(Map<String, dynamic> json) {
    _seller =
    json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    _avgRating = json['avg_rating'].toString();
    _totalReview = json['total_review'];
    _totalOrder = json['total_order'];
    _totalProduct = json['total_product'];
    if(json['minimum_order_amount'] != null){
      try{
        minimumOrderAmount = json['minimum_order_amount'].toDouble();
      }catch(e){
        minimumOrderAmount = double.parse(json['minimum_order_amount'].toString());
      }
    }else{
      minimumOrderAmount = 0;
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_seller != null) {
      data['seller'] = _seller!.toJson();
    }
    data['avg_rating'] = _avgRating;
    data['total_review'] = _totalReview;
    data['total_order'] = _totalOrder;
    data['total_product'] = _totalProduct;
    return data;
  }
}

class Seller {
  int? _id;
  String? _fName;
  String? _lName;
  String? _phone;
  String? _image;
  bool? isSelected;

  Seller(
      {int? id,
        String? fName,
        String? lName,
        String? phone,
        String? image,
        bool? isSelected,
      }) {
    if (id != null) {
      _id = id;
    }
    if (fName != null) {
      _fName = fName;
    }
    if (lName != null) {
      _lName = lName;
    }
    if (phone != null) {
      _phone = phone;
    }
    if (image != null) {
      _image = image;
    }
    isSelected = isSelected;
  }

  int? get id => _id;
  String? get fName => _fName;
  String? get lName => _lName;
  String? get phone => _phone;
  String? get image => _image;
  //Shop? get shop => _shop;

  Seller.fromJson(Map<String, dynamic> json) {
    _id = json['BLKODU'];
    _fName = json['TICARI_UNVANI'];
    _lName = json['ADI'];
    _phone = json['TEL1'];
    _image = json['NOT_1'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BLKODU'] = _id;
    data['TICARI_UNVANI'] = _fName;
    data['ADI'] = _lName;
    data['TEL1'] = _phone;
    data['NOT_1'] = _image;
    isSelected = false;
    return data;
  }
}