import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/notification/domain/model/notification_model.dart';
import 'package:flutter_spareparts_store/features/order/view/order_details_screen.dart';
import 'package:flutter_spareparts_store/features/order/view/order_details_screen1.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../utill/styles.dart';
import '../../sale/view/sale_details_screen.dart';

class NotificationDialog extends StatelessWidget {
  final NotificationItem notificationModel;
  const NotificationDialog({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        const SizedBox(height: Dimensions.paddingSizeDefault,),

        InkWell(onTap: ()=>Navigator.of(context).pop(),
          child: Container(
            width: 40,height: 5,decoration: BoxDecoration(
              color: Theme.of(context).hintColor.withOpacity(.5),
              borderRadius: BorderRadius.circular(20)
          ),),
        ),
        const SizedBox(height: 20,),
          notificationModel.image != "null"?
          Container(height: MediaQuery.of(context).size.width-100, width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            decoration: BoxDecoration( color: Theme.of(context).primaryColor.withOpacity(0.20)),
            child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.notificationImageUrl}/${notificationModel.image}',
              height: MediaQuery.of(context).size.width-130, width: MediaQuery.of(context).size.width,)
          ):const SizedBox(),
          const SizedBox(height: Dimensions.paddingSizeLarge),

          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Text(notificationModel.title!, textAlign: TextAlign.center,
              style: titilliumSemiBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge))),

          Padding(padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Text(notificationModel.description!, textAlign: TextAlign.center, style: titilliumRegular)),


        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: InkWell(
              child: Text(
                getTranslated('view_details', context)!,
                style: ubuntuBold.copyWith(
                  color: Theme.of(context).primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: ()=> {
                if(notificationModel.notificationType=='service')
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SaleDetailsScreen(saleId: notificationModel.sourceId!))),
                if(notificationModel.notificationType=='order')
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderDetailsScreen(orderId: notificationModel.sourceId!))),
                if(notificationModel.notificationType=='local_order')
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderDetailsScreen(orderId: notificationModel.sourceId!)))
              },
            ),),



        const SizedBox(height: Dimensions.paddingSizeSmall,),

        ],
      ),
    );
  }
}
