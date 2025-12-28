import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/provider/dashboard_provider.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/widgets/monthly_dashboard_chart_amount.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/widgets/yearly_dashboad_chart_amount.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/widgets/yearly_dashboad_chart.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'monthly_dashboard_chart.dart';

class ServiceAmountsSection extends GetView<DashboardProvider> {
  const ServiceAmountsSection({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> previousYearsList =[];
    for(int i=4;i>=0;i--){
      previousYearsList.add((DateTime.now().year -i).toString());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault+3, vertical: Dimensions.paddingSizeDefault),
          child: Row(
            children: [
              Image.asset(Images.dashboardEarning,height: 15,width: 15,),
              const SizedBox(width: Dimensions.paddingSizeDefault,),
              Text(
                  getTranslated('service_amounts_statistics', context)!,
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
              right: Dimensions.paddingSizeSmall,
              top:Dimensions.paddingSizeDefault,
              bottom: Dimensions.paddingSizeSmall
          ),
          decoration: BoxDecoration(
              color:Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),boxShadow: shadow
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),

               Consumer<DashboardProvider>(builder: (context, dashboardProvider, child) {
                return SizedBox(
                  width: context.width,
                  child: dashboardProvider.getChartType == EarningType.monthly ?
                  const MonthlyDashBoardChartAmount():
                  const YearlyDashBoardChartAmount(),
                );
              }),
              Text(getTranslated('total_amounts', context)!,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),),
            ],
          ),
        ),
      ],
    );
  }
}
