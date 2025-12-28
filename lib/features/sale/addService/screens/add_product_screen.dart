import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:flutter_spareparts_store/features/sale/addService/controllers/add_service_controller.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/add_product_section_widget.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/add_product_title_bar.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/add_service_model.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/custom_snackbar_widget.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/custom_text_feild_widget.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/edit_service_model.dart';
import 'package:flutter_spareparts_store/features/sale/domain/model/sale_model.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';

class AddProductScreen extends StatefulWidget {
  final Sales? service;
  final AddServiceModel? addService;
  final EditServiceModel? editService;
  final bool fromHome;
  const AddProductScreen({super.key, this.service,  this.addService, this.editService,  this.fromHome = false});
  @override
  AddProductScreenState createState() => AddProductScreenState();
}

class AddProductScreenState extends State<AddProductScreen> with TickerProviderStateMixin {
  //TabController? _tabController;
  int? length;
  late bool _update;
  int cat=0, subCat=0, subSubCat=0, unit=0, brand=0;
  String? unitValue = '';
  List<String> titleList = [];
  List<String> descriptionList = [];


  @override
  void initState() {
    super.initState();

    Provider.of<AddServiceController>(context,listen: false).setSelectedPageIndex(0, isUpdate: false);
    //_load();
    length = Provider.of<SplashProvider>(context,listen: false).configModel!.language!.length;
    _update = widget.service != null;
    Provider.of<AddServiceController>(context, listen: false).initColorCode();
    if(widget.service != null){

      Provider.of<AddServiceController>(context,listen: false).productCode.text = widget.service!.saleNumber ?? '123456';
      Provider.of<AddServiceController>(context,listen: false).getEditProduct(context, widget.service!.id);


    }else{
      Provider.of<AddServiceController>(context, listen: false).setCurrentStock('1');
      Provider.of<AddServiceController>(context,listen: false);

      Provider.of<AddServiceController>(context,listen: false).emptyDigitalProductData();
    }
  }

