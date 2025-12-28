import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/add_product_service_interface.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/add_service_model.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/custom_snackbar_widget.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/edit_service_model.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/image_model.dart';
import 'package:flutter_spareparts_store/features/sale/domain/model/sale_model.dart';
import 'package:flutter_spareparts_store/features/splash/domain/model/config_model.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/helper/api_checker.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';



class AddServiceController extends ChangeNotifier {
  final AddProductServiceInterface shopServiceInterface;

  AddServiceController({ required this.shopServiceInterface});

  int _totalQuantity =0;
  int get totalQuantity => _totalQuantity;
  String? _unitValue;
  String? get unitValue => _unitValue;
  int _discountTypeIndex = 0;
  int _taxTypeIndex = 0;
  String _imagePreviewSelectedType = 'large';
  int? _categorySelectedIndex;
  int? _subCategorySelectedIndex;
  int? _subSubCategorySelectedIndex;
  int? _categoryIndex = 0;
  int? _subCategoryIndex = 0;
  int? _subSubCategoryIndex = 0;
  int? _brandIndex = 0;
  int _unitIndex = 0;
  List<String> _selectedDigitalVariation = [];
  List<List<String>> _digitalVariationExtension = [];
  List<TextEditingController> extentionControllerList = [];
  List<List<String>> editVariantKeys = [];
  List<List<bool>> _isDigitalVariationLoading = [];
  final TextEditingController maxSnippetController = TextEditingController();
  final TextEditingController maxImagePreviewController = TextEditingController();

  int get unitIndex => _unitIndex;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int? get categorySelectedIndex => _categorySelectedIndex;
  int? get subCategorySelectedIndex => _subCategorySelectedIndex;
  int? get subSubCategorySelectedIndex => _subSubCategorySelectedIndex;
  List<int> _selectedColor = [];
  List<int> get selectedColor =>_selectedColor;
  List<int?> _categoryIds = [];
  List<int?> _subCategoryIds = [];
  List<int?> _subSubCategoryIds = [];
  List<int?> get categoryIds => _categoryIds;
  List<int?> get subCategoryIds => _subCategoryIds;
  List<int?> get subSubCategoryIds => _subSubCategoryIds;
  EditServiceModel? _editProduct;
  EditServiceModel? get editProduct => _editProduct;
  int get discountTypeIndex => _discountTypeIndex;
  int get taxTypeIndex => _taxTypeIndex;
  String get imagePreviewSelectedType => _imagePreviewSelectedType;
  XFile? _pickedLogo;
  XFile? _pickedCover;
  XFile? _pickedMeta;
  XFile? _coveredImage;
  List <XFile>_productImage = [];
  bool _isMultiply = false;
  bool get isMultiply => _isMultiply;
  XFile? get pickedLogo => _pickedLogo;
  XFile? get pickedCover => _pickedCover;
  XFile? get pickedMeta => _pickedMeta;
  XFile? get coveredImage => _coveredImage;
  List<XFile> get productImage => _productImage;
  int? get categoryIndex => _categoryIndex;
  int? get subCategoryIndex => _subCategoryIndex;
  int? get subSubCategoryIndex => _subSubCategoryIndex;
  int? get brandIndex => _brandIndex;
  final picker = ImagePicker();
  List<TextEditingController> _titleControllerList = [];
  List<TextEditingController> _descriptionControllerList = [];
  List<String?> _colorCodeList =[];
  List<String?> get colorCodeList => _colorCodeList;
  List<TextEditingController>  get titleControllerList=> _titleControllerList;
  List<TextEditingController> get descriptionControllerList=> _descriptionControllerList;
  final TextEditingController _productCode = TextEditingController();
  TextEditingController get productCode => _productCode;
  List<FocusNode>? _titleNode;
  List<FocusNode>? _descriptionNode;
  List<FocusNode>? get titleNode => _titleNode;
  List<FocusNode>? get descriptionNode => _descriptionNode;
  int _productTypeIndex = 0;
  int get productTypeIndex => _productTypeIndex;
  int _digitalProductTypeIndex = 0;
  int get digitalProductTypeIndex => _digitalProductTypeIndex;
  File? _selectedFileForImport ;
  File? get selectedFileForImport =>_selectedFileForImport;
  String? _digitalProductFileName;
  String?  get digitalProductFileName =>_digitalProductFileName;
  List<bool?> _selectedCategory = [];
  List<bool?> get selectedCategory => _selectedCategory;
  int _totalVariantQuantity = 0;
  int get totalVariantQuantity => _totalVariantQuantity;
  // List<String?>? productReturnImage  = [];
  List<Map<String, dynamic>>? productReturnImage  = [];
  int _variationTotalQuantity = 0;
  int get variationTotalQuantity  => _variationTotalQuantity;
  final TextEditingController _totalQuantityController = TextEditingController(text: '1');
  TextEditingController get totalQuantityController => _totalQuantityController;
  bool _isCategoryLoading = false;
  bool get isCategoryLoading => _isCategoryLoading;
  int? _selectedPageIndex = 0;
  int? get selectedPageIndex => _selectedPageIndex;
  List<String> get selectedDigitalVariation => _selectedDigitalVariation;
  List<List<String>> get digitalVariationExtantion => _digitalVariationExtension;
  List<List<bool>> get isDigitalVariationLoading => _isDigitalVariationLoading;


