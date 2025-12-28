import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/shop/domain/model/top_seller_model.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:flutter_spareparts_store/features/shop/widget/top_seller_view.dart';

class AllTopSellerScreen extends StatelessWidget {
  final TopSellerModel? topSeller;
  final String title;
  const AllTopSellerScreen({super.key, required this.topSeller, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: ColorResources.getIconBg(context),
      appBar: CustomAppBar(title: '${getTranslated(title, context)}',),
      body: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: TopSellerView(isHomePage: false),
      ),
    );
  }
}
