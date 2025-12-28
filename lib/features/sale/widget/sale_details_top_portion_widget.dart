import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/features/dashboard/dashboard_screen.dart';
import 'package:flutter_spareparts_store/utill/images.dart';

import '../provider/sale_provider.dart';

class SaleDetailTopPortion extends StatelessWidget {
  final SaleProvider saleProvider;
  final bool fromNotification;
  const SaleDetailTopPortion({super.key, required this.saleProvider, this.fromNotification = false});

  @override
  Widget build(BuildContext context) {
    return saleProvider.sales != null?
    Stack(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center, children: [
                RichText(text: TextSpan(
                    //text: '${getTranslated('sale_order', context)}# ',
                    text: '${getTranslated('service', context)}# ',
                    //text: 'BK-PO- ',
                    style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeDefault), children:[
                      //TextSpan(text: saleProvider.sales?.id.toString(),
                      TextSpan(text: saleProvider.sales!.saleNumber,
                          style: textBold.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeLarge)),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall,),

                RichText(text: TextSpan(
                    text: getTranslated('your_service_is', context),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getHint(context)),
                    children:[
                      TextSpan(text: ' ${getTranslated('${saleProvider.sales?.saleStatus}', context)}',
                          style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                            color:
                            //saleProvider.sales?.saleStatus == '4'? ColorResources.getGrey(context) :
                            saleProvider.sales?.saleStatus == '4'? ColorResources.getRed(context) :
                            saleProvider.sales?.saleStatus == '2'? ColorResources.getGreen(context) :
                            saleProvider.sales?.saleStatus == '8'? ColorResources.getCheris(context) :
                            saleProvider.sales?.saleStatus == '10'? ColorResources.getYellow1(context) :
                            saleProvider.sales?.saleStatus == '11'? ColorResources.getCheris(context) :
                            saleProvider.sales!.saleStatus == '1'? ColorResources.getYellow(context) :
                            saleProvider.sales!.saleStatus == '5'? ColorResources.getFloatingBtn(context) :
                            ColorResources.getGreen(context)

                          ))]),),
                const SizedBox(height: Dimensions.paddingSizeSmall,),

              /*RichText(text: TextSpan(
                //text: getTranslated('your_sale_is', context),
                  text: getTranslated('your_service_is', context),
                  style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getHint(context)),
                  children:[
                    TextSpan(text: saleProvider.sales!.createdBy!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color:Colors.red))]),),*/


                Text(DateConverter.localDateToIsoStringAMPMOrder(DateTime.parse(saleProvider.sales!.createdAt!)),
                    style: titilliumRegular.copyWith(color: ColorResources.getHint(context),
                        fontSize: Dimensions.fontSizeSmall)),



              Padding(padding:  const EdgeInsets.only(top: Dimensions.paddingSizeSmall),//,left: MediaQuery.of(context).size.width * .65),
                child: Row(children: [
                  //SizedBox(height: 14,width: 14, child: Image.asset(Images.profile,color:Colors.red)),
                  Text( getTranslated('created_by', context)!,  style: titilliumRegular.copyWith(color: ColorResources.getHint(context), fontSize: Dimensions.fontSizeSmall)),
                  const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
                  Text(saleProvider.sales!.createdBy!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color:ColorResources.red)),
                ],
                ),
              ),
              ],
            ),
          ],
        ),
        InkWell(onTap: (){
          if(fromNotification){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
          }else{
            Navigator.pop(context);
          }
        }, child: const Padding(padding: EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault),
            child: Icon(CupertinoIcons.back)))
      ],
    ): const SizedBox();
  }
}
