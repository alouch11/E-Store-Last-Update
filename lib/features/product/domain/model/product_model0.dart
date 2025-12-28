import 'dart:convert';

import 'package:flutter_spareparts_store/features/product/domain/model/product_details_model.dart';

class ProductModel {
  int? totalSize;
  int? limit;
  int? offset;
  List<Product>? _products;

  ProductModel(
      {int? totalSize, int? limit, int? offset, List<Product>? products}) {
    totalSize = totalSize;
    limit = limit;
    offset = offset;
    _products = products;
  }


  List<Product>? get products => _products;

  ProductModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = int.parse(json['limit'].toString());
    offset = int.parse(json['offset'].toString());
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {_products!.add(Product.fromJson(v));
      });
    }
  }

}

class Product {
  int? _id;
  //String? _addedBy;
  //int? _userId;
  String? _name;
  String? _slug;
  String? _productType;
  //List<CategoryIds>? _categoryIds;
  List<StockLocations>? _stockLocations;
  List<StockSerials>? _stockSerials;
  String? _unit;
  List<String>? _images;
  String? _thumbnail;
  //List<ProductColors>? _colors;
  List<String>? _attributes;
  List<ChoiceOptions>? _choiceOptions;
  List<PartManufacture>? _partManufacture;
  List<CatalogueList>? _catalogueList;
  List<ProductData>? _productData;
  List<ApplicabilityOptions>? _applicabilityOptions;
  //List<Variation>? _variation;
  //double? _unitPrice;
  //double? _purchasePrice;
  //double? _tax;
  //String? _taxModel;
  int? _minQty;
  //int? _refundable;
  //String? _digitalProductType;
  //String? _digitalFileReady;
  //String? _taxType;
  //double? _discount;
  //String? _discountType;
  int? _currentStock;
  String? _details;
  String? _createdAt;
  String? _updatedAt;
  //List<Rating>? _rating;
 // double? _shippingCost;
 // int? _isMultiPly;
  //int? _reviewCount;
  String? _videoUrl;
 // int? _minimumOrderQty;
  int? wishList;
  Brand? brand;
  int? _authlevel;






  Product(
      {int? id,
        String? addedBy,
        int? userId,
        String? name,
        String? slug,
        String? productType,
        List<CategoryIds>? categoryIds,
        List<StockLocations>? stockLocations,
        List<StockSerials>? stockSerials,
        String? unit,
        int? minQty,
        int? refundable,
        String? digitalProductType,
        String? digitalFileReady,
        List<String>? images,
        String? thumbnail,
        List<ProductColors>? colors,
        String? variantProduct,
        List<String>? attributes,
        List<ChoiceOptions>? choiceOptions,
        List<PartManufacture>? partManufacture,
        List<CatalogueList>? catalogueList,
        List<ProductData>? productData,
        List<ApplicabilityOptions>? applicabilityOptions,
        //List<Variation>? variation,
        double? unitPrice,
        double? purchasePrice,
        double? tax,
        String? taxModel,
        String? taxType,
        double? discount,
        String? discountType,
        int? currentStock,
        String? details,
        String? attachment,
        String? createdAt,
        String? updatedAt,
        int? featuredStatus,
        //List<Rating>? rating,
        double? shippingCost,
        int? isMultiPly,
        int? reviewCount,
        String? videoUrl,
        int? minimumOrderQty,
        int? wishList,
        Brand? brand,
        int? authlevel,

      }) {
    _id = id;
    //_addedBy = addedBy;
    //_userId = userId;
    _name = name;
    _slug = slug;
    //_categoryIds = categoryIds;
    _stockLocations= stockLocations;
    _stockSerials= stockSerials;
    _unit = unit;
    _minQty = minQty;
/*    if (refundable != null) {
      _refundable = refundable;
    }*/
    if (authlevel != null) {
      _authlevel = _authlevel;
    }

/*    if (digitalProductType != null) {
      _digitalProductType = digitalProductType;
    }*/
/*    if (digitalFileReady != null) {
      _digitalFileReady = digitalFileReady;
    }*/
    _images = images;
    _thumbnail = thumbnail;
    //_colors = colors;
    _attributes = attributes;
    _choiceOptions = choiceOptions;
    _partManufacture= partManufacture;
    _catalogueList = catalogueList;
    _productData = productData;
    _applicabilityOptions =applicabilityOptions;
/*    _variation = variation;
    _unitPrice = unitPrice;
    _purchasePrice = purchasePrice;
    _tax = tax;
    _taxModel = taxModel;
    _taxType = taxType;
    _discount = discount;
    _discountType = discountType;*/
    _currentStock = currentStock;
    _details = details;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
   // _rating = rating;
   // _shippingCost = shippingCost;
   // _isMultiPly = isMultiPly;
   // _reviewCount = reviewCount;
    if (videoUrl != null) {
      _videoUrl = videoUrl;
    }
   // _minimumOrderQty = minimumOrderQty;
    this.wishList;
    this.brand;

  }

