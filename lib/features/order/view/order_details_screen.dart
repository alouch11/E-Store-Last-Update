import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/features/dashboard/dashboard_screen.dart';
import 'package:flutter_spareparts_store/features/home/shimmer/order_details_shimmer.dart';
import 'package:flutter_spareparts_store/features/order/widget/cancel_and_support_center.dart';
import 'package:flutter_spareparts_store/features/order/widget/order_details_top_portion_widget.dart';
import 'package:flutter_spareparts_store/features/order/widget/ordered_product_list.dart';
import 'package:flutter_spareparts_store/helper/price_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/amount_widget.dart';
import 'package:provider/provider.dart';

import '../../profile/provider/profile_provider.dart';
import '../widget/order_informations_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  final bool isNotification;
  final int? orderId;
  final String? orderType;
  final bool fromTrack;
  const OrderDetailsScreen({super.key, required this.orderId, this.isNotification = false, this.orderType,  this.fromTrack = false});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {


  void _loadData(BuildContext context) async {
    if(Provider.of<AuthController>(context, listen: false).isLoggedIn() && !widget.fromTrack){
      await Provider.of<OrderProvider>(Get.context!, listen: false).getOrderDetails(widget.orderId.toString());
      await Provider.of<OrderProvider>(Get.context!, listen: false).initTrackingInfo(widget.orderId.toString());
      await Provider.of<OrderProvider>(Get.context!, listen: false).getOrderFromOrderId(widget.orderId.toString());
    }else{
      await Provider.of<OrderProvider>(Get.context!, listen: false).getOrderFromOrderId(widget.orderId.toString());

    }

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

  }


  @override
  Widget build(BuildContext context) {
    String seeprice =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeprice ?? 'no';
    //String seeprice =  'no';
    return PopScope(
      onPopInvoked: (val) async{
       if(widget.isNotification){
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
       }
      },
      child: Scaffold(
        appBar: AppBar(elevation: 1, backgroundColor: Theme.of(context).cardColor,
            toolbarHeight: 120, leadingWidth: 0, automaticallyImplyLeading: false,
            title: Consumer<OrderProvider>(builder: (context, orderProvider, _) {
                return (orderProvider.orderDetails != null && orderProvider.orders != null) ?
                OrderDetailTopPortion(orderProvider: orderProvider, fromNotification: widget.isNotification):const SizedBox();
              })),

          body: Consumer<OrderProvider>(builder: (context, orderProvider,_) {
            return Consumer<SplashProvider>(builder: (context, config, _) {
              return config.configModel != null?
              Consumer<OrderProvider>(builder: (context, orderProvider, child) {

                double order = 0;
                double discount = 0;
                double? eeDiscount = 0;
                double tax = 0;
                double shippingCost = 0;



                  if (orderProvider.orderDetails != null && orderProvider.orderDetails!.isNotEmpty) {


                    for (var orderDetails in orderProvider.orderDetails!) {
                      order = order + (orderDetails.price! * orderDetails.qty!);
                      discount = discount + orderDetails.discount!;
                      tax = tax + orderDetails.tax!;
                    }

                  }


                  return (orderProvider.orderDetails != null && orderProvider.orders != null) ?
                  ListView(padding: const EdgeInsets.all(0), children: [

                    Container(height: 10, color: Theme.of(context).primaryColor.withOpacity(.1)),

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



                    if(orderProvider.orders != null)
                      OrderProductList(order: orderProvider,orderType: orderProvider.orders!.orderType),



                    const SizedBox(height: Dimensions.marginSizeDefault),

                    if(seeprice =='yes')
                    Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      color: Theme.of(context).highlightColor,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                        AmountWidget(title: getTranslated('sub_total', context), amount: PriceConverter.convertPrice(context, order)),
                        //AmountWidget(title: getTranslated('sub_total', context), amount:  order.toString()),

                        //orderProvider.orders!.orderType == "POS"? const SizedBox():
                        AmountWidget(title: getTranslated('shipping_fee', context), amount: PriceConverter.convertPrice(context, shippingCost)),


                        AmountWidget(title: getTranslated('discount', context), amount: PriceConverter.convertPrice(context, discount)),


                       // orderProvider.orders!.orderType == "POS"?
                        AmountWidget(title: getTranslated('extra_discount', context), amount: PriceConverter.convertPrice(context, eeDiscount)),//:const SizedBox(),

                        AmountWidget(title: getTranslated('tax', context), amount: PriceConverter.convertPrice(context, tax)),


                        const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                          child: Divider(height: 2, color: ColorResources.hintTextColor),),


                        AmountWidget(title: getTranslated('total_payable', context),
                          amount: PriceConverter.convertPrice(context,
                              //(order + shippingCost - eeDiscount! - orderProvider.orders!.discountAmount! - discount  + tax)),),
                              (order + shippingCost - eeDiscount! - discount  + tax)),),
                      ])),


                    const SizedBox(height: Dimensions.paddingSizeSmall,),

                        CancelAndSupport(orderModel: orderProvider.orders),

                      ],
                      ) : const OrderDetailsShimmer();
                    },
                  ):const OrderDetailsShimmer();
                }
            );
          }
        )
      ),
    );
  }
}
