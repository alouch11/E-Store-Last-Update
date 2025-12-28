import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/order/view/order_details_screen.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:provider/provider.dart';
import '../../../basewidget/show_custom_snakbar.dart';
import '../../profile/provider/profile_provider.dart';
//import '../../search/widget/qrcode.dart';
import '../view/product_transactions_screen.dart';
import '../view/product_transactions_screen.dart';
import 'dropdown_search.dart';

class ProductsTransactions extends StatelessWidget {
  final int? productId;
  const ProductsTransactions({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {

    String seetransactions =Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seetransactions ?? '';

        return
        Container(margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
          padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall, 0),
          color: Theme.of(context).cardColor,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal:  Dimensions.paddingSizeLarge),
              child: InkWell(
                  onTap: ()
        async {
          if(seetransactions == 'yes'){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>  ProductTransactionsScreen(productId:productId)));
                  }else
                   {showCustomSnackBar('${getTranslated('no_auth', context)}', context);}},

                child: Container(width: MediaQuery.of(context).size.width, height: 40,
                  decoration: BoxDecoration(color: ColorResources.visitShop(context),
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                  child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                        child: SizedBox(width: 20, child: Image.asset(Images.transactions, color: Theme.of(context).primaryColor))),
                      Text(getTranslated('View_transactions', context)!,
                        style: titleRegular.copyWith(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor),),
                    ],
                  )),
                ),
              ),
            )

/*            ,Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal:  Dimensions.paddingSizeLarge),
                child: InkWell(
                    onTap: ()
                    //=> Navigator.push(context, MaterialPageRoute(builder: (_) => const FoodOptions(),
                     => Navigator.push(context, MaterialPageRoute(builder: (_) => const   MyHomePage1(),
                    )),
                    child: Container(width: MediaQuery.of(context).size.width, height: 40,
                           decoration: BoxDecoration(color: ColorResources.visitShop(context),
                           borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                               child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                               Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                               child: SizedBox(width: 20, child: Image.asset(Images.termCondition, color: Theme.of(context).primaryColor))),
                               Text('View List',
                               style: titleRegular.copyWith(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor),),
                               ],
                               )),
                               ),
            )
            )*/


            ],
          ),
        );
        //:const SizedBox();
    //  },
  //  );
  }
}
