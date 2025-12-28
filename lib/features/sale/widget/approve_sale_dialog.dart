import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spareparts_store/features/sale/view/sale_details_screen.dart';
import '../provider/sale_provider.dart';

class ApproveSaleDialog extends StatefulWidget {
  final int? saleId;
  final String? serviceman;
   const ApproveSaleDialog({super.key, required this.saleId, required this.serviceman});

  @override
  State<ApproveSaleDialog> createState() => _ApproveSaleDialogState();
}

class _ApproveSaleDialogState extends State<ApproveSaleDialog> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).cardColor.withOpacity(0.5),
              ),
              padding: const EdgeInsets.all(3),
              child: const Icon(Icons.clear),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),


        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            color: Theme.of(context).cardColor,
          ),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(Dimensions.homePagePadding),
          child: Column(
            children: [
              Image.asset(Images.approvedIcon, height: 60),
              const SizedBox(height: Dimensions.homePagePadding),

              Text(getTranslated('are_you_sure_you_want_to_approve_your_order', context)!,
                textAlign: TextAlign.center,

                style: titilliumBold.copyWith(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: Dimensions.homePagePadding),
              const SizedBox(height: Dimensions.homePagePadding),


              //  CustomTextField(
              //   maxLines: 3,
              //   inputAction: TextInputAction.done,
              //   inputType: TextInputType.text,
              //   hintText: getTranslated('write_here', context),
              // ),
              // const SizedBox(height: Dimensions.homePagePadding),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: CustomButton(

                    textColor: Theme.of(context).textTheme.bodyLarge?.color,
                    backgroundColor: Theme.of(context).hintColor.withOpacity(0.50),
                    buttonText:  getTranslated('NO', context)!,
                    onTap: () {
                      Navigator.pop(context);
                    },

                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                  child: CustomButton(
                    buttonText:  getTranslated('YES', context)!,
                    onTap: () {
                      Provider.of<SaleProvider>(context, listen: false).apporveSale(context, widget.saleId,widget.serviceman).then((value) {
                        if (value.response?.statusCode == 200) {
                          //Provider.of<SaleProvider>(context, listen: false).getSaleList(1, Provider.of<SaleProvider>(context, listen: false).selectedType);
                            Provider.of<SaleProvider>(context, listen: false).setIndex(1, notify: false);
                          //Provider.of<SaleProvider>(context, listen: false).getSaleList(1,'approved');
                           // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SaleDetailsScreen(saleId: widget.saleId)));
                          Navigator.pop(context);
                          Navigator.pop(context);
                          showCustomSnackBar(getTranslated('order_approved_successfully', context)!, context, isError: false);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SaleDetailsScreen(saleId: widget.saleId)));
                        }
                      });
                    },

                  ),
                ),
              ]),


            ],
          ),
        ),
      ],
      ),
    );
  }
}