  List<String> pages = ['general_info', 'variation_setup', 'product_seo'];
  List<String> imagePreviewType = ['large', 'medium', 'small'];


  void setTitle(int index, String title) {
    _titleControllerList[index].text = title;
  }
  
  void setDescription(int index, String description) {
    _descriptionControllerList[index].text = description;
  }
  
  getTitleAndDescriptionList(List<Language> languageList, EditServiceModel? edtProduct){
    _titleControllerList = [];
    _descriptionControllerList = [];
    for(int i= 0; i<languageList.length; i++){
      if(edtProduct != null){
        if(i==0){
          _titleControllerList.insert(i,TextEditingController(text: edtProduct.name)) ;
          _descriptionControllerList.add(TextEditingController(text: edtProduct.details)) ;
        } else{
          for (var lan in edtProduct.translations!) {
            if(lan.locale == languageList[i].code && lan.key == 'name'){
              _titleControllerList.add(TextEditingController(text: lan.value)) ;
            }
            if(lan.locale == languageList[i].code && lan.key == 'description'){
              _descriptionControllerList.add(TextEditingController(text: lan.value));
            }
          }
        }
      }
      else{
        _titleControllerList.add(TextEditingController());
        _descriptionControllerList.add(TextEditingController());
      }
    }
    if(edtProduct != null){
      if(_titleControllerList.length < languageList.length) {
        int l1 = languageList.length-_titleControllerList.length;
        for(int i=0; i<l1; i++) {
          _titleControllerList.add(TextEditingController(text: editProduct!.name));
        }
      }
      if(_descriptionControllerList.length < languageList.length) {
        int l0 = languageList.length-_descriptionControllerList.length;
        for(int i=0; i<l0; i++) {
          _descriptionControllerList.add(TextEditingController(text: editProduct!.details));
        }
      }
    }else {
      if(_titleControllerList.length < languageList.length) {
        int l = languageList.length-_titleControllerList.length;
        for(int i=0; i<l; i++) {
          _titleControllerList.add(TextEditingController());
        }
      }
      if(_descriptionControllerList.length < languageList.length) {
        int l2 = languageList.length-_descriptionControllerList.length;
        for(int i=0; i<l2; i++) {
          _descriptionControllerList.add(TextEditingController());
        }
      }
    }
  }

  Future <void> getAttributeList(BuildContext context, Sales? product, String language) async {
   // _attributeList = null;
    _discountTypeIndex = 0;
    // _categoryIndex = 0;
    // _subCategoryIndex = 0;
    // _subSubCategoryIndex = 0;
    _variationTotalQuantity = 0;
    _pickedLogo = null;
    _pickedMeta = null;
    _pickedCover = null;
    _selectedColor = [];
   // _variantTypeList = [];
    ApiResponse response = await shopServiceInterface.getAttributeList(language);
    if (response.response != null && response.response!.statusCode == 200) {
      /*_attributeList = [];
      withColor =[];
      _attributeList!.add(AttributeModel(attribute: Attr(id : 0, name:'Color'), active: false,
          controller: TextEditingController(), variants: []));
      response.response!.data.forEach((attribute) {
        if (product != null && product.attributes!=null && product.attributes!.isNotEmpty) {
          bool active = product.attributes!.contains(Attr.fromJson(attribute).id);
          if (kDebugMode) {
            print('--------${Attr.fromJson(attribute).id}/$active/${product.attributes}');
          }
          List<String> options = [];
          if (active && product.choiceOptions != null && product.choiceOptions!.isNotEmpty) {
            options.addAll(product.choiceOptions![product.attributes!.indexOf(Attr.fromJson(attribute).id)].options!);
          }
          _attributeList!.add(AttributeModel(
            attribute: Attr.fromJson(attribute),
            active: active,
            controller: TextEditingController(), variants: options,
          ));
        } else {
          _attributeList!.add(
              AttributeModel(attribute: Attr.fromJson(attribute), active: false,
                controller: TextEditingController(), variants: [],
              ));
        }
      });*/
    } else {
      ApiChecker.checkApi( response);
    }
   notifyListeners();
  }


