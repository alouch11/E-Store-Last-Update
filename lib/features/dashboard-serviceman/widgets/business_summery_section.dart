import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/provider/dashboard_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dashboard_custom_card.dart';

class BusinessSummerySection extends StatelessWidget {
  const  BusinessSummerySection({super.key,});

  @override
  Widget build(BuildContext context) {
    return
      Consumer<DashboardProvider>(builder: (context, dashboardProvider, child) {

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault,
              vertical: Dimensions.paddingSizeDefault,
            ),
            child: Text(
               getTranslated('services_summary', context)!,
              style: ubuntuMedium.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
          Container(
            padding:  const EdgeInsets.symmetric(
              horizontal:Dimensions.paddingSizeDefault,
              vertical: Dimensions.paddingSizeSmall,
            ),
            width: MediaQuery.of(context).size.width,
            height: 260,
            decoration: BoxDecoration(
              color:Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
              boxShadow: shadow
            ),

            child: Column(
              children: [
                Row(
                  children:   [
                    BusinessSummaryItem(
                        height: 80,
                        curveColor: const Color(0xff7180ff),
                        cardColor: const Color(0xff6a79ff),
                        amount: dashboardProvider.cards.pendingServices ?? 0,
                        title: getTranslated('total_assigned_service', context)!,
                        iconData: Images.earning
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall,),
                    BusinessSummaryItem(
                      height: 80,
                      cardColor: const Color(0xff3376E0),
                      curveColor: const Color(0xff367ae3),
                      amount: dashboardProvider.cards.ongoingServices ?? 0,
                      title: getTranslated('ongoing_service', context)!,
                      iconData: Images.service,
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall,),

                BusinessSummaryItem(
                  cardColor:Theme.of(context).colorScheme.surfaceTint,
                  amount: dashboardProvider.cards.completedServices ?? 0,
                  title: getTranslated('total_completed_service', context)!,
                  iconData: Images.serviceMan,
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall,),

                BusinessSummaryItem(
                  cardColor: Theme.of(context).colorScheme.tertiary,
                  amount: dashboardProvider.cards.canceledServices ?? 0,
                  title: getTranslated('total_canceled_service', context)!,
                  iconData: Images.booking,
                ),
              ],
            ),
          ),
        ],
      );
      }
    );
  }
}
