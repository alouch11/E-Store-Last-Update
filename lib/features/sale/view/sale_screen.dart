import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/sale_filter_dialog.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/sale/view/sale_details_screen.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/not_loggedin_widget.dart';
import 'package:flutter_spareparts_store/basewidget/paginated_list_view.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/enum.dart';
import '../../../theme/provider/theme_provider.dart';
import '../provider/sale_provider.dart';
import '../widget/sale_shimmer.dart';
import '../widget/sale_type_button.dart';
import '../widget/sale_widget.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_spareparts_store/features/sale/view/add_service_screen.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';


class SaleScreen extends StatefulWidget {
  final bool isBacButtonExist;
  const SaleScreen({super.key, this.isBacButtonExist = true});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  ScrollController scrollController  = ScrollController();
   bool isGuestMode = !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();
   String? expandservices =  Provider.of<ProfileProvider>(Get.context!, listen: false).userInfoModel!.expandservices;
   String? userType =  Provider.of<ProfileProvider>(Get.context!, listen: false).userInfoModel!.userType;
    bool isToggled = false;


  @override
  void initState() {
    if(!isGuestMode){
      Provider.of<SaleProvider>(context, listen: false).setSearchType(false);
      Provider.of<SaleProvider>(context, listen: false).setIndex(0, notify: false);


     setState(() {
        Provider.of<SaleProvider>(context, listen: false).selectedSaleTypeList=[];
        Provider.of<SaleProvider>(context, listen: false).selectedSalePersonList=[];
        Provider.of<SaleProvider>(context, listen: false).selectedSaleLineList=[];
        Provider.of<SaleProvider>(context, listen: false).selectedSaleMachineList=[];
        Provider.of<SaleProvider>(context, listen: false).selectedSaleStartDate="2000-01-01";
        Provider.of<SaleProvider>(context, listen: false).selectedSaleEndDate="2200-01-01";
      });

      Provider.of<SaleProvider>(context, listen: false).getSaleList(1, 'pending', Provider.of<SaleProvider>(context, listen: false).selectedSearchType,startDate:Provider.of<SaleProvider>(context, listen: false).selectedSaleStartDate,endDate:Provider.of<SaleProvider>(context, listen: false).selectedSaleEndDate,serviceSelectedType:'allServices');
      //Provider.of<SaleProvider>(context, listen: false).getServiceList(1, 'pending', Provider.of<SaleProvider>(context, listen: false).selectedSearchType,startDate:Provider.of<SaleProvider>(context, listen: false).selectedSaleStartDate,endDate:Provider.of<SaleProvider>(context, listen: false).selectedSaleEndDate);

    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(getTranslated('services', context)!,
                  style: titilliumRegular.copyWith(fontSize: 20,
                    color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black,),
                  maxLines: 1, overflow: TextOverflow.ellipsis),

              const SizedBox(width: 8),
              userType == 'serviceman' ?
              InkWell(onTap: () async {
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const SimpleBarcodeScannerPage(
                          appBarTitle: 'Scan Service Barcode',
                          isShowFlashIcon: true,
                          centerTitle: true,
                          scanType: ScanType.barcode),

                    ));
                setState(()  {
                  if (res is String) {
                    String saleNumber = res.toString();
                    if(saleNumber.isEmpty){
                      showCustomSnackBar('${getTranslated('service_number_is_required', context)}', context);
                    }
                    else{
                      Provider.of<SaleProvider>(context, listen: false).trackYourSale(saleNo: saleNumber.toString()).then((value) {
                        if (value.response != null && value.response!.statusCode == 200) {
                          int? saleId = value.response!.data[0]['BLMASKODU'];
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> SaleDetailsScreen(fromTrack: true,
                              saleId: saleId)));
                        }

                      });

                    }

                  }
                });
              },
                child: Padding(padding: const EdgeInsets.all(2),
                  child: Container(width: 30, height: 30,
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.all( Radius.circular(Dimensions.paddingSizeSmall))),
                    child: const Icon(Icons.qr_code_scanner_outlined ,color: Colors.white,size: 22),
                  ),
                ),

              ):const SizedBox(),
            ],
          ),
        actions:  [

          /*userType == 'serviceman' ?
          InkWell(onTap: () async {
            var res = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SimpleBarcodeScannerPage(),
                ));
            setState(()  {
              if (res is String) {
                String saleNumber = res.toString();
                if(saleNumber.isEmpty){
                  showCustomSnackBar('${getTranslated('service_number_is_required', context)}', context);
                }
                else{
                  Provider.of<SaleProvider>(context, listen: false).trackYourSale(saleNo: saleNumber.toString()).then((value) {
                    if (value.response != null && value.response!.statusCode == 200) {
                      int? saleId = value.response!.data[0]['BLMASKODU'];
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> SaleDetailsScreen(fromTrack: true,
                          saleId: saleId)));
                    }

                  });

                }

              }
            });
          },
            child: Padding(padding: const EdgeInsets.all(2),
              child: Container(width: 30, height: 30,
                decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all( Radius.circular(Dimensions.paddingSizeSmall))),
                child: const Icon(Icons.qr_code_scanner_outlined ,color: Colors.white,size: 22),
              ),
            ),

          ):const SizedBox(),
          */

          userType == 'serviceman' ?
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AddServiceScreen()));
              },child:Container(decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault), color: Theme.of(context).primaryColor
          ), child: const Icon(Icons.add,size: 30,color: Colors.white,)) ):const SizedBox(),

          const FilterPopUpMenuWidget(),


        ],
        ),

      /*floatingActionButton:
      userType == 'serviceman' ?
      FloatingActionButton(
        // /mini: true,
        splashColor: Theme.of(context).splashColor,
        shape: const CircleBorder(),
        hoverColor:Theme.of(context).hintColor ,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
        child: const Icon(Icons.add,size: 30),
        onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddServiceScreen()));
          },
      ) :const SizedBox(),*/
      //floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      body: isGuestMode ? const NotLoggedInWidget() :

      Consumer<SaleProvider>(
        builder: (context, saleProvider, child) {

          int countPending=  saleProvider.saleModel?.totalPending??0;
          int countApproved=  saleProvider.saleModel?.totalApproved??0;
          int countServiced=  saleProvider.saleModel?.totalServiced??0;
          int countPartiallyServiced=  saleProvider.saleModel?.totalPartiallyServiced??0;
          int countCanceled=  saleProvider.saleModel?.totalCanceled??0;


          String? selectedSaleTypes =  saleProvider.selectedSaleTypeList.isNotEmpty ? jsonEncode( saleProvider.selectedSaleTypeList) : null;
          String? selectedSalePersons = saleProvider.selectedSalePersonList.isNotEmpty ? jsonEncode(saleProvider.selectedSalePersonList)  : null;
          String? selectedSaleLines = saleProvider.selectedSaleLineList.isNotEmpty ? jsonEncode(saleProvider.selectedSaleLineList)  : null;
          String? selectedSaleMachines = saleProvider.selectedSaleMachineList.isNotEmpty ? jsonEncode(saleProvider.selectedSaleMachineList)  : null;
          String? selectedSaleStartDate = saleProvider.selectedSaleStartDate!="2000-01-01" ? saleProvider.selectedSaleStartDate : "2000-01-01";
          String? selectedSaleEndDate = saleProvider.selectedSaleEndDate!="2200-01-01" ? saleProvider.selectedSaleEndDate : "2200-01-01";
          String? selectedServiceType =  saleProvider.selectedServiceType.isNotEmpty ? saleProvider.selectedServiceType: "allServices";

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
                  saleProvider.getSaleList(1, saleProvider.selectedType, saleProvider.selectedSearchType, saleType: selectedSaleTypes, persons: selectedSalePersons, lines: selectedSaleLines, machines: selectedSaleMachines,startDate: selectedSaleStartDate, endDate: selectedSaleEndDate,serviceSelectedType:selectedServiceType);

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
          builder: (c) =>  SaleFilterDialog(isToggled:isToggled)

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
          )
          ])
          ),
          ],
          ),
          ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
              child: SizedBox(
                height: 40,
                child:
          ListView(
                  controller: Provider.of<SaleProvider>(context, listen: false).scrollControllerService,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    SaleTypeButton(text: getTranslated('PENDING', context), index: 0,count:countPending),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    SaleTypeButton(text: getTranslated('APPROVED', context), index: 1,count:countApproved),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    SaleTypeButton(text: getTranslated('PARTIALLY_SERVICED', context), index: 4,count:countPartiallyServiced),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    SaleTypeButton(text: getTranslated('SERVICED', context), index: 2,count:countServiced),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    SaleTypeButton(text: getTranslated('CANCELED', context), index: 3,count:countCanceled),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  ],
                ),

              )),


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

              Expanded(child: saleProvider.saleModel != null ? (saleProvider.saleModel!.sales != null && saleProvider.saleModel!.sales!.isNotEmpty)?
                SingleChildScrollView(
                  controller: scrollController,
                  child: PaginatedListView(scrollController: scrollController,
                    onPaginate: (int? offset) async{

                    await saleProvider.getSaleList(offset!, saleProvider.selectedType, saleProvider.selectedSearchType, saleType: selectedSaleTypes, persons: selectedSalePersons, lines: selectedSaleLines, machines: selectedSaleMachines,startDate:saleProvider.selectedSaleStartDate,endDate:saleProvider.selectedSaleEndDate,serviceSelectedType:saleProvider.selectedServiceType);
                    },
                    totalSize: saleProvider.saleModel?.totalSize,
                    offset: saleProvider.saleModel?.offset != null ? int.parse(saleProvider.saleModel!.offset!):1,
                    itemView: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: saleProvider.saleModel?.sales!.length,
                      padding: const EdgeInsets.all(0),
                      //itemBuilder: (context, index) => SaleWidget(saleModel: saleProvider.saleModel?.sales![index],index:index+1,hasdetails:saleProvider.saleModel?.sales![index].hasdetails),
                      itemBuilder: (context, index) => SaleWidget(saleModel: saleProvider.saleModel?.sales![index],index:index+1,saleCategory:saleProvider.saleModel?.sales![index].saleCategory),
                    ),

                  ),
                ) : const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noOrder, message: 'no_order_found',) : const SaleShimmer()

              )


           /* ,ElevatedButton(
              child: Text("Overlay Test"),
              onPressed: () {
                final entry = OverlayEntry(
                  builder: (context) => Container(
                    color: Colors.blue,
                  ),
                );
                Overlay.of(context)?.insert(entry);
              },
            )*/
            ],

          );
        }
      ),
    );
  }

}



