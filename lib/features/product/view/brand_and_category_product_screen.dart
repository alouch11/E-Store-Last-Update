import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/product_shimmer.dart';
import 'package:flutter_spareparts_store/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class BrandAndCategoryProductScreen extends StatelessWidget {
  final bool isBrand;
  final String id;
  final String? name;
  final String? image;
  final int? count;
  const BrandAndCategoryProductScreen({super.key, required this.isBrand, required this.id, required this.name, this.image, this.count});
  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).initBrandOrCategoryProductList(isBrand, id, context);
    return Scaffold(
      appBar: CustomAppBar(title: name),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [



            isBrand ? Container(height: 100,
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
              color: Theme.of(context).highlightColor,
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.brandImageUrl}/$image', width: 80, height: 80, fit: BoxFit.cover,),
                const SizedBox(width: Dimensions.paddingSizeSmall),


                Text(name!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                Text(' ( $count )', style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: const Color(
                    0xFF0525F6))),
              ]),
            ) : const SizedBox.shrink(),

            const SizedBox(height: Dimensions.paddingSizeSmall),

            // Products
            productProvider.brandOrCategoryProductList.isNotEmpty ?
            Expanded(
              child: MasonryGridView.count(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                itemCount: productProvider.brandOrCategoryProductList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ProductWidget(productModel: productProvider.brandOrCategoryProductList[index]);
                },
              ),
            ) :

            Expanded(child: productProvider.hasData! ?

              ProductShimmer(isHomePage: false,
                isEnabled: Provider.of<ProductProvider>(context).brandOrCategoryProductList.isEmpty)
                : const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noProduct,
              message: 'no_product_found',)),

          ]);
        },
      ),
    );
  }
}