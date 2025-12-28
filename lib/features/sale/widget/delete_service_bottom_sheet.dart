import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/auth/views/auth_screen.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:provider/provider.dart';

class DeleteServiceBottomSheet extends StatelessWidget {
  final int serviceId;
  const DeleteServiceBottomSheet({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.only(bottom: 40, top: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.paddingSizeDefault))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 40,height: 5,decoration: BoxDecoration(color: Theme.of(context).hintColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(20)),),
        const SizedBox(height: 40,),
        Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          child: SizedBox(width: 60,child: Image.asset(Images.delete)),),
        const SizedBox(height: Dimensions.paddingSizeSmall,),
        Text(getTranslated('delete_service', context)!, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

        Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeLarge),
          child: Text('${getTranslated('want_to_delete_service', context)}'),),

        const SizedBox(height: Dimensions.paddingSizeDefault,),
        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeOverLarge),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            SizedBox(width: 120,child: CustomButton(buttonText: '${getTranslated('cancel', context)}',
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(.5),
              textColor: Theme.of(context).textTheme.bodyLarge?.color,
              onTap: ()=> Navigator.pop(context),)),
            const SizedBox(width: Dimensions.paddingSizeDefault,),
            SizedBox(width: 120,child: CustomButton(buttonText: '${getTranslated('delete', context)}',
                backgroundColor: Theme.of(context).colorScheme.error,
                onTap: (){
                 Provider.of<SaleProvider>(context, listen: false).deleteService(context,serviceId).then((condition) {
                    if(condition.response!.statusCode == 200){
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Provider.of<SaleProvider>(context, listen: false).setIndex(4, notify: false);
                    }
                  });
                }))
          ],),
        )

      ],),
    );
  }
}