  int? get id => _id;
  //String? get addedBy => _addedBy;
  //int? get userId => _userId;
  String? get name => _name;
  String? get slug =>_slug;
  String? get productType => _productType;
  //List<CategoryIds>? get categoryIds => _categoryIds;
  List<StockLocations>? get stockLocations =>_stockLocations;
  List<StockSerials>? get stockSerials =>_stockSerials;
  String? get unit => _unit;
  int? get minQty => _minQty;
  //int? get refundable => _refundable;
 // String? get digitalProductType => _digitalProductType;
  //String? get digitalFileReady => _digitalFileReady;
  List<String>? get images => _images;
  String? get thumbnail => _thumbnail;
  //List<ProductColors>? get colors => _colors;
  List<String>? get attributes => _attributes;
  List<ChoiceOptions>? get choiceOptions => _choiceOptions;
  List<PartManufacture>? get partManufacture => _partManufacture;
  List<CatalogueList>? get catalogueList => _catalogueList;
  List<ProductData>? get productData => _productData;
  List<ApplicabilityOptions>? get applicabilityOptions => _applicabilityOptions;
/*  List<Variation>? get variation => _variation;
  double? get unitPrice => _unitPrice;
  double? get purchasePrice => _purchasePrice;
  double? get tax => _tax;
  String? get taxModel => _taxModel;
  String? get taxType => _taxType;
  double? get discount => _discount;
  String? get discountType => _discountType;*/
  int? get currentStock => _currentStock;
  String? get details => _details;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  //List<Rating>? get rating => _rating;
  //double? get shippingCost => _shippingCost;
 // int? get isMultiPly => _isMultiPly;
  //int? get reviewCount => _reviewCount;
  String? get videoUrl => _videoUrl;
 // int? get minimumOrderQuantity => _minimumOrderQty;
  int? get authlevel => _authlevel;

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    //_addedBy = json['added_by'];
    //_userId = json['user_id'];
    _name = json['name'];
    _slug = json['slug'];
    _productType = json['product_type'];
    _authlevel = json['auth_level'];

/*    if (json['category_ids'] != null) {
      _categoryIds = [];
      try{
        json['category_ids'].forEach((v) {
          _categoryIds!.add(CategoryIds.fromJson(v));
        });
      }catch(e){
        jsonDecode(json['category_ids']).forEach((v) {
          _categoryIds!.add(CategoryIds.fromJson(v));
        });
      }
    }*/

    if (json['stock_location'] != null) {
      _stockLocations = [];
      try{
        json['stock_location'].forEach((v) {
          _stockLocations!.add(StockLocations.fromJson(v));
        });
      }catch(e){
        jsonDecode(json['stock_location']).forEach((v) {
          _stockLocations!.add(StockLocations.fromJson(v));
        });
      }
    }

