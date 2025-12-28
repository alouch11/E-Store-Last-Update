
import 'package:flutter_spareparts_store/features/product/domain/model/product_model.dart';

class ProductDetailsModel {
  int? _id;
  String? _code;
  String? _slug;
  String? _productType;
  //int? _brandId;
  String? _unit;
  List<String>? _images;
  String? _thumbnail;
  //List<int>? _attributes;
  List<ChoiceOptions>? _choiceOptions;
  List<PartManufacture>? _partManufacture;
  List<CatalogueList>? _catalogueList;
  List<ProductData>? _productData;
  List<ApplicabilityOptions>? _applicabilityOptions;
  double? _currentStock;
  int? _minimumOrderQty;

  //String? _stockLocation;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  //int? _status;
  //String? _code;
  //Seller? _seller;
  int? wishList;
  int? _authlevel;
  List<StockLocations>? _stockLocations;
  List<StockSerials>? _stockSerials;
  String? _videoUrl;
  String? _has3d;
  String? _threedfile;
  double? _qtyRemaining;
  double? _qtyOrdered;
  double? _qtyBlocked;
  double? _qtyUsable;
  double? _qtyIn;
  double? _qtyOut;
  List<StockSuppliers>? _stockSuppliers;
  List<StockAttachments>? _stockAttachments;



  ProductDetailsModel(
      {int? id,
        String? addedBy,
        int? userId,
        String? code,
        String? slug,
        String? productType,
        List<CategoryIds>? categoryIds,
        int? brandId,
        String? unit,
        int? minQty,
        int? refundable,
        String? digitalProductType,
        String? digitalFileReady,
        List<String>? images,
        String? thumbnail,
        int? featured,
        String? videoProvider,
        String? videoUrl,
        int? variantProduct,
        List<int>? attributes,
        List<ChoiceOptions>? choiceOptions,
        List<PartManufacture>? partManufacture,
        List<CatalogueList>? catalogueList,
        List<ProductData>? productData,
        List<ApplicabilityOptions>? applicabilityOptions,
        int? published,
        double? unitPrice,
        double? purchasePrice,
        double? tax,
        String? taxModel,
        String? taxType,
        double? discount,
        String? discountType,
        double? currentStock,
        int? minimumOrderQty,
        String? stockLocation,
        String? description,
        int? freeShipping,
        String? createdAt,
        String? updatedAt,
        int? status,
        int? featuredStatus,
        String? metaTitle,
        String? metaDescription,
        String? metaImage,
        int? requestStatus,
        String? deniedNote,
        double? shippingCost,
        int? multiplyQty,
        int? reviewsCount,
        String? averageReview,
        //Seller? seller,
        int? wishList,
        int? authlevel,
        List<StockLocations>? stockLocations,
        List<StockSerials>? stockSerials,
        String? has3d,
        String? threedfile,
        double? qtyRemaining,
        double? qtyOrdered,
        double? qtyBlocked,
        double? qtyUsable,
        double? qtyIn,
        double? qtyOut,
        List<StockSuppliers>? stockSuppliers,
        List<StockAttachments>? stockAttachments,

      }) {
    if (id != null) {
      _id = id;
    }

    if (code != null) {
      _code = code;
    }
    if (slug != null) {
      _slug = slug;
    }
    if (productType != null) {
      _productType = productType;
    }
    /*if (brandId != null) {
      _brandId = brandId;
    }*/
    if (unit != null) {
      _unit = unit;
    }

    if (images != null) {
      _images = images;
    }
    if (thumbnail != null) {
      _thumbnail = thumbnail;
    }

   /* if (attributes != null) {
      _attributes = attributes;
    }*/
    if (choiceOptions != null) {
      _choiceOptions = choiceOptions;
    }
    if (partManufacture != null) {
      _partManufacture = partManufacture;
    }
    if (catalogueList != null) {
      _catalogueList = catalogueList;
    }
    if (productData != null) {
      _productData = productData;
    }
    if (applicabilityOptions != null) {
      _applicabilityOptions = applicabilityOptions;
    }
    if (currentStock != null) {
      _currentStock = currentStock;
    }
    if (minimumOrderQty != null) {
      _minimumOrderQty = minimumOrderQty;
    }

    /*if (stockLocation != null) {
      _stockLocation = stockLocation;
    }*/

    if (description != null) {
      _description = description;
    }

    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }

    if (authlevel != null) {
      _authlevel = authlevel;
    }

    if (stockLocations != null) {
      _stockLocations = stockLocations;
    }
    if (stockSerials != null) {
      _stockSerials = stockSerials;
    }

    if (videoUrl != null) {
      _videoUrl = videoUrl;
    }

    if (has3d != null) {
      _has3d = has3d;
    }

    if (threedfile != null) {
      _threedfile = threedfile;
    }
    if (stockSuppliers != null) {
      _stockSuppliers = stockSuppliers;
    }

