
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/provider/dashboard_provider.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/widgets/business_summery_section.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/widgets/dashboard_shimmer.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/widgets/earning_amounts_section.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/widgets/earning_statistics_section.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/widgets/recent_activity_section.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:provider/provider.dart';




class DashBoardScreenService extends StatefulWidget {
  const DashBoardScreenService({super.key});
  @override
  State<DashBoardScreenService> createState() => _DashBoardScreenServiceState();
}
class _DashBoardScreenServiceState extends State<DashBoardScreenService> {

  void _loadData(){
    Provider.of<DashboardProvider>(context, listen: false).getDashboardData();
    Provider.of<DashboardProvider>(context, listen: false).changeToYearlyEarnStatisticsChart(EarningType.monthly);
    Provider.of<DashboardProvider>(context, listen: false).getMonthlyServicesDataForChart(
      DateConverter.stringYear(DateTime.now()),DateTime.now().month.toString(),
      isRefresh: true
    );
    Provider.of<DashboardProvider>(context, listen: false).getYearlyServicesDataForChart(
      DateConverter.stringYear(DateTime.now()),
      isRefresh: true
    );

    Provider.of<DashboardProvider>(context, listen: false).getMonthlyServicesAmountForChart(
        DateConverter.stringYear(DateTime.now()),DateTime.now().month.toString(),
        isRefresh: true
    );
    Provider.of<DashboardProvider>(context, listen: false).getYearlyServicesAmountForChart(
        DateConverter.stringYear(DateTime.now()),
        isRefresh: true
    );

  }


  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Theme.of(context).colorScheme.surface,
     appBar: const CustomAppBar(title: "Dashboard"),
      body: RefreshIndicator(
        backgroundColor: Theme.of(context).colorScheme.surface,
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
        onRefresh: () async {
          _loadData();
        },
        child: SingleChildScrollView(
          child:

     Consumer<DashboardProvider>(
    builder: (context, dashboardProvider, child) {
              return
                dashboardProvider.isLoading ?
              const DashboardTopCardShimmer() :

              const Column(
                children:[
                  BusinessSummerySection(),
                  ServiceStatisticsSection(),
                  ServiceAmountsSection(),
                  RecentActivitySection(),
                  SizedBox(height: Dimensions.paddingSizeDefault,)
                ],
              );
            },
          ),

    ),
      )
    );
  }
}