    if (json['stock_serial'] != null) {
      _stockSerials = [];
      try{
        json['stock_serial'].forEach((v) {
          _stockSerials!.add(StockSerials.fromJson(v));
        });
      }catch(e){
        jsonDecode(json['stock_serial']).forEach((v) {
          _stockSerials!.add(StockSerials.fromJson(v));
        });
      }
    }

    _unit = json['unit'];
    _minQty = json['min_qty'];

/*    if(json['refundable']!=null){
      _refundable = int.parse(json['refundable'].toString());
    }
    if(json['digital_product_type']!=null){
      _digitalProductType = json['digital_product_type'];
    }
   if(json['digital_file_ready']!=null){
      _digitalFileReady = json['digital_file_ready'];
    }*/

    if(json['images'] != null){
      try{
        _images = json['images'] != null ? json['images'].cast<String>() : [];
      }catch(e){
        _images = json['images'] != null ? jsonDecode(json['images']).cast<String>() : [];
      }

    }

    _thumbnail = json['thumbnail'];
/*    if (json['colors_formatted'] != null) {
      _colors = [];
      try{
        json['colors_formatted'].forEach((v) {
          _colors!.add(ProductColors.fromJson(v));
        });
      }catch(e){
        jsonDecode(json['colors_formatted']).forEach((v) {
          _colors!.add(ProductColors.fromJson(v));
        });
      }
    }*/
    if(json['attributes'] != null && json['attributes'] != "null") {
      try{
        _attributes = json['attributes'].cast<String>();
      }catch(e){
        _attributes = jsonDecode(json['attributes']).cast<String>();
      }
    }
    if (json['choice_options'] != null) {
      _choiceOptions = [];
      try{
        json['choice_options'].forEach((v) {
          _choiceOptions!.add(ChoiceOptions.fromJson(v));
        });
      }catch(e){
        jsonDecode(json['choice_options']).forEach((v) {
          _choiceOptions!.add(ChoiceOptions.fromJson(v));
        });
      }
    }

    if (json['part_manufacture'] != null) {
      _partManufacture = [];
      try{
        json['part_manufacture'].forEach((v) {
          _partManufacture!.add(PartManufacture.fromJson(v));
        });
      }catch(e){
        jsonDecode(json['part_manufacture']).forEach((v) {
          _partManufacture!.add(PartManufacture.fromJson(v));
        });
      }
    }

    if (json['catalogue_list'] != null) {
      _catalogueList = [];
      try{
        json['catalogue_list'].forEach((v) {
          _catalogueList!.add(CatalogueList.fromJson(v));
        });
      }catch(e){
        jsonDecode(json['catalogue_list']).forEach((v) {
          _catalogueList!.add(CatalogueList.fromJson(v));
        });
      }
    }

    if (json['product_data'] != null) {
      _productData = [];
      try{
        json['product_data'].forEach((v) {
          _productData!.add(ProductData.fromJson(v));
        });
      }catch(e){
        jsonDecode(json['product_data']).forEach((v) {
          _productData!.add(ProductData.fromJson(v));
        });
      }
    }