  void removeImage(int index,bool fromColor){
    if(fromColor){
      if (kDebugMode) {
        print('==$index/${withColor[index].image}/${withColor[index].color}');
      }
      withColor[index].image = null;
    }else{
      withoutColor.removeAt(index);
    }
    notifyListeners();
  }


  String discountType= 'flat';

  void setDiscountTypeIndex(int index, bool notify) {
    _discountTypeIndex = index;
    if(_discountTypeIndex == 0){
      discountType = 'percent';
    }else{
      discountType = 'flat';
    }
    if(notify) {
      notifyListeners();
    }
  }
  
  void setTaxTypeIndex(int index, bool notify) {
    _taxTypeIndex = index;
    if(notify) {
      notifyListeners();
    }
  }

  void setImagePreviewType(String type, bool notify) {
    _imagePreviewSelectedType = type;
    if(notify) {
      notifyListeners();
    }
  }



  void toggleMultiply(BuildContext context) {
    _isMultiply = !_isMultiply;
    notifyListeners();
  }







  ///Move to pos Directory
  void setSelectedCategoryForFilter(int index, bool? selected){
    _selectedCategory[index] = selected;
    notifyListeners();
  }

  ///Move to Product List
  Future<void> getCategoryList(BuildContext context, Sales? product, String language) async {
    log("====category call==> ");
    _categoryIds =[];
    _subCategoryIds =[];
    _subSubCategoryIds =[];
    _categoryIds.add(0);
    _subCategoryIds.add(0);
    _subSubCategoryIds.add(0);
    _categoryIndex = 0;
    _colorCodeList =[];
    _selectedCategory = [];
    ApiResponse response = await shopServiceInterface.getCategoryList(language);
    if (response.response != null && response.response!.statusCode == 200) {
      /*  _categoryList = [];
      response.response!.data.forEach((category) => _categoryList!.add(CategoryModel.fromJson(category)));
      _categoryIndex = 0;

      for(int index = 0; index < _categoryList!.length; index++) {
        _categoryIds.add(_categoryList![index].id);
        _selectedCategory.add(false);
      }

      if(product != null && product.categoryIds != null &&product.categoryIds!.isNotEmpty){
        setCategoryIndex(_categoryIds.indexOf(int.parse(product.categoryIds![0].id!)), false);
        getSubCategoryList(Get.context!,_categoryIds.indexOf(int.parse(product.categoryIds![0].id!)), false, product);
        if (_subCategoryList != null && _subCategoryList!.isNotEmpty) {
          for (int index = 0; index < _subCategoryList!.length; index++) {
            _subCategoryIds.add(_subCategoryList![index].id);
          }

          if(product.categoryIds!.length>1){
            setSubCategoryIndex(_subCategoryIds.indexOf(int.parse(product.categoryIds![1].id!)), false);
            getSubSubCategoryList(_subCategoryIds.indexOf(int.parse(product.categoryIds![1].id!)), false);
          }
        }

        if (_subSubCategoryList != null) {
          for (int index = 0; index < _subSubCategoryList!.length; index++) {
            _subSubCategoryIds.add(_subSubCategoryList![index].id);
          }
          if(product.categoryIds!.length>2){
            setSubSubCategoryIndex(_subSubCategoryIds.indexOf(int.parse(product.categoryIds![2].id!)), false);
            setSubSubCategoryIndex(_subSubCategoryIds.indexOf(int.parse(product.categoryIds![2].id!)), false);
          }
        }
      }*/
    } else {
      ApiChecker.checkApi(response);
    }
    notifyListeners();
  }




  ///Move to Add Product Directory
  Future<void> getEditProduct(BuildContext context,int? id) async {
    _editProduct = null;
    ApiResponse response = await shopServiceInterface.getEditProduct(id);
    if (response.response != null && response.response!.statusCode == 200) {
      _editProduct = EditServiceModel.fromJson(response.response!.data);
      getTitleAndDescriptionList(Provider.of<SplashProvider>( context,listen: false).configModel!.language!, _editProduct);
    } else {
      ApiChecker.checkApi(response);
    }
    notifyListeners();
  }




