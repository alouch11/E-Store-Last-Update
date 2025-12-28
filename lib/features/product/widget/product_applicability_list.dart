import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/product/domain/model/product_details_model.dart';
import 'package:flutter_spareparts_store/features/product/widget/product_applicability_widget.dart';

class ProductApplicabilityList extends StatelessWidget {
  final ProductDetailsModel? productDetailsModel;
  const ProductApplicabilityList({super.key, this.productDetailsModel});

  @override
  Widget build(BuildContext context) {

    return  ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      itemCount:productDetailsModel!.applicabilityOptions!.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>ProductApplicabilityWidget(productApplicabilityModel: productDetailsModel!.applicabilityOptions![index]),
    );
  }
}