    if (json['applicability'] != null) {
      _applicabilityOptions = [];
      try{
        json['applicability'].forEach((v) {
          _applicabilityOptions!.add(ApplicabilityOptions.fromJson(v));
        });
      }catch(e){
        jsonDecode(json['applicability']).forEach((v) {
          _applicabilityOptions!.add(ApplicabilityOptions.fromJson(v));
        });
      }
    }
/*    if (json['variation'] != null) {
      _variation = [];
      try{
        json['variation'].forEach((v) {
          _variation!.add(Variation.fromJson(v));
        });
      }catch(e){
        jsonDecode(json['variation']).forEach((v) {
          _variation!.add(Variation.fromJson(v));
        });
      }
    }
    if(json['unit_price'] != null){
      _unitPrice = json['unit_price'].toDouble();
    }
    if(json['purchase_price']!=null){
      _purchasePrice = json['purchase_price'].toDouble();
    }

    if(json['tax'] != null){
      _tax = json['tax'].toDouble();
    }

    if(json['tax_model'] != null){
      _taxModel = json['tax_model'];
    }else{
      _taxModel = 'exclude';
    }

    _taxType = json['tax_type'];
    if(json['discount'] != null ){
      _discount = json['discount'].toDouble();
    }
    _discountType = json['discount_type'];*/
    _currentStock = json['current_stock']??0;
    _details = json['details'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
/*    if (json['rating'] != null) {
      _rating = [];
      json['rating'].forEach((v) {
        _rating!.add(Rating.fromJson(v));
      });
    }else{

    }
   if(json['shipping_cost']!=null){
      _shippingCost = double.parse(json['shipping_cost'].toString());
    }
    if(json['multiply_qty']!=null){
      _isMultiPly = int.parse(json['multiply_qty'].toString());
    }
   if(json['reviews_count']!=null){
      _reviewCount = int.parse(json['reviews_count'].toString());
    }*/
    _videoUrl = json['video_url'];
    /*if(json['minimum_order_qty'] != null){
      try{
        _minimumOrderQty = json['minimum_order_qty'];
      }catch(e){
        _minimumOrderQty = int.parse(json['minimum_order_qty'].toString());
      }

    }else{
      _minimumOrderQty = 1;
    }*/
    if(json['wish_list_count'] != null){
      try{
        wishList = json['wish_list_count'];
      }catch(e){
        wishList = int.parse(json['wish_list_count'].toString());
      }

    }
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;

  }


}

class CategoryIds {
  int? _position;

  CategoryIds({int? position}) {
    _position = position;
  }

  int? get position => _position;

  CategoryIds.fromJson(Map<String, dynamic> json) {
    _position = json['position'];
  }

}


class ProductColors {
  String? _name;
  String? _code;

  ProductColors({String? name, String? code}) {
    _name = name;
    _code = code;
  }

  String? get name => _name;
  String? get code => _code;

  ProductColors.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _code = json['code'];
  }

}

class ChoiceOptions {
  String? _name;
  String? _title;
  List<String>? _options;

  ChoiceOptions({String? name, String? title, List<String>? options}) {
    _name = name;
    _title = title;
    _options = options;
  }

  String? get name => _name;
  String? get title => _title;
  List<String>? get options => _options;

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _title = json['title'];
    if(json['options'] != null){
      _options = json['options'].cast<String>();
    }

  }

}

class PartManufacture {
  String? _name;
  String? _title;
  List<String>? _options;

  PartManufacture({String? name, String? title, List<String>? options}) {
    _name = name;
    _title = title;
    _options = options;
  }

  String? get name => _name;
  String? get title => _title;
  List<String>? get options => _options;

  PartManufacture.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _title = json['title'];
    if(json['options'] != null){
      _options = json['options'].cast<String>();
    }

  }

}

class CatalogueList {
  String? _line;
  String? _machine;
  int? _catalogueauth;
  String? _cataloguetitle;
  List<CatalogueListoptions>? _catalogueoptions;


  CatalogueList({String? line,String? machine,int? catalogueauth, String? cataloguetitle, List<CatalogueListoptions>? catalogueoptions}) {
    _line=line;
    _machine=machine;
    _catalogueauth = catalogueauth;
    _cataloguetitle = cataloguetitle;
    _catalogueoptions = catalogueoptions;
  }

  String? get line => _line;
  String? get machine => _machine;
  int? get catalogueauth => _catalogueauth;
  String? get cataloguetitle => _cataloguetitle;
  List<CatalogueListoptions>? get catalogueoptions => _catalogueoptions;

  CatalogueList.fromJson(Map<String, dynamic> json) {
    _line = json['line'];
    _machine = json['machine'];
    _catalogueauth = json['catalogue_auth'];
    _cataloguetitle = json['catalogue_title'];
    if(json['catalogue_options'] != null){
      _catalogueoptions = [];
      json['catalogue_options'].forEach((v) {_catalogueoptions!.add(CatalogueListoptions.fromJson(v));
      });
    }

  }
}


