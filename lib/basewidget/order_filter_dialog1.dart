import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../main.dart';


class OrderFilterDialog1 extends StatefulWidget {
  final String? orderType ;
  final int productId;
  const OrderFilterDialog1({super.key,required this.orderType, required this.productId});

  @override
  OrderFilterDialog1State createState() => OrderFilterDialog1State();
}

class OrderFilterDialog1State extends State<OrderFilterDialog1> {



  final _orderSuppliers =  Provider.of<SplashProvider>(Get.context!, listen: false).orderSupplierFilter!.split(',').map((orderSupplier) => MultiSelectItem<String>(orderSupplier, orderSupplier)).toList();
  final _orderTypes = Provider.of<SplashProvider>(Get.context!, listen: false).orderTypeFilter!.split(',').map((orderType) => MultiSelectItem<String>(orderType, orderType)).toList();
  final _orderPersons =  Provider.of<SplashProvider>(Get.context!, listen: false).orderPersonFilter!.split(',').map((supplier) => MultiSelectItem<String>(supplier, supplier)).toList();
  final _orderLines = Provider.of<SplashProvider>(Get.context!, listen: false).orderLinesFilter!.split(',').map((orderType) => MultiSelectItem<String>(orderType, orderType)).toList();
  final _orderMachines =  Provider.of<SplashProvider>(Get.context!, listen: false).orderMachineFilter!.split(',').map((machine) => MultiSelectItem<String>(machine, machine)).toList();



  final TextEditingController _startDateController= TextEditingController();
  final TextEditingController _endDateController= TextEditingController();

