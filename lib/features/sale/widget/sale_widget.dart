import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/product/widget/service_update_bottom_sheet.dart';
import 'package:flutter_spareparts_store/features/sale/view/service_details_screen.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/gaps.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../profile/provider/profile_provider.dart';
import '../domain/model/sale_model.dart';
import '../view/sale_details_screen.dart';


class SaleWidget extends StatelessWidget {
  final Sales? saleModel;
  final int? index;
  final int? saleCategory;
  const SaleWidget({super.key, this.saleModel, this.index , this.saleCategory});

  @override
  Widget build(BuildContext context) {

    String seeprice =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeprice ?? '';

    return
    Stack(children: [
          Container(
            decoration: BoxDecoration(color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow:  [BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],),

            child:
            Padding(
              padding:  const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
              child:  Container(
                color: saleCategory==1 ? Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1):Theme.of(context).primaryColor.withOpacity(0.2),
                width: double.infinity,
                /*decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                    boxShadow: shadow
                ),*/
                margin: const EdgeInsets.only(bottom: 3),
                padding:  const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeSmall,
                  horizontal: Dimensions.paddingSizeDefault,
                ),
                child:
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /*SizedBox(child: Container(height: 80,
                        padding: const EdgeInsets.all(3),
                        //decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Theme.of(context).primaryColor,),
                            color:  Theme.of(context).primaryColor),
                        child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("$index", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.white))
                    ))),*/

                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimensions.paddingSizeDefault,),
                          Row(
                            children: [
                             // const Text('Service', style: ubuntuMedium,),
                               Text('${getTranslated('service', context)}',style: ubuntuMedium,),
                               const SizedBox(height: Dimensions.paddingSizeSmall),

                              Text(" # ${saleModel!.saleNumber}", overflow: TextOverflow.ellipsis, style: ubuntuBold,),
                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                          bookingDate('${getTranslated('date', context)}: ',saleModel!.createdAt!),


                          const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                          Row(
                            children: [
                              Text('${getTranslated('service_man', context)}: ',
                                style: ubuntuRegularLow.copyWith(
                                  color: ColorResources.yellow,
                                ),
                              ),
                              Text("${saleModel!.serviceman}", overflow: TextOverflow.ellipsis, style: ubuntuRegularLow.copyWith(color: ColorResources.yellow),),
                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                          Row(
                            children: [
                              Text(
                                '${getTranslated('machine', context)}: ',
                                style: ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor),
                              ),
                              Text("${saleModel!.machine}", overflow: TextOverflow.ellipsis, style:  ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor),),
                            ],
                          )
                        ],
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeExtraSmall,
                              vertical: 5
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Get.isDarkMode ?
                            Colors.grey.withOpacity(0.2) :
                            saleModel!.saleStatus == '1'? ColorResources.getYellow(context).withOpacity(.10) :
                            saleModel!.saleStatus == '5'? ColorResources.getFloatingBtn(context).withOpacity(.10) :
                            saleModel!.saleStatus == '2'? ColorResources.getGreen(context).withOpacity(.10) :
                            saleModel!.saleStatus == '8'? ColorResources.getCheris(context).withOpacity(.10):
                            saleModel!.saleStatus == '10'? ColorResources.getYellow1(context).withOpacity(.10):
                            saleModel!.saleStatus == '11'? ColorResources.getCheris(context).withOpacity(.15):
                            saleModel!.saleStatus == '4'? ColorResources.getGrey(context).withOpacity(.10):
                            ColorResources.getYellow(context).withOpacity(.1),
                          ),
                          child: Center(
                            child: Text(
                              getTranslated('${saleModel!.saleStatus}', context)!,
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color:
                                    saleModel!.saleStatus == '1'? ColorResources.getYellow(context) :
                                    saleModel!.saleStatus == '5'? ColorResources.getFloatingBtn(context):
                                    saleModel!.saleStatus == '2'?  ColorResources.getGreen(context) :
                                    saleModel!.saleStatus == '8'? ColorResources.getCheris(context):
                                    saleModel!.saleStatus == '10'? ColorResources.getYellow1(context):
                                    saleModel!.saleStatus == '11'? ColorResources.getCheris(context):
                                    saleModel!.saleStatus == '4'? ColorResources.getGrey(context).withOpacity(.10):
                                    ColorResources.getYellow(context),
                              ),
                            ),
                          ),
                        ),
                        Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
                        Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
                        InkWell(
                          child: Text(
                            getTranslated('view_details', context)!,
                            style: ubuntuBold.copyWith(
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: ()=> {
                           // if(saleModel!.hasdetails ==1){
                          if(saleModel!.saleCategory ==1){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SaleDetailsScreen(saleId: saleModel!.id)))
                            }
                            else
                              {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ServiceUpdateBottomSheet( serviceModel: saleModel,servicenamid:saleModel!.customerId))),

                              }
                          },
                          ),

                      ],
                    ),
                  ],
                ),
              ),
            ),


          ),
      Positioned(top: 0, left:3, child: Container(
          padding: const EdgeInsets.all(3),
          //decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Theme.of(context).primaryColor,),
              color:  Theme.of(context).primaryColor),
          child: Text("$index", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.white))
      )),
        ],
      );//,
  //  );
  }
}


Widget bookingDate(String dateType,String date){
  return Builder(
      builder: (context) {
        return Row(
          children: [
            Text(dateType, style: ubuntuRegularLow.copyWith(color: ColorResources.green)),
            Text(
                textDirection: TextDirection.ltr,
                //date,
                DateConverter.dateMonthYearTime(DateConverter.isoUtcStringToLocalDate(date)),
                style: ubuntuRegularLow.copyWith(color: ColorResources.green)
            ),
          ],
        );
      }
  );
}