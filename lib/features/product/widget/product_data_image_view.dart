import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/product/domain/model/product_details_model.dart' as pd;
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/localization/provider/localization_provider.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import '../view/product_data_image_screen.dart';

class ProductDataImageView extends StatelessWidget {
  final pd.ProductDetailsModel? productModel;
  final int productdataindexno;
  final int datalistindexno;
  ProductDataImageView({super.key, required this.productModel,required this.productdataindexno,required this.datalistindexno});


  HashSet<String> selectedItem = HashSet();
  bool isMultiSelectionEnabled = false;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return productModel?.productData!= null?
    Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

        InkWell(onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>
              ProductDataImageScreen(title: getTranslated('images', context),
                  imagePath:'${productModel!.productData![productdataindexno].line}/${productModel!.productData![productdataindexno].machine}/${productModel!.productData![productdataindexno].datatitle}/${productModel!.productData![productdataindexno].datalist?[datalistindexno].imagesgroup}/',
                  imageList: productModel!.productData![productdataindexno].datalist?[datalistindexno].imageslist))),


          child: (productModel != null && productModel!.productData![productdataindexno].datalist![datalistindexno].imageslist !=null) ?

          Padding(padding: const EdgeInsets.all(Dimensions.homePagePadding),
            child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              child: Container(decoration:  BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?Theme.of(context).hintColor.withOpacity(.25) : Theme.of(context).primaryColor.withOpacity(.25)),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                child: Stack(children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.50,
                    child: productModel!.productData![productdataindexno].datalist![datalistindexno].imageslist != null?

                    PageView.builder(
                      controller: _controller,
                      itemCount: productModel!.productData![productdataindexno].datalist![datalistindexno].imageslist?.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius:BorderRadius.circular(Dimensions.paddingSizeSmall),
                          child: CustomImage(height: MediaQuery.of(context).size.height*0.50, width: MediaQuery.of(context).size.width,
                              image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.machineDataUrl}/'
                                  '${productModel!.productData![productdataindexno].line}/'
                                  '${productModel!.productData![productdataindexno].machine}/'
                                  '${productModel!.productData![productdataindexno].datatitle}/'
                                  '${productModel!.productData![productdataindexno].datalist?[datalistindexno].imagesgroup}/'
                                  '${productModel!.productData![productdataindexno].datalist![datalistindexno].imageslist![index]}'),
                        );

                      },
                      onPageChanged: (index) {
                        Provider.of<ProductDetailsProvider>(context, listen: false).setImageSliderSelectedIndex(index);
                      },
                    ):const SizedBox(),
                  ),

                    ///page _indicators
                  Positioned(left: 0, right: 0, bottom: 10,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const SizedBox(),
                        const Spacer(),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: _indicators(context)),
                        const Spacer(),
                      ],
                    ),
                  ),
                  ///page _indicators

                  ///Share
                  Positioned(top: 5, right: 5,
                    child: Column(children: [
                      const SizedBox(height: Dimensions.paddingSizeSmall,),
                      InkWell(onTap: () async {
                          int? index=Provider.of<ProductDetailsProvider>(context).imageSliderIndex!;
                          final url = Uri.parse('${Provider.of<SplashProvider>(context,listen: false).baseUrls!.machineDataUrl}/'
                              '${productModel!.productData![productdataindexno].line}/'
                              '${productModel!.productData![productdataindexno].machine}/'
                              '${productModel!.productData![productdataindexno].datatitle}/'
                              '${productModel!.productData![productdataindexno].datalist?[datalistindexno].imagesgroup}/'
                              '${productModel!.productData![productdataindexno].datalist![datalistindexno].imageslist![index]}');
                          final response = await http.get(url);
                          Share.shareXFiles([
                            XFile.fromData(
                              response.bodyBytes,
                              name: productModel!.productData![productdataindexno].datalist![datalistindexno].imageslist![index],
                              mimeType: 'image/webp',
                            ),
                          ],
                              subject: productModel!.productData![productdataindexno].datalist![datalistindexno].imageslist![index]
                          );
                      },

                          child: Card(elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              child: Container(width: 40, height: 40,
                                  decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
                                  child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                      child: Image.asset(Images.share, color: Theme.of(context).primaryColor)))))
                    ],
                    ),
                  ),
                  ///Share



                  ///page number / total page
                    Positioned(right: 3, bottom: 10,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Provider.of<ProductDetailsProvider>(context).imageSliderIndex != null?
                      Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault,bottom: Dimensions.paddingSizeDefault),
                        child: Text('${Provider.of<ProductDetailsProvider>(context).imageSliderIndex!+1}/${productModel!.productData![productdataindexno].datalist![datalistindexno].imageslist?.length.toString()}'),
                      ):const SizedBox(),
                    ],
                    ),
                  ),
                  ///page number / total page

                ]),
              ),
            ),
          ):const SizedBox(),
        ),
      Padding(padding: EdgeInsets.only(left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Dimensions.homePagePadding:0,
            right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0:Dimensions.homePagePadding, bottom: Dimensions.paddingSizeLarge),
       child: SizedBox(height: MediaQuery.of(context).size.height,
          //child: ListView.builder(
          child: GridView.builder(
            //gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio: 1.0),
           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing:0.2,mainAxisSpacing: 0.2,),
            itemCount: productModel!.productData![productdataindexno].datalist![datalistindexno].imageslist?.length,
            itemBuilder: (context, index) {
              return InkWell(

            /*    onTap: (){
                Provider.of<ProductDetailsProvider>(context, listen: false).setImageSliderSelectedIndex(index);
                _controller.animateToPage(index, duration: const Duration(microseconds: 50), curve:Curves.ease);
              },*/

                onTap: (){
                  doMultiSelection(Provider.of<ProductDetailsProvider>(context).productDetailsModel!.productData![productdataindexno].datalist![datalistindexno].imageslist![index]);
                  Provider.of<ProductDetailsProvider>(context, listen: false).setImageSliderSelectedIndex(index);
                  _controller.animateToPage(index, duration: const Duration(microseconds: 50), curve:Curves.ease);
                },
                onLongPress: () {
                  isMultiSelectionEnabled = true;
                  doMultiSelection(Provider.of<ProductDetailsProvider>(context).productDetailsModel!.productData![productdataindexno].datalist![datalistindexno].imageslist![index]);
                },




                child: Padding(
                  padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                  child: Center(
                      child:  Stack(alignment: Alignment.topRight, children: [
                   // child:
                      Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex? 2:0,
                        color: (index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex && Provider.of<ThemeProvider>(context, listen: false).darkTheme)? Theme.of(context).primaryColor:
                        (index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex && !Provider.of<ThemeProvider>(context, listen: false).darkTheme)?Theme.of(context).primaryColor: Colors.transparent),
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                      child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        child: CustomImage(height: 70, width: 70,
                            image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.machineDataUrl}/'
                                '${productModel!.productData![productdataindexno].line}/'
                                '${productModel!.productData![productdataindexno].machine}/'
                                '${productModel!.productData![productdataindexno].datatitle}/'
                                '${productModel!.productData![productdataindexno].datalist?[datalistindexno].imagesgroup}/'
                                '${productModel!.productData![productdataindexno].datalist![datalistindexno].imageslist![index]}'
                        ),
                      ),
                    ),


                      Visibility(
                          visible: isMultiSelectionEnabled,
                          child: Icon(
                            selectedItem.contains(Provider.of<ProductDetailsProvider>(context).productDetailsModel!.productData![productdataindexno].datalist![datalistindexno].imageslist![index])
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            size: 20,
                            color: Colors.red,
                          ))
                      ]),

                  ),
                ),
              );
            },),
        ),
      )
      ],
    ): const SizedBox();
  }


  String getSelectedItemCount() {
    return selectedItem.isNotEmpty
        ? "${selectedItem.length} item selected"
        : "No item selected";
  }


  void doMultiSelection(String imagelist) {
    if (isMultiSelectionEnabled) {
      if (selectedItem.contains(imagelist)) {
        selectedItem.remove(imagelist);
      } else {
        selectedItem.add(imagelist);
      }
      //setState(() {});
    } else {
      //Other logic
    }
  }


  List<Widget> _indicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int index = 0; index < productModel!.productData![productdataindexno].datalist![datalistindexno].imageslist!.length; index++) {
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
