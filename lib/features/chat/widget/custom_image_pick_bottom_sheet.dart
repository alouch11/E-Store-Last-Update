import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/custom_asset_image_widget.dart';
import 'package:flutter_spareparts_store/features/chat/provider/chat_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:provider/provider.dart';

class CustomImagePickBottomSheet extends StatelessWidget {
  final ChatProvider chatProvider;
   const CustomImagePickBottomSheet(this.chatProvider, {super.key});

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.sizeOf(context).width;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Container(
      width: widthSize,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeExtraLarge), topRight: Radius.circular(Dimensions.paddingSizeExtraLarge)),
        color: themeProvider.darkTheme ? Theme.of(context).textTheme.bodyLarge?.color : Theme.of(context).cardColor,),
      child: Center(
        child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [

          InkWell(
            onTap: () {
              chatProvider.pickMultipleMedia(false);
              Navigator.pop(context);

            },
            child: Column(mainAxisSize: MainAxisSize.min, children: [

                const CustomAssetImageWidget(Images.fromGallery, width: 70, height: 70,),
              const SizedBox(height: Dimensions.paddingSizeSmall,),

                Text(getTranslated('from_gallery', context)!, style: titilliumRegular,),

              ]),
          ),
          const SizedBox(width: Dimensions.paddingSizeOverLarge,),

          InkWell(
            onTap: () {
              chatProvider.pickMultipleMedia(false, openCamera: true);
              Navigator.pop(context);
            },
            child: Column(mainAxisSize: MainAxisSize.min, children: [

                const CustomAssetImageWidget(Images.openCamera, width: 70, height: 70,),
                const SizedBox(height: Dimensions.paddingSizeSmall,),

                Text(getTranslated('open_camera', context)!, style: titilliumRegular,),

              ]),
          ),
        ]),
      ),
    );
  }
}

