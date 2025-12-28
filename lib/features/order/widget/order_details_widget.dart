
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/order/domain/model/order_details_model.dart';
import 'package:flutter_spareparts_store/features/product/view/product_details_screen.dart';
import 'package:flutter_spareparts_store/features/sale/view/service_image_screen.dart';
import 'package:flutter_spareparts_store/helper/price_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';


class OrderDetailsWidget extends StatefulWidget {
  final OrderDetailsModel orderDetailsModel;
  final String orderType;
  final String paymentStatus;
  final Function callback;
  final bool fromTrack;
  //final int? isGuest;
  const OrderDetailsWidget({super.key, required this.orderDetailsModel, required this.callback, required this.orderType,
    required this.paymentStatus,  this.fromTrack = false});

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {

  @override
  Widget build(BuildContext context) {

    String seeprice =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeprice ?? 'no';
    String seeqty =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeqty ?? '';




    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: Stack(children: [

        Card(color: Theme.of(context).cardColor, child: Column(children: [
          const SizedBox(height: Dimensions.paddingSizeLarge),
          Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(width: Dimensions.marginSizeDefault),

            InkWell(
              child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).
              baseUrls!.productThumbnailUrl}/${widget.orderDetailsModel.productCode}.webp', width: 80, height: 80),
              onTap: () async {
                final res = await http.get(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).
                baseUrls!.productThumbnailUrl}/${widget.orderDetailsModel.productCode}.webp'));
                if (res.statusCode == 200) {
                  await showDialog(
                      context: context,
                      //builder: (_) => ApplicabilityImageScreen(title: '${widget.orderDetailsModel.productDescription}', image: '${widget.orderDetailsModel.productCode}.webp',url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.productImageUrl)
                      builder: (_) => ServiceImageScreen(title: '${widget.orderDetailsModel.productDescription}', image: '${widget.orderDetailsModel.productCode}.webp',url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.productImageUrl)

                );
                }
                else {
                  showCustomSnackBar('${getTranslated('no_image', context)}', context);
                }
              },
            ),
            const SizedBox(width: Dimensions.marginSizeDefault),





            Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(widget.orderDetailsModel.productCode??'',
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                    maxLines: 2, overflow: TextOverflow.ellipsis))]),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),

              Row(children: [
                Expanded(child: Text(widget.orderDetailsModel.productDescription??'',
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                    maxLines: 2, overflow: TextOverflow.ellipsis))]),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),

              if(seeprice =='yes')
              Row(children: [

                Text("${getTranslated('price', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                Text(PriceConverter.convertPrice(context, widget.orderDetailsModel.price),
                  style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context), fontSize: 16),),
              ]),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),

              if(seeqty =='yes')
                Row(children: [
                  Text("${getTranslated('qty_ordered', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                  Text('${widget.orderDetailsModel.qty} ${widget.orderDetailsModel.qtyunit}', style: titilliumRegular.copyWith(
                      color: ColorResources.getPrimary(context), fontSize: 14)),
                  const SizedBox(height: Dimensions.marginSizeExtraSmall),
                ]),


              if(Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 2 || Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 6 ||Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 8 || Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 9)
                Row(children: [
                  Text("${getTranslated('qty_delivered', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                  Text('${widget.orderDetailsModel.qtydelivered} ${widget.orderDetailsModel.qtyunit}', style: titilliumRegular.copyWith(
                      color: ColorResources.getPrimary(context), fontSize: 14)),
                  const SizedBox(height: Dimensions.marginSizeExtraSmall),
                ]),

              if(Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 2 || Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 6 ||Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 8 || Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 9)         Row(children: [
                  Text("${getTranslated('qty_remaining', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                  Text('${widget.orderDetailsModel.qtyremaining} ${widget.orderDetailsModel.qtyunit}', style: titilliumRegular.copyWith(
                      color: ColorResources.getPrimary(context), fontSize: 14)),
                  const SizedBox(height: Dimensions.marginSizeExtraSmall),
                ]),

              const SizedBox(height: Dimensions.marginSizeExtraSmall),
             if(widget.orderDetailsModel.warehouse != null && widget.orderDetailsModel.location != null)
                Row(children: [
                Text("${getTranslated('warehouse_location', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                Text('${widget.orderDetailsModel.warehouse}-${widget.orderDetailsModel.location}', style: titilliumRegular.copyWith(
                    color: ColorResources.getCheris(context), fontSize: 14)),
                const SizedBox(height: Dimensions.marginSizeExtraSmall),
              ]),
              /* const SizedBox(height: Dimensions.marginSizeExtraSmall),
              Row(children: [
                Text("${getTranslated('locations', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                Text('${widget.orderDetailsModel.location}', style: titilliumRegular.copyWith(
                    color: ColorResources.getCheris(context), fontSize: 14)),
                const SizedBox(height: Dimensions.marginSizeExtraSmall),
              ]),*/

              const SizedBox(height: Dimensions.marginSizeExtraSmall),
              if(seeprice =='yes')
                Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
                    child:Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${getTranslated('sub_amount', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.primaryMaterial, fontSize: 16),),
                          Text(PriceConverter.convertPrice(context, widget.orderDetailsModel.price!* widget.orderDetailsModel.qty!.toDouble()),
                            style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context), fontSize: 16),),
                        ])),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),

              (widget.orderDetailsModel.variant != null && widget.orderDetailsModel.variant!.isNotEmpty) ?
              Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                child: Row(children: [
                  Text('${getTranslated('variations', context)}: ', style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall)),


                  Flexible(child: Text(widget.orderDetailsModel.variant!, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).disabledColor)))])) : const SizedBox(),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),

                        ],
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),

       /* Positioned(top: 5, left:4, child: Container(
            padding: const EdgeInsets.all(3),
           // /decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.rectangle),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Theme.of(context).primaryColor,),
                color:  Theme.of(context).primaryColor),
            child: Text(widget.orderDetailsModel.position.toString(), style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.white))
        )),*/


        InkWell(
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0,top: 2),
            child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Theme.of(context).primaryColor,),
                    color:  Theme.of(context).primaryColor),
                child: Text(widget.orderDetailsModel.position.toString(), style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.white))
            ),
          ),
          onTap: () async {
           // final res = await http.get(Uri.parse('${AppConstants.baseUrl}${AppConstants.productDetailsUri}${widget.orderDetailsModel.productId}?guest_id=1'));
            final res = await http.get(Uri.parse('${AppConstants.baseUrl}${AppConstants.relatedProductUri}${widget.orderDetailsModel.productId}?guest_id=1'));
            if (res.statusCode == 200) {
            await showDialog(
                context: context,
                //builder: (_) => ServiceImageScreen(title: '${widget.saleDetailsModel.productDescription}', image: '${widget.saleDetailsModel.productCode}.webp',url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.productImageUrl)
                builder: (_) => ProductDetails(productId: widget.orderDetailsModel.productId,slug: widget.orderDetailsModel.productId.toString())
            );}
          },
        ),


          Positioned(top: 35,  left: 20,
            child: widget.orderDetailsModel.discount! > 0?
            Container(height: 20, alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(Dimensions.paddingSizeExtraSmall))),

              child: Text(PriceConverter.percentageCalculation(context,
                  (widget.orderDetailsModel.price! * widget.orderDetailsModel.qty!),
                  widget.orderDetailsModel.discount, 'amount'),
                style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: ColorResources.white)),
            ):const SizedBox(),
          ),
        ],
      ),
    );
  }
}