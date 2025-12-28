import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../main.dart';


class SaleFilterDialog1 extends StatefulWidget {
final bool isToggled;
final int productId;

  const SaleFilterDialog1({super.key, this.isToggled=false, required this.productId});

  @override
  SaleFilterDialog1State createState() => SaleFilterDialog1State();
}

class SaleFilterDialog1State extends State<SaleFilterDialog1> {



  final _serviceTypes = Provider.of<SplashProvider>(Get.context!, listen: false).serviceTypeFilter!.split(',').map((orderType) => MultiSelectItem<String>(orderType, orderType)).toList();
  final _servicePersons =  Provider.of<SplashProvider>(Get.context!, listen: false).servicePersonFilter!.split(',').map((supplier) => MultiSelectItem<String>(supplier, supplier)).toList();
  final _serviceLines = Provider.of<SplashProvider>(Get.context!, listen: false).serviceLinesFilter!.split(',').map((line) => MultiSelectItem<String>(line, line)).toList();
  final _serviceMachines =  Provider.of<SplashProvider>(Get.context!, listen: false).serviceMachineFilter!.split(',').map((machine) => MultiSelectItem<String>(machine, machine)).toList();

final TextEditingController _startDateController= TextEditingController();
final TextEditingController _endDateController= TextEditingController();

