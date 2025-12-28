import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/order/domain/model/order_model.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/features/order/widget/cancel_order_dialog.dart';
import 'package:flutter_spareparts_store/features/tracking/view/tracking_result_screen.dart';
import 'package:provider/provider.dart';

class CancelAndSupport extends StatelessWidget {
  final Orders? orderModel;
  final bool fromNotification;
  const CancelAndSupport({super.key, this.orderModel, this.fromNotification = false});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [

          (orderModel != null && (orderModel!.customerId! == int.parse(Provider.of<ProfileProvider>(context, listen: false).userID)) &&
              (orderModel!.orderStatus == '1')) ?
    //(orderModel!.orderStatus == '1') && (orderModel!.orderType != "POS")) ?
          CustomButton(textColor: Theme.of(context).colorScheme.error,
              backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.1),
              buttonText: getTranslated('cancel_order', context),
              onTap: () {
            showDialog(context: context, builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: CancelOrderDialog(orderId: orderModel!.id)));}) :


          (Provider.of<AuthController>(context, listen: false).isLoggedIn()  && orderModel!.orderStatus != '4' )?
          CustomButton(buttonText: getTranslated('TRACK_ORDER', context),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrackingResultScreen(orderID: orderModel!.id.toString()))),): const SizedBox(),

          const SizedBox(width: Dimensions.paddingSizeSmall),


        ],
      ),
    );
  }
}
