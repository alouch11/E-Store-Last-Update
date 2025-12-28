import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/product/domain/model/product_details_model.dart';
import 'package:flutter_spareparts_store/features/product/widget/Product_attachment_dialog_widget.dart';
import 'package:flutter_spareparts_store/features/product/widget/product_applicability_widget.dart';

class ProductAttachmentList extends StatelessWidget {
  final ProductDetailsModel? productDetailsModel;
  const ProductAttachmentList({super.key, this.productDetailsModel});

  @override
  Widget build(BuildContext context) {

    return

      Material(child:
        Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child:
      Column(
        children: [
          InkWell(onTap: ()=>Navigator.of(context).pop(),
            child: Container(width: 40,height: 5,decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20)))
        ),
          ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          itemCount:productDetailsModel!.stockAttachments!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>ProductAttachmentDialog(productAttachmentModel: productDetailsModel!.stockAttachments![index]),
              ),
        ],
      )));
  }
}
