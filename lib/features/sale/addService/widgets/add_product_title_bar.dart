import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/sale/addService/controllers/add_service_controller.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:provider/provider.dart';

class AddProductTitleBar extends StatelessWidget {
  AddProductTitleBar({super.key});
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return  Consumer<AddServiceController>(
        builder : (context, resProvider, child){

        return SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      border: Border.all(color: resProvider.selectedPageIndex == 0 ? Theme.of(context).primaryColor: Colors.transparent),
                      color: resProvider.selectedPageIndex == 0 ? Theme.of(context).primaryColor.withOpacity(0.15) : Colors.transparent
                  ),
                  child: Text(getTranslated(resProvider.pages[0], context)!,
                    style: textRegular.copyWith(color: resProvider.selectedPageIndex == 0 ? Theme.of(context).primaryColor: Theme.of(context).hintColor),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      border: Border.all(color: resProvider.selectedPageIndex == 1 ? Theme.of(context).primaryColor: Colors.transparent),
                      color: resProvider.selectedPageIndex == 1 ? Theme.of(context).primaryColor.withOpacity(0.15) : Colors.transparent
                  ),
                  child: Text(getTranslated(resProvider.pages[1], context)!,
                    style: textRegular.copyWith(color: resProvider.selectedPageIndex == 1 ? Theme.of(context).primaryColor: Theme.of(context).hintColor),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      border: Border.all(color: resProvider.selectedPageIndex == 2 ? Theme.of(context).primaryColor: Colors.transparent),
                      color: resProvider.selectedPageIndex == 2 ? Theme.of(context).primaryColor.withOpacity(0.15) : Colors.transparent
                  ),
                  child: Text(
                    getTranslated(resProvider.pages[2], context)!,
                    style: textRegular.copyWith(color: resProvider.selectedPageIndex == 2 ? Theme.of(context).primaryColor: Theme.of(context).hintColor),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