class CatalogueListoptions {
  String? _cataloguelang;
  String? _cataloguepath;

  CatalogueListoptions({String? cataloguelang, String? cataloguepath}) {
    _cataloguelang = cataloguelang;
    _cataloguepath = cataloguepath;
  }

  String? get cataloguelang => _cataloguelang;
  String? get cataloguepath => _cataloguepath;

  CatalogueListoptions.fromJson(Map<String, dynamic> json) {
    _cataloguelang = json['catalogue_lang'];
    _cataloguepath = json['catalogue_path'];
  }

}


class ProductData {
  String? _line;
  String? _machine;
  int? _dataauth;
  String? _datatitle;
 //List<String>?_datalist;
  List<Datalist>? _datalist;



  //ProductData({String? line,String? machine,int? dataauth, String? datatitle, List<String>? datalist }) {
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
  //List<String>? get datalist => _datalist;
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
        try{
          _imageslist = json['images_list'] != null ? json['images_list'].cast<String>() : [];
        }catch(e){
          _imageslist = json['images_list'] != null ? jsonDecode(json['images_list']).cast<String>() : [];
        }
      }
  }
}

/*
class Variation {
  String? _type;
  double? _price;
  String? _sku;
  int? _qty;

  Variation({String? type, double? price, String? sku, int? qty}) {
    _type = type;
    _price = price;
    _sku = sku;
    _qty = qty;
  }

  String? get type => _type;
  double? get price => _price;
  String? get sku => _sku;
  int? get qty => _qty;

  Variation.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _price = json['price'].toDouble();
    _sku = json['sku'];
    _qty = json['qty'];
  }
}

class Rating {
  String? _average;

  Rating({String? average, int? productId}) {
    _average = average;
  }

  String? get average => _average;

  Rating.fromJson(Map<String, dynamic> json) {
    _average = json['average'].toString();
  }

}*/

class Brand {
  String? name;


  Brand(
      {
        this.name,
        });

  Brand.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

}


class ApplicabilityOptions{
  int? _id;
  String? _line;
  String? _machine;
  String? _assembly;
  String? _position;
  double? _x;
  double? _y;
  double? _ratio;
  double? _fontsize;
  double? _fontpadding;
  String? _image;
  List<String>? _graphics;

  ApplicabilityOptions({int? id,String? line,String? machine,String? assembly,String? position,double? x,double? y,double? ratio,double? fontsize,double? fontpadding, String? image,List<String>? graphics}) {
    _id = id;
    _line = line;
    _machine = machine;
    _assembly = assembly;
    _position = position;
    _x = x;
    _y = y;
    _ratio = ratio;
    _fontsize = fontsize;
    _fontpadding = fontpadding;
    _image = image;
    _graphics = graphics;
  }

  int? get id => _id;
  String? get line => _line;
  String? get machine => _machine;
  String? get assembly => _assembly;
  String? get position => _position;
  double? get x => _x;
  double? get y => _y;
  double? get ratio => _ratio;
  double? get fontsize => _fontsize;
  double? get fontpadding => _fontpadding;
  String? get image => _image;
  List<String>? get graphics => _graphics;

  ApplicabilityOptions.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _line = json['line'];
    _machine = json['machine'];
    _position = json['position'];
    if(json['x'] != null){
      _x = json['x'].toDouble();
    }
    if(json['y'] != null){
      _y = json['y'].toDouble();
    }
    if(json['ratio'] != null){
      _ratio = json['ratio'].toDouble();
    }
    if(json['fontsize'] != null){
      _fontsize = json['fontsize'].toDouble();
    }
    if(json['fontpadding'] != null){
      _fontpadding = json['fontpadding'].toDouble();
    }
    _assembly = json['assembly'];
    _image = json['image'];
    if(json['graphics'] != null){
      _graphics = json['graphics'].cast<String>();
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