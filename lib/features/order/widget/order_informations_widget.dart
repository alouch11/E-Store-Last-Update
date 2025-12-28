import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/features/order/widget/icon_with_text_row.dart';
import 'package:provider/provider.dart';

class OrderInformationsWidget extends StatelessWidget {
  final OrderProvider orderProvider;
  const OrderInformationsWidget({super.key, required this.orderProvider});

  @override
  Widget build(BuildContext context) {
    return  orderProvider.orders!.orderType == 'POS' ? Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Dimensions.homePagePadding),
        color: Theme.of(context).highlightColor,
        child: Text(getTranslated('pos_order', context)!)) :
    Container(decoration: const BoxDecoration(
      image: DecorationImage(image: AssetImage(Images.mapBg), fit: BoxFit.cover)),
        child: Card(margin: const EdgeInsets.all(Dimensions.marginSizeDefault),
          child: Padding(padding: const EdgeInsets.all(Dimensions.homePagePadding),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                IconWithTextRow(
                  //icon: Icons.delivery_dining_outlined,
                    icon: Icons.list_alt,
                  iconColor: Theme.of(context).primaryColor,
                  text: getTranslated('order_info', context)!,
                  textColor: Theme.of(context).primaryColor),


                orderProvider.onlyDigital?
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Divider(),
                  //  Text(getTranslated('vendor', context)!),
                  //  const SizedBox(height: Dimensions.marginSizeSmall),

                  Row(children: [
                    Expanded(child: Text(getTranslated('vendor', context)!)),
                    Expanded(child: Text(getTranslated('machine', context)!)),
                  ]),
                  const SizedBox(height: Dimensions.marginSizeSmall),

                  Row(children: [
                    Expanded(child: IconWithTextRow(
                        icon: Icons.person,
                        //text: '${orderProvider.orders!.vendorAddressData!= null ? orderProvider.orders!.vendorAddressData!.contactPersonName : ''}')),
                        text: '${orderProvider.orders!= null ? orderProvider.orders!.orderVendorContactPerson : ''}')),
                    Expanded(child: IconWithTextRow(
                        icon: Icons.reorder,
                        //text: '${orderProvider.orders !.machineAddressData!= null ?  orderProvider.orders!.machineAddressData!.contactPersonName : ''}')),
                       text: '${orderProvider.orders != null ?  orderProvider.orders!.orderPerson : ''}')),
                  ]),


                  Row(children: [
                    Expanded(child: IconWithTextRow(
                        icon: Icons.call,
                        text: '${orderProvider.orders != null ? orderProvider.orders!.orderVendorPhone : ''}')),

                   Expanded(child: IconWithTextRow(
                        icon: Icons.numbers,
                        text: '${orderProvider.orders != null ?  orderProvider.orders!.orderVendorNumber : ''}')),
                  ]),



                  Row(children: [
                    Expanded(child: IconWithTextRow(
                        icon: Icons.location_on,
                        text: '${orderProvider.orders != null ? orderProvider.orders!.orderVendorAddress : ''}')),

                   Expanded(child: IconWithTextRow(
                        icon: Icons.task,
                        text: '${orderProvider.orders != null ?  orderProvider.orders!.orderType : ''}')),
                  ]),




                  Row(children: [
                      Expanded(child: IconWithTextRow(
                          icon: Icons.location_city,
                          text: '${orderProvider.orders != null ? orderProvider.orders!.orderVendorCountry : ''}')),

                       Expanded(child: IconWithTextRow(
                        icon: Icons.location_city,
                        text: '${orderProvider.orders != null ? orderProvider.orders!.machine : ''}')),
                  ]),

                  ],
                ):const SizedBox(),

                const SizedBox(height: Dimensions.paddingSizeDefault),



               // orderProvider.orderModel != null && orderProvider.orders!.billingAddressData != null?
              //  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
               //       Text(getTranslated('machine', context)!),
               //       const SizedBox(height: Dimensions.marginSizeSmall),

               //       IconWithTextRow(
               //         icon: Icons.person,
               //         text: '${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.contactPersonName : ''}'),
              //        const SizedBox(height: Dimensions.marginSizeSmall),

              //        IconWithTextRow(icon: Icons.call,
              //          text: '${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.phone : ''}'),
              //        const SizedBox(height: Dimensions.marginSizeSmall),



             //         Row(mainAxisAlignment:MainAxisAlignment.start, crossAxisAlignment:CrossAxisAlignment.start, children: [
             //             Icon(Icons.location_on, color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.white : Theme.of(context).primaryColor.withOpacity(.30)),
             //             const SizedBox(width: Dimensions.marginSizeSmall),

             //             Expanded(child: Padding(
             //               padding: const EdgeInsets.symmetric(vertical: 1),
             //               child: Text(' ${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.address : ''}',
             //                   maxLines: 3, overflow: TextOverflow.ellipsis, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
             //             )),
             //           ],
             //         ),
             //     Row(children: [
             //       Expanded(child: IconWithTextRow(
             //           icon: Icons.location_city,
             //           text: '${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.country : ''}')),

             //       Expanded(child: IconWithTextRow(
             //           icon: Icons.location_city,
             //           text: '${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.zip : ''}'))]),
             //   ]
             //   )//:const SizedBox(),
              ],
            ),

          ),

        )
    );
  }
}
