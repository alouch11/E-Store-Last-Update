import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/package/provider/package_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/features/dashboard/dashboard_screen.dart';



class PackageDetailTopPortion extends StatelessWidget {
  final PackageProvider packageProvider;
  final bool fromNotification;
  const PackageDetailTopPortion({super.key, required this.packageProvider, this.fromNotification = false});

  @override
  Widget build(BuildContext context) {
    return packageProvider.packages != null?
    Stack(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center, children: [
                RichText(text: TextSpan(
                    text: '${getTranslated('package', context)}# ',
                    //text: 'BK-PO- ',
                    style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeDefault), children:[
                      //TextSpan(text: packageProvider.packages?.id.toString(),
                      TextSpan(text: packageProvider.packages!.packageCode,
                          style: textBold.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeLarge)),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall,),

                RichText(text: TextSpan(
                    text: getTranslated('your_package_is', context),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getHint(context)),
                    children:[

                      TextSpan(text: '${packageProvider.packages?.packageDescription}',
                          style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                            color:ColorResources.getGreen(context)
                          )),
/*                      TextSpan(text: ' - ${packageProvider.packages?.packageMachine}',
                          style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                              color:ColorResources.getGreen(context)
                          )),
                      TextSpan(text: ' - ${packageProvider.packages?.packageType}',
                          style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                              color:ColorResources.getGreen(context)
                          ))*/

                    ]),),
                const SizedBox(height: Dimensions.paddingSizeSmall,),

                Text(DateConverter.localDateToIsoStringAMPMPackage(DateTime.parse(packageProvider.packages!.createdAt!)),
                    style: titilliumRegular.copyWith(color: ColorResources.getHint(context),
                        fontSize: Dimensions.fontSizeSmall)),
              ],
            ),
          ],
        ),
        InkWell(onTap: (){
          if(fromNotification){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
          }else{
            Navigator.pop(context);
          }
        }, child: const Padding(padding: EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault),
            child: Icon(CupertinoIcons.back)))
      ],
    ): const SizedBox();
  }
}
