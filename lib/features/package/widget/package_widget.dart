import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/package/domain/model/package_model.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/helper/price_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/features/package/view/package_details_screen.dart';
import 'package:provider/provider.dart';

import '../../profile/provider/profile_provider.dart';


class PackageWidget extends StatelessWidget {
  final Packages? packageModel;
  const PackageWidget({super.key, this.packageModel});

  @override
  Widget build(BuildContext context) {

    String seeprice =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeprice ?? '';

    return InkWell(onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => PackageDetailsScreen(packageId: packageModel!.id)));},

      child: Stack(children: [
          Container(margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,
              left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow:  [BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],),

            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(width: 82,height: 82,
                  child: Column(children: [
                    Container(decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      border: Border.all(width: 1, color: Theme.of(context).primaryColor.withOpacity(.25)),
                      boxShadow: Provider.of<ThemeProvider>(context, listen: false).darkTheme? null :[BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder, fit: BoxFit.scaleDown, width: 80, height: 80,
                          image: '${Provider.of<SplashProvider>(context, listen: false).configModel?.baseUrls?.sellerImageUrl}/${packageModel?.seller?.image}',
                          imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.scaleDown, width: 80, height: 80),
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(width: Dimensions.paddingSizeLarge),



                Expanded(flex: 5,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(DateConverter.localDateToIsoStringAMPMPackage(DateTime.parse(packageModel!.createdAt!)),
                        style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor)),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Row(children: [
                      Expanded(child:
                      Text('${packageModel!.packageCode}',
                          style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.bold)))]),
                    const SizedBox(height: Dimensions.paddingSizeSmall),


                    Text('${packageModel!.packageDescription}',
                      style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.green),),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Text('${packageModel!.packageType}',
                      style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.yellow),),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    if(seeprice =='yes')
                    Text(PriceConverter.convertPrice(context, packageModel!.packageAmountTotal), style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getPrimary(context)),),])),

              ]),
            ),
          ),

          Positioned(top: 2, left: 90, child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
              child: Text("${packageModel?.packageDetailsCount}", style: textRegular.copyWith(color: Colors.white))
          )),
        ],
      ),
    );
  }
}
