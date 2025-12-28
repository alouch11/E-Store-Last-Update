import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/sale_filter_dialog_by_machine.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/sale/widget/sale_type_by_machine_button.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/paginated_list_view.dart';
import 'package:provider/provider.dart';
import '../provider/sale_provider.dart';
import '../widget/sale_shimmer.dart';
import '../widget/sale_widget.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import '../../../theme/provider/theme_provider.dart';
import 'dart:convert';


class SaleScreenByMachine extends StatefulWidget {
  final int? indexId;
  final int? machineId;
  const SaleScreenByMachine({super.key,required this.indexId, required this.machineId});

  @override
  State<SaleScreenByMachine> createState() => _SaleScreenByMachineState();
}

class _SaleScreenByMachineState extends State<SaleScreenByMachine> {
  ScrollController scrollController  = ScrollController();
   bool isGuestMode = !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();
  String? expandservices =  Provider.of<ProfileProvider>(Get.context!, listen: false).userInfoModel!.expandservices;
  bool isToggled = true;

  @override
  void initState() {
    if(!isGuestMode){
      Provider.of<SaleProvider>(context, listen: false).setIndexByMachine(widget.indexId!,widget.machineId.toString(), notify: false);
      setState(() {
        Provider.of<SaleProvider>(context, listen: false).selectedSaleTypeList=[];
        Provider.of<SaleProvider>(context, listen: false).selectedSearchType='';
        Provider.of<SaleProvider>(context, listen: false).selectedSalePersonList=[];
        Provider.of<SaleProvider>(context, listen: false).selectedSaleLineList=[];
        Provider.of<SaleProvider>(context, listen: false).selectedSaleMachineList=[];
        Provider.of<SaleProvider>(context, listen: false).selectedSaleStartDate="2000-01-01";
        Provider.of<SaleProvider>(context, listen: false).selectedSaleEndDate="2200-01-01";
      });

      Provider.of<SaleProvider>(context, listen: false).getSaleListByMachine(1, 'pending', widget.machineId.toString(), Provider.of<SaleProvider>(context, listen: false).selectedSearchType,startDate:Provider.of<SaleProvider>(context, listen: false).selectedSaleStartDate,endDate:Provider.of<SaleProvider>(context, listen: false).selectedSaleEndDate);

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

        return Consumer<SaleProvider>(
        builder: (context, saleProvider, child) {
          int countPending=  saleProvider.saleModelByMachine?.totalPending??0;
          int countApproved=  saleProvider.saleModelByMachine?.totalApproved??0;
          int countServiced=  saleProvider.saleModelByMachine?.totalServiced??0;
          int countPartiallyServiced=  saleProvider.saleModelByMachine?.totalPartiallyServiced??0;
          int countCanceled=  saleProvider.saleModelByMachine?.totalCanceled??0;

          String? selectedSaleTypes =  saleProvider.selectedSaleTypeList.isNotEmpty ? jsonEncode( saleProvider.selectedSaleTypeList) : null;
          String? selectedSalePersons = saleProvider.selectedSalePersonList.isNotEmpty ? jsonEncode(saleProvider.selectedSalePersonList)  : null;
          String? selectedSaleStartDate = saleProvider.selectedSaleStartDate!="2000-01-01" ? saleProvider.selectedSaleStartDate : "2000-01-01";
          String? selectedSaleEndDate = saleProvider.selectedSaleEndDate!="2200-01-01" ? saleProvider.selectedSaleEndDate : "2200-01-01";


          return Column(children: [
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(children: [

                FlutterSwitch(
                  height: 27.0,
                  width: 47.0,
                  padding: 4.0,
                  toggleSize: 20.0,
                  borderRadius: 15.0,
                  activeColor: Theme.of(context).primaryColor,
                  value:  expandservices =='yes' ?isToggled:false, //&& widget.saleDetailsModel.deliveryStatus !='serviced' ?
                  onToggle: (value) {
                    setState(() {
                      if(expandservices =='yes'){
                        isToggled = value;
                        saleProvider.setSearchType(value);
                        saleProvider.getSaleListByMachine(1, saleProvider.selectedTypeByMachine,widget.machineId.toString(),saleProvider.selectedSearchType, saleType: selectedSaleTypes, persons: selectedSalePersons,startDate: selectedSaleStartDate, endDate: selectedSaleEndDate);

                      }
                    });
                  },
                ),

                const SizedBox(width: 10,height: 24),
                Expanded(child:  Text(getTranslated('see_all_services', context)!,style: robotoBold,)),
                Text('${getTranslated('filter_list', context)}',style: robotoBold,),
                const SizedBox(width: 10,height: 24),

                InkWell(onTap: () =>
                    showModalBottomSheet(context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        builder: (c) =>  SaleFilterDialogByMachine(isToggled:isToggled,machineId:widget.machineId!)


                    ),

                    child: Stack(clipBehavior: Clip.none, children: [
                      Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,
                          horizontal: Dimensions.paddingSizeExtraSmall),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Theme.of(context).hintColor.withOpacity(.25))),
                        child: SizedBox(width: 25,height: 24, child: Image.asset(Images.dropdown,
                            color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.white:Theme.of(context).primaryColor)
                        ),
                      ),

                      if ( saleProvider.selectedSaleTypeList.isNotEmpty || saleProvider.selectedSalePersonList.isNotEmpty || saleProvider.selectedSaleLineList.isNotEmpty || saleProvider.selectedSaleMachineList.isNotEmpty || saleProvider.selectedSaleStartDate!="2000-01-01" || saleProvider.selectedSaleEndDate!="2200-01-01")
                        Positioned(top: 0,right: 0,
                            child: Align(alignment: Alignment.topRight,
                              child: Center(
                                child: Container( decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault), color: Theme.of(context).primaryColor
                                ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical : Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeExtraSmall),
                                  ),
                                ),
                              ),
                            )
                        )])
                ),
              ],
              ),
            ),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
          child: SizedBox(
          height: 40,
          child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
                SaleTypeByMachineButton(text: getTranslated('PENDING', context), index: 0,machineId:widget.machineId.toString(),count:countPending),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                SaleTypeByMachineButton(text: getTranslated('APPROVED', context), index: 1,machineId:widget.machineId.toString(),count:countApproved),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                SaleTypeByMachineButton(text: getTranslated('PARTIALLY_SERVICED', context), index: 4,machineId:widget.machineId.toString(),count:countPartiallyServiced),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                SaleTypeByMachineButton(text: getTranslated('SERVICED', context), index: 2,machineId:widget.machineId.toString(),count:countServiced),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                SaleTypeByMachineButton(text: getTranslated('CANCELED', context), index: 3,machineId:widget.machineId.toString(),count:countCanceled),
          ],
          ),
          ),
          ),

            const Row(
                children: <Widget>[
                  Expanded(
                      child: Divider()
                  ),
                  Text(" List "),
                  Expanded(
                      child: Divider()
                  ),
                ]
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),

              Expanded(child: saleProvider.saleModelByMachine != null ? (saleProvider.saleModelByMachine!.sales != null && saleProvider.saleModelByMachine!.sales!.isNotEmpty)?
                SingleChildScrollView(
                  controller: scrollController,
                  child: PaginatedListView(scrollController: scrollController,
                    onPaginate: (int? offset) async{
                      await Provider.of<SaleProvider>(context, listen: false).getSaleListByMachine(offset!, saleProvider.selectedTypeByMachine,widget.machineId.toString(), Provider.of<SaleProvider>(context, listen: false).selectedSearchType, saleType: selectedSaleTypes, persons: selectedSalePersons,startDate:saleProvider.selectedSaleStartDate,endDate:saleProvider.selectedSaleEndDate);
                    },
                    totalSize: saleProvider.saleModelByMachine?.totalSize,
                    offset: saleProvider.saleModelByMachine?.offset != null ? int.parse(saleProvider.saleModelByMachine!.offset!):1,
                    itemView: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: saleProvider.saleModelByMachine?.sales!.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) => SaleWidget(saleModel: saleProvider.saleModelByMachine?.sales![index],index:index+1),
                    ),

                  ),
                ) : const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noOrder, message: 'no_order_found',) : const SaleShimmer()
              )

            ],
          );
        }
    //  ),
    );
  }
}




