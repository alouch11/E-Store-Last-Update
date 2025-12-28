import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/features/product/widget/product_image_view.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/sale/domain/model/service_body.dart';
import 'package:flutter_spareparts_store/features/sale/domain/model/sale_details_model.dart';
import 'package:flutter_spareparts_store/features/sale/view/service_image_screen.dart';
import 'package:flutter_spareparts_store/helper/price_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/localization/provider/localization_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/basewidget/custom_textfield.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';


class ServiceDialog extends StatefulWidget {
  final String productID;
  final Function? callback;
  final SaleDetailsModel saleDetailsModel;
  final String saleType;
  const ServiceDialog({super.key, required this.productID, required this.callback, required this.saleDetailsModel, required this.saleType});

  @override
  State<ServiceDialog> createState() => _ServiceDialogState();
}

class _ServiceDialogState extends State<ServiceDialog> {

  TextEditingController _controller = TextEditingController();

  bool isEdit= true;
  bool isCancel= false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    if( widget.saleDetailsModel.comment==null) {

      _controller.text = "";
    }
    else
      {
        _controller.text = widget.saleDetailsModel.comment!;
      }


  }


  @override
  Widget build(BuildContext context) {



    return Consumer<SaleProvider>(
      builder: (context, saleProvider, _) {

        return SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column( mainAxisSize: MainAxisSize.min, children: [

                Align(alignment: Alignment.centerRight,
                  child: InkWell(onTap: () => Navigator.pop(context),
                    child: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).cardColor.withOpacity(0.5)),
                      padding: const EdgeInsets.all(3), child: const Icon(Icons.clear)))),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault), color: Theme.of(context).cardColor),
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(Dimensions.homePagePadding),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



                    (widget.saleDetailsModel.sale!.saleStatus != '2' && (widget.saleDetailsModel.sale!.serviceman! == Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.userServiceName))?
                    Align(alignment: Alignment.centerRight,
                        child:
                   Visibility(
                        visible: isEdit,
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color:  Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              isEdit=false;
                              isCancel=true;
                            });
                          },
                        ))):const SizedBox(),

                    Align(alignment: Alignment.centerRight,
                        child:
                    Visibility(
                        visible: isCancel,
                        child: IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color:  Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              isEdit=true;
                              isCancel=false;
                              if(widget.saleDetailsModel.comment!=null) {
                                _controller.text = widget.saleDetailsModel.comment!;
                              }
                            });
                          },
                        ))),



                    SaleDetails(saleDetailsModel: widget.saleDetailsModel,
                        saleType: widget.saleType,),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                    widget.saleDetailsModel.comment == null && widget.saleDetailsModel.sale!.saleStatus != '2'?
                      Align(alignment: Alignment.centerLeft,
                        child: Text(getTranslated('have_thoughts_to_share', context)!,
                            style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))
                     : const SizedBox(height: Dimensions.paddingSizeExtraExtraSmall),

                    /*CustomTextField(
                      maxLines: 10,
                      hintText: widget.saleDetailsModel.comment ?? getTranslated('write_your_experience_here', context),
                      controller: _controller,
                      inputAction: TextInputAction.done,
                      isEnabled:isCancel,
                    ),*/
                    TextField(
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor,
                              width: .75,)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor,//widget.borderColor,
                              width: .75,)),

                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color:Theme.of(context).primaryColor,
                              width: .75,)),

                        fillColor: Theme.of(context).cardColor,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      //maxLines: null,
                       maxLines: _controller.text.length >100 ?(_controller.text.length.toInt()/15).round(): 10,
                      //hintText: widget.saleDetailsModel.comment ?? getTranslated('write_your_experience_here', context),
                      controller: _controller,
                      textInputAction: TextInputAction.newline,
                      enabled:isCancel,
                    ),

                  widget.saleDetailsModel.sale!.saleStatus != '2' && isCancel?
                   Padding(padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault),
                      child: SizedBox(height: 75,
                        child: ListView.builder(
                            shrinkWrap: true,

                            scrollDirection: Axis.horizontal,
                            itemCount : saleProvider.serviceImages.length + 1 ,
                            itemBuilder: (BuildContext context, index){
                              return index ==  saleProvider.serviceImages.length ?
                              Padding(padding: const EdgeInsets.only(right : Dimensions.paddingSizeDefault),
                                child: InkWell(onTap: ()=> isCancel?saleProvider.pickImage(false, fromService: true):'',
                                  child: DottedBorder(
                                    strokeWidth: 2,
                                    dashPattern: const [10,5],
                                    color: Theme.of(context).hintColor,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(Dimensions.paddingSizeSmall),
                                    child: Stack(children: [
                                      ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                        child:  SizedBox(height: 75,
                                          width: 75, child: Image.asset(Images.placeholder, fit: BoxFit.cover,),
                                        ),
                                      ),
                                      Positioned(bottom: 0, right: 0, top: 0, left: 0,
                                        child: Container(decoration: BoxDecoration(
                                            color: Theme.of(context).hintColor.withOpacity(0.07),
                                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall))),
                                      ),
                                    ],
                                    ),
                                  ),
                                ),
                              ) :
                                Stack(children: [
                                  Padding(padding: const EdgeInsets.only(right : Dimensions.paddingSizeSmall),
                                    child: Container(decoration: const BoxDecoration(color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(20)),),
                                        child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall)),
                                            child:  Image.file(File(saleProvider.serviceImages[index].path),
                                            width: 75, height: 75, fit: BoxFit.cover)

                                        )),


                                      ),

                                  Positioned(top:0,right:0,
                                    child: InkWell(onTap :() => saleProvider.removeImage(index,fromService: true),
                                      child: Container(decoration: const BoxDecoration(color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault))),
                                          child: Padding(padding: const EdgeInsets.all(4.0),
                                            child: Icon(Icons.cancel,color: Theme.of(context).hintColor, size: 15,),)),
                                    ),
                                  ),
                                ],
                              );

                            } ),
                      ),
                    ): const SizedBox(height: Dimensions.marginSizeDefault),


                    if(widget.saleDetailsModel.attachments!=null )
                    Padding(padding: EdgeInsets.only(left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Dimensions.homePagePadding:0,
                        right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0:Dimensions.homePagePadding, bottom: Dimensions.paddingSizeLarge),
                      child:

                      InkWell(
                        child: SizedBox(
                          height: widget.saleDetailsModel.attachments!.length.toDouble() /2 * 150,
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing:0.2,mainAxisSpacing: 0.2,),
                            itemCount: widget.saleDetailsModel.attachments!.length,

                            itemBuilder: (context, index) {
                              return  widget.saleDetailsModel.attachments!.isNotEmpty?
                              Padding(padding: const EdgeInsets.all(0.0),
                                child: Stack(children: [
                               InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                    child: Center(
                                      child:  Stack(alignment: Alignment.topRight, children: [
                                          ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                            child: CustomImage(height: 70, width: 70,
                                                image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.serviceImagesUrl}/'
                                                    '${widget.saleDetailsModel.attachments![index]}'
                                            ),
                                          ),
                                      //  ),
                                      ]),
                                    ),
                                  ),

                               onTap: () async {
                                  await showDialog(
                                  context: context,
                                  builder: (_) =>
                                       // ServiceImageScreen(title: '${widget.saleDetailsModel.productDescription}',
                                          ServiceImageScreen(title: widget.saleDetailsModel.attachments![index],
                                          image:  widget.saleDetailsModel.attachments![index],url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.serviceImagesUrl));

                                  },
                              ),
                                ])):const SizedBox();
                            },),
                        ),
                      ),

                    ),

                      Provider.of<ProductDetailsProvider>(context).errorText != null ?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(Provider.of<ProductDetailsProvider>(context).errorText!,
                            style: textRegular.copyWith(color: ColorResources.red)),
                      ) :
                      const SizedBox.shrink(),

                    //widget.saleDetailsModel.sale!.saleStatus != '2' &&  widget.saleDetailsModel.sale!.saleStatus != '6' &&  widget.saleDetailsModel.sale!.saleStatus != '10' ?
                    widget.saleDetailsModel.sale!.saleStatus != '2' && isCancel ?
                    Builder(
                        builder: (context) => !Provider.of<ProductDetailsProvider>(context).isLoading ?
                        CustomButton(
                          buttonText: getTranslated(widget.saleDetailsModel.alreadyComment !=1 ?'submit':'update', context),
                           //buttonText: widget.saleDetailsModel.attachments!.toString(),

                     onTap: () {

                            if (widget.saleDetailsModel.comment== _controller.text && saleProvider.serviceImages.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(getTranslated('change_something', context)!), backgroundColor: ColorResources.red));
                            }
                              else if(_controller.text.isEmpty) {
                              Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText('${getTranslated('write_a_note', context)}');
                            }else {
                              Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText('');
                              ServiceBodySale serviceBody = ServiceBodySale(saleId: widget.saleDetailsModel.id,
                                productId: widget.productID,
                                comment: _controller.text.isEmpty ? '' : _controller.text);
                              Provider.of<ProductDetailsProvider>(context, listen: false).submitService(serviceBody,
                                  saleProvider.serviceImages, Provider.of<AuthController>(context, listen: false).getUserToken()).then((value) {
                                if(value.isSuccess) {
                                  Navigator.pop(context);
                                  widget.callback!();
                                  Provider.of<SaleProvider>(Get.context!, listen: false).getSaleDetails(widget.saleDetailsModel.saleId.toString());
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  _controller.clear();


                                }else {
                                  Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText(value.message);
                                }
                              });
                            }

                          },
                        ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                      ): const SizedBox.shrink(),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}



