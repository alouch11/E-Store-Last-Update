import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/order/domain/model/order_model.dart';
import 'package:flutter_spareparts_store/features/product/view/product_details_screen.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/helper/price_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/features/order/view/order_details_screen.dart';
import 'package:provider/provider.dart';

import '../../profile/provider/profile_provider.dart';


class OrderWidget extends StatelessWidget {
  final Orders? orderModel;
  final int? index;
  const OrderWidget({super.key, this.orderModel, this.index});

  @override
  Widget build(BuildContext context) {

    String seeprice =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeprice ?? '';

    return InkWell(onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderDetailsScreen(orderId: orderModel!.id)));},

      child: Stack(children: [
          Container(margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,
              left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow:  [BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],),

            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(width: 100,height: 120,
                  child: Column(children: [
                    Container(decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      border: Border.all(width: 1, color: Theme.of(context).primaryColor.withOpacity(.25)),
                      boxShadow: Provider.of<ThemeProvider>(context, listen: false).darkTheme? null :[BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder, fit: BoxFit.scaleDown, width: 80, height: 80,
                          image: '${Provider.of<SplashProvider>(context, listen: false).configModel?.baseUrls?.sellerImageUrl}/${orderModel?.seller?.image}',
                          imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.scaleDown, width: 80, height: 80),
                        ),
                      ),
                    ),

                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                    Container(alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall,vertical: Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                        color:
                        orderModel!.orderStatus == '1'? ColorResources.getYellow(context).withOpacity(.10) :
                        orderModel!.orderStatus == '7'? ColorResources.getRed(context).withOpacity(.10) :
                        orderModel!.orderStatus == '5'? ColorResources.getFloatingBtn(context).withOpacity(.10):
                        orderModel!.orderStatus == '2'? ColorResources.getGreen(context).withOpacity(.10) :
                        orderModel!.orderStatus == '6'? ColorResources.getCheris(context).withOpacity(.10):
                        orderModel!.orderStatus == '4'? ColorResources.getHint(context).withOpacity(.10):
                        ///Local orders
                        orderModel!.orderStatus == '1'? ColorResources.getYellow(context).withOpacity(.10) :
                        orderModel!.orderStatus == '7'? ColorResources.getRed(context).withOpacity(.10) :
                        orderModel!.orderStatus == '5'? ColorResources.getFloatingBtn(context).withOpacity(.10) :
                        orderModel!.orderStatus == '2'? ColorResources.getGreen(context).withOpacity(.10) :
                        orderModel!.orderStatus == '6'? ColorResources.getCheris(context).withOpacity(.10):
                        orderModel!.orderStatus == '4'? ColorResources.getHint(context).withOpacity(.10)

                            : ColorResources.getYellow(context).withOpacity(.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(getTranslated('4${orderModel!.orderStatus}', context)!, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                        color:
                        orderModel!.orderStatus == '1'? ColorResources.getYellow(context) :
                        orderModel!.orderStatus == '7'? ColorResources.getRed(context):
                        orderModel!.orderStatus == '5'? ColorResources.getFloatingBtn(context):
                        orderModel!.orderStatus == '2'?  ColorResources.getGreen(context) :
                        orderModel!.orderStatus == '6'? ColorResources.getCheris(context):
                        orderModel!.orderStatus == '4'? ColorResources.getHint(context):
                        ///Local orders
                        orderModel!.orderStatus == '1'? ColorResources.getYellow(context) :
                        orderModel!.orderStatus == '7'? ColorResources.getRed(context):
                        orderModel!.orderStatus == '5'? ColorResources.getFloatingBtn(context):
                        orderModel!.orderStatus == '2'?  ColorResources.getGreen(context) :
                        orderModel!.orderStatus == '6'? ColorResources.getCheris(context):
                        orderModel!.orderStatus == '4'? ColorResources.getHint(context)
                            : ColorResources.getYellow(context),
                      )),
                    ),

                  ]),
                ),
                const SizedBox(width: Dimensions.paddingSizeLarge),



                Expanded(flex: 5,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    Text(DateConverter.localDateToIsoStringAMPMOrder(DateTime.parse(orderModel!.createdAt!)),
                        style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor)),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Row(children: [
                      Expanded(child:
                      Text('${orderModel!.orderNumber}',
                          style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.bold)))]),
                    const SizedBox(height: Dimensions.paddingSizeSmall),


                    Text('${orderModel!.orderPerson}',
                      style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.red),),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Text('${orderModel!.orderMachine}',
                      style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.yellow),),
                    const SizedBox(height: Dimensions.paddingSizeSmall),


                    Text('${orderModel!.orderType}',
                      style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.green),),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    if(seeprice =='yes')
                    Text(PriceConverter.convertPrice(context, orderModel!.orderAmount), style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.getPrimary(context)),),
                  ])),

              ]),
            ),
          ),

          Positioned(top: 2, left: 90, child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
              child: Text("${orderModel?.orderDetailsCount}", style: textRegular.copyWith(color: Colors.white))
          )),

        Positioned(top: 1, left:10, child: Container(
            padding: const EdgeInsets.all(3),
            //decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Theme.of(context).primaryColor,),
                color:  Theme.of(context).primaryColor),
            child: Text("$index", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.white))
        )),


        ],
      ),
    );
  }
}
