import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/basewidget/image_diaglog.dart';
import 'package:flutter_spareparts_store/features/dashboard/dashboard_screen.dart';
import 'package:flutter_spareparts_store/features/home/shimmer/order_details_shimmer.dart';
import 'package:flutter_spareparts_store/features/order/widget/cancel_and_support_center.dart';
import 'package:flutter_spareparts_store/features/order/widget/order_details_top_portion_widget.dart';
import 'package:flutter_spareparts_store/features/order/widget/ordered_product_list.dart';
import 'package:flutter_spareparts_store/features/order/widget/payment_info.dart';
import 'package:flutter_spareparts_store/features/order/widget/seller_section.dart';
import 'package:flutter_spareparts_store/features/order/widget/order_informations_widget.dart';
import 'package:flutter_spareparts_store/helper/price_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/amount_widget.dart';
import 'package:provider/provider.dart';

import '../../profile/provider/profile_provider.dart';

class OrderDetailsScreen1 extends StatefulWidget {
  final bool isNotification;
  final int? orderId;
  final String? orderType;
  final bool fromTrack;
  const OrderDetailsScreen1({super.key, required this.orderId, this.isNotification = false, this.orderType,  this.fromTrack = false});

  @override
  State<OrderDetailsScreen1> createState() => _OrderDetailsScreen1State();
}

class _OrderDetailsScreen1State extends State<OrderDetailsScreen1> {


  /* void _loadData(BuildContext context) async {
      await Provider.of<OrderProvider>(Get.context!, listen: false).getOrderDetails(widget.orderId.toString());
      await Provider.of<OrderProvider>(Get.context!, listen: false).initTrackingInfo(widget.orderId.toString());
      await Provider.of<OrderProvider>(Get.context!, listen: false).getOrderFromOrderId(widget.orderId.toString());
  }

  @override
  void initState() {
    super.initState();
    if(Provider.of<SplashProvider>(context, listen: false).configModel == null ){
      Provider.of<SplashProvider>(context, listen: false).initConfig(context).then((value){
        _loadData(context);
        Provider.of<OrderProvider>(context, listen: false).digitalOnly(true);
      });
    }else{
      _loadData(context);
      Provider.of<OrderProvider>(context, listen: false).digitalOnly(true);
    }

  }*/
  @override
  void initState() {
      Provider.of<OrderProvider>(context, listen: false).setIndex(0, notify: false);
      Provider.of<OrderProvider>(context, listen: false).getOrderList(1,'pending',4);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    String seeprice =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeprice ?? '';

   // return Consumer<OrderProvider>(
  //     builder: (context, orderProvider,_) {
   //         return Consumer<SplashProvider>(
    //            builder: (context, config, _) {
            //  return //config.configModel != null?
              return Consumer<OrderProvider>(builder: (context, orderProvider, child) {

                double order = 0;
                double discount = 0;
                double? eeDiscount = 0;
                double tax = 0;
                double shippingCost = 0;



                  if (orderProvider.orderDetails != null && orderProvider.orderDetails!.isNotEmpty) {


                 /*   if( orderProvider.orderDetails?[0].order?.isShippingFree == 1){
                      shippingCost = 0;
                    }else{
                      shippingCost = orderProvider.orders?.shippingCost??0;
                    }

                    for (var orderDetails in orderProvider.orderDetails!) {
                      if(orderDetails.productDetails?.productType != null && orderDetails.productDetails!.productType != "physical" ){
                        orderProvider.digitalOnly(false, isUpdate: false);
                      }
                    }*/



                    for (var orderDetails in orderProvider.orderDetails!) {
                      order = order + (orderDetails.price! * orderDetails.qty!);
                      discount = discount + orderDetails.discount!;
                      tax = tax + orderDetails.tax!;
                    }


                   /* if(orderProvider.orders != null && orderProvider.orders!.orderType == 'POS'){
                      if(orderProvider.orders!.extraDiscountType == 'percent'){
                        eeDiscount = order * (orderProvider.orders!.extraDiscount!/100);
                      }else{
                        eeDiscount = orderProvider.orders!.extraDiscount;
                      }
                    }*/
                  }


                  return (orderProvider.orderDetails != null && orderProvider.orders != null) ?
                  ListView(padding: const EdgeInsets.all(0), children: [


                    Container(height: 10, color: Theme.of(context).primaryColor.withOpacity(.1)),

                   /* if(Provider.of<SplashProvider>(context, listen: false).configModel?.orderVerification == 1 && orderProvider.orders!.orderType != 'POS')
                      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                          child: Center(child: Text.rich(TextSpan(children: [
                            TextSpan(text: '${getTranslated('order_verification_code', context)} : ',
                                style: textRegular.copyWith(color: Theme.of(context).hintColor)),
                            TextSpan(text: orderProvider.orders?.verificationCode??'',
                                style: robotoBold.copyWith(color: Theme.of(context).primaryColor)),
                          ])))),*/


                    OrderInformationsWidget(orderProvider: orderProvider),


                    orderProvider.orders != null && orderProvider.orders!.orderNote != null?
                    Padding(padding : const EdgeInsets.all(Dimensions.marginSizeSmall),
                        child: Text.rich(TextSpan(children: [
                          TextSpan(text: '${getTranslated('order_note', context)} : ',
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getReviewRattingColor(context))),

                          TextSpan(text:  orderProvider.orders!.orderNote != null? orderProvider.orders!.orderNote ?? '': "",
                              style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).textTheme.bodyLarge?.color)),
                        ]))):const SizedBox(),
                    const SizedBox(height: Dimensions.paddingSizeSmall),



                   // SellerSection(order: orderProvider),


                    if(orderProvider.orders != null)
                      OrderProductList(order: orderProvider,orderType: orderProvider.orders!.orderType),
                        //fromTrack: widget.fromTrack,isGuest: orderProvider.orders!.isGuest!,),


                    const SizedBox(height: Dimensions.marginSizeDefault),

                    if(seeprice =='yes')
                    Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      color: Theme.of(context).highlightColor,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                        AmountWidget(title: getTranslated('sub_total', context), amount: PriceConverter.convertPrice(context, order)),


                        //orderProvider.orders!.orderType == "POS"? const SizedBox():
                        AmountWidget(title: getTranslated('shipping_fee', context), amount: PriceConverter.convertPrice(context, shippingCost)),


                        AmountWidget(title: getTranslated('discount', context), amount: PriceConverter.convertPrice(context, discount)),


                        //orderProvider.orders!.orderType == "POS"?
                        AmountWidget(title: getTranslated('extra_discount', context), amount: PriceConverter.convertPrice(context, eeDiscount)),//:const SizedBox(),


                      //  AmountWidget(title: getTranslated('coupon_voucher', context), amount: PriceConverter.convertPrice(context, orderProvider.orders!.discountAmount),),


                        AmountWidget(title: getTranslated('tax', context), amount: PriceConverter.convertPrice(context, tax)),


                        const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                          child: Divider(height: 2, color: ColorResources.hintTextColor),),


                        AmountWidget(title: getTranslated('total_payable', context),
                          amount: PriceConverter.convertPrice(context,
                              //(order + shippingCost - eeDiscount! - orderProvider.orders!.discountAmount! - discount  + tax)),),
                                (order + shippingCost - eeDiscount!  - discount  + tax)),),
                      ])),




                    const SizedBox(height: Dimensions.paddingSizeSmall,),


                        CancelAndSupport(orderModel: orderProvider.orders),

                      ],
                      ) : const OrderDetailsShimmer();
                    },
               //   ):const OrderDetailsShimmer();
             //   }
          //  );
         // }
        );
  }
}

