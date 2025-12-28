import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/sale/widget/sale_details_widget.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';

import '../provider/sale_provider.dart';

class SaleProductList extends StatelessWidget {
  final SaleProvider? sale;
  final String? saleType;
  final bool fromTrack;
  final int? isGuest;
  const SaleProductList({super.key, this.sale, this.saleType,  this.fromTrack = false, this.isGuest});

  @override
  Widget build(BuildContext context) {

    return  ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      itemCount:sale!.saleDetails!.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) => SaleDetailsWidget(saleDetailsModel: sale!.saleDetails![i],
          isGuest: isGuest,
          fromTrack: fromTrack,
          callback: () {showCustomSnackBar('${getTranslated('note_submitted_successfully', context)}', context, isError: false);},
          saleType: saleType!, paymentStatus: sale!.sales!.saleType!,
          ),
    );
  }
}
