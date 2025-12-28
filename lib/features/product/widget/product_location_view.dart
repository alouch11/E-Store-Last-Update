

import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/product/domain/model/product_details_model.dart'as pd;
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/images.dart';
import '../domain/model/product_details_model.dart';



class ProductLocationView extends StatelessWidget {
  final pd.ProductDetailsModel? productModel;
  const ProductLocationView({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {

    List<StockLocations>? list = productModel!.stocklocations;


     return Card(
        child: ExpansionTile(
            initiallyExpanded: true,
            shape:const RoundedRectangleBorder(),
            title:
            Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
              SizedBox(width: Dimensions.iconSizeDefault,
                  child: Image.asset(Images.warehouse, color: Theme.of(context).primaryColor,)),
              const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
              Text('${getTranslated('warehouse_Location', context)}', maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
            ]),

            children: [
              Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //const Text('Warehouse-Location-Stock'),
              Padding(
                padding: const EdgeInsets.only(left: 5.0,right: 5.0,bottom: 10),
                child: Table(
                    border: TableBorder.all(),
                    columnWidths: const {
                      0: FractionColumnWidth(0.30),
                      1: FractionColumnWidth(0.40),
                      2: FractionColumnWidth(0.30)
                    },
                    children: [
                      TableRow(children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(0),
                          child: Text('${getTranslated('warehouse', context)}'),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(0),
                          child:  Text('${getTranslated('locations', context)}'),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(0),
                          child: Text('${getTranslated('qty', context)}'),
                        ),
                      ]),
                      //for (var item in list)
                      for (int index = 0; index < productModel!.stocklocations!.length; index++)
                        TableRow(children: [
                          Container(
                              alignment: Alignment.center,
                            margin: const EdgeInsets.all(0),
                              //child: Text('${list![index].warehouse}'),
                              child:  Text('${list![index].warehouse}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.getGreen(context)))

                          ),
                          Container(
                              alignment: Alignment.center,
                            margin: const EdgeInsets.all(0),
                            //child: Text('${list![index].location}'),
                              child:  Text('${list[index].location}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.getYellow(context)))
                          ),
                          Container(
                              alignment: Alignment.center,
                            margin: const EdgeInsets.all(0),
                            //child: Text('${list![index].qty}'),
                              child:  Text('${list[index].qty}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color:const Color(0xFF0000FF)))
                          ),
                        ])
                    ]
                ),
              )
              ,const SizedBox(width: Dimensions.paddingSizeDefault),
            ])
              ,const SizedBox(width: Dimensions.paddingSizeDefault),


            ]
        )
     );
  }


}






