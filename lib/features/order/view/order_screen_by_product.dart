import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/order_filter_dialog1.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/paginated_list_view.dart';
import 'package:flutter_spareparts_store/features/order/widget/order_shimmer.dart';
import 'package:flutter_spareparts_store/features/order/widget/order_widget.dart';
import 'package:provider/provider.dart';

import '../widget/order_type_by_product_button.dart';



class OrderScreenByProduct extends StatefulWidget {
  final int? productId;
  const OrderScreenByProduct({super.key, required this.productId});

  @override
  State<OrderScreenByProduct> createState() => _OrderScreenByProductState();
}

class _OrderScreenByProductState extends State<OrderScreenByProduct> {
  ScrollController scrollController  = ScrollController();
   bool isGuestMode = !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();
  @override
  void initState() {
    if(!isGuestMode){
      Provider.of<OrderProvider>(context, listen: false).setIndexByProduct(0,widget.productId.toString(), notify: false);
      setState(() {
        Provider.of<OrderProvider>(context, listen: false).selectedOrderSupplierList=[];
        Provider.of<OrderProvider>(context, listen: false).selectedOrderTypeList=[];
        Provider.of<OrderProvider>(context, listen: false).selectedOrderPersonList=[];
        Provider.of<OrderProvider>(context, listen: false).selectedOrderLineList=[];
        Provider.of<OrderProvider>(context, listen: false).selectedOrderMachineList=[];
        Provider.of<OrderProvider>(context, listen: false).selectedOrderStartDate="2000-01-01";
        Provider.of<OrderProvider>(context, listen: false).selectedOrderEndDate="2200-01-01";
      });
      Provider.of<OrderProvider>(context, listen: false).getOrderListByProduct(1,'pending',widget.productId.toString(),startDate:Provider.of<OrderProvider>(context, listen: false).selectedOrderStartDate,endDate:Provider.of<OrderProvider>(context, listen: false).selectedOrderEndDate);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

        return Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          int countPending=  orderProvider.orderModelByProduct?.totalPending??0;
          int countSigned=  orderProvider.orderModelByProduct?.totalSigned??0;
          int countApproved=  orderProvider.orderModelByProduct?.totalApproved??0;
          int countDelivered=  orderProvider.orderModelByProduct?.totalDelivered??0;
          int countPartiallyDelivered=  orderProvider.orderModelByProduct?.totalPartiallyDelivered??0;
          int countCanceled=  orderProvider.orderModelByProduct?.totalCanceled??0;

          String? selectedOrderSuppliers = orderProvider.selectedOrderSupplierList.isNotEmpty ? jsonEncode(orderProvider.selectedOrderSupplierList) :null;
          String? selectedOrderTypes =  orderProvider.selectedOrderTypeList.isNotEmpty ? jsonEncode( orderProvider.selectedOrderTypeList)  :null;
          String? selectedOrderPersons = orderProvider.selectedOrderPersonList.isNotEmpty ? jsonEncode(orderProvider.selectedOrderPersonList) :null;
          String? selectedOrderLines = orderProvider.selectedOrderLineList.isNotEmpty ? jsonEncode(orderProvider.selectedOrderLineList)  :null;
          String? selectedOrderMachines = orderProvider.selectedOrderMachineList.isNotEmpty ? jsonEncode(orderProvider.selectedOrderMachineList)  :null;
          String? selectedOrderStartDate = orderProvider.selectedOrderStartDate!="2000-01-01" ? orderProvider.selectedOrderStartDate : "2000-01-01";
          String? selectedOrderEndDate = orderProvider.selectedOrderEndDate!="2200-01-01" ? orderProvider.selectedOrderEndDate : "2200-01-01";

          return Column(children: [
            const SizedBox(height: Dimensions.paddingSizeSmall),
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
                        builder: (c) =>  OrderFilterDialog1(orderType: 'order', productId:widget.productId!)

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
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    OrderTypeByProductButton(text: getTranslated('PENDING', context), index: 0,productId:widget.productId.toString(),count:countPending),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeByProductButton(text: getTranslated('SIGNED', context), index: 10,productId:widget.productId.toString(),count:countSigned),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeByProductButton(text: getTranslated('APPROVED', context), index: 1,productId:widget.productId.toString(),count:countApproved),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeByProductButton(text: getTranslated('PARTIALLY_DELIVERED', context), index: 8,productId:widget.productId.toString(),count:countPartiallyDelivered),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeByProductButton(text: getTranslated('DELIVERED', context), index: 2,productId:widget.productId.toString(),count:countDelivered),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeByProductButton(text: getTranslated('CANCELED', context), index: 3,productId:widget.productId.toString(),count:countCanceled),
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


              Expanded(child: orderProvider.orderModelByProduct != null ? (orderProvider.orderModelByProduct!.orders != null && orderProvider.orderModelByProduct!.orders!.isNotEmpty)?
                SingleChildScrollView(
                  controller: scrollController,
                  child: PaginatedListView(scrollController: scrollController,
                    onPaginate: (int? offset) async{
                      await Provider.of<OrderProvider>(context, listen: false).getOrderListByProduct(offset!, orderProvider.selectedTypeByProduct,widget.productId.toString(),
                          types:selectedOrderTypes,
                          suppliers: selectedOrderSuppliers,
                          persons:selectedOrderPersons,
                          lines:  selectedOrderLines,
                          machines: selectedOrderMachines,
                          startDate: selectedOrderStartDate,
                          endDate: selectedOrderEndDate
                      );
                    /*  countPending=  orderProvider.orderModelByProduct?.totalPending??0;
                      countApproved=  orderProvider.orderModelByProduct?.totalApproved??0;
                      countDelivered=  orderProvider.orderModelByProduct?.totalDelivered??0;
                      countCanceled=  orderProvider.orderModelByProduct?.totalCanceled??0;*/
                    },
                    totalSize: orderProvider.orderModelByProduct?.totalSize,
                    offset: orderProvider.orderModelByProduct?.offset != null ? int.parse(orderProvider.orderModelByProduct!.offset!):1,
                    itemView: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orderProvider.orderModelByProduct?.orders!.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) => OrderWidget(orderModel: orderProvider.orderModelByProduct?.orders![index],index: index+1),
                    ),

                  ),
                ) : const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noOrder, message: 'no_order_found',) : const OrderShimmer()
              )

            ],
          );
        }
    //  ),
    );
  }
}




