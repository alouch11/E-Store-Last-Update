
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_screen_extra.dart';
import 'package:flutter_spareparts_store/features/product/provider/search_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class SearchAssetWidget extends StatefulWidget {
  const SearchAssetWidget({super.key});


  @override
  State<SearchAssetWidget> createState() => SearchAssetWidgetState();
}

class SearchAssetWidgetState extends State<SearchAssetWidget> {
  TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Consumer<SearchProvider>(
        builder: (context, searchProvider, _) {
      return
           SizedBox(height: 56,
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
            );

        }
      )
    );
  }

}






