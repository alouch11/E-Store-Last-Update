import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/package/provider/package_provider.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/not_loggedin_widget.dart';
import 'package:flutter_spareparts_store/basewidget/paginated_list_view.dart';
import 'package:flutter_spareparts_store/features/package/widget/package_shimmer.dart';
import 'package:flutter_spareparts_store/features/package/widget/package_widget.dart';
import 'package:provider/provider.dart';
import '../../splash/provider/splash_provider.dart';
import '../widget/package_dropdown_hour_list.dart';
import '../widget/package_dropdown_line_list.dart';
import '../widget/package_dropdown_machine_list.dart';

class PackageScreen extends StatefulWidget {
  final bool isBacButtonExist;
  const PackageScreen({super.key, this.isBacButtonExist = true});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  ScrollController scrollController  = ScrollController();
   bool isGuestMode = !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();



    void _loadData(BuildContext context) async {

      List<String>? lines = Provider.of<SplashProvider>(context, listen: false).packagelines!.split(',');
      List<String>? hours = Provider.of<SplashProvider>(context, listen: false).packagehours!.split(',');
      List<String>? machines = Provider.of<SplashProvider>(context, listen: false).packagemachines!.split(',');

    DropdownLineList(list:lines);
    DropdownMachineList(list:machines);
    DropdownHourList(list:hours);
  }




  @override
  void initState() {
    if(!isGuestMode){
      super.initState();
      _loadData(context);


      //Provider.of<PackageProvider>(context, listen: false).setLine('All', notify: false);
      //Provider.of<PackageProvider>(context, listen: false).setHour('All', notify: false);
      //Provider.of<PackageProvider>(context, listen: false).setMachine('All', notify: false);
      Provider.of<PackageProvider>(context, listen: false).getPackageList(1,'All','All','All');

    }
  }

  @override
  Widget build(BuildContext context) {

    String? packagelines= Provider.of<SplashProvider>(context, listen: false).configModel!.packagelines?? '';
    String? packagehours= Provider.of<SplashProvider>(context, listen: false).configModel!.packagehours?? '';
    String? packagemachines= Provider.of<SplashProvider>(context, listen: false).configModel!.packagemachines?? '';

    List<String>? lines = packagelines.split(',');
    List<String>? hours = packagehours.split(',');
    List<String>? machines = packagemachines.split(',');



    return Scaffold(
     appBar: CustomAppBar(title: getTranslated('package', context), isBackButtonExist: widget.isBacButtonExist),
      body: isGuestMode ? const NotLoggedInWidget() :

      Consumer<PackageProvider>(
        builder: (context, packageProvider, child) {
          return Column(children: [

/*            Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Row(children: [
                PackageTypeButton(text: getTranslated('PACKAGE_PENDING', context), index: 0),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                PackageTypeButton(text: getTranslated('PACKAGE_APPROVED', context), index: 1),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                PackageTypeButton(text: getTranslated('PACKAGE_DELIVERED', context), index: 3),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                PackageTypeButton(text: getTranslated('PACKAGE_CANCELED', context), index: 4),
              ],),),*/

/*            DropdownSearch<String>.multiSelection(
              items: const ["pending", "approved", "delivered", 'canceled'],
              popupProps: PopupPropsMultiSelection.menu(
                showSelectedItems: true,
                disabledItemFn: (String s) => s.startsWith('I'),
              ),
              onChanged: print,
              selectedItems: const ["pending"],
            ),*/

/*            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Column(
                    children: [*/
                      DropdownLineList(list:lines ),
                     // const Divider(),
                      DropdownMachineList(list:machines ),
                     // const Divider(),
                      DropdownHourList(list:hours),
           //         ]
           //     )
          //  ),


            const Divider(),
             //const DropdownButtonExample(),
            // const DropdownLineList(list:<String>['All','SBO10-1', 'SBO10-2', 'SBO14-1', 'SBO14-2']),
           //  const DropdownHourList(list:<String>['All','3000H', '6000H', '9000H', '12000H']),
/*
            const SizedBox(height: Dimensions.marginSizeExtraSmall),


          Row(children: [
            //Text("    ${getTranslated('lines', context)}:   ", style: titilliumRegular.copyWith(color: ColorResources.black, fontSize: 18),),
            Expanded(child: DropdownLineList(list:lines ?? ['']),)]),

          const SizedBox(height: Dimensions.marginSizeExtraSmall),
          Row(children: [
          //  Text("    ${getTranslated('machine', context)}:   ", style: titilliumRegular.copyWith(color: ColorResources.black, fontSize: 18),),
            Expanded(child: DropdownMachineList(list:machines ?? ['']),)]),

          const SizedBox(height: Dimensions.marginSizeExtraSmall),

          Row(
              children: [
          //  Text("    ${getTranslated('hours', context)}:   ", style: titilliumRegular.copyWith(color: ColorResources.black, fontSize: 18),),
            Expanded(child: DropdownHourList(list:hours ?? ['']),)]),
*/


         //   const SizedBox(height: Dimensions.marginSizeLarge),

              Expanded(child: packageProvider.packageModel != null ? (packageProvider.packageModel!.packages != null && packageProvider.packageModel!.packages!.isNotEmpty)?
                SingleChildScrollView(
                  controller: scrollController,
                  child: PaginatedListView(scrollController: scrollController,
                    onPaginate: (int? offset) async{
                      await Provider.of<PackageProvider>(context, listen: false).getPackageList(offset!, packageProvider.packageLineIndex,packageProvider.packageHourIndex,packageProvider.packageMachineIndex);
                    },
                    totalSize: packageProvider.packageModel?.totalSize,
                    offset: packageProvider.packageModel?.offset != null ? int.parse(packageProvider.packageModel!.offset!):1,
                    itemView: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: packageProvider.packageModel?.packages!.length,
                      //itemCount: 10,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) => PackageWidget(packageModel: packageProvider.packageModel?.packages![index]),
                    ),

                  ),
                ) : const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noOrder, message: 'no_package_found',) : const PackageShimmer()
              )

            ],
          );
        }
      ),
    );
  }
}


