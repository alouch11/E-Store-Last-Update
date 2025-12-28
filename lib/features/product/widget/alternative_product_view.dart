import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_provider.dart';
import 'package:flutter_spareparts_store/basewidget/product_shimmer.dart';
import 'package:flutter_spareparts_store/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class AlternativeProductView extends StatelessWidget {
  const AlternativeProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        return Column(children: [

          prodProvider.alternativeProductList != null ? prodProvider.alternativeProductList!.isNotEmpty ?
          MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: prodProvider.alternativeProductList!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ProductWidget(productModel: prodProvider.alternativeProductList![index]);
            },
          ):  Center(child: Text(getTranslated('no_alternative_product', context)??"")) :
          ProductShimmer(isHomePage: false, isEnabled: Provider.of<ProductProvider>(context).alternativeProductList == null),
        ]);
      },
    );
  }
}
