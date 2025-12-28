import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:provider/provider.dart';
import '../domain/model/product_model.dart';
import '../view/applicability_image_screen2.dart';
import 'package:http/http.dart' as http;

class ProductApplicabilityWidget extends StatefulWidget {
  final ApplicabilityOptions productApplicabilityModel;

  const ProductApplicabilityWidget({super.key, required this.productApplicabilityModel});

  @override
  State<ProductApplicabilityWidget> createState() => _ProductApplicabilityWidgetState();
}

class _ProductApplicabilityWidgetState extends State<ProductApplicabilityWidget> {

  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: Stack(children: [

        Card(color: Theme.of(context).cardColor, child: Column(children: [
          const SizedBox(height: Dimensions.paddingSizeLarge),
          Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(width: Dimensions.marginSizeDefault),

            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.125))),
                    child:

                    InkWell(
                      child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).
                      baseUrls!.graphicImageUrl}/${widget.productApplicabilityModel.image}', width: 80, height: 80),
                      //onTap: ()=>
                         onTap: () async {
                        final res = await http.get(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).
                    baseUrls!.graphicImageUrl}/${widget.productApplicabilityModel.image}'));
                     if (res.statusCode == 200) {

                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>
                          ApplicabilityImageScreen2(title: getTranslated('drawings', context),
                              position:widget.productApplicabilityModel.position,
                              x:widget.productApplicabilityModel.x,
                              y:widget.productApplicabilityModel.y,
                              ratio:widget.productApplicabilityModel.ratio!.toDouble(),
                              fontsize:widget.productApplicabilityModel.fontsize!.toDouble(),
                              fontpadding:widget.productApplicabilityModel.fontpadding!.toDouble(),
                              imageList: widget.productApplicabilityModel.image
                              ))
                          );
                         }
                     else {
                       showCustomSnackBar('${getTranslated('no_drawing', context)}', context);
                     }
                         },
            )
                )
            ),


            const SizedBox(width: Dimensions.marginSizeDefault),


            Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Row(children: [
                Text('${widget.productApplicabilityModel.line}', style: titilliumRegular.copyWith(
                    color: ColorResources.getYellow(context), fontSize: 14),maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: Dimensions.marginSizeExtraSmall),
              ]),


              Row(children: [
                Expanded(child: Text('${widget.productApplicabilityModel.machine}',
                    style: titilliumRegular.copyWith(color: ColorResources.getSellerTxt(context),fontSize:14),
                    maxLines: 2, overflow: TextOverflow.ellipsis))]),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),

              Row(children: [
                Expanded(child: Text('${widget.productApplicabilityModel.assembly}',
                    style: titilliumRegular.copyWith(color: ColorResources.getSellerTxt(context),fontSize:14),
                    maxLines: 2, overflow: TextOverflow.ellipsis))]),
              const SizedBox(height: Dimensions.marginSizeExtraSmall),

              Row(children: [
                Text("${getTranslated('item_position', context)}: ", style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: 14),),
                Text('${widget.productApplicabilityModel.position}', style: titilliumRegular.copyWith(
                    color: ColorResources.getPrimary(context), fontSize: 16),maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: Dimensions.marginSizeExtraSmall),
              ]),

                        ],
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}