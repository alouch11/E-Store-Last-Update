import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/not_loggedin_widget.dart';
import 'package:flutter_spareparts_store/basewidget/paginated_list_view.dart';
import 'package:flutter_spareparts_store/features/order/widget/order_shimmer.dart';
import 'package:flutter_spareparts_store/features/order/widget/order_type_button.dart';
import 'package:flutter_spareparts_store/features/order/widget/order_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/basewidget/order_filter_dialog.dart';
import 'dart:convert';

class LOrderScreen extends StatefulWidget {
  final bool isBacButtonExist;
  const LOrderScreen({super.key, this.isBacButtonExist = true});

  @override
  State<LOrderScreen> createState() => _LOrderScreenState();
}

class _LOrderScreenState extends State<LOrderScreen> {
  ScrollController scrollController  = ScrollController();
   bool isGuestMode = !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();
   bool isToggled = false;
  @override
  void initState() {
    if(!isGuestMode){
      Provider.of<OrderProvider>(context, listen: false).setIndex(4, notify: false);
      setState(() {
        Provider.of<OrderProvider>(context, listen: false).selectedOrderSupplierList=[];
        Provider.of<OrderProvider>(context, listen: false).selectedOrderTypeList=[];
        Provider.of<OrderProvider>(context, listen: false).selectedOrderPersonList=[];
        Provider.of<OrderProvider>(context, listen: false).selectedOrderLineList=[];
        Provider.of<OrderProvider>(context, listen: false).selectedOrderMachineList=[];
        Provider.of<OrderProvider>(context, listen: false).selectedOrderStartDate="2000-01-01";
        Provider.of<OrderProvider>(context, listen: false).selectedOrderEndDate="2200-01-01";
      });
      Provider.of<OrderProvider>(context, listen: false).getOrderList(1,'pending',2,startDate:Provider.of<OrderProvider>(context, listen: false).selectedOrderStartDate,endDate:Provider.of<OrderProvider>(context, listen: false).selectedOrderEndDate);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: CustomAppBar(title: getTranslated('lorder', context), isBackButtonExist: widget.isBacButtonExist),
      body: isGuestMode ? const NotLoggedInWidget() :

      Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          int countLPending=  orderProvider.orderModel?.totalLPending??0;
          int countLSigned=  orderProvider.orderModel?.totalLSigned??0;
          int countLApproved=  orderProvider.orderModel?.totalLApproved??0;
          int countLDelivered=  orderProvider.orderModel?.totalLDelivered??0;
          int countLPartiallyDelivered=  orderProvider.orderModel?.totalLPartiallyDelivered??0;
          int countLCanceled=  orderProvider.orderModel?.totalLCanceled??0;
          //List<Orders>? orderList=  orderProvider.orderModel?.orders;

          String? selectedOrderSuppliers = orderProvider.selectedOrderSupplierList.isNotEmpty ? jsonEncode(orderProvider.selectedOrderSupplierList) :null;
          String? selectedOrderTypes =  orderProvider.selectedOrderTypeList.isNotEmpty ? jsonEncode( orderProvider.selectedOrderTypeList)  :null;
          String? selectedOrderPersons = orderProvider.selectedOrderPersonList.isNotEmpty ? jsonEncode(orderProvider.selectedOrderPersonList) :null;
          String? selectedOrderLines = orderProvider.selectedOrderLineList.isNotEmpty ? jsonEncode(orderProvider.selectedOrderLineList)  :null;
          String? selectedOrderMachines = orderProvider.selectedOrderMachineList.isNotEmpty ? jsonEncode(orderProvider.selectedOrderMachineList)  :null;
          String? selectedOrderStartDate = orderProvider.selectedOrderStartDate!="2000-01-01" ? orderProvider.selectedOrderStartDate : "2000-01-01";
          String? selectedOrderEndDate = orderProvider.selectedOrderEndDate!="2200-01-01" ? orderProvider.selectedOrderEndDate : "2200-01-01";

          return Column(children: [

            Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(children: [
                const Expanded(child:  SizedBox(width: 10,height: 24),),

                Text('${getTranslated('filter_list', context)}',style: robotoBold,),
                const SizedBox(width: 10,height: 24),

                InkWell(onTap: () =>
                    showModalBottomSheet(context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        builder: (c) =>  const OrderFilterDialog(orderType: 'lorder')

                    ),
                    child: Stack(clipBehavior: Clip.none, children: [
                      //child:
                      Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,
                          horizontal: Dimensions.paddingSizeExtraSmall),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Theme.of(context).hintColor.withOpacity(.25))),
                        child: SizedBox(width: 25,height: 24, child: Image.asset(Images.dropdown,
                            color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.white:Theme.of(context).primaryColor)
                        ),
                      ),

                        if (orderProvider.selectedOrderSupplierList.isNotEmpty || orderProvider.selectedOrderTypeList.isNotEmpty || orderProvider.selectedOrderPersonList.isNotEmpty || orderProvider.selectedOrderLineList.isNotEmpty || orderProvider.selectedOrderMachineList.isNotEmpty || orderProvider.selectedOrderStartDate!="2000-01-01" || orderProvider.selectedOrderEndDate!="2200-01-01")
                        Positioned(top: 0,right: 0,
                            child: Align(alignment: Alignment.topRight,
                              child: Center(
                                child: Container( decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                                    color: Theme.of(context).primaryColor
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
                    OrderTypeButton(text: getTranslated('LOCAL_PENDING', context), index: 4,count:countLPending),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('LOCAL_SIGNED', context), index: 11,count:countLSigned),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('LOCAL_APPROVED', context), index: 5,count:countLApproved),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('LOCAL_PARTIALLY_DELIVERED', context), index: 9,count:countLPartiallyDelivered),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('LOCAL_DELIVERED', context), index: 6,count:countLDelivered),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('LOCAL_CANCELED', context), index: 7,count:countLCanceled),
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

              Expanded(child: orderProvider.orderModel != null ? (orderProvider.orderModel!.orders != null && orderProvider.orderModel!.orders!.isNotEmpty)?
                SingleChildScrollView(
                  controller: scrollController,
                  child: PaginatedListView(scrollController: scrollController,
                    onPaginate: (int? offset) async{

                      await Provider.of<OrderProvider>(context, listen: false).getOrderList(offset!, orderProvider.selectedType, 2,
                          types:selectedOrderTypes,
                          suppliers: selectedOrderSuppliers,
                          persons:selectedOrderPersons,
                          lines:  selectedOrderLines,
                          machines: selectedOrderMachines,
                          startDate: selectedOrderStartDate,
                          endDate: selectedOrderEndDate
                      );

                    },
                    totalSize: orderProvider.orderModel?.totalSize,
                    offset: orderProvider.orderModel?.offset != null ? int.parse(orderProvider.orderModel!.offset!):1,
                    itemView: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orderProvider.orderModel?.orders!.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) => OrderWidget(orderModel: orderProvider.orderModel?.orders![index],index: index+1),
                    ),

                  ),
                ) : const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noOrder, message: 'no_order_found',) : const OrderShimmer()
              )

            ],
          );
        }
      ),
    );
  }
}




