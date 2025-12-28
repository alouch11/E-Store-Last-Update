import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/package/domain/model/package_details_model.dart';
import 'package:flutter_spareparts_store/features/sale/view/service_image_screen.dart';
import 'package:flutter_spareparts_store/helper/price_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/package/provider/package_provider.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/auth/widgets/otp_verification_screen.dart';
import 'package:flutter_spareparts_store/features/product/widget/refund_request_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../product/view/applicability_image_screen.dart';
import '../../profile/provider/profile_provider.dart';

class PackageDetailsWidget extends StatefulWidget {
  final PackageDetailsModel packageDetailsModel;
  final String packageType;
  final int packageStatus;
  final Function callback;
  final bool fromTrack;
  //final int? isGuest;
  const PackageDetailsWidget({super.key, required this.packageDetailsModel, required this.callback, required this.packageType,
    required this.packageStatus,  this.fromTrack = false, });

  @override
  State<PackageDetailsWidget> createState() => _PackageDetailsWidgetState();
}

class _PackageDetailsWidgetState extends State<PackageDetailsWidget> {

  @override
  Widget build(BuildContext context) {

    String seeprice =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeprice ?? '';

    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: Stack(children: [

        Card(color: Theme.of(context).cardColor, child: Column(children: [
          const SizedBox(height: Dimensions.paddingSizeLarge),
          Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(width: Dimensions.marginSizeDefault),

/*            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.125))),
                    child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).
                    baseUrls!.productThumbnailUrl}/${widget.packageDetailsModel.productImage}', width: 80, height: 80))),
            const SizedBox(width: Dimensions.marginSizeDefault),*/


            InkWell(
              child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).
              baseUrls!.productThumbnailUrl}/${widget.packageDetailsModel.product!.thumbnail}', width: 80, height: 80),
              onTap: () async {
                final res = await http.get(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).
                baseUrls!.productThumbnailUrl}/${widget.packageDetailsModel.product!.thumbnail}'));
                if (res.statusCode == 200) {
                  await showDialog(
                      context: context,
                      //builder: (_) => ApplicabilityImageScreen(title: '${widget.packageDetailsModel.product?.details}', image: '${widget.packageDetailsModel.product!.thumbnail}',url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.productImageUrl)
                      builder: (_) => ServiceImageScreen(title: '${widget.packageDetailsModel.product?.description}', image: '${widget.packageDetailsModel.product!.thumbnail}',url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.productImageUrl)
                  );
                }
                else {
                  showCustomSnackBar('${getTranslated('no_image', context)}', context);
                }
              },
            ),
            const SizedBox(width: Dimensions.marginSizeDefault),


            Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Expanded(child: Text(widget.packageDetailsModel.productCode??'',
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                    maxLines: 2, overflow: TextOverflow.ellipsis))]),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),

              Row(children: [
                Expanded(child: Text(widget.packageDetailsModel.productDescription??'',
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                    maxLines: 2, overflow: TextOverflow.ellipsis))]),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),

              if(seeprice =='yes')
              Row(children: [
                Text("${getTranslated('price', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                //Text(PriceConverter.convertPrice(context, widget.packageDetailsModel.price),
                 Text('${widget.packageDetailsModel.price} ${widget.packageDetailsModel.priceUnit}',
                  style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context), fontSize: 16),),
              ]),

              const SizedBox(height: Dimensions.marginSizeExtraSmall),

              Row(children: [
              Text("${getTranslated('qty', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
              Text('${widget.packageDetailsModel.qty} ${widget.packageDetailsModel.product!.unit}', style: titilliumRegular.copyWith(
                      color: ColorResources.getPrimary(context), fontSize: 14)),
               ]),

              const SizedBox(height: Dimensions.marginSizeExtraSmall),

                        ],
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),

/*          Positioned(top: 35,  left: 20,
            child: widget.packageDetailsModel.discount! > 0?
            Container(height: 20, alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(Dimensions.paddingSizeExtraSmall))),


              child: Text(PriceConverter.percentageCalculation(context,
                  (widget.packageDetailsModel.price! * widget.packageDetailsModel.qty!),
                  widget.packageDetailsModel.discount, 'amount'),
                style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: ColorResources.white)),
            ):const SizedBox(),
          ),*/
        ],
      ),
    );
  }
}