  @override
  void initState() {
    _startDateController.text=Provider.of<OrderProvider>(Get.context!, listen: false).selectedOrderStartDate!= "2000-01-01" ?
    Provider.of<OrderProvider>(Get.context!, listen: false).selectedOrderStartDate: 'From';
   _endDateController.text=Provider.of<OrderProvider>(Get.context!, listen: false).selectedOrderEndDate!= "2200-01-01" ?
    Provider.of<OrderProvider>(Get.context!, listen: false).selectedOrderEndDate: 'To';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Dismissible(
        key: const Key('key'),
    direction: DismissDirection.down,
    onDismissed: (_) => Navigator.pop(context),
    child:
      Consumer<OrderProvider>(
        builder: (context, orderProvider,_) {
      return  SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(padding: const EdgeInsets.only(top: 50.0),
          child: Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(color: Theme
                .of(context)
                .highlightColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),

              InkWell(onTap: () => Navigator.of(context).pop(),
                  child: Padding(padding: const EdgeInsets.only(
                    bottom: Dimensions.paddingSizeDefault,),
                      child: Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 35,),
                            Container(width: 35,
                                height: 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.paddingSizeDefault),
                                    color: Theme
                                        .of(context)
                                        .hintColor
                                        .withOpacity(.5))),

                            Icon(Icons.clear, color: Theme
                                .of(context)
                                .hintColor)
                          ])))),

              Padding(padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeSmall),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 60),
                        Text(getTranslated('filter', context) ?? '',
                            style: titilliumSemiBold.copyWith(
                                fontSize: Dimensions.fontSizeLarge)),
                        InkWell(
                            onTap: () {
                              setState(() {
                                orderProvider.selectedOrderSupplierList=[];
                                orderProvider.selectedOrderTypeList=[];
                                orderProvider.selectedOrderPersonList=[];
                                orderProvider.selectedOrderLineList=[];
                                orderProvider.selectedOrderMachineList=[];
                                orderProvider.selectedOrderStartDate="2000-01-01";
                                orderProvider.selectedOrderEndDate="2200-01-01";
                                _startDateController.text="";
                                _endDateController.text="";
                              });
                            },
                            child: Padding(padding: const EdgeInsets.only(
                                right: Dimensions.paddingSizeExtraSmall),
                                child: Row(children: [
                                  SizedBox(width: 20,
                                      child: Image.asset(Images.reset)),
                                  Text('${getTranslated('reset', context)}',
                                      style: textRegular.copyWith(color: Theme
                                          .of(context)
                                          .primaryColor))
                                ])))
                      ])),

              MultiSelectBottomSheetField(
                initialChildSize: 0.4,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Theme.of(context).primaryColor.withOpacity(1))),
                listType: MultiSelectListType.CHIP,
                searchable: true,
                buttonText: const Text("Lines"),
                title: const Text("Select Order Lines"),
                initialValue: orderProvider.selectedOrderLineList,
                items: _orderLines,
                onConfirm: (values) {
                  orderProvider.selectedOrderLineList = values;
                },
                chipDisplay: MultiSelectChipDisplay(
                  onTap: (value) {
                    setState(() {
                      orderProvider.selectedOrderLineList.remove(value);
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              MultiSelectBottomSheetField(
                initialChildSize: 0.4,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Theme.of(context).primaryColor.withOpacity(1))),
                listType: MultiSelectListType.CHIP,
                searchable: true,
                buttonText: const Text("Machines"),
                title: const Text("Select Order Machines"),
                initialValue: orderProvider.selectedOrderMachineList,
                items: _orderMachines,
                onConfirm: (values) {
                  orderProvider.selectedOrderMachineList = values;
                },
                chipDisplay: MultiSelectChipDisplay(
                  onTap: (value) {
                    setState(() {
                      orderProvider.selectedOrderMachineList.remove(value);
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              MultiSelectBottomSheetField(
                  initialChildSize: 0.4,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Theme.of(context).primaryColor.withOpacity(1))),
                  listType: MultiSelectListType.CHIP,
                  searchable: true,

                  buttonText: const Text("Suppliers"),
                  title: const Text("Select Order Suppliers"),
                  initialValue: orderProvider.selectedOrderSupplierList,
                  items: _orderSuppliers,
                  onConfirm: (values) {
                    orderProvider.selectedOrderSupplierList = values;
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    onTap: (value) {
                      setState(() {
                        orderProvider.selectedOrderSupplierList.remove(value);
                      });
                    },
                  ),
                ),


              const SizedBox(
                height: 20,
              ),

              MultiSelectBottomSheetField(
                initialChildSize: 0.4,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Theme.of(context).primaryColor.withOpacity(1))),
                listType: MultiSelectListType.CHIP,
                searchable: true,
                buttonText: const Text("Types"),
                title: const Text("Select Order Types"),
                initialValue: orderProvider.selectedOrderTypeList,
                items: _orderTypes,
                onConfirm: (values) {
                  orderProvider.selectedOrderTypeList = values;
                },
                chipDisplay: MultiSelectChipDisplay(
                  onTap: (value) {
                    setState(() {
                      orderProvider.selectedOrderTypeList.remove(value);
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),


              MultiSelectBottomSheetField(
                initialChildSize: 0.4,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Theme.of(context).primaryColor.withOpacity(1))),
                listType: MultiSelectListType.CHIP,
                searchable: true,
                buttonText: const Text("Persons"),
                title: const Text("Select Order Persons"),
                initialValue: orderProvider.selectedOrderPersonList,
                items: _orderPersons,
                onConfirm: (values) {
                  orderProvider.selectedOrderPersonList = values;
                },
                chipDisplay: MultiSelectChipDisplay(
                  onTap: (value) {
                    setState(() {
                      orderProvider.selectedOrderPersonList.remove(value);
                    });
                  },
                ),
              ),


              const SizedBox(
                height: 20,
              ),


              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IntrinsicWidth(
                  stepWidth: 150,
                  child: TextField(
                    controller: _startDateController,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      labelText: "From",
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_today,color: Color(0xff0461A5),),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                      focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                    ),
                    readOnly:true,
                    onTap: () async {
                      final DateTime? startDateTime =
                      await showDatePicker(
                        context: context,
                        helpText: 'Select Start Date',
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2019),
                        lastDate: DateTime(2100),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme:  ColorScheme.light(
                                primary: Theme.of(context).colorScheme.primary,
                                onPrimary: Colors.white,
                                surface: Colors.white,
                                onSurface: Colors.black,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      setState(() {
                        if(startDateTime == null) return;
                        _startDateController.text=getFormattedDateSimple(startDateTime.millisecondsSinceEpoch);
                        orderProvider.selectedOrderStartDate = getFormattedDateSimple(startDateTime.millisecondsSinceEpoch);
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                IntrinsicWidth(
                  stepWidth: 150,
                  child: TextField(
                    controller: _endDateController,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      labelText: "To",
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_today,color: Color(0xff0461A5),),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                      focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                    ),
                    readOnly:true,
                    onTap: () async {
                      final DateTime? startDateTime =
                      await showDatePicker(
                        context: context,
                        helpText: 'Select End Date',
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2019),
                        lastDate: DateTime(2100),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme:  ColorScheme.light(
                                primary: Theme.of(context).colorScheme.primary,
                                onPrimary: Colors.white,
                                surface: Colors.white,
                                onSurface: Colors.black,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      setState(() {
                        if(startDateTime == null) return;
                        _endDateController.text=getFormattedDateSimple(startDateTime.millisecondsSinceEpoch);
                        orderProvider.selectedOrderEndDate = getFormattedDateSimple(startDateTime.millisecondsSinceEpoch);
                      });
                    },
                  ),

                ),
              ]),


              const SizedBox(
                height: 40,
              ),

              Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: CustomButton(
                    buttonText: getTranslated('apply', context),
                    onTap: () {
                        String selectedType = orderProvider.selectedType;
                        String? selectedOrderSuppliers = orderProvider.selectedOrderSupplierList.isNotEmpty ? jsonEncode(orderProvider.selectedOrderSupplierList) :null;
                        String? selectedOrderTypes =  orderProvider.selectedOrderTypeList.isNotEmpty ? jsonEncode( orderProvider.selectedOrderTypeList)  :null;
                        String? selectedOrderPersons = orderProvider.selectedOrderPersonList.isNotEmpty ? jsonEncode(orderProvider.selectedOrderPersonList) :null;
                        String? selectedOrderLines = orderProvider.selectedOrderLineList.isNotEmpty ? jsonEncode(orderProvider.selectedOrderLineList)  :null;
                        String? selectedOrderMachines = orderProvider.selectedOrderMachineList.isNotEmpty ? jsonEncode(orderProvider.selectedOrderMachineList)  :null;
                        String? selectedOrderStartDate = orderProvider.selectedOrderStartDate.isNotEmpty ? orderProvider.selectedOrderStartDate : "2000-01-01";
                        String? selectedOrderEndDate = orderProvider.selectedOrderEndDate.isNotEmpty ? orderProvider.selectedOrderEndDate : "2200-01-01";



          if(orderProvider.selectedOrderStartDate.isEmpty && orderProvider.selectedOrderEndDate.isEmpty || ( DateTime.parse(orderProvider.selectedOrderEndDate).compareTo(DateTime.parse(orderProvider.selectedOrderStartDate)) >= 0 /*&& orderProvider.selectedOrderStartDate.isNotEmpty && orderProvider.selectedOrderEndDate.isNotEmpty*/)) {
              orderProvider.getOrderListByProduct(1,
                  selectedType,
                  widget.productId.toString(),
                  types:selectedOrderTypes,
                  suppliers: selectedOrderSuppliers,
                  persons:selectedOrderPersons,
                  lines:  selectedOrderLines,
                  machines: selectedOrderMachines,
                  startDate: selectedOrderStartDate,
                  endDate: selectedOrderEndDate
            );

            Navigator.pop(context);

          }
                        if(DateTime.parse(orderProvider.selectedOrderEndDate).compareTo(DateTime.parse(orderProvider.selectedOrderStartDate)) < 0){
                          showCustomSnackBar(getTranslated('end_date_great_than_start_date', Get.context!), Get.context!);
                        }

                      }
                   // },
                  ))

              // ]));})

            ]),
          ),
        ),
      );
  //  );

  }));

  }

  static String getFormattedDateSimple(int date) {
    DateFormat newFormat = DateFormat("yyyy-MM-dd");
    //DateFormat newFormat = DateFormat("dd-MM-yyyy");
    return newFormat.format(DateTime.fromMillisecondsSinceEpoch(date));
  }


  String hoursBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day ,from.hour,from.minute);
    to = DateTime(to.year, to.month, to.day,to.hour,to.minute);
    Duration difference = to.difference(from);
    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    String totalDifference="$days days $hours hours $minutes minutes";
    return totalDifference;
  }

}
