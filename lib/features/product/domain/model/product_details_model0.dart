
import 'package:flutter_spareparts_store/features/product/domain/model/product_model.dart';
import 'package:flutter_spareparts_store/features/shop/domain/model/seller_model.dart';

class ProductDetailsModel {
  int? _id;
  String? _name;
  String? _slug;
  String? _productType;
  int? _brandId;
  String? _unit;
  List<String>? _images;
  String? _thumbnail;
  List<int>? _attributes;
  List<ChoiceOptions>? _choiceOptions;
  List<PartManufacture>? _partManufacture;
  List<CatalogueList>? _catalogueList;
  List<ProductData>? _productData;
  List<ApplicabilityOptions>? _applicabilityOptions;
  int? _currentStock;
  String? _stockLocation;
  String? _details;
  String? _createdAt;
  String? _updatedAt;
  int? _status;
  String? _code;
  Seller? _seller;
  int? wishList;
  int? _authlevel;
  List<StockLocations>? _stockLocations;
  List<StockSerials>? _stockSerials;
  String? _videoUrl;
  String? _has3d;
  String? _threedfile;



  ProductDetailsModel(
      {int? id,
        String? addedBy,
        int? userId,
        String? name,
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
        int? currentStock,
        int? minimumOrderQty,
        String? stockLocation,
        String? details,
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
        String? code,
        int? reviewsCount,
        String? averageReview,
        Seller? seller,
        int? wishList,
        int? authlevel,
        List<StockLocations>? stockLocations,
        List<StockSerials>? stockSerials,
        String? has3d,
        String? threedfile,


      }) {
    if (id != null) {
      _id = id;
    }

    if (name != null) {
      _name = name;
    }
    if (slug != null) {
      _slug = slug;
    }
    if (productType != null) {
      _productType = productType;
    }
    if (brandId != null) {
      _brandId = brandId;
    }
    if (unit != null) {
      _unit = unit;
    }

    if (images != null) {
      _images = images;
    }
    if (thumbnail != null) {
      _thumbnail = thumbnail;
    }

    if (attributes != null) {
      _attributes = attributes;
    }
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

    if (stockLocation != null) {
      _stockLocation = stockLocation;
    }

    if (details != null) {
      _details = details;
    }

    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (status != null) {
      _status = status;
    }
    if (code != null) {
      _code = code;
    }

    if (seller != null) {
      _seller = seller;
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

    this.wishList;

  }

  int? get id => _id;
  String? get has3d => _has3d;
  String? get threedfile => _threedfile;
  String? get name => _name;
  String? get slug => _slug;
  String? get productType => _productType;
  int? get brandId => _brandId;
  String? get unit => _unit;
  List<String>? get images => _images;
  String? get thumbnail => _thumbnail;
  List<int>? get attributes => _attributes;
  List<ChoiceOptions>? get choiceOptions => _choiceOptions;
  List<PartManufacture>? get partManufacture => _partManufacture;
  List<CatalogueList>? get catalogueList => _catalogueList;
  List<ProductData>? get productData => _productData;
  List<ApplicabilityOptions>? get applicabilityOptions => _applicabilityOptions;
  int? get currentStock => _currentStock;
  String? get stockLocation => _stockLocation;
  String? get details => _details;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get status => _status;
  String? get code => _code;
  Seller? get seller => _seller;
  int? get authlevel => _authlevel;
  List<StockLocations>? get stocklocations => _stockLocations;
  List<StockSerials>? get stockSerials => _stockSerials;
  String? get videoUrl => _videoUrl;



  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _has3d = json['has3d'];
    _threedfile = json['threedfile'];
    _authlevel = json['auth_level'];
    _name = json['name'];
    _slug = json['slug'];
    _productType = json['product_type'];
    _brandId = json['brand_id'];
    _unit = json['unit'];
    if (json['images'] != null) {
      _images = json['images'].cast<String>();
    }
    _thumbnail = json['thumbnail'];
    _attributes = json['attributes'].cast<int>();
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
    _currentStock = json['current_stock'];
    _details = json['details'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _status = json['status'];
    _code = json['code'];
    _seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
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

