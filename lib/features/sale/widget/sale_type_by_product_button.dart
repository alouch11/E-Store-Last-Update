import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:provider/provider.dart';

import '../provider/sale_provider.dart';

class SaleTypeByProductButton extends StatelessWidget {
  final String? text;
  final int index;
  final String productId;
  final int count;


  const SaleTypeByProductButton({super.key, required this.text, required this.index, required this.productId,required this.count});

  @override
  Widget build(BuildContext context) {
    return
      //Expanded(
        SizedBox(
      child: TextButton(
        onPressed: () => Provider.of<SaleProvider>(context, listen: false).setIndexByProduct(index,productId),
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
        child: Container(
          height: 35,
          width: 110,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Provider.of<SaleProvider>(context, listen: false).saleTypeByProductIndex == index ? ColorResources.getPrimary(context) : Theme.of(context).primaryColor.withOpacity(0.07),
            borderRadius: BorderRadius.circular(50),
          ),
          child:          Row(
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
                margin: const EdgeInsetsDirectional.only(start: 5),
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
                      fontSize: 10,
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
                  style: titilliumBold.copyWith(color: Provider.of<SaleProvider>(context, listen: false).saleTypeByProductIndex == index
                      ? Theme.of(context).highlightColor : ColorResources.getReviewRattingColor(context))),
              const SizedBox(width: 5),

            ],
          ),*/
        ),
      ),
    );
  }
}