class FilterPopUpMenuWidget extends StatelessWidget {
  const FilterPopUpMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Consumer<SaleProvider>(
          builder: (context, saleProvider, child) {

      List<String> serviceFilterList = ['all_services', "system_services", "created_services"];

      return PopupMenuButton<String>(
        shape:  RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall,)),
            side: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.1))
        ),
        surfaceTintColor: Theme.of(context).cardColor,
        position: PopupMenuPosition.under, elevation: 8,
        shadowColor: Theme.of(context).hintColor.withOpacity(0.3),
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context) {
          return serviceFilterList.map((String option) {
            String type = option == "system_services" ? "systemServices" :  option == "created_services" ? "createdServices" : "all";
            return PopupMenuItem<String>(
              value: option,
              padding: EdgeInsets.zero,
              height: 45,
              child:  saleProvider.selectedServiceType == type ?
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 12),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(getTranslated(option, context)!, style: robotoRegular.copyWith(color: Theme.of(context).colorScheme.primary)),
                  ],
                ),
              ) : Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Text(getTranslated(option, context)!, style: robotoRegular,),
              ),
              onTap: (){
                saleProvider.updateSelectedServiceType (type: option == "system_services" ? "systemServices" :  option == "created_services" ? "createdServices" : "allServices");
                saleProvider.getSaleList(1, saleProvider.selectedType, saleProvider.selectedSearchType, saleType: jsonEncode(saleProvider.selectedSaleTypeList), persons: jsonEncode(saleProvider.selectedSalePersonList), lines: jsonEncode(saleProvider.selectedSaleLineList), machines: jsonEncode(saleProvider.selectedSaleMachineList),startDate:saleProvider.selectedSaleStartDate,endDate:saleProvider.selectedSaleEndDate,serviceSelectedType:saleProvider.selectedServiceType);
                   },
            );
          }).toList();
        },
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Stack(
            alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              Icon(Icons.filter_list, color: Theme.of(context).colorScheme.primary),
              if(saleProvider.selectedServiceType != 'allServices')
                Positioned(
                  right: -5,
                  bottom: 13,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.circle, size: 13, color: Colors.white,),
                      Icon(Icons.circle, size: 10, color: Theme.of(context).primaryColor,),
                    ],
                  ),
                )
            ],
          ),
        ),
      );
    });
  }
}
