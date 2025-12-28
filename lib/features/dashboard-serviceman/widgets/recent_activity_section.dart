import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/provider/dashboard_provider.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/widgets/recent_activity_card.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});
  @override
  Widget build(BuildContext context) {
    return
      Consumer<DashboardProvider>(builder: (context, dashboardProvider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault+3,
                vertical: Dimensions.paddingSizeDefault),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(Images.dashboardProfile,height: 15,width: 15,),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text(
                        getTranslated('my_recent_activities', context)!,
                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                    ),
                  ],
                ),
              ],
            ),
          ),
          dashboardProvider.services.isEmpty?
          Container(
            padding: const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeSmall),

            child: Center(
              child: Text(
                getTranslated('your_recent_service_will_appear_here', context)!,
                style: ubuntuRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,

                ),
              ),
            ),
          ) :
          Container(
            padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
              boxShadow: shadow,
            ),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      child: RecentActivityItem(activityData: dashboardProvider.services[index]),
                      onTap: (){
                       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SaleDetailsScreen(saleId: saleModel!.id)));
                        },
                    ),
                    if(index!=dashboardProvider.services.length-1) const Divider()
                  ],
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dashboardProvider.services.length,
            ),
          ),
        ],
      );
    });
  }
}
