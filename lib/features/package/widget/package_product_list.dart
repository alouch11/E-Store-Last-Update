import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/package/provider/package_provider.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/package/widget/package_details_widget.dart';

class PackageProductList extends StatelessWidget {
  final PackageProvider? package;
  final String? packageType;
  final bool fromTrack;
  //final int? isGuest;
  const PackageProductList({super.key, this.package, this.packageType,  this.fromTrack = false});

  @override
  Widget build(BuildContext context) {

    return  ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      itemCount:
      package!.packageDetails!.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) => PackageDetailsWidget(packageDetailsModel: package!.packageDetails![i],
         // isGuest: isGuest,
          fromTrack: fromTrack,
          callback: () {showCustomSnackBar('${getTranslated('note_submitted_successfully', context)}', context, isError: false);},
          packageType: packageType!, packageStatus: package!.packages!.packageStatus!),
    );
  }
}
