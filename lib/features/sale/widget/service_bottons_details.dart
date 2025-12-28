import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:flutter_spareparts_store/features/product/widget/sale_close_bottom_sheet.dart';
import 'package:flutter_spareparts_store/features/sale/view/service_image_screen.dart';
import 'package:flutter_spareparts_store/features/sale/widget/service_widget.dart';
import 'package:flutter_spareparts_store/features/sale/domain/model/sale_model.dart';
import 'package:flutter_spareparts_store/features/sale/widget/approve_sale_dialog.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/features/sale/widget/cancel_sale_dialog.dart';
import 'package:provider/provider.dart';
import '../../product/widget/sale_close_bottom_sheet1.dart';

class ServiceButtons extends StatelessWidget {
  final Sales? saleModel;
  final bool fromNotification;
  const ServiceButtons({super.key, this.saleModel, this.fromNotification = false});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
         // InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportTicketScreen())),
         //   child: Text.rich(TextSpan(children: [
          //    TextSpan(text: getTranslated('if_you_cannot_contact_with_seller_or_facing_any_trouble_then_contact', context),
          //      style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: Dimensions.fontSizeSmall),),
         //     TextSpan(text: ' ${getTranslated('SUPPORT_CENTER', context)}',
         //       style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context)))]))),
        //  const SizedBox(height: Dimensions.homePagePadding),


        ///approve sale
              // (saleModel != null && (saleModel!.customerId! == int.parse(Provider.of<ProfileProvider>(context, listen: false).userID)) &&
             // (saleModel!.saleStatus == 'pending') && (saleModel!.saleType != "POS")) ?
               (saleModel != null && (saleModel!.serviceman! == Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.userServiceName) &&
                   (saleModel!.saleStatus == '1') ) ?
          CustomButton(textColor: ColorResources.white,
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(1),
              buttonText: getTranslated('approve_sale', context),
              onTap: () {
            showDialog(context: context, builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: ApproveSaleDialog(saleId: saleModel!.id,serviceman: saleModel!.serviceman)));}) :


///cancel sale

        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        (saleModel != null && (saleModel!.serviceman! == Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.userServiceName) &&
            (saleModel!.saleStatus == '1')) ?
        CustomButton(textColor: Theme.of(context).colorScheme.error,
            backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.1),
            buttonText: getTranslated('cancel_sale', context),
            onTap: () {
              showDialog(context: context, builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: CancelSaleDialog(saleId: saleModel!.id)));}) :
               const SizedBox(width: Dimensions.paddingSizeSmall),




        ///View Service details

        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        //(saleModel != null && (saleModel!.customerId! == int.parse(Provider.of<ProfileProvider>(context, listen: false).userID)) &&
         //   (saleModel!.saleStatus == 'delivered') && (saleModel!.serviceReq == 1) && (saleModel!.saleType != "POS")) ?
        //(saleModel != null && (saleModel!.saleStatus == 'serviced') && (saleModel!.alreadyServiced == 1)) ?
        //(saleModel != null && (saleModel!.saleStatus == '2') && (saleModel!.alreadyServiced == 1)) ?
        (saleModel != null && (saleModel!.alreadyServiced == 1)) ?
        CustomButton(textColor: ColorResources.white,
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(1),
            buttonText: getTranslated('view_service_details', context),

                  //onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ServiceWidget(saleModel: saleModel)))
                  onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SaleCloseBottomSheet1(saleModel: saleModel)))

  ) :

        const SizedBox(width: Dimensions.paddingSizeSmall),




        ///Close sale
   // Consumer<SaleProvider>(builder: (context,saleProvider,_){
    //return
   // (saleModel != null && (saleModel!.customerId! == int.parse(Provider.of<ProfileProvider>(context, listen: false).userID)) && (saleModel!.saleStatus != 'canceled') &&
   // (saleModel!.saleStatus == 'approved')  && (saleModel!.saleType != "POS")) ?
    (saleModel != null && (saleModel!.serviceman! == Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.userServiceName) && (saleModel!.saleStatus != '4') &&
        (saleModel!.saleStatus == '5')) ?
    //(saleModel!.saleType != "POS")) ?
        CustomButton(textColor: ColorResources.white,
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(1),
            buttonText: getTranslated('close_sale', context),
           // buttonText:getTranslated(saleModel!.serviceReq != 1 ? 'close_sale' : 'view_service_details', context)!,
            onTap: () {
              //Provider.of<ProductDetailsProvider>(context, listen: false).removeData();
             // saleProvider.getServiceReqInfo(saleModel!.id).then((value) {
               // if(value.response!.statusCode==200){
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      SaleCloseBottomSheet(saleId: saleModel!.id)));
             //   }
            //  });
        })

            :const SizedBox(width: Dimensions.paddingSizeSmall)
  //;}),



      ],
      ),
    );
  }
}
