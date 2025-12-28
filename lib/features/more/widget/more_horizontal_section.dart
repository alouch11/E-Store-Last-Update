import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/more/more_screen.dart';
import 'package:flutter_spareparts_store/features/wishlist/provider/wishlist_provider.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/features/order/view/order_screen.dart';
import 'package:flutter_spareparts_store/features/order/view/lorder_screen.dart';
import 'package:flutter_spareparts_store/features/wishlist/view/wishlist_screen.dart';
import 'package:provider/provider.dart';

import '../../package/view/package_screen.dart';
import '../../sale/view/sale_screen.dart';

class MoreHorizontalSection extends StatelessWidget {
  const MoreHorizontalSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthController>(context, listen: false).isLoggedIn();
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
                  //  SquareButton(image: Images.offerIcon, title: getTranslated('offers', context),
                  //    navigateTo: const OffersScreen(),count: 0,hasCount: false,),

                 //   if(!isGuestMode && Provider.of<SplashProvider>(context,listen: false).configModel!.walletStatus == 1)
                 //     SquareButton(image: Images.wallet, title: getTranslated('wallet', context),
                 //         navigateTo: const WalletScreen(),count: 1,hasCount: false,
                 //        subTitle: 'amount', isWallet: true, balance: Provider.of<ProfileProvider>(context, listen: false).balance),


                 //   if(!isGuestMode && Provider.of<SplashProvider>(context,listen: false).configModel!.loyaltyPointStatus == 1)
                  //    SquareButton(image: Images.loyaltyPoint, title: getTranslated('loyalty_point', context),
                  //      navigateTo: const LoyaltyPointScreen(),count: 1,hasCount: false,isWallet: true,subTitle: 'point',
                 //       balance: Provider.of<ProfileProvider>(context, listen: false).loyaltyPoint, isLoyalty: true,
                   //   ),
                     //SquareButton(image: Images.wishlist, title: getTranslated('wishlist', context),
                     SquareButton(image: Images.favorites, title: getTranslated('wishlist', context),
                       navigateTo: const WishListScreen(),
                       count: Provider.of<AuthController>(context, listen: false).isLoggedIn() &&
                           Provider.of<WishListProvider>(context, listen: false).wishList != null &&
                           Provider.of<WishListProvider>(context, listen: false).wishList!.isNotEmpty ?
                       Provider.of<WishListProvider>(context, listen: false).wishList!.length : 0, hasCount: false,),


                   // if(!isGuestMode)
                   //   if(auth =='yes')
                  //  SquareButton(image: Images.shoppingImage, title: getTranslated('orders', context),
                  //    navigateTo: const OrderScreen(),count: 1,hasCount: false,isWallet: true,subTitle: 'orders',
                   //   balance: profileProvider.userInfoModel?.totalOrder??0, isLoyalty: true,
                  //  ),
                       // if(auth =='yes')
                          if(seeorder =='yes')
                    SquareButton(image: Images.orderImage, title: getTranslated('orders', context),
                      navigateTo: const OrderScreen(),count: 1,hasCount: false),

                    //if(auth =='yes')
                      if(seeorder =='yes')
                      SquareButton(image: Images.localOrderImage, title: getTranslated('lorders', context),
                          navigateTo: const LOrderScreen(),count: 1,hasCount: false),

                    if(seeorder =='yes')
                      SquareButton(image: Images.serviceImage, title: getTranslated('services', context),
                          navigateTo: const SaleScreen(),count: 1,hasCount: false),


                    if(seepackage =='yes')
                      SquareButton(image: Images.packageImage, title: getTranslated('packages', context),
                          navigateTo: const PackageScreen(),count: 1,hasCount: false),
                   // SquareButton(image: Images.cartImage, title: getTranslated('cart', context),
                  //   navigateTo: const CartScreen(),
                   //   count: Provider.of<CartController>(context,listen: false).cartList.length, hasCount: true,),

                  ]),
            ),
          ),
        );
      }
    );
  }
}
