
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/basewidget/custom_textfield.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../sale/provider/sale_provider.dart';
import '../sale/view/sale_details_screen.dart';

class GuestTrackServiceScreen extends StatefulWidget {
  const GuestTrackServiceScreen({super.key});


  @override
  State<GuestTrackServiceScreen> createState() => _GuestTrackServiceScreenState();
}

class _GuestTrackServiceScreenState extends State<GuestTrackServiceScreen> {
  TextEditingController saleIdController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: CustomAppBar(title: getTranslated('TRACK_SERVICE', context)),
      body: Consumer<SaleProvider>(
        builder: (context, saleTrackingProvider, _) {
          return
            Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: ListView(children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),

              /*CustomTextField(controller: saleIdController,
                prefixIcon: Images.serviceIcon,
                isAmount: false,
                inputType: TextInputType.text,
                hintText: getTranslated('service_number', context),
                labelText: getTranslated('service_number', context),),


              const SizedBox(height: Dimensions.paddingSizeDefault),

              if (saleTrackingProvider.searching) const Center(child: CircularProgressIndicator()) else
                CustomButton(buttonText: '${getTranslated('search_service', context)}', onTap: () async {
                String saleNumber = saleIdController.text.trim();
                if(saleNumber.isEmpty){
                  showCustomSnackBar('${getTranslated('service_number_is_required', context)}', context);
                }
                else{
                  await saleTrackingProvider.trackYourSale(saleNo: saleNumber.toString()).then((value) {
                    if (value.response != null && value.response!.statusCode == 200) {
                      int? saleId = value.response!.data[0]['BLMASKODU'];
                     Navigator.push(context, MaterialPageRoute(builder: (_)=> SaleDetailsScreen(fromTrack: true,
                     saleId: saleId)));
                    }

                  });

                }
              },),*/



              TextFormField(
                controller: saleIdController,
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
                  hintText: "Service Number",
                  prefixIcon: SizedBox(width: saleIdController.text.isNotEmpty? 60: 57,
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
                                  String saleNumber = res.toString();
                                  saleIdController.text= res.toString();
                                  if(saleNumber.isEmpty){
                                    showCustomSnackBar('${getTranslated('service_number_is_required', context)}', context);
                                  }
                                  else{
                                     saleTrackingProvider.trackYourSale(saleNo: saleNumber.toString()).then((value) {
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
                                child: Container(width: 35, height: 35,
                                  decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                                      borderRadius: const BorderRadius.all( Radius.circular(Dimensions.paddingSizeSmall))),
                                  child: const Icon(Icons.qr_code_scanner_outlined ,color: Colors.white,size: 22),
                                ),
                              ),

                            ),

                            Text('|', style: textBold.copyWith(fontSize: 30,color: Theme.of(context).hintColor),),


                          ])),
                  suffixIcon: SizedBox(width: saleIdController.text.isNotEmpty? 70 : 50,
                    child:
                    Row(
                      children: [
                        if(saleIdController.text.isNotEmpty)
                          InkWell(onTap: (){
                            setState(() {
                              saleIdController.clear();
                            });
                          },
                              child: const Icon(Icons.clear, size: 20,)),
                        InkWell(
                          onTap: () async {
                            String saleNumber = saleIdController.text.trim();
                            if(saleNumber.isEmpty){
                              showCustomSnackBar('${getTranslated('service_number_is_required', context)}', context);
                            }
                            else{
                              await saleTrackingProvider.trackYourSale(saleNo: saleNumber.toString()).then((value) {
                                if (value.response != null && value.response!.statusCode == 200) {
                                  int? saleId = value.response!.data[0]['BLMASKODU'];
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=> SaleDetailsScreen(fromTrack: true,
                                      saleId: saleId)));
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







            ],),
          );


         /* SizedBox(height: 56,
            child: TextFormField(
              controller: searchController,
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
                hintText: "Search Asset",
                prefixIcon: SizedBox(width: searchController.text.isNotEmpty? 60: 57,
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
                            setState(() {
                              if (res is String) {
                                searchController.text= res.toString();
                                Provider.of<MachinesProvider>(context, listen: false).searchAsset(assetCode:searchController.text).then((value) {
                                  if (value.response != null  && value.response!.statusCode == 200 && value.response!.data.isNotEmpty) {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MachineScreenExtra(machineModel:Provider.of<MachinesProvider>(context, listen: false).machinesSearch)));
                                  }
                                  else
                                    showCustomSnackBar('No Asset Found', context);
                                });

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
                suffixIcon: SizedBox(width: searchController.text.isNotEmpty? 70 : 50,
                  child:
                  Row(
                    children: [
                      if(searchController.text.isNotEmpty)
                        InkWell(onTap: (){
                          setState(() {
                            searchController.clear();
                          });
                        },
                            child: const Icon(Icons.clear, size: 20,)),
                      InkWell(
                        onTap: () async {
                          if(searchController.text.trim().isEmpty) {
                            showCustomSnackBar(getTranslated('enter_asset_code', context), context);
                          }
                          else{
                            await Provider.of<MachinesProvider>(context, listen: false).searchAsset(assetCode:searchController.text).then((value) {
                              if (value.response != null  && value.response!.statusCode == 200 && value.response!.data.isNotEmpty) {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MachineScreenExtra(machineModel:Provider.of<MachinesProvider>(context, listen: false).machinesSearch)));
                              }
                              else
                                showCustomSnackBar('No Asset Found', context);
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
          );*/






        }
      )
    );
  }

}