///Sale Details Widget

class SaleDetails extends StatefulWidget {
  final SaleDetailsModel saleDetailsModel;

  final String saleType;
  const SaleDetails({super.key, required this.saleDetailsModel, required this.saleType});

  @override
  State<SaleDetails> createState() => _SaleDetailsState();
}

class _SaleDetailsState extends State<SaleDetails> {
  @override
  Widget build(BuildContext context) {

    String seeprice =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeprice ?? '';

    return Stack(children: [
        Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            color: Theme.of(context).cardColor,
            boxShadow: Provider.of<ThemeProvider>(context, listen: false).darkTheme ? null : [BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],

          ),

          child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.125),
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                border: Border.all(width: 1, color: Theme.of(context).primaryColor.withOpacity(.125)),),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder, fit: BoxFit.scaleDown, width: 70, height: 70,
                    image: '${Provider.of<SplashProvider>(context, listen: false).
                      baseUrls!.productThumbnailUrl}/${widget.saleDetailsModel.productCode}.webp',
                    imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                        fit: BoxFit.scaleDown, width: 70, height: 70),),
                ),
              ),
              const SizedBox(width: Dimensions.marginSizeDefault),



              Expanded(flex: 3,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                        Expanded(child: Text(widget.saleDetailsModel.productCode??'',
                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).hintColor),
                        maxLines: 2, overflow: TextOverflow.ellipsis,),),

                    ],
                    ),
                    const SizedBox(height: Dimensions.marginSizeExtraSmall),

                    Row(children: [
                        Expanded(child: Text(widget.saleDetailsModel.productDescription??'',
                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).hintColor),
                        maxLines: 2, overflow: TextOverflow.ellipsis,),),

                    ],
                    ),
                    const SizedBox(height: Dimensions.marginSizeExtraSmall),

                    if(seeprice =='yes')
                   Row(children: [

                     Text("${getTranslated('price', context)}: ",
                       style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),

                     Text(PriceConverter.convertPrice(context, widget.saleDetailsModel.price),maxLines: 1,
                         style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context), fontSize: 16),),

                   ],),

                   const SizedBox(height: Dimensions.marginSizeExtraSmall),

                    Text('${getTranslated('qty', context)}: ${widget.saleDetailsModel.qty}',
                        style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14)),
                    const SizedBox(height: Dimensions.marginSizeExtraSmall),

                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}

