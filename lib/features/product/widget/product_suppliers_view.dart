import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/product/domain/model/product_details_model.dart'as pd;
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:provider/provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/images.dart';
import '../domain/model/product_details_model.dart' ;


class ProductSupplierView extends StatelessWidget {
  final pd.ProductDetailsModel? productModel;
  const ProductSupplierView({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {

    List<StockSuppliers>? list = productModel?.stockSuppliers;


     return Card(
        child: ExpansionTile(
            initiallyExpanded: true,
            shape:const RoundedRectangleBorder(),
            title:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(width: Dimensions.iconSizeLarge,
                  child: Image.asset(Images.supplier, color: Theme.of(context).primaryColor,)),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
              Text('${getTranslated('suppliers', context)}', maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
            ]),
            children: [
              // Row(
              Column(


            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5.0,bottom: 10),
                  child: Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FractionColumnWidth(0.20),
                    1: FractionColumnWidth(0.40),
                    2: FractionColumnWidth(0.40)
                  },
                  children: [
                    TableRow(children: [
                       Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(1),
                        child: Text('${getTranslated('logo', context)}'),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(1),
                        child: Text('${getTranslated('supplier', context)}'),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(1),
                        child:  Text('${getTranslated('supplier_code', context)}'),
                      ),
                     /* Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(1),
                        child: Text('${getTranslated('qty', context)}'),
                      ),*/
                    ]),
                    //for (var item in list)
                    for (int index = 0; index < productModel!.stockSuppliers!.length; index++)
                      TableRow(children: [
                        Container(height: 50,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(5),
                            child:  FadeInImage.assetNetwork(
                                placeholder: Images.placeholder, width: 40,
                                height: 40, fit: BoxFit.cover,
                                image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.brandImageUrl}/${list![index].supplier}.webp',
                                imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                                    width: 40, height: 40, fit: BoxFit.cover),
                              )
                        ),
                        Container(height: 50,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 10,left: 3,bottom: 3),
                            child:  Text('${list[index].supplier}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.getGreen(context)))

                        ),
                        Container(height: 50,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 10),
                            child:  Text('${list[index].supplierCode}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.getYellow(context)))
                        ),
                        /*Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(0),
                            //child: Text('${list![index].qty}'),
                            child:  Text('${list[index].supplierCode}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color:const Color(0xFF0000FF)))
                        ),*/
                      ])
                  ]
              ))
              ,const SizedBox(width: Dimensions.paddingSizeDefault),
            ])
              ,const SizedBox(width: Dimensions.paddingSizeDefault),
            ]
        )
     );
  }


}






