
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/basewidget/custom_textfield.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/order/view/order_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class GuestTrackOrderScreen extends StatefulWidget {
  const GuestTrackOrderScreen({super.key});


  @override
  State<GuestTrackOrderScreen> createState() => _GuestTrackOrderScreenState();
}

class _GuestTrackOrderScreenState extends State<GuestTrackOrderScreen> {
  TextEditingController orderIdController = TextEditingController();
  //TextEditingController orderTypeController = TextEditingController();


  final singleDropDownKey = GlobalKey<DropdownSearchState>();
  final multipleDropDownKey = GlobalKey<DropdownSearchState>();

  final List<String>? _type=['Local PO','International PO'];
  String? selectedline;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: CustomAppBar(title: getTranslated('TRACK_ORDER', context)),
      body: Consumer<OrderProvider>(
        builder: (context, orderTrackingProvider, _) {
          return
            Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: ListView(children: [
             Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(getTranslated('Order_Type', context)! , style: robotoRegular.copyWith(
                            color: ColorResources.primaryColor, fontSize: Dimensions.fontSizeDefault)),
                        Text('*',style: robotoBold.copyWith(color: ColorResources.primaryColor,
                            fontSize: Dimensions.fontSizeDefault),),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only( top: 12,bottom: 12),
                        child: DropdownButton<String>(
                            elevation: 10,
                            menuMaxHeight: 250,
                            dropdownColor:ColorResources.homeBg,
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                            underline: Container(),
                            hint: const Text("Select Order Type", style: TextStyle(color: ColorResources.hintTextColor)),
                            icon:  Icon(Icons.keyboard_arrow_down,color: ColorResources.primaryColor),
                            style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor),
                            isDense: true,
                            isExpanded: true,
                            items: _type!.map((type){
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(maxLines: 1, type, style: const TextStyle(color: ColorResources.black)),
                              );
                            }).toList(),
                            //value: orderTypeController.text,
                            value: selectedline,
                            onChanged: (value){
                              setState(() {
                                //orderTypeController.text = value!;
                                selectedline = value;
                              });
                            }),
                      ),

                    ),
                  ],
                ),

             const SizedBox(height: Dimensions.paddingSizeDefault),


              /*
              CustomTextField(controller: orderIdController,
                prefixIcon: Images.orderIdIcon,
                isAmount: false,
                inputType: TextInputType.text,
                hintText: getTranslated('order_Number', context),
                labelText: getTranslated('order_Number', context),),*/





              TextFormField(
                controller: orderIdController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  hintText: "Order Number",
                  prefixIcon: SizedBox(width: orderIdController.text.isNotEmpty? 60: 57,
                      child:
                      Row(
                          children: [
                            InkWell(onTap: ()

                            async {
                              var res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SimpleBarcodeScannerPage(),
                                  ));
                              setState(()  {
                                if (res is String) {
                                  String orderNumber = res.toString();
                                  orderIdController.text= res.toString();
                                  orderNumber.contains('BK-LPO-') ? selectedline='Local PO' : selectedline='International PO';
                                  if(orderNumber.isEmpty){
                                    showCustomSnackBar('${getTranslated('order_number_is_required', context)}', context);
                                  }
                                  else{
                                    orderTrackingProvider.trackYourOrder(orderNo: orderNumber.toString()).then((value) {
                                      if (value.response != null && value.response!.statusCode == 200) {
                                        int? orderId = value.response!.data[0]['BLMASKODU'];
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderDetailsScreen(fromTrack: true,
                                            orderId: orderId)));
                                      }

                                    });

                                  }

                                }
                              });
                            },
                              child: Padding(padding: const EdgeInsets.all(2),
                                child: Container(width: 35, height: 35,
                                  decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                                      borderRadius: const BorderRadius.all( Radius.circular(Dimensions.paddingSizeSmall))),
                                  child: const Icon(Icons.qr_code_scanner_outlined ,color: Colors.white,size: 22),
                                ),
                              ),

                            ),

                            Text('|', style: textBold.copyWith(fontSize: 30,color: Theme.of(context).hintColor),),


                          ])),
                  suffixIcon: SizedBox(width: orderIdController.text.isNotEmpty? 70 : 50,
                    child:
                    Row(
                      children: [
                        if(orderIdController.text.isNotEmpty)
                          InkWell(onTap: (){
                            setState(() {
                              orderIdController.clear();
                            });
                          },
                              child: const Icon(Icons.clear, size: 20,)),
                        InkWell(
                          onTap: () async {
                            String orderNumber = orderIdController.text.trim();
                            String selectedtype =  '';
                            orderNumber.contains('BK-LPO-') ? selectedtype='Local PO' : selectedtype='International PO';
                            if(selectedtype.isEmpty){
                              showCustomSnackBar('${getTranslated('order_type_is_required', context)}', context);
                            }
                            if(orderNumber.isEmpty){
                              showCustomSnackBar('${getTranslated('service_number_is_required', context)}', context);
                            }
                            else{

                              orderNumber.contains('BK-LPO-') ? selectedtype='Local PO' : selectedtype='International PO';
                              Provider.of<OrderProvider>(context, listen: false)..trackYourOrder(orderNo: orderNumber.toString(), orderType: selectedtype).then((value) {
                                if (value.response != null && value.response!.statusCode == 200) {
                                  int? orderId = value.response!.data[0]['BLMASKODU'];
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderDetailsScreen(fromTrack: true,
                                      orderId: orderId, orderType: selectedtype)
                                  ));
                                }

                              });

                            }
                          },
                          child: Padding(padding: const EdgeInsets.all(5),
                            child: Container(width: 40, height: 40,decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all( Radius.circular(Dimensions.paddingSizeSmall))),
                                child: SizedBox(width : 18,height: 18, child: Padding(
                                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                  child: Image.asset(Images.search, color: Colors.white),
                                ))),
                          ),

                        ),
                      ],
                    ),

                  ),),
              ),





              const SizedBox(height: Dimensions.paddingSizeDefault),

              const SizedBox(height: Dimensions.paddingSizeExtraLarge),



              /*InkWell(onTap: () async {
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const SimpleBarcodeScannerPage(
                          appBarTitle: 'Scan Order Barcode',
                          isShowFlashIcon: true,
                          centerTitle: true,
                        ),

                    ));
                setState(()  async {
                  if (res is String) {
                    String saleNumber = res.toString();
                    if(saleNumber.isEmpty){
                      showCustomSnackBar('${getTranslated('service_number_is_required', context)}', context);
                    }
                    else{
                      await orderTrackingProvider.trackYourOrder(orderNo: orderNo.toString(), orderType: selectedline).then((value) {
                      if (value.response != null && value.response!.statusCode == 200) {
                        int? orderId = value.response!.data[0]['BLMASKODU'];
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderDetailsScreen(fromTrack: true,
                            orderId: orderId, orderType: selectedline)
                        ));
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

              )*/



              if (orderTrackingProvider.searching) const Center(child: CircularProgressIndicator()) else CustomButton(buttonText: '${getTranslated('search_order', context)}', onTap: () async {
                String orderNo = orderIdController.text.trim();
                String orderType = selectedline!;
                if(orderType.isEmpty){
                  showCustomSnackBar('${getTranslated('order_type_is_required', context)}', context);
                }
                if(orderNo.isEmpty){
                  showCustomSnackBar('${getTranslated('order_number_is_required', context)}', context);
                }

                else{
                  await orderTrackingProvider.trackYourOrder(orderNo: orderNo.toString(), orderType: selectedline).then((value) {
                    if (value.response != null && value.response!.statusCode == 200) {
                      int? orderId = value.response!.data[0]['BLMASKODU'];
                     Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderDetailsScreen(fromTrack: true,
                     orderId: orderId, orderType: selectedline)
                     ));
                    }

                  });

                }
              },),

            ],),
          );
        }
      )
    );
  }

}






