import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/provider/dashboard_provider.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/widgets/monthly_dashboard_chart_amount.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/widgets/yearly_dashboad_chart_amount.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/widgets/yearly_dashboad_chart.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drop_down_button.dart';
import 'monthly_dashboard_chart.dart';

class ServiceStatisticsSection extends GetView<DashboardProvider> {
  const ServiceStatisticsSection({super.key});
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
                  getTranslated('service_statistics', context)!,
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
              Consumer<DashboardProvider>(builder: (context, dashboardProvider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      GestureDetector(
                        onTap: (){
                          dashboardProvider.changeToYearlyEarnStatisticsChart(EarningType.monthly);
                          Provider.of<DashboardProvider>(context, listen: false).getMonthlyServicesDataForChart(DateConverter.stringYear(DateTime.now()),DateTime.now().month.toString());
                        },
                        child:  DashboardCustomButton(
                            buttonText:getTranslated('monthly', context)!,
                            isSelectedButton: dashboardProvider.getChartType == EarningType.monthly ? true: false
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      GestureDetector(
                        onTap: (){
                          dashboardProvider.changeToYearlyEarnStatisticsChart(EarningType.yearly);
                          dashboardProvider.changeDashboardDropdownValue(DateConverter.stringYear(DateTime.now()),"Year");
                        },
                        child:  DashboardCustomButton(
                            buttonText:getTranslated('yearly', context)!,
                            isSelectedButton: dashboardProvider.getChartType == EarningType.yearly ? true: false
                        ),
                      ),
                    ],
                  );
                },

              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),

                 Consumer<DashboardProvider>(builder: (context, dashboardProvider, child) {

                    return dashboardProvider.getChartType == EarningType.monthly ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        CustomDropDownButton(type: "Year",itemList: previousYearsList ,title:getTranslated('year', context)!),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        CustomDropDownButton(
                            type: "Month",
                            itemList: const ['January','February','March','April','May','June','July','August',
                              'September','October','November','December'],
                            title:getTranslated('month', context)!
                        ),
                      ],
                    ) : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomDropDownButton(type: "Year",itemList: previousYearsList ,title:getTranslated('year', context)!),
                      ],
                    );
                  }),

               Consumer<DashboardProvider>(builder: (context, dashboardProvider, child){
                return SizedBox(
                  width: context.width,
                  child: dashboardProvider.getChartType == EarningType.monthly ?
                  const MonthlyDashBoardChart():
                  const YearlyDashBoardChart(),
                );
              }),
              Text(getTranslated('total_services', context)!,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),),
            ],
          ),
        ),
      ],
    );
  }
}
