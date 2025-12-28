
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/product/domain/model/product_details_model.dart' as pd;
import 'package:flutter_spareparts_store/features/product/widget/Product_attachment_dialog_widget.dart';
import 'package:flutter_spareparts_store/features/product/widget/product_attachment_list.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/localization/provider/localization_provider.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/features/product/view/product_image_screen.dart';
import 'package:flutter_spareparts_store/features/product/widget/favourite_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;


class ProductImageView extends StatelessWidget {
  final pd.ProductDetailsModel? productModel;
  ProductImageView({super.key, required this.productModel});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {

    int? index=Provider.of<ProductDetailsProvider>(context).imageSliderIndex!;

    return productModel != null?
    Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

        InkWell(onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>
              ProductImageScreen(title: getTranslated('product_image', context),imageList: productModel!.images))),
          child: (productModel != null && productModel!.images !=null) ?


          Padding(padding: const EdgeInsets.all(Dimensions.homePagePadding),
            child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              child: Container(decoration:  BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?Theme.of(context).hintColor.withOpacity(.25) : Theme.of(context).primaryColor.withOpacity(.25)),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                child: Stack(children: [
                  SizedBox(height: MediaQuery.of(context).size.width,
                    child: productModel!.images != null?

                    PageView.builder(
                      controller: _controller,
                      itemCount: productModel!.images!.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius:BorderRadius.circular(Dimensions.paddingSizeSmall),
                          child: CustomImage(height: MediaQuery.of(context).size.width, width: MediaQuery.of(context).size.width,
                              image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}/${productModel!.images![index]}'),
                        );

                      },
                      onPageChanged: (index) {
                        Provider.of<ProductDetailsProvider>(context, listen: false).setImageSliderSelectedIndex(index);
                      },
                    ):const SizedBox(),
                  ),


                  Positioned(left: 0, right: 0, bottom: 10,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const SizedBox(),
                        const Spacer(),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: _indicators(context)),
                        const Spacer(),


                        Provider.of<ProductDetailsProvider>(context).imageSliderIndex != null?
                        Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault,bottom: Dimensions.paddingSizeDefault),
                          child: Text('${Provider.of<ProductDetailsProvider>(context).imageSliderIndex!+1}/${productModel!.images!.length.toString()}'),
                        ):const SizedBox(),
                      ],
                    ),
                  ),


                  Positioned(top: 16, right: 16,
                    child: Column(children: [
                        FavouriteButton(backgroundColor: ColorResources.getImageBg(context), productId: productModel!.id),

                      ///Share
                        InkWell(onTap: () async {
                           final res = await http.get(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).
                           baseUrls!.productImageUrl}/${productModel!.images![index]}'));
                           if (res.statusCode == 200) {
                              final url = Uri.parse('${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}/${productModel!.images![index]}');
                              final response = await http.get(url);
                                  Share.shareXFiles([
                                    XFile.fromData(
                                      response.bodyBytes,
                                      name: productModel?.code,
                                      mimeType: 'image/webp',
                                    ),
                                  ], subject: productModel?.description);

                            }
                           else {
                             showCustomSnackBar('${getTranslated('no_image_to_share', context)}', context);
                           }
                          },

                          child: Card(elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            child: Container(width: 40, height: 40,
                              decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
                              child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                child: Image.asset(Images.share, color: Theme.of(context).primaryColor))))),
                      ///Share

                      ///Attachment
                      if( productModel?.productType =='physical'  && productModel!.stockAttachments != null && productModel!.stockAttachments!.isNotEmpty)
                      InkWell(onTap: () async {
                        showModalBottomSheet(
                          showDragHandle: true,
                          enableDrag: true,
                            backgroundColor: Colors.transparent,
                            context: context, builder: (context) =>
                            //ProductAttachmentDialog(productModel: productModel!)
                              ProductAttachmentList(productDetailsModel: productModel!)

                        );


                       /* showModal( context: context, builder: (c) =>    ProductAttachmentDialog(productModel: productModel!));*/
                      },

                          child: Card(elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              child: Container(width: 40, height: 40,
                                  decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
                                  child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                      child: Image.asset(Images.fileIcon, color: Theme.of(context).primaryColor,)))))
                      ///Attachment
                      ],
                    ),
                  ),




                  (productModel != null && productModel!.has3d ==1)?
                  Positioned(top:  0, left: 0,
                    child: Column(children: [
                     /* InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MachineAssemblyParts3DWidget(title: '${productModel!.code} - ${productModel!.description}', file:  productModel!.threedfile,))),
                          child: Card(elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              child: Container(width: 40, height: 40,
                                  decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
                                  child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                      child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)))))*/
                    ],
                    ),
                  ):const SizedBox(),









                ]),
              ),
            ),
          ):const SizedBox(),
        ),
      Padding(padding: EdgeInsets.only(left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Dimensions.homePagePadding:0,
            right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0:Dimensions.homePagePadding, bottom: Dimensions.paddingSizeLarge),
        child: SizedBox(height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            itemCount: productModel!.images!.length,
            itemBuilder: (context, index) {
              return InkWell(onTap: (){
                Provider.of<ProductDetailsProvider>(context, listen: false).setImageSliderSelectedIndex(index);
                _controller.animateToPage(index, duration: const Duration(microseconds: 50), curve:Curves.ease);
              },
                child: Padding(
                  padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex? 2:0,
                        color: (index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex && Provider.of<ThemeProvider>(context, listen: false).darkTheme)? Theme.of(context).primaryColor:
                        (index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex && !Provider.of<ThemeProvider>(context, listen: false).darkTheme)?Theme.of(context).primaryColor: Colors.transparent),
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                      child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        child: CustomImage(height: 50, width: 50,
                            image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}/${productModel!.images![index]}'),
                      ),
                    ),
                  ),
                ),
              );
            },),
        ),
      )
      ],
    ): const SizedBox();
  }

  List<Widget> _indicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int index = 0; index < productModel!.images!.length; index++) {
      indicators.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraExtraSmall),
        child: Container(width: index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex? 20 : 6, height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex ?
            Theme.of(context).primaryColor : Theme.of(context).hintColor,
          ),

        ),
      ));
    }
    return indicators;
  }

}
