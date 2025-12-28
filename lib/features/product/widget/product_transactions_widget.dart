import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/order/domain/model/order_model.dart';
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
import '../domain/model/product_transactions_model.dart';


class TransactionsWidget extends StatelessWidget {
  final TransactionsModel? producttransactionsDetails;
  const TransactionsWidget({super.key, this.producttransactionsDetails});

  @override
  Widget build(BuildContext context) {

    return InkWell(onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderDetailsScreen(orderId: producttransactionsDetails!.id)));},

      child: Stack(children: [
          Container(margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,
              left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow:  [BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],),

            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(width: 82,height: 82,
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
                          image: '${Provider.of<SplashProvider>(context, listen: false).configModel?.baseUrls?.sellerImageUrl}/${producttransactionsDetails?.seller?.image}',
                          imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.scaleDown, width: 80, height: 80),
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(width: Dimensions.paddingSizeLarge),



                Expanded(flex: 5,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      //Expanded(child: Text('${getTranslated('order', context)!}# ${orderModel!.id.toString()}',
                      Expanded(child:
                      //Text('BK-PO-${orderModel!.id.toString()}',
                      Text('${producttransactionsDetails!.paymentStatus}',
                          style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.bold)))]),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Text(DateConverter.localDateToIsoStringAMPMOrder(DateTime.parse(producttransactionsDetails!.createdAt!)),
                        style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Text('${producttransactionsDetails!.updatedAt}',
                      style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getPrimary(context)),),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                   // Text('${orderModel!.orderAmount} €',
                   //   style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getPrimary(context)),),
                   // const SizedBox(height: Dimensions.paddingSizeSmall),

                  //  Text('${orderModel!.orderAmount}', style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getPrimary(context)),),
                  //  const SizedBox(height: Dimensions.paddingSizeSmall),

                ])),


              ]),
            ),
          ),

          Positioned(top: 2, left: 90, child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
              child: Text("${producttransactionsDetails?.orderId}", style: textRegular.copyWith(color: Colors.white))
          )),
        ],
      ),
    );
  }
}
