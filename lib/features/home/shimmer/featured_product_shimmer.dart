import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedProductShimmer extends StatelessWidget {
  const FeaturedProductShimmer({super.key, });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 50, vertical: Dimensions.paddingSizeSmall),
          child: Container(height: 10,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
                color: ColorResources.iconBg()),
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).cardColor,
              highlightColor: Colors.grey[300]!,
              enabled: true,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

                Container(height: 10, padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                    decoration:  BoxDecoration(color: ColorResources.iconBg(),
                        borderRadius: BorderRadius.circular(2)))
              ]),
            ),
          ),
        ),
      ],
      ),
    );
  }
}

