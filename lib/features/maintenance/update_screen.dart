import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

            Image.asset(
              //color: Theme.of(context).primaryColor,
              Images.update,
              width: MediaQuery.of(context).size.height*0.4,
              height: MediaQuery.of(context).size.height*0.4,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),

            Text(
              getTranslated('update', context)!,
              style: robotoBold.copyWith(fontSize: MediaQuery.of(context).size.height*0.023, color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),

            Text(
              getTranslated('your_app_is_deprecated', context)!,
              style: textRegular.copyWith(fontSize: MediaQuery.of(context).size.height*0.0175, color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02),

            RichText(text: TextSpan(
                text: '${getTranslated('current_version', context)}',
                style: textRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeDefault), children:[
              TextSpan(text:AppConstants.appVersion ,
                  style: textBold.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeDefault)),
            ])),

          RichText(text: TextSpan(
            text: '${getTranslated('last_version', context)}',
            style: textRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeDefault), children:[
            TextSpan(text: Provider.of<SplashProvider>(context, listen: false).configModel!.userAppVersionControl!.forAndroid!.version,
                style: textBold.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeDefault)),
          ])),


            SizedBox(height: MediaQuery.of(context).size.height*0.04),

            CustomButton(buttonText: getTranslated('update_now', context)!, onTap: () async {
              String? appUrl = 'https://google.com';

              if(Platform.isAndroid) {
                appUrl = '${Provider.of<SplashProvider>(Get.context!, listen: false).baseUrls!.appsUrl}/'
                         '${Provider.of<SplashProvider>(context, listen: false).configModel?.userAppVersionControl?.forAndroid?.link}';
              }else if(Platform.isIOS) {
                appUrl = '${Provider.of<SplashProvider>(Get.context!, listen: false).baseUrls!.appsUrl}/'
                         '${Provider.of<SplashProvider>(context, listen: false).configModel?.userAppVersionControl?.forIos?.link}';
              }
              if(await canLaunchUrlString(appUrl)) {
                launchUrlString(appUrl, mode: LaunchMode.externalApplication);
              }else {
                showCustomSnackBar('${getTranslated('can_not_launch', Get.context!)!}  $appUrl', Get.context!);
              }
            }),

          ]),
        ),
      ),
    );
  }
}