    this.wishList;
    this.qtyRemaining;
    this.qtyOrdered;
    this.qtyBlocked;
    this.qtyUsable;
    if (qtyIn != null) {
      _qtyIn = qtyIn;
    }
    if (qtyOut != null) {
      _qtyOut = qtyOut;
    }

  }

  int? get id => _id;
  String? get has3d => _has3d;
  String? get threedfile => _threedfile;
  String? get code => _code;
  String? get slug => _slug;
  String? get productType => _productType;
  //int? get brandId => _brandId;
  String? get unit => _unit;
  List<String>? get images => _images;
  String? get thumbnail => _thumbnail;
  //List<int>? get attributes => _attributes;
  List<ChoiceOptions>? get choiceOptions => _choiceOptions;
  List<PartManufacture>? get partManufacture => _partManufacture;
  List<CatalogueList>? get catalogueList => _catalogueList;
  List<ProductData>? get productData => _productData;
  List<ApplicabilityOptions>? get applicabilityOptions => _applicabilityOptions;
  double? get currentStock => _currentStock;
  int? get minimumOrderQty => _minimumOrderQty;
  //String? get stockLocation => _stockLocation;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  //int? get status => _status;
  //String? get code => _code;
  //Seller? get seller => _seller;
  int? get authlevel => _authlevel;
  List<StockLocations>? get stocklocations => _stockLocations;
  List<StockSerials>? get stockSerials => _stockSerials;
  String? get videoUrl => _videoUrl;
  double? get qtyRemaining => _qtyRemaining;
  double? get qtyOrdered => _qtyOrdered;
  double? get qtyBlocked => _qtyBlocked;
  double? get qtyUsable => _qtyUsable;
  double? get qtyIn => _qtyIn;
  double? get qtyOut => _qtyOut;
  List<StockSuppliers>? get stockSuppliers =>_stockSuppliers;
  List<StockAttachments>? get stockAttachments =>_stockAttachments;



  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _has3d = json['has3d'];
    _threedfile = json['threedfile'];
    _authlevel = json['auth_level'];
    _code = json['code'];
    _slug = json['slug'];
    _productType = json['product_type'];
    //_brandId = json['brand_id'];
    _unit = json['unit'];
    if (json['images'] != null) {
      _images = json['images'].cast<String>();
    }
    _thumbnail = json['thumbnail'];
    //_attributes = json['attributes'].cast<int>();
    if (json['choice_options'] != null) {
      _choiceOptions = <ChoiceOptions>[];
      json['choice_options'].forEach((v) {
        _choiceOptions!.add(ChoiceOptions.fromJson(v));
      });
    }

    if (json['part_manufacture'] != null) {
      _partManufacture = <PartManufacture>[];
      json['part_manufacture'].forEach((v) {
        _partManufacture!.add(PartManufacture.fromJson(v));
      });
    }

    if (json['catalogue_list'] != null) {
      _catalogueList = <CatalogueList>[];
      json['catalogue_list'].forEach((v) {
        _catalogueList!.add(CatalogueList.fromJson(v));
      });
    }

    if (json['product_data'] != null) {
      _productData = <ProductData>[];
      json['product_data'].forEach((v) {
        _productData!.add(ProductData.fromJson(v));
      });
    }

    if (json['applicability'] != null) {
      _applicabilityOptions = <ApplicabilityOptions>[];
      json['applicability'].forEach((v) {
        _applicabilityOptions!.add(ApplicabilityOptions.fromJson(v));
      });
    }
    _videoUrl = json['video_url'];
    _currentStock = json['current_stock'].toDouble()??0;
    _minimumOrderQty = json['minimum_order_qty'];

    _description = json['details'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    //_status = json['status'];
    //_code = json['code'];
    //_seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    if(json['wish_list_count'] != null){
      try{
        wishList = json['wish_list_count'];
      }catch(e){
        wishList = int.parse(json['wish_list_count'].toString());
      }
    }

    if (json['stock_location'] != null) {
      _stockLocations = <StockLocations>[];
      json['stock_location'].forEach((v) {
        _stockLocations!.add(StockLocations.fromJson(v));
      });
    }

    if (json['stock_serial'] != null) {
      _stockSerials = <StockSerials>[];
      json['stock_serial'].forEach((v) {
        _stockSerials!.add(StockSerials.fromJson(v));
      });
    }

    if (json['stock_suppliers'] != null) {
      _stockSuppliers = <StockSuppliers>[];
      json['stock_suppliers'].forEach((v) {
        _stockSuppliers!.add(StockSuppliers.fromJson(v));
      });
    }

    if (json['stock_attachment'] != null) {
      _stockAttachments = <StockAttachments>[];
      json['stock_attachment'].forEach((v) {
        _stockAttachments!.add(StockAttachments.fromJson(v));
      });
    }



    if (json['qty_remaining'] != null) {
      _qtyRemaining = json['qty_remaining'].toDouble() ?? 0;
    }
    else
      {
        _qtyRemaining =0;
      }
    _qtyOrdered = json['qty_order'].toDouble()??0;
    _qtyBlocked = json['qty_block'].toDouble()??0;
    _qtyUsable = json['qty_usable'].toDouble()??0;
     _qtyIn = json['qty_in'].toDouble()??0;
     _qtyOut = json['qty_out'].toDouble()??0;

  }
}