  @override
  Widget build(BuildContext context) {
    late List<int?> brandIds;
     return PopScope(
       canPop: true,
       onPopInvoked: (value){
         //Provider.of<AddServiceController>(context,listen: false).removeCategory();
       },
       child: Scaffold(
        appBar: CustomAppBar (title: widget.service != null ?
        getTranslated('update_product', context):getTranslated('add_product', context)),

         body: Consumer<AddServiceController>(
           builder: (context, resProvider, child){
             brandIds = [];
             brandIds.add(0);

            return widget.service !=null && resProvider.editProduct == null?
            const Center(child: CircularProgressIndicator()):
            length != null? Consumer<SplashProvider>(
              builder: (context,splashController,_) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: AddProductTitleBar()),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                          AddProductSectionWidget(
                            title: getTranslated('general_setup', context)!,
                            childrens: [
                              const SizedBox(height: Dimensions.paddingSizeSmall),
                              /*Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                child: SelectCategoryWidget(service: widget.service),
                              ),*/

                              resProvider.productTypeIndex == 0?
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text(getTranslated('select_unit', context)!, style: textRegular.copyWith(
                                          color: ColorResources.hintTextColor, fontSize: Dimensions.fontSizeDefault)),
                                      Text('*',style: robotoBold.copyWith(color: ColorResources.primaryColor,
                                          fontSize: Dimensions.fontSizeDefault),),
                                    ],),
                                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                                    Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                      decoration: BoxDecoration(color: Theme.of(context).cardColor,
                                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                          border: Border.all(width: .5, color: Theme.of(context).primaryColor.withOpacity(.7))
                                      ),
                                      child: DropdownButton<String>(
                                        hint: resProvider.unitValue == null ? Text(getTranslated('select_unit', context)!, style: robotoBold.copyWith(color: Theme.of(context).textTheme.bodySmall?.color)) :
                                        Text(resProvider.unitValue!, style: TextStyle(color: ColorResources.primaryColor),),
                                        items: Provider.of<SplashProvider>(context,listen: false).configModel!.unit!.map((String value) {
                                          return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value));}).toList(),
                                        onChanged: (val) {
                                          unitValue = val;
                                          setState(() {resProvider.setValueForUnit(val);},);},
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                      ),
                                    ),

                                  ],
                                ),
                              ):const SizedBox(),

                              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                              Container(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, 0),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      const Spacer(),
                                      InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: (){

                                            String generateSKU() {
                                              const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
                                              final random = Random();
                                              String sku = '';

                                              for (int i = 0; i < 6; i++) {
                                                sku += chars[random.nextInt(chars.length)];
                                              }
                                              return sku;
                                            }

                                            String code = generateSKU();
                                            // var rng = Random();
                                            // var code = rng.nextInt(900000) + 100000;
                                            resProvider.productCode.text = code.toString();
                                          },
                                          child: Text(getTranslated('generate_code', context)!, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.primaryColor))),
                                    ],
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                  CustomTextFieldWidget(
                                    formProduct: true,
                                    required: true,
                                    border: true,
                                    controller: resProvider.productCode,
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.text,
                                    isAmount: false,
                                    hintText: getTranslated('product_code_sku', context)!,
                                  ),
                                ],),),

                              const SizedBox(height: 15)
                            ],
                          ),

                        ]),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!,
                            spreadRadius: 0.5, blurRadius: 0.3)],
                      ),
                      child: Consumer<AddServiceController>(
                          builder: (context,resProvider, _) {

                            return!resProvider.isLoading? SizedBox(height: 50,
                              child: InkWell(
                                onTap:  (){
                                  bool haveBlankTitle = false;
                                  bool haveBlankDes = false;
                                  for(TextEditingController title in resProvider.titleControllerList){
                                    if(title.text.isEmpty){
                                      haveBlankTitle = true;
                                      break;
                                    }
                                  }
                                  for(TextEditingController des in resProvider.descriptionControllerList){
                                    if(des.text.isEmpty){
                                      haveBlankDes = true;
                                      break;}}

                                  if(haveBlankTitle){
                                    showCustomSnackBarWidget(getTranslated('please_input_all_title',context),context, sanckBarType: SnackBarType.warning);
                                  }else if(haveBlankDes){
                                    showCustomSnackBarWidget(getTranslated('please_input_all_des',context),context,  sanckBarType: SnackBarType.warning);
                                  }
                                  else if (resProvider.categoryIndex == 0) {
                                    showCustomSnackBarWidget(getTranslated('select_a_category',context),context,  sanckBarType: SnackBarType.warning);
                                  }
                                  /*else if (resProvider.brandIndex == 0 && Provider.of<SplashProvider>(context, listen: false).configModel!.brandSetting == "1") {
                                    showCustomSnackBarWidget(getTranslated('select_a_brand',context),context,  sanckBarType: SnackBarType.warning);
                                  }*/
                                  else if (resProvider.unitValue == '' || resProvider.unitValue == null &&  resProvider.productTypeIndex == 0) {
                                    showCustomSnackBarWidget(getTranslated('select_a_unit',context),context,  sanckBarType: SnackBarType.warning);
                                  }
                                  else if (resProvider.productCode.text == '' || resProvider.productCode.text.isEmpty) {
                                    showCustomSnackBarWidget(getTranslated('product_code_is_required',context),context,  sanckBarType: SnackBarType.warning);
                                  }
                                  else if (resProvider.productCode.text.length < 6 || resProvider.productCode.text == '000000') {
                                    showCustomSnackBarWidget(getTranslated('product_code_minimum_6_digit',context),context,  sanckBarType: SnackBarType.warning);
                                  }
                                  else{
                                    for(TextEditingController textEditingController in resProvider.titleControllerList) {
                                      titleList.add(textEditingController.text.trim());
                                    }
                                    resProvider.setSelectedPageIndex(1, isUpdate: true);
                                    /*Navigator.push(context, MaterialPageRoute(builder: (_) => AddProductNextScreen(
                                        categoryId: resProvider.categoryList![resProvider.categoryIndex!-1].id.toString(),
                                        subCategoryId: resProvider.subCategoryIndex != 0? resProvider.subCategoryList![resProvider.subCategoryIndex!-1].id.toString(): "-1",
                                        subSubCategoryId: resProvider.subSubCategoryIndex != 0? resProvider.subSubCategoryList![resProvider.subSubCategoryIndex!-1].id.toString():"-1",
                                        brandId: brandIds[resProvider.brandIndex!].toString(),
                                        unit: unitValue,
                                        service: widget.service, addProduct: widget.addService, )
                                    ));*/
                                  }},


                                child: Container(width: MediaQuery.of(context).size.width, height: 40,
                                  decoration: BoxDecoration(
                                    color:Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                  ),
                                  child: Center(child: Text(getTranslated('next',context)!, style: const TextStyle(
                                      color: Colors.white,fontWeight: FontWeight.w600,
                                      fontSize: Dimensions.fontSizeLarge),)),
                                ),
                              ),):
                            const SizedBox();
                          }
                      ),
                    )
                  ],
                );
              }
            ):const SizedBox();
          },
        ),
       ),
     );
  }
}


extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}