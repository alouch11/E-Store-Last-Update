import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/product/domain/model/product_details_model.dart'as pd;
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/images.dart';
import '../domain/model/product_details_model.dart';


class ProductSerialView extends StatelessWidget {
  final pd.ProductDetailsModel? productModel;
  const ProductSerialView({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {

    List<StockSerials>? list = productModel?.stockSerials;


     return Card(
        child: ExpansionTile(
            initiallyExpanded: true,
            shape:const RoundedRectangleBorder(),
            title:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(width: Dimensions.iconSizeDefault,
                  child: Image.asset(Images.serialnumber, color: Theme.of(context).primaryColor,)),
              const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
              Text('${getTranslated('serial_lot', context)}', maxLines: 1,
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
/*                  0: FixedColumnWidth(100.0),
                    1: FixedColumnWidth(150.0),
                    2: FixedColumnWidth(150.0)*/
                    0: FractionColumnWidth(0.40),
                    1: FractionColumnWidth(0.40),
                    2: FractionColumnWidth(0.20)
                  },
                  children: [
                    TableRow(children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(1),
                        child: Text('${getTranslated('serial_number', context)}'),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(1),
                        child:  Text('${getTranslated('expiration_date', context)}'),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(1),
                        child: Text('${getTranslated('qty', context)}'),
                      ),
                    ]),
                    //for (var item in list)
                    for (int index = 0; index < productModel!.stockSerials!.length; index++)
                      TableRow(children: [
                        Container(
                            color: MaterialStateColor.resolveWith((states){
                              if (list![index].remainingdays!<0)
                              {return ColorResources.red;}
                              else
                              if (list[index].remainingdays!>0 && list[index].remainingdays!<30)
                              {return ColorResources.getYellow(context);}
                              else
                              if (list[index].remainingdays!>31)
                              {return ColorResources.green;}
                              else
                              {return ColorResources.white;}
                            }),
                            alignment: Alignment.center,
                          margin: const EdgeInsets.all(0),
                            //child:  Text('${list![index].serialnumber}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.getGreen(context)))
                            child:  Text('${list![index].serialnumber}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault))
                        ),
                        Container(
                            color: MaterialStateColor.resolveWith((states){
                              if (list[index].remainingdays!<0)
                              {return ColorResources.red;}
                              else
                              if (list[index].remainingdays!>0 && list[index].remainingdays!<30)
                              {return ColorResources.getYellow(context);}
                              else
                              if (list[index].remainingdays!>31)
                              {return ColorResources.green;}
                              else
                              {return ColorResources.white;}
                            }),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(0),
                            //child:  Text('${list[index].expirationdate}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.getYellow(context)))
                             child:  Text('${list[index].expirationdate}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault))
                        ),
                        Container(
                            color: MaterialStateColor.resolveWith((states){
                              if (list[index].remainingdays!<0)
                              {return ColorResources.red;}
                              else
                              if (list[index].remainingdays!>0 && list[index].remainingdays!<30)
                              {return ColorResources.getYellow(context);}
                              else
                              if (list[index].remainingdays!>31)
                              {return ColorResources.green;}
                              else
                              {return ColorResources.white;}
                            }),
                            alignment: Alignment.center,
                          margin: const EdgeInsets.all(0),
                            //child:  Text('${list[index].qty}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color:const Color(0xFF0000FF)))
                            child:  Text('${list[index].qty}' ,style: titleRegular.copyWith(fontSize: Dimensions.fontSizeDefault))
                        ),
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






