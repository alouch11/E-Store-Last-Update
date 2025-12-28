import 'dart:convert';

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
  String? _name;
  String? _slug;
  String? _productType;
  String? _unit;
  List<String>? _images;
  String? _thumbnail;
 // List<String>? _attributes;
 // List<ChoiceOptions>? _choiceOptions;
  List<PartManufacture>? _partManufacture;
  List<CatalogueList>? _catalogueList;
  List<ProductData>? _productData;
  List<ApplicabilityOptions>? _applicabilityOptions;
  //int? _minQty;
  double? _currentStock;
  int? _minimumOrderQty;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  int? wishList;
  //Brand? brand;
  int? _authlevel;
  List<StockLocations>? _stockLocations;
  List<StockSerials>? _stockSerials;
  String? _videoUrl;
  double? _qtyRemaining;
  double? _qtyOrdered;
  double? _qtyBlocked;
  double? _qtyUsable;
  double? _qtyIn;
  double? _qtyOut;
  List<StockSuppliers>? _stockSuppliers;
  List<StockAttachments>? _stockAttachments;






  Product(
      {
        int? id,
        String? name,
        String? slug,
        String? productType,
        String? unit,
        List<String>? images,
        String? thumbnail,
        List<String>? attributes,
        List<ChoiceOptions>? choiceOptions,
        List<PartManufacture>? partManufacture,
        List<CatalogueList>? catalogueList,
        List<ProductData>? productData,
        List<ApplicabilityOptions>? applicabilityOptions,
        double? currentStock,
        int? minimumOrderQty,
        String? details,
        String? createdAt,
        String? updatedAt,
        int? wishList,
        int? authlevel,
        List<StockLocations>? stockLocations,
        List<StockSerials>? stockSerials,
        String? videoUrl,
        double? qtyRemaining,
        double? qtyOrdered,
        double? qtyBlocked,
        double? qtyUsable,
        double? qtyIn,
        double? qtyOut,
        List<StockSuppliers>? stockSuppliers,
        List<StockAttachments>? stockAttachments,


      }) {
    _id = id;
    _name = name;
    _slug = slug;
    _stockLocations= stockLocations;
    _stockSerials= stockSerials;
    _unit = unit;
    //_minQty = minQty;
    if (authlevel != null) {
      _authlevel = _authlevel;
    }
    _images = images;
    _thumbnail = thumbnail;
    //_attributes = attributes;
   // _choiceOptions = choiceOptions;
    _partManufacture= partManufacture;
    _catalogueList = catalogueList;
    _productData = productData;
    _applicabilityOptions =applicabilityOptions;
    _currentStock = currentStock;
    if (minimumOrderQty != null) {
      _minimumOrderQty = minimumOrderQty;
    }
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    if (videoUrl != null) {
      _videoUrl = videoUrl;
    }
    this.wishList;
    this.qtyRemaining;
    this.qtyOrdered;
    this.qtyBlocked;
    this.qtyUsable;
    //this.qtyIn;
    //this.qtyOut;

  }

  int? get id => _id;
  String? get name => _name;
  String? get slug =>_slug;
  String? get productType => _productType;
  List<StockLocations>? get stockLocations =>_stockLocations;
  List<StockSerials>? get stockSerials =>_stockSerials;
  String? get unit => _unit;
  //int? get minQty => _minQty;
  List<String>? get images => _images;
  String? get thumbnail => _thumbnail;
  //List<String>? get attributes => _attributes;
  //List<ChoiceOptions>? get choiceOptions => _choiceOptions;
  List<PartManufacture>? get partManufacture => _partManufacture;
  List<CatalogueList>? get catalogueList => _catalogueList;
  List<ProductData>? get productData => _productData;
  List<ApplicabilityOptions>? get applicabilityOptions => _applicabilityOptions;
  double? get currentStock => _currentStock;
  int? get minimumOrderQty => _minimumOrderQty;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get videoUrl => _videoUrl;
  int? get authlevel => _authlevel;
  double? get qtyRemaining => _qtyRemaining;
  double? get qtyOrdered => _qtyOrdered;
  double? get qtyBlocked => _qtyBlocked;
  double? get qtyUsable => _qtyUsable;
  double? get qtyIn => _qtyIn;
  double? get qtyOut => _qtyOut;
  List<StockSuppliers>? get stockSuppliers =>_stockSuppliers;
  List<StockAttachments>? get stockAttachments =>_stockAttachments;



  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _productType = json['product_type'];
    _authlevel = json['auth_level'];

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
    if (json['stock_suppliers'] != null) {
      _stockSuppliers = [];
      try{
        json['stock_suppliers'].forEach((v) {
          _stockSuppliers!.add(StockSuppliers.fromJson(v));
        });
      }catch(e){
        jsonDecode(json['stock_suppliers']).forEach((v) {
          _stockSuppliers!.add(StockSuppliers.fromJson(v));
        });
      }
    }

    if (json['stock_attachment'] != null) {
      _stockAttachments = [];
      try{
        json['stock_attachment'].forEach((v) {
          _stockAttachments!.add(StockAttachments.fromJson(v));
        });
      }catch(e){
        jsonDecode(json['stock_attachment']).forEach((v) {
          _stockAttachments!.add(StockAttachments.fromJson(v));
        });
      }
    }


    _unit = json['unit'];
    //_minQty = json['min_qty'];

    if(json['images'] != null){
      try{
        _images = json['images'] != null ? json['images'].cast<String>() : [];
      }catch(e){
        _images = json['images'] != null ? jsonDecode(json['images']).cast<String>() : [];
      }

    }

    _thumbnail = json['thumbnail'];
    /*if(json['attributes'] != null && json['attributes'] != "null") {
      try{
        _attributes = json['attributes'].cast<String>();
      }catch(e){
        _attributes = jsonDecode(json['attributes']).cast<String>();
      }
    }*/
  /*  if (json['choice_options'] != null) {
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
    }*/

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
    else {
        _catalogueList = [];
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
    else {
      _productData = [];
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
    else{
      _applicabilityOptions = [];
    }

    _currentStock = json['current_stock'].toDouble()??0;
    _minimumOrderQty = json['minimum_order_qty'];
    _description = json['details'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if(json['wish_list_count'] != null){
      try{
        wishList = json['wish_list_count'];
      }catch(e){
        wishList = int.parse(json['wish_list_count'].toString());
      }

    }
    //brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    _qtyRemaining = json['qty_remaining'].toDouble()??0;
    _qtyOrdered = json['qty_order'].toDouble()??0;
    _qtyBlocked = json['qty_block'].toDouble()??0;
    _qtyUsable = json['qty_usable'].toDouble()??0;
    _qtyIn = json['qty_in'].toDouble()??0;
    _qtyOut = json['qty_out'].toDouble()??0;
  }


}

/*class CategoryIds {
  int? _position;

  CategoryIds({int? position}) {
    _position = position;
  }

  int? get position => _position;

  CategoryIds.fromJson(Map<String, dynamic> json) {
    _position = json['position'];
  }

}*/


/*class ProductColors {
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

}*/

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
        try{
          _imageslist = json['images_list'] != null ? json['images_list'].cast<String>() : [];
        }catch(e){
          _imageslist = json['images_list'] != null ? jsonDecode(json['images_list']).cast<String>() : [];
        }
      }
  }
}



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
      _name = _name;
    }
    if (_path != null) {
      _path = path;
    }

  }

  String? get name => _name;
  String? get path => _path;


  StockAttachments.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _path = json['path'];

  }
}