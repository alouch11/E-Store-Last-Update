import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/more/more_screen.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/features/order/view/order_screen.dart';
import 'package:flutter_spareparts_store/features/order/view/lorder_screen.dart';
import 'package:provider/provider.dart';
import '../../sale/view/sale_screen.dart';

class MoreHorizontalSection1 extends StatelessWidget {
  const MoreHorizontalSection1({super.key});

  @override
  Widget build(BuildContext context) {
    String seeorder =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeorder ?? '';
    String seepackage =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seepackage ?? '';
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider,_) {
        return SizedBox(height: 130,
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
            child: Center(
              child: ListView(scrollDirection:Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(), children: [
                   if(Provider.of<SplashProvider>(context, listen: false).configModel!.activeTheme != "theme_fashion")
                          if(seeorder =='yes')
                    SquareButton(image: Images.shoppingImage, title: getTranslated('orders', context),
                      navigateTo: const OrderScreen(),count: 1,hasCount: false),

                    //if(auth =='yes')
                      if(seeorder =='yes')
                      SquareButton(image: Images.shoppingImage, title: getTranslated('lorders', context),
                          navigateTo: const LOrderScreen(),count: 1,hasCount: false),


                    if(seeorder =='yes')
                      SquareButton(image: Images.shoppingImage, title: getTranslated('services', context),
                          navigateTo: const SaleScreen(),count: 1,hasCount: false),


                  ]),
            ),
          ),
        );
      }
    );
  }
}
