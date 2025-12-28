import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/helper/price_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/shop/provider/shop_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/animated_custom_dialog.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/basewidget/guest_dialog.dart';
import 'package:provider/provider.dart';

import '../domain/model/product_details_model.dart';

class ProductInfoWidget extends StatelessWidget {
  final String productName;
  final int productId;
  final String banner;
  final String shopImage;
  const ProductInfoWidget({super.key, required this.productName, required this.productId, required this.banner, required this.shopImage});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(width: Dimensions.paddingSizeSmall),
        Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Container(transform: Matrix4.translationValues(0, -20, 0),
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeDefault ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
                boxShadow: Provider.of<ThemeProvider>(context,listen: false).darkTheme?
                null:[BoxShadow( spreadRadius: 1, blurRadius: 5)]),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(children: [
                Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                    boxShadow: Provider.of<ThemeProvider>(context,listen: false).darkTheme?
                    null: [BoxShadow( spreadRadius: 1, blurRadius: 5)]),
                  child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    child: CustomImage(placeholder: Images.placeholder, height: 80, width: 80, fit: BoxFit.cover,
                      image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.sellerImageUrl}/$shopImage'))),
              ]),

              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                child: Consumer<ProductDetailsModel>(
                    builder: (context, ProductDetailsModel,_) {
                      String ratting = ProductDetailsModel.code != null?
                      "1" : "0";

                      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Expanded(child: Text(productName,
                            style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                            maxLines: 2, overflow: TextOverflow.ellipsis,),),

                        ],
                        ),

/*
                        ProductDetailsModel.currentStock   = null ?
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                              child: Row(children: [
                                const Icon(Icons.star_rate_rounded,),
                                Text(double.parse(ratting).toStringAsFixed(1), style: textRegular),


                                if(ProductDetailsModel!.currentStock != null)
                                Text('${ProductDetailsModel!.unitPrice} ${getTranslated('reviews', context)}',
                                  style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).primaryColor),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,),
                              ])),
                          const SizedBox(height: Dimensions.paddingSizeSmall),


                          Row(children: [

                            (ProductDetailsModel!.unitPrice != null )?

                            Text('${PriceConverter.convertPrice(context, ProductDetailsModel!.unitPrice)} ${getTranslated('minimum_order', context)}',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).primaryColor),
                              maxLines: 1, overflow: TextOverflow.ellipsis,):
                            Text('${ProductDetailsModel!.unitPrice} ${getTranslated('reviews', context)}',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).primaryColor),
                              maxLines: 1, overflow: TextOverflow.ellipsis,),



                            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                              child: Text('|', style: textRegular.copyWith(color: Theme.of(context).primaryColor),),),

                            Text('${ProductDetailsModel.id} ${getTranslated('products', context)}',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).primaryColor),
                              maxLines: 1, overflow: TextOverflow.ellipsis,),

                          ],
                          ),
                        ])*/]
                      ,
                      );
                    }
                ),
              ),

            ]),
          ),
        ),
      ],
    );
  }
}