  late ImageModel thumbnail;
  late ImageModel metaImage;
  List<ImageModel> withColor = [];
  List<ImageModel> withoutColor = [];
  List<String> withColorKeys = [];
  List<String> withoutColorKeys = [];

  int totalPickedImage = 0;


  void pickImage(bool isLogo,bool isMeta, bool isRemove, int? index, {bool update = false, bool isAddProduct = false}) async {
    if(isRemove) {
      totalPickedImage--;
      _pickedLogo = null;
      _pickedCover = null;
      _pickedMeta = null;
      _coveredImage = null;
      _productImage = [];
      withColor =[];
      withoutColor =[];
    }else {
      totalPickedImage ++;
      if (isLogo) {
        _pickedLogo = await ImagePicker().pickImage(source: ImageSource.gallery);
        if(_pickedLogo != null){
          thumbnail = ImageModel(type: 'thumbnail', color: '', image: _pickedLogo);
          if(isAddProduct){
            metaImage = ImageModel(type: 'meta', color: '', image: _pickedLogo);
            _pickedMeta = pickedLogo;
          }
        }

      } else if(isMeta){
        _pickedMeta = await ImagePicker().pickImage(source: ImageSource.gallery);
        if(_pickedMeta != null){
          metaImage = ImageModel(type: 'meta', color: '', image: _pickedMeta);
        }

      }else {
        _coveredImage = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (_coveredImage != null && index != null) {
          if(update){totalPickedImage --;}
          withColor[index].image =  _coveredImage;
          withColor[index].type =  'product';
        }else if(_coveredImage != null) {
          withoutColor.add(ImageModel(image: _coveredImage, type: 'product',color: ''));
        }
      }
    }

    notifyListeners();

  }

  void setSelectedColorIndex(int index, bool notify) {
    if(!_selectedColor.contains(index)) {
      _selectedColor.add(index);
      if(notify) {
        notifyListeners();
      }
    }notifyListeners();
  }


  void setBrandIndex(int? index, bool notify) {
    _brandIndex = index;
    if(notify) {
      notifyListeners();
    }
  }
  void setUnitIndex(int index, bool notify) {
    _unitIndex = index;
    if(notify) {
      notifyListeners();
    }
  }

  void setCategoryIndex(int? index, bool notify) {
    _categoryIndex = index;
    if(notify) {
      notifyListeners();
    }
  }

  void setSubCategoryIndex(int? index, bool notify) {
    _subCategoryIndex = index;
    if(notify) {
      notifyListeners();
    }
  }
  void setSubSubCategoryIndex(int? index, bool notify) {
    _subSubCategoryIndex = index;
    if(notify) {
      notifyListeners();
    }
  }


  void setStringImage(int index, String image, String colorCode, {String? path}) {
    withColor[index].imageString = image;
   // withColor[index].colorImage = ColorImage(color: colorCode, imageName: ImageFullUrl(key: image, path: path));
  }


  int totalUploaded = 0;
  void initUpload(){
    totalUploaded = 0;
    notifyListeners();
  }

  void initColorCode(){
    _colorCodeList = [];
    withColor = [];
  }

  Future addProductImage(BuildContext context, ImageModel imageForUpload, Function callback, {bool update =false, int? index}) async {
    _isLoading = true;
    notifyListeners();
  }


  Future<void> addProduct(BuildContext context, Sales product, AddServiceModel addProduct, String? thumbnail, String? metaImage, bool isAdd, List<String?> tags) async {
    _isLoading = true;

    String? token;
    notifyListeners();
    Map<String, dynamic> fields = {};

    ApiResponse response = await shopServiceInterface.addProduct(product, addProduct ,fields, productReturnImage, thumbnail, metaImage, isAdd,true,  tags, _digitalProductFileName, _selectedDigitalVariation.isNotEmpty, token);
    if(response.response != null && response.response?.statusCode == 200) {
      _productCode.clear();

      showCustomSnackBarWidget(isAdd ? getTranslated('product_added_successfully', context): getTranslated('product_updated_successfully', context),context, isError: false);
       titleControllerList.clear();
      descriptionControllerList.clear();
      _pickedLogo = null;
      _pickedCover = null;
      _coveredImage =null;
      _productImage = [];
[];
      productReturnImage=[];
      withColor = [];
      withoutColor = [];
      emptyDigitalProductData();
      _isLoading = false;
      _selectedFileForImport = null;
      _digitalProductFileName = '';

     }else {
      //colorWithImage = [];
      productReturnImage =[];
      withColor = [];

      withoutColor = [];
      _isLoading = false;
      ApiChecker.checkApi( response);
      showCustomSnackBarWidget(getTranslated('product_add_failed', context), context, sanckBarType: SnackBarType.error);
    }
    _isLoading = false;
    notifyListeners();
  }



