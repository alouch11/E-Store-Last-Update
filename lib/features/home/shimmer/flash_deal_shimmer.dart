import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_slider/carousel_options.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class FlashDealShimmer extends StatelessWidget {
  const FlashDealShimmer({super.key, });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: Column(children: [


        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding),
          child: Container(height: 70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: ColorResources.iconBg(),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)]),
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).cardColor,
              highlightColor: Colors.grey[300]!,
              enabled: true,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

                Container(height: 70,
                    padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                    decoration:  BoxDecoration(color: ColorResources.iconBg(),
                        borderRadius: BorderRadius.circular(10)))
              ]),
            ),
          ),
        ),
        ],
      ),
    );
  }
}

