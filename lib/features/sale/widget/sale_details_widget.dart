import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/product/view/product_details_screen.dart';
import 'package:flutter_spareparts_store/features/sale/view/service_image_screen.dart';
import 'package:flutter_spareparts_store/features/sale/widget/service_details_dialog.dart';
import 'package:flutter_spareparts_store/helper/price_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:provider/provider.dart';
import '../../profile/provider/profile_provider.dart';
import '../domain/model/sale_details_model.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:http/http.dart' as http;

class SaleDetailsWidget extends StatefulWidget {
  final SaleDetailsModel saleDetailsModel;
  final String saleType;
  final String paymentStatus;
  final Function callback;
  final bool fromTrack;
  final int? isGuest;
  const SaleDetailsWidget({super.key, required this.saleDetailsModel, required this.callback, required this.saleType,
    required this.paymentStatus,  this.fromTrack = false, this.isGuest });

  @override
  State<SaleDetailsWidget> createState() => _SaleDetailsWidgetState();
}


class _SaleDetailsWidgetState extends State<SaleDetailsWidget> {



  @override
  Widget build(BuildContext context) {

    String seeprice =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeprice ?? '';

    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: Stack(children: [
        Card(color: Theme.of(context).cardColor, child: Column(children: [
          const SizedBox(height: Dimensions.marginSizeDefault),

          Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(width: Dimensions.marginSizeDefault),


            const SizedBox(width: Dimensions.marginSizeExtraSmall),

            InkWell(
              child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).
              baseUrls!.productImageUrl}/${widget.saleDetailsModel.productCode}.webp', width: 80, height: 80),
              onTap: () async {
                final res = await http.get(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).
                baseUrls!.productImageUrl}/${widget.saleDetailsModel.productCode}.webp'));
                if (res.statusCode == 200) {
                  await showDialog(
                    context: context,
                       builder: (_) => ServiceImageScreen(title: '${widget.saleDetailsModel.productDescription}', image: '${widget.saleDetailsModel.productCode}.webp',url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.productImageUrl)

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
                Expanded(child: Text(widget.saleDetailsModel.productCode??'',
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                    maxLines: 2, overflow: TextOverflow.ellipsis))]),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),

              Row(children: [
                    Expanded(child: Text(widget.saleDetailsModel.productDescription??'',
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                    maxLines: 2, overflow: TextOverflow.ellipsis))]),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),

              if(seeprice =='yes')
              Row(children: [
                Text("${getTranslated('price', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                Text(PriceConverter.convertPrice(context, widget.saleDetailsModel.price),
                  style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context), fontSize: 16),),
              ]),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),


                Row(children: [
                  Text("${getTranslated('qty', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                  Text('${widget.saleDetailsModel.qty} ${widget.saleDetailsModel.qtyunit}', style: titilliumRegular.copyWith(
                      color: ColorResources.getPrimary(context), fontSize: 14)),
                  const SizedBox(height: Dimensions.marginSizeExtraSmall),
                ]),

             /* const SizedBox(height: Dimensions.marginSizeExtraSmall),
              Row(children: [
                Text("${getTranslated('warehouse', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                Text('${widget.saleDetailsModel.warehouse}', style: titilliumRegular.copyWith(
                    color: ColorResources.getPrimary(context), fontSize: 14)),
                const SizedBox(height: Dimensions.marginSizeExtraSmall),
              ]),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),
              Row(children: [
                Text("${getTranslated('locations', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                Text('${widget.saleDetailsModel.location}', style: titilliumRegular.copyWith(
                    color: ColorResources.getPrimary(context), fontSize: 14)),
                const SizedBox(height: Dimensions.marginSizeExtraSmall),
              ]),*/
              const SizedBox(height: Dimensions.marginSizeExtraSmall),
              Row(children: [
                Text("${getTranslated('warehouse_location', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                Text('${widget.saleDetailsModel.warehouse}-${widget.saleDetailsModel.location}', style: titilliumRegular.copyWith(
                    color: ColorResources.getCheris(context), fontSize: 14)),
                const SizedBox(height: Dimensions.marginSizeExtraSmall),
              ]),

              const SizedBox(height: Dimensions.marginSizeExtraSmall),
              if(seeprice =='yes')
              Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
                child:Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                  Text("${getTranslated('sub_amount', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.primaryMaterial, fontSize: 16),),
                  Text(PriceConverter.convertPrice(context, widget.saleDetailsModel.price!* widget.saleDetailsModel.qty!.toDouble()),
                    style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context), fontSize: 16),),
                ])),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),


              ///ServiceDialog Note  and  Service Close///////////////////
              (widget.saleDetailsModel.comment ==null && widget.saleDetailsModel.sale!.saleStatus =='2' ) ?
                  const SizedBox.shrink():
              Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                child: Row(children: [
                  const Spacer(),
                  //Provider.of<SaleProvider>(context).saleTypeIndex ==1   || Provider.of<SaleProvider>(context).saleTypeIndex == 2 && widget.saleType != "POS"?
                  //widget.saleDetailsModel.saleDetailsStatus !='pending' && widget.saleDetailsModel.saleDetailsStatus !='canceled' ?
                  (widget.saleDetailsModel.sale!.saleStatus !='1' && widget.saleDetailsModel.sale!.saleStatus !='4') ?
                  InkWell(onTap: () {
                    //if(Provider.of<SaleProvider>(context, listen: false).saleTypeIndex == 1  || Provider.of<SaleProvider>(context).saleTypeIndex == 2) {
                    //if(widget.saleDetailsModel.deliveryStatus =='delivered') {
                      Provider.of<ProductDetailsProvider>(context, listen: false).removeData();
                      showDialog(context: context, builder: (context) => Dialog(
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          child:
                          ServiceDialog(
                              productID: widget.saleDetailsModel.productId.toString(),
                              callback: widget.callback,
                              saleDetailsModel: widget.saleDetailsModel,
                              saleType: widget.saleType
                          )));
                   // }
                  },
                    child: Container(height: 30,
                      decoration: BoxDecoration(color:  Colors.redAccent, borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),),
                      child: Row(children: [
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        widget.saleDetailsModel.alreadyComment !=1 ? //&& widget.saleDetailsModel.deliveryStatus !='serviced' ?
                        const Icon(Icons.note_add, color: Colors.white, size: 20,):
                        const Icon(Icons.event_note_outlined, color: Colors.white, size: 20,),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        Text(getTranslated('note', context)!, style: titilliumRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: ColorResources.white,
                        )),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      ],
                      ),
                    ),
                  ) : const SizedBox.shrink(),

                  const SizedBox(width: 10),
                ],),
              )
              


                        ],
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
        /*Positioned(top: 5, left:4, child: Container(
            padding: const EdgeInsets.all(3),
            //decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Theme.of(context).primaryColor,),
                color:  Theme.of(context).primaryColor),
            child: Text(widget.saleDetailsModel.position.toString(), style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.white))
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
                child: Text(widget.saleDetailsModel.position.toString(), style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.white))
            ),
          ),
          onTap: () async {
              await showDialog(
                  context: context,
                  //builder: (_) => ServiceImageScreen(title: '${widget.saleDetailsModel.productDescription}', image: '${widget.saleDetailsModel.productCode}.webp',url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.productImageUrl)
                  builder: (_) => ProductDetails(productId: widget.saleDetailsModel.productId,slug: widget.saleDetailsModel.productId.toString())
              );
          },
        ),

        ],
      ),
    );


  }
}
