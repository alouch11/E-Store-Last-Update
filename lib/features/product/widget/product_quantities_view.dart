

import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/product/domain/model/product_details_model.dart'as pd;
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/images.dart';
import '../domain/model/product_details_model.dart';



class ProductQuantitiesView extends StatefulWidget {
  final pd.ProductDetailsModel? productModel;

  const ProductQuantitiesView({super.key, required this.productModel});
  @override
  State<ProductQuantitiesView> createState() => _ProductQuantitiesViewState();
}

class _ProductQuantitiesViewState extends State<ProductQuantitiesView> with SingleTickerProviderStateMixin {


  late AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

/*    AnimatedOpacity(
      opacity:2.0,
      duration: const Duration(seconds: 1),
      child: ColoredBox(color: ColorResources.red),
    ),
    AnimatedOpacity(
    opacity: 2.0,
    duration: const Duration(seconds: 1),
    child: ColoredBox(color: ColorResources.blue)),*/

     return  Card(
        child: ExpansionTile(
            initiallyExpanded: true,
            shape:const RoundedRectangleBorder(),
            title:
            Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
              SizedBox( width: Dimensions.iconSizeDefault,
                  child: Image.asset(Images.quantities, color: Theme.of(context).primaryColor,)),
              const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
              Text('${getTranslated('quantities', context)}', maxLines: 1,
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
                      0: FractionColumnWidth(0.25),
                      1: FractionColumnWidth(0.25),
                      2: FractionColumnWidth(0.25),
                      3: FractionColumnWidth(0.25)
                    },
                    children: [
                      TableRow(children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(0),
                          child: Text('${getTranslated('qty_remaining', context)}'),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(0),
                          child:  Text('${getTranslated('qty_ordered', context)}'),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(0),
                          child: Text('${getTranslated('qty_blocked1', context)}'),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(0),
                          child: Text('${getTranslated('qty_usable', context)}'),
                        ),
                      ]),
                      //for (var item in list)
                        TableRow(children: [
                          Container(
                              alignment: Alignment.center,
                            margin: const EdgeInsets.all(0),
                              child:  Text('${widget.productModel!.qtyRemaining}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color:const Color(0xFF0000FF) ))

                          ),
                          Container(
                              alignment: Alignment.center,
                            margin: const EdgeInsets.all(0),
                            //child: Text('${list![index].location}'),
                              child:  Text('${widget.productModel!.qtyOrdered}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.getYellow(context)))
                          ),
                          Container(
                              alignment: Alignment.center,
                            margin: const EdgeInsets.all(0),
                            //child: Text('${list![index].qty}'),
                              child:  Text('${widget.productModel!.qtyBlocked}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.red))
                          ),
                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(0),
                              //child: Text('${list![index].qty}'),
                              child:  Text('${widget.productModel!.qtyUsable}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color:ColorResources.getGreen(context)))
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