  void loadingFalse() {
    _isLoading = false;
    notifyListeners();
  }


  void setValueForUnit (String? setValue){
    if (kDebugMode) {
      print('------$setValue====$_unitValue');
    }
    _unitValue = setValue;
  }

  void setProductTypeIndex(int index, bool notify) {
    _productTypeIndex = index;
    if(notify) {
      notifyListeners();
    }
  }


  void setDigitalProductTypeIndex(int index, bool notify) {
    _digitalProductTypeIndex = index;
    if(notify) {
      notifyListeners();
    }
  }

  void setSelectedFileName(File? fileName){
    _selectedFileForImport = fileName;
    if (kDebugMode) {
      print('Here is your file ===>$_selectedFileForImport');
    }
    notifyListeners();
  }


  Future<ApiResponse> uploadDigitalProduct(String token) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse response = await shopServiceInterface.uploadDigitalProduct(_selectedFileForImport, token);

    if(response.response!.statusCode == 200) {
      if (kDebugMode) {
        print('digital product uploaded');
      }
      _isLoading = false;
      Map map = jsonDecode(response.response!.data);
      _digitalProductFileName = map["digital_file_ready_name"];
      if (kDebugMode) {
        print('-----digital product uploaded---->$_digitalProductFileName');
      }

    }else {
      _isLoading = false;
    }
    _isLoading = false;
    notifyListeners();
    return response;
  }
  
  
  void setTotalVariantTotalQuantity(int total){
    _totalVariantQuantity = total;
  }



  Future<void> deleteProductImage(String id, String name, String? color) async {
    //_isLoading = true;
    ApiResponse apiResponse = await shopServiceInterface.deleteProductImage(id, name, color);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      //_isLoading = false;
    } else {
      // _isLoading = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }


  List<String> imagesWithoutColor = [];
  List<String> imagesWithColorForUpdate = [];



  void resetCategory () {
    _categoryIndex = 0;
    _subCategoryIndex = 0;
    _subSubCategoryIndex = 0;
  }

  void setCurrentStock(String stock){
    _totalQuantityController.text = stock;
  }







  void removeExtension(int index, int subIndex){
    _digitalVariationExtension[index].removeAt(subIndex);
    _isDigitalVariationLoading[index].removeAt(subIndex);
    notifyListeners();
  }


  void pickFileForDigitalProduct (int index, int subIndex) async{

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withReadStream: true,
      withData: true,
      allowedExtensions: ['pdf', 'zip', 'jpg', 'png', "jpeg", "gif",  "mp4", "avi", "mov", "mkv", "webm", "mpeg", "mpg", "3gp", "m4v", "mp3", "wav", "aac", "wma", "amr"],
    );

    if(result != null){
      Uint8List? imageBytes = result.files.first.bytes;
      File? _file = await File(result.files.first.path!).writeAsBytes(imageBytes!);

      XFile xFile =  XFile(_file.path);
      PlatformFile? fileNamed = result.files.first;

    }

    notifyListeners();
  }


  void removeFileForDigitalProduct (int index, int subIndex) async{
    notifyListeners();
  }

  void  setSelectedPageIndex (int index, {bool isUpdate = true}){
    _selectedPageIndex = index;
    if(isUpdate) {
      notifyListeners();
    }
  }


  List<String> processList(List<String> inputList) {
    return inputList.map((str) => str.toLowerCase().trim()).toList();
  }

  String removeSpacesAndLowercase(String input) {
    return input.replaceAll(' ', '').toLowerCase();
  }
  String replaceUnderscoreWithHyphen(String input) {
    return input.replaceAll('_', '-');
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }


  void updateState(){
    notifyListeners();
  }


  String generateSKU() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = math.Random();
    String sku = '';

    for (int i = 0; i < 6; i++) {
      sku += chars[random.nextInt(chars.length)];
    }
    return sku;
  }

  void emptyDigitalProductData() {
    _selectedDigitalVariation = [];
    _digitalVariationExtension = [];
    extentionControllerList = [];
    editVariantKeys = [];
    _isDigitalVariationLoading = [];
  }


}
