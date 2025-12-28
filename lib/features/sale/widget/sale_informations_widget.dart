import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/sale/widget/icon_with_text_row.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:provider/provider.dart';

class SaleInformationsWidget extends StatelessWidget {
  final SaleProvider saleProvider;
  const SaleInformationsWidget({super.key, required this.saleProvider});

  @override
  Widget build(BuildContext context) {
    return  saleProvider.sales!.saleType == 'POS' ? Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Dimensions.homePagePadding),
        color: Theme.of(context).highlightColor,
        child: Text(getTranslated('pos_sale', context)!)) :
    Container(decoration: const BoxDecoration(
      image: DecorationImage(image: AssetImage(Images.mapBg), fit: BoxFit.cover)),
        child: Card(margin: const EdgeInsets.all(Dimensions.marginSizeDefault),
          child: Padding(padding: const EdgeInsets.all(Dimensions.homePagePadding),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                IconWithTextRow(
                  //icon: Icons.delivery_dining_outlined,
                    icon: Icons.list_alt,
                  iconColor: Theme.of(context).primaryColor,
                  text: getTranslated('service_info', context)!,
                  textColor: Theme.of(context).primaryColor),


                saleProvider.onlyDigital?
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Divider(),
                  //  Text(getTranslated('vendor', context)!),
                  //  const SizedBox(height: Dimensions.marginSizeSmall),

                  Row(children: [
                   // Expanded(child: Text(getTranslated('vendor', context)!)),
                    Expanded(child: Text(getTranslated('machine', context)!)),
                  ]),
                  const SizedBox(height: Dimensions.marginSizeSmall),


                  Row(children: [
                    Expanded(child: IconWithTextRow(
                        icon: Icons.factory,
                        text: '${saleProvider.sales != null ? saleProvider.sales!.department : ''}')),
                  ]),


                  Row(children: [
                    Expanded(child: IconWithTextRow(
                        icon: Icons.list_alt_rounded,
                        text: '${saleProvider.sales != null ? saleProvider.sales!.machine : ''}')),
                  ]),

                  Row(children: [
                    Expanded(child: IconWithTextRow(
                        icon: Icons.person,
                        text: '${saleProvider.sales != null ? saleProvider.sales!.serviceman : ''}')),
                  ]),


                  Row(children: [
                    Expanded(child: IconWithTextRow(
                        icon: Icons.task,
                        text: '${saleProvider.sales != null ? saleProvider.sales!.saleType: ''}')),
                  ]),


                  ],
                ):const SizedBox(),

                const SizedBox(height: Dimensions.paddingSizeDefault),
              ],
            ),

          ),

        )
    );
  }
}
