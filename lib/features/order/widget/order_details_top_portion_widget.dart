import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/features/dashboard/dashboard_screen.dart';

class OrderDetailTopPortion extends StatelessWidget {
  final OrderProvider orderProvider;
  final bool fromNotification;
  const OrderDetailTopPortion({super.key, required this.orderProvider, this.fromNotification = false});

  @override
  Widget build(BuildContext context) {
    return orderProvider.orders != null?
    Stack(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center, children: [
                RichText(text: TextSpan(
                    text: '${getTranslated('order', context)}# ',
                    style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeDefault), children:[
                      TextSpan(text: orderProvider.orders!.orderNumber,
                          style: textBold.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeLarge)),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall,),

                RichText(text: TextSpan(
                    text: getTranslated('your_order_is', context),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getHint(context)),
                    children:[
                      TextSpan(text: ' ${getTranslated('4${orderProvider.orders?.orderStatus}', context)}',
                          style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                            color:

                            orderProvider.orders!.orderStatus == '1'? ColorResources.getYellow(context) :
                            orderProvider.orders?.orderStatus == '7'? ColorResources.getRed(context):
                            orderProvider.orders!.orderStatus == '5'? ColorResources.getFloatingBtn(context) :
                            orderProvider.orders?.orderStatus == '2'? ColorResources.getGreen(context) :
                            orderProvider.orders?.orderStatus == '6'? ColorResources.getCheris(context) :
                            orderProvider.orders?.orderStatus == '4'? ColorResources.getHint(context):

                            ///Local Orders
                            orderProvider.orders!.orderStatus == '1'? ColorResources.getYellow(context) :
                            orderProvider.orders?.orderStatus == '7'? ColorResources.getRed(context):
                            orderProvider.orders!.orderStatus == '5'? ColorResources.getFloatingBtn(context) :
                            orderProvider.orders?.orderStatus == '2'? ColorResources.getGreen(context) :
                            orderProvider.orders?.orderStatus == '6'? ColorResources.getCheris(context) :
                            orderProvider.orders?.orderStatus == '4'? ColorResources.getHint(context) :
                            orderProvider.orders!.orderStatus == '5'? Theme.of(context).primaryColor : ColorResources.getGreen(context)


                          ))]),),
                const SizedBox(height: Dimensions.paddingSizeSmall,),

                Text(DateConverter.localDateToIsoStringAMPMOrder(DateTime.parse(orderProvider.orders!.createdAt!)),
                    style: titilliumRegular.copyWith(color: ColorResources.getHint(context),
                        fontSize: Dimensions.fontSizeSmall)),

              Padding(padding:  const EdgeInsets.only(top: Dimensions.paddingSizeSmall),//,left: MediaQuery.of(context).size.width * .65),
                child: Row(children: [
                  //SizedBox(height: 14,width: 14, child: Image.asset(Images.profile,color:Colors.red)),
                  Text( getTranslated('created_by', context)!,  style: titilliumRegular.copyWith(color: ColorResources.getHint(context), fontSize: Dimensions.fontSizeSmall)),
                  const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
                  Text(orderProvider.orders!.createdBy!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color:ColorResources.red)),
                ],
                ),
              ),
              ],
            ),
          ],
        ),
        InkWell(onTap: (){
          if(fromNotification){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
          }else{
            Navigator.pop(context);
          }
        }, child: const Padding(padding: EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault),
            child: Icon(CupertinoIcons.back))
        )
      ],
    ): const SizedBox();
  }
}
