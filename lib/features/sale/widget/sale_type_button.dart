import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:provider/provider.dart';

import '../provider/sale_provider.dart';

class SaleTypeButton extends StatelessWidget {
  final String? text;
  final int index;
  final int count;

  const SaleTypeButton({super.key, required this.text, required this.index ,required this.count});

  @override
  Widget build(BuildContext context) {
    return
      //Expanded(
        SizedBox(
      child: TextButton(
        onPressed: () => Provider.of<SaleProvider>(context, listen: false).setIndex(index),
/*        onPressed: () {
          Provider.of<SaleProvider>(context, listen: false).setIndex(index);
          Provider.of<SaleProvider>(context, listen: false).selectedSaleTypeList=[];
          Provider.of<SaleProvider>(context, listen: false).selectedSalePersonList=[];
          Provider.of<SaleProvider>(context, listen: false).selectedSaleLineList=[];
          Provider.of<SaleProvider>(context, listen: false).selectedSaleMachineList=[];
        },*/
        style: TextButton.styleFrom(padding: const EdgeInsets.all(3)),
        child: Container(
          height: 35,
          width: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Provider.of<SaleProvider>(context, listen: false).saleTypeIndex == index ? ColorResources.getPrimary(context) : Theme.of(context).primaryColor.withOpacity(0.07),
            borderRadius: BorderRadius.circular(50),
          ),
          child:
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                text!,
                style:titleRegular.copyWith(color:Colors.black,fontSize:14),
                overflow: TextOverflow.ellipsis,
              ),
              count > 0
                  ? Container(
                margin: const EdgeInsetsDirectional.only(start:5),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    count > 99 ? "99+" : count.toString(),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ),)
                  : const SizedBox(width: 0, height: 0),

/*              Text('${text!}10',
                  style: titilliumBold.copyWith(color: Provider.of<OrderProvider>(context, listen: false).orderTypeByProductIndex == index
                      ? Theme.of(context).highlightColor : ColorResources.getReviewRattingColor(context))),*/


              const SizedBox(width: 5),

            ],
          ),


/*          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text!,
                  style: titilliumBold.copyWith(color: Provider.of<SaleProvider>(context, listen: false).saleTypeIndex == index
                      ? Theme.of(context).highlightColor : ColorResources.getReviewRattingColor(context))),
              const SizedBox(width: 5),

            ],
          ),*/
        ),
      ),
    );
  }
}