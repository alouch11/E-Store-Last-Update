import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/domain/model/dashboard_model.dart';
import 'package:flutter_spareparts_store/features/sale/view/sale_details_screen.dart';
import 'package:flutter_spareparts_store/features/sale/widget/sale_widget.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/gaps.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';



class RecentActivityItem extends StatelessWidget {
  final DashboardService activityData;
  const RecentActivityItem({
    super.key, required this.activityData,
  });

  @override
  Widget build(BuildContext context) {
      return Consumer<SplashProvider>(builder: (context, splashProvider, _) {
        return Container(
          decoration: BoxDecoration(color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow:  [BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],),

          child:

          Padding(
            padding:  const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                  boxShadow: shadow
              ),
              margin: const EdgeInsets.only(bottom: 3),
              padding:  const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeSmall,
                horizontal: Dimensions.paddingSizeDefault,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('${getTranslated('service', context)}',style: ubuntuMedium,),
                            const SizedBox(height: Dimensions.paddingSizeSmall),

                            Text(" # ${activityData.serviceNo}", overflow: TextOverflow.ellipsis, style: ubuntuBold,),
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                        bookingDate('${getTranslated('date', context)}: ',activityData.createdAt!),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


                        Row(
                          children: [
                            Text('${getTranslated('service_man', context)}: ',
                              style: ubuntuRegularLow.copyWith(
                                color: ColorResources.yellow,
                              ),
                            ),
                            Text("${activityData.serviceman}", overflow: TextOverflow.ellipsis, style: ubuntuRegularLow.copyWith(color: ColorResources.yellow),),
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                        Row(
                          children: [
                            Text(
                              '${getTranslated('machine', context)}: ',
                              style: ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor),
                            ),
                            Text("${activityData.machine}", overflow: TextOverflow.ellipsis, style:  ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor),),
                          ],
                        )
                      ],
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeExtraSmall,
                            vertical: 5
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Get.isDarkMode ?
                          Colors.grey.withOpacity(0.2) :
                          activityData.serviceStatus == '1'? ColorResources.getYellow(context).withOpacity(.10) :
                          activityData.serviceStatus == '5'? ColorResources.getFloatingBtn(context).withOpacity(.10) :
                          activityData.serviceStatus == '2'? ColorResources.getGreen(context).withOpacity(.10) :
                          activityData.serviceStatus == '8'? ColorResources.getCheris(context).withOpacity(.10):
                          activityData.serviceStatus == '10'? ColorResources.getCheris(context).withOpacity(.10):
                          activityData.serviceStatus == '4'? ColorResources.getGrey(context).withOpacity(.10):
                          ColorResources.getYellow(context).withOpacity(.1),
                        ),
                        child: Center(
                          child: Text(
                            getTranslated('${activityData.serviceStatus}', context)!,
                            style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color:
                              activityData.serviceStatus == '1'? ColorResources.getYellow(context) :
                              activityData.serviceStatus == '5'? ColorResources.getFloatingBtn(context):
                              activityData.serviceStatus == '2'?  ColorResources.getGreen(context) :
                              activityData.serviceStatus == '8'? ColorResources.getCheris(context):
                              activityData.serviceStatus == '10'? ColorResources.getCheris(context):
                              activityData.serviceStatus == '4'? ColorResources.getGrey(context).withOpacity(.10):
                              ColorResources.getYellow(context),

                            ),
                          ),
                        ),
                      ),
                      Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
                      Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
                      InkWell(
                        child: Text(
                          getTranslated('view_details', context)!,
                          style: ubuntuBold.copyWith(
                            color: Theme.of(context).primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: ()=> {Navigator.of(context).push(MaterialPageRoute(builder: (context) => SaleDetailsScreen(saleId: activityData.id)))},
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        );
    });
  }}