  @override
  void initState() {
    _startDateController.text=Provider.of<SaleProvider>(Get.context!, listen: false).selectedSaleStartDate!= "2000-01-01" ?
    Provider.of<SaleProvider>(Get.context!, listen: false).selectedSaleStartDate: 'From';
    _endDateController.text=Provider.of<SaleProvider>(Get.context!, listen: false).selectedSaleEndDate!= "2200-01-01" ?
    Provider.of<SaleProvider>(Get.context!, listen: false).selectedSaleEndDate: 'To';

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Dismissible(
        key: const Key('key'),
        direction: DismissDirection.down,
        onDismissed: (_) => Navigator.pop(context),
        child:
        Consumer<SaleProvider>(
            builder: (context, saleProvider,_) {
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
                                        saleProvider.selectedSaleSupplierList=[];
                                        saleProvider.selectedSaleTypeList=[];
                                        saleProvider.selectedSalePersonList=[];
                                        saleProvider.selectedSaleLineList=[];
                                        saleProvider.selectedSaleMachineList=[];
                                        saleProvider.selectedSaleStartDate="2000-01-01";
                                        saleProvider.selectedSaleEndDate="2200-01-01";
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
                      const SizedBox(
                        height: 20,
                      ),

                      MultiSelectBottomSheetField(
                        initialChildSize: 0.7,
                        maxChildSize: 0.7,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Theme.of(context).primaryColor.withOpacity(1))),
                        listType: MultiSelectListType.CHIP,
                        searchable: true,
                        buttonText: const Text("Lines"),
                        title: const Text("Select line"),
                        initialValue: saleProvider.selectedSaleLineList,
                        //items: _linesmachineslist,
                        items: _serviceLines,
                        onConfirm: (values) {
                          saleProvider.selectedSaleLineList = values;
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (value) {
                            setState(() {
                              saleProvider.selectedSaleLineList.remove(value);
                            });
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),


                      MultiSelectBottomSheetField(
                        initialChildSize: 0.7,
                        maxChildSize: 0.7,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Theme.of(context).primaryColor.withOpacity(1))),
                        listType: MultiSelectListType.CHIP,
                        searchable: true,
                        buttonText: const Text(" Machines"),
                        title: const Text("Select machine"),
                        // items: _machines.map((machine)=>MultiSelectItem<String>(machine,machine)).toList(),
                        items: _serviceMachines,
                        initialValue: saleProvider.selectedSaleMachineList,
                        onConfirm: (values) {
                          saleProvider.selectedSaleMachineList = values;
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (value) {
                            setState(() {
                              saleProvider.selectedSaleMachineList.remove(value);
                            });
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      MultiSelectBottomSheetField(
                        initialChildSize: 0.7,
                        maxChildSize: 0.7,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Theme.of(context).primaryColor.withOpacity(1))),
                        listType: MultiSelectListType.CHIP,
                        searchable: true,
                        buttonText: const Text("Types"),
                        title: const Text("Select Types"),
                        initialValue: saleProvider.selectedSaleTypeList,
                        items: _serviceTypes,
                        onConfirm: (values) {
                          saleProvider.selectedSaleTypeList = values;
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (value) {
                            setState(() {
                              saleProvider.selectedSaleTypeList.remove(value);
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),


                      MultiSelectBottomSheetField(
                        initialChildSize: 0.7,
                        maxChildSize: 0.7,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Theme.of(context).primaryColor.withOpacity(1))),
                        listType: MultiSelectListType.CHIP,
                        searchable: true,
                        buttonText: const Text("Persons"),
                        title: const Text("Select Persons"),
                        initialValue: saleProvider.selectedSalePersonList,
                        items: _servicePersons,
                        onConfirm: (values) {
                          saleProvider.selectedSalePersonList = values;
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (value) {
                            setState(() {
                              saleProvider.selectedSalePersonList.remove(value);
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
                            //textInputAction: TextInputAction.done,
                            textAlign: TextAlign.left,
                            // / style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
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
                                saleProvider.selectedSaleStartDate = getFormattedDateSimple(startDateTime.millisecondsSinceEpoch);
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
                            //keyboardType: TextInputType.number,
                            //textInputAction: TextInputAction.done,
                            textAlign: TextAlign.left,
                            // style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
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
                                saleProvider.selectedSaleEndDate = getFormattedDateSimple(startDateTime.millisecondsSinceEpoch);
                              });
                            },
                          ),

                        ),
                      ]),


                      const SizedBox(
                        height: 20,
                      ),


                      Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: CustomButton(
                              buttonText: getTranslated('apply', context),
                              onTap: () {
                                String? selectedSaleTypes =  saleProvider.selectedSaleTypeList.isNotEmpty ? jsonEncode( saleProvider.selectedSaleTypeList) : null;
                                String? selectedSalePersons = saleProvider.selectedSalePersonList.isNotEmpty ? jsonEncode(saleProvider.selectedSalePersonList) : null;
                                String? selectedSaleLines = saleProvider.selectedSaleLineList.isNotEmpty ? jsonEncode(saleProvider.selectedSaleLineList): null;
                                String? selectedSaleMachines = saleProvider.selectedSaleMachineList.isNotEmpty ? jsonEncode(saleProvider.selectedSaleMachineList) : null;
                                String? selectedSaleStartDate = saleProvider.selectedSaleStartDate.isNotEmpty ? saleProvider.selectedSaleStartDate : "2000-01-01";
                                String? selectedSaleEndDate = saleProvider.selectedSaleEndDate.isNotEmpty ? saleProvider.selectedSaleEndDate : "2200-01-01";

                               String? selectedType = saleProvider.selectedTypeByProduct;


                                  if(saleProvider.selectedSaleStartDate.isEmpty && saleProvider.selectedSaleEndDate.isEmpty || ( DateTime.parse(saleProvider.selectedSaleEndDate).compareTo(DateTime.parse(saleProvider.selectedSaleStartDate)) >= 0 && saleProvider.selectedSaleStartDate.isNotEmpty && saleProvider.selectedSaleEndDate.isNotEmpty)){
                                  saleProvider.getSaleListByProduct(
                                      1, selectedType,
                                      widget.productId.toString(),
                                      saleProvider.selectedSearchType,
                                      saleType: selectedSaleTypes,
                                      persons: selectedSalePersons,
                                      lines: selectedSaleLines,
                                      machines: selectedSaleMachines,
                                      startDate:selectedSaleStartDate,
                                      endDate:selectedSaleEndDate
                                  );
                                  Navigator.pop(context);
                                   }

                                if(DateTime.parse(saleProvider.selectedSaleEndDate).compareTo(DateTime.parse(saleProvider.selectedSaleStartDate)) < 0){
                                  showCustomSnackBar(getTranslated('end_date_great_than_start_date', Get.context!), Get.context!);
                                }


                              }
                          ))


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