///Machine Technical Doc List
class ProductDetailsByCodeModel {
  int? totalProducts;
  List<ProductDetailsModel>? product;

  ProductDetailsByCodeModel({this.totalProducts, this.product});

  ProductDetailsByCodeModel.fromJson(Map<String, dynamic> json) {
    totalProducts = json['total_products'];
    if (json['product'] != null) {
      product = <ProductDetailsModel>[];
      json['product'].forEach((v) {
        product!.add(ProductDetailsModel.fromJson(v));
      });
    }
  }

}


class CategoryIds {
  String? _id;
  int? _position;

  CategoryIds({String? id, int? position}) {
    if (id != null) {
      _id = id;
    }
    if (position != null) {
      _position = position;
    }
  }

  String? get id => _id;
  int? get position => _position;


  CategoryIds.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['position'] = _position;
    return data;
  }
}



class ProductData {
  String? _line;
  String? _machine;
  int? _dataauth;
  String? _datatitle;
  List<Datalist>? _datalist;




  ProductData({String? line,String? machine,int? dataauth, String? datatitle, List<Datalist>? datalist }) {
    _line=line;
    _machine=machine;
    _dataauth = dataauth;
    _datatitle = datatitle;
    _datalist = datalist;
  }

  String? get line => _line;
  String? get machine => _machine;
  int? get dataauth => _dataauth;
  String? get datatitle => _datatitle;
  List<Datalist>? get datalist => _datalist;


  ProductData.fromJson(Map<String, dynamic> json) {
    _line = json['line'];
    _machine = json['machine'];
    _dataauth = json['data_auth'];
    _datatitle = json['data_title'];
    if(json['data_list'] != null){
      _datalist = [];
      json['data_list'].forEach((v) {_datalist!.add(Datalist.fromJson(v));
      });
    }

  }
}


class Datalist {

  String? _imagesgroup;
  List<String>?_imageslist;


    Datalist({String? imagesgroup, List<String>? imageslist}) {
    _imagesgroup = imagesgroup;
    _imageslist = imageslist;
  }

  String? get imagesgroup => _imagesgroup;
 List<String>? get imageslist => _imageslist;

  Datalist.fromJson(Map<String, dynamic> json) {
    _imagesgroup = json['images_group'];
    if(json['images_list'] != null){
      _imageslist = json['images_list'].cast<String>();
     }
  }
}

class StockLocations {
  String? _warehouse;
  String? _location;
  String? _qty;

  StockLocations({String? warehouse,String? location, String? qty}) {
    if (warehouse != null) {
      _warehouse = warehouse;
    }
    if (location != null) {
      _location = location;
    }
    if (qty != null) {
      _qty = qty;
    }
  }

  String? get warehouse => _warehouse;
  String? get location => _location;
  String? get qty => _qty;


  StockLocations.fromJson(Map<String, dynamic> json) {
    _warehouse = json['warehouse'];
    _location = json['location'];
    _qty = json['qty'];
  }
}


class StockSerials {
  String? _serialnumber;
  String? _expirationdate;
  String? _qty;
  int? _remainingdays;

  StockSerials({String? serialnumber,String? expirationdate, String? qty,int? remainingdays}) {
    if (serialnumber != null) {
      _serialnumber = serialnumber;
    }
    if (expirationdate != null) {
      _expirationdate = expirationdate;
    }
    if (qty != null) {
      _qty = qty;
    }
    if (remainingdays != null) {
      _remainingdays = remainingdays;
    }
  }

  String? get serialnumber => _serialnumber;
  String? get expirationdate => _expirationdate;
  String? get qty => _qty;
  int? get remainingdays => _remainingdays;

  StockSerials.fromJson(Map<String, dynamic> json) {
    _serialnumber = json['serial_number'];
    _expirationdate = json['expiration_date'];
    _qty = json['qty'];
    _remainingdays = json['remaining_days'];
  }
}

class StockSuppliers {
  String? _supplier;
  String? _supplierCode;


  StockSuppliers({String? supplier,String? supplierCode}) {
    if (supplier != null) {
      _supplier = supplier;
    }
    if (_supplierCode != null) {
      _supplierCode = supplierCode;
    }

  }

  String? get supplier => _supplier;
  String? get supplierCode => _supplierCode;


  StockSuppliers.fromJson(Map<String, dynamic> json) {
    _supplier = json['supplier'];
    _supplierCode = json['supplier_code'];

  }
}


class StockAttachments {
  String? _name;
  String? _path;


  StockAttachments({String? name,String? path}) {
    if (name != null) {
      _name = name;
    }
    if (path != null) {
      path = _path;
    }

  }

  String? get name => _name;
  String? get path => _path;


  StockAttachments.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _path = json['path'];

  }
}
