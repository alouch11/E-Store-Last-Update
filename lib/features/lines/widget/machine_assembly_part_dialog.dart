import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/features/lines/widget/assembly_parts_shimmer.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:flutter_spareparts_store/features/product/view/product_details_screen.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/sale/view/service_image_screen.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:provider/provider.dart';

import '../../../basewidget/custom_image.dart';
import '../../../localization/language_constrants.dart';

class MachineAssemblyPartDialog extends StatefulWidget {
  final String? productCode;
  const MachineAssemblyPartDialog({super.key,  required this.productCode});

  @override
  State<MachineAssemblyPartDialog> createState() => _MachineAssemblyPartDialogState();
}

class _MachineAssemblyPartDialogState extends State<MachineAssemblyPartDialog> {


  @override
  void initState() {
    //Provider.of<ProductDetailsProvider>(context, listen: false).
    Provider.of<ProductDetailsProvider>(context, listen: false).getProductDetailsByCode(context, widget.productCode.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String seeqty =Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeqty ?? '';
    String seeorder =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeorder ?? '';
    List<int>? userauthlevel =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.userauthlevel;


    return
      Consumer<ProductDetailsProvider>(
        builder: (context, details, child) {
      return SizedBox(height: 300,

    child:
    (details.productDetailsModelByCode != null) ? ( details.productDetailsModelByCode!.product != null && details.productDetailsModelByCode!.product!.isNotEmpty)?
      SizedBox(width: MediaQuery.of(context).size.width ,
      child: Material(
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          const SizedBox(height: Dimensions.paddingSizeDefault,),

        Column(
            mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [

          Row(mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(width: MediaQuery.of(context).size.width *0.85,
                child: Text(details.productDetailsModelByCode!.product![0].code ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: ubuntuBoldHigh.copyWith(
                        color: Theme.of(context).primaryColor), maxLines: 2
                ),
              )
            ),
                 // SizedBox(width: MediaQuery.of(context).size.width *0.55),
                  InkWell(onTap: ()=>Navigator.of(context).pop(),
                  child: const Icon(Icons.close_rounded, size: 30,color:Colors.red,),
                  )]),

          Row(mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child :Padding(
                  padding: const EdgeInsets.only(left: 10.0 ,right: 10),
                  child:Text(details.productDetailsModelByCode!.product![0].description ?? '',maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: ubuntuBold.copyWith(color: Theme.of(context).hintColor),
                  ),
                ))
              ]),


          ]),
          const SizedBox(height: 15),

              Padding(
              padding: const EdgeInsets.only(left: 10),
              child:
            SizedBox(height: 120,
              child:
               ListView.builder(
                    scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                     // physics: const NeverScrollableScrollPhysics(),
                itemCount: details.productDetailsModelByCode!.product![0].images!.length,
                itemBuilder: (context, index) {
                  return  Padding(
                    padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2,color: Theme.of(context).primaryColor ),
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                        child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                          child: InkWell(
                              onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (_) => ServiceImageScreen(title: '${details.productDetailsModelByCode!.product![0].code} - ${details.productDetailsModelByCode!.product![0].description}', image: details.productDetailsModelByCode!.product![0].images![index],url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.productImageUrl)
                                  );
                              },
                                 child: CustomImage(height: 120, width: 120,
                              image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}/${details.productDetailsModelByCode!.product![0].images![index]}'),
                          ) ),
                      ),
                    ),
                  );
                },))),


          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child:  Column(children: [

              /* Row(children: [
              Text('${getTranslated('stock_code', context)} : ',
                overflow: TextOverflow.ellipsis,
                style: ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor),
              ),
              Text(details.productDetailsModelByCode!.product![0].name ?? '',
                overflow: TextOverflow.ellipsis,
                style: ubuntuRegularLow.copyWith(
                    color: Theme.of(context).hintColor), maxLines: 2
              )
            ]),

              const SizedBox(height: 10),

             Row(children: [
                Text('${getTranslated('stock_description', context)} : ',
                  overflow: TextOverflow.ellipsis,
                  style: ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor),
                ),

              Expanded(child: Text(details.productDetailsModelByCode!.product![0].details ?? '',
                overflow: TextOverflow.ellipsis,
                style: ubuntuRegularLow.copyWith(color: Theme.of(context).hintColor),
              ))
              ]),

              const SizedBox(height: 10),

              Row(children: [
                Text('${getTranslated('stock_qty', context)} : ', maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor)),

                Text('${details.productDetailsModelByCode!.product![0].currentStock} ${details.productDetailsModelByCode!.product![0].unit}' ,
                    style: ubuntuRegularLow.copyWith( color: Theme.of(context).hintColor))
              ]),
*/
          /* const SizedBox(height: 10),

              Row(children: [
                if(seeqty == 'yes')
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: '${details.qtyorder} ', style: ubuntuRegularLow.copyWith(
                        color: Provider.of<ThemeProvider>(context, listen: false).darkTheme ? Theme.of(context).hintColor : Theme.of(context).hintColor,
                        fontSize: Dimensions.fontSizeDefault)),
                    TextSpan(text: '${getTranslated('qty_order', context)} | ',
                        style: ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor))
                  ])),

                if(seeqty == 'yes')
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: '${details.qtyblock} ', style: ubuntuRegularLow.copyWith(
                        color: Provider.of<ThemeProvider>(context, listen: false).darkTheme ? Theme.of(context).hintColor : Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault)),
                    TextSpan(text: '${getTranslated('qty_blocked', context)}',
                        style: ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor))
                  ])),

              ]),
*/

              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: InkWell(
                  child: Text(
                    getTranslated('view_details', context)!,
                    style: ubuntuBold.copyWith(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: ()=> {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetails(productId: details.productDetailsModelByCode!.product![0].id,slug:details.productDetailsModelByCode!.product![0].slug))),
                  },
                ),),




            ])
          ),

          ],
        ),
      ),
        )
        //: const  BannerShimmer()
        :const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noProduct, message: 'no_products_found',isClose: true,)
        : const  AssemblyPartsShimmer()

          );
        });
  }
}
