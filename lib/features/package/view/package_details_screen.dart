import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/features/dashboard/dashboard_screen.dart';
import 'package:flutter_spareparts_store/features/package/widget/package_details_top_portion_widget.dart';
import 'package:flutter_spareparts_store/features/package/widget/package_product_list.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/package/provider/package_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:provider/provider.dart';
import '../../home/shimmer/package_details_shimmer.dart';

class PackageDetailsScreen extends StatefulWidget {
  final bool isNotification;
  final int? packageId;
  final String? phone;
  final bool fromTrack;
  const PackageDetailsScreen({super.key, required this.packageId, this.isNotification = false, this.phone,  this.fromTrack = false});

  @override
  State<PackageDetailsScreen> createState() => _PackageDetailsScreenState();
}

class _PackageDetailsScreenState extends State<PackageDetailsScreen> {


  void _loadData(BuildContext context) async {
    if(Provider.of<AuthController>(context, listen: false).isLoggedIn() && !widget.fromTrack){
      await Provider.of<PackageProvider>(Get.context!, listen: false).getPackageDetails(widget.packageId.toString());
      await Provider.of<PackageProvider>(Get.context!, listen: false).getPackageFromPackageId(widget.packageId.toString());
    }else{
      await Provider.of<PackageProvider>(Get.context!, listen: false).getPackageFromPackageId(widget.packageId.toString());

    }

  }

  @override
  void initState() {
    super.initState();
    if(Provider.of<SplashProvider>(context, listen: false).configModel == null ){
      Provider.of<SplashProvider>(context, listen: false).initConfig(context).then((value){
        _loadData(context);
        Provider.of<PackageProvider>(context, listen: false).digitalOnly(true);
      });
    }else{
      _loadData(context);
      Provider.of<PackageProvider>(context, listen: false).digitalOnly(true);
    }

  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (val) async{
       if(widget.isNotification){
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
       }
      },
      child: Scaffold(
        appBar: AppBar(elevation: 1, backgroundColor: Theme.of(context).cardColor,
            toolbarHeight: 120, leadingWidth: 0, automaticallyImplyLeading: false,
            title: Consumer<PackageProvider>(builder: (context, packageProvider, _) {
                return (packageProvider.packageDetails != null && packageProvider.packages != null) ?
                PackageDetailTopPortion(packageProvider: packageProvider, fromNotification: widget.isNotification):const SizedBox();
              })),

          body: Consumer<PackageProvider>(builder: (context, packageProvider,_) {/*               double package = 0;
                double discount = 0;
                double? eeDiscount = 0;
                double tax = 0;
                double shippingCost = 0;



                  if (packageProvider.packageDetails != null && packageProvider.packageDetails!.isNotEmpty) {
                    if( packageProvider.packageDetails?[0].package?.isShippingFree == 1){
                      shippingCost = 0;
                    }else{
                      //shippingCost = packageProvider.packages?.shippingCost??0;
                      shippingCost = 0;
                    }

                    for (var packageDetails in packageProvider.packageDetails!) {
                      if(packageDetails.productDetails?.productType != null && packageDetails.productDetails!.productType != "physical" ){
                        packageProvider.digitalOnly(false, isUpdate: false);
                      }
                    }



                    for (var packageDetails in packageProvider.packageDetails!) {
                      package = package + (packageDetails.price! * packageDetails.qty!);
                      discount = discount + packageDetails.discount!;
                      tax = tax + packageDetails.tax!;
                    }


                    if(packageProvider.packages != null && packageProvider.packages!.packageType == 'POS'){
                      if(packageProvider.packages!.extraDiscountType == 'percent'){
                        eeDiscount = package * (packageProvider.packages!.extraDiscount!/100);
                      }else{
                        eeDiscount = packageProvider.packages!.extraDiscount;
                      }
                    }
                  }*/
            return Consumer<SplashProvider>(builder: (context, config, _) {
              return config.configModel != null?
              Consumer<PackageProvider>(builder: (context, packageProvider, child) {




                  return (packageProvider.packageDetails != null && packageProvider.packages != null) ?
                  ListView(padding: const EdgeInsets.all(0), children: [


                    Container(height: 10, color: Theme.of(context).primaryColor.withOpacity(.1)),


/*                    packageProvider.packages != null && packageProvider.packages!.packageNote != null?
                    Padding(padding : const EdgeInsets.all(Dimensions.marginSizeSmall),
                        child: Text.rich(TextSpan(children: [
                          TextSpan(text: '${getTranslated('package_note', context)} : ',
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getReviewRattingColor(context))),

                          TextSpan(text:  packageProvider.packages!.packageNote != null? packageProvider.packages!.packageNote ?? '': "",
                              style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).textTheme.bodyLarge?.color)),
                        ]))):const SizedBox(),
                    const SizedBox(height: Dimensions.paddingSizeSmall),*/



                   // SellerSection(package: packageProvider),


                    if(packageProvider.packages != null)
                      PackageProductList(package: packageProvider,packageType: packageProvider.packages!.packageType),
                        //fromTrack: widget.fromTrack,isGuest: packageProvider.packages!.isGuest!,),


                    const SizedBox(height: Dimensions.marginSizeDefault),

/*                    Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      color: Theme.of(context).highlightColor,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                        AmountWidget(title: getTranslated('sub_total', context), amount: PriceConverter.convertPrice(context, package)),


                        packageProvider.packages!.packageType == "POS"? const SizedBox():
                        AmountWidget(title: getTranslated('shipping_fee', context), amount: PriceConverter.convertPrice(context, shippingCost)),


                        AmountWidget(title: getTranslated('discount', context), amount: PriceConverter.convertPrice(context, discount)),


                        packageProvider.packages!.packageType == "POS"?
                        AmountWidget(title: getTranslated('extra_discount', context), amount: PriceConverter.convertPrice(context, eeDiscount)):const SizedBox(),


                      //  AmountWidget(title: getTranslated('coupon_voucher', context), amount: PriceConverter.convertPrice(context, packageProvider.packages!.discountAmount),),


                        AmountWidget(title: getTranslated('tax', context), amount: PriceConverter.convertPrice(context, tax)),


                        const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                          child: Divider(height: 2, color: ColorResources.hintTextColor),),


                        AmountWidget(title: getTranslated('total_payable', context),
                          amount: PriceConverter.convertPrice(context,
                              (package + shippingCost - eeDiscount! - packageProvider.packages!.discountAmount! - discount  + tax)),),
                      ])),*/




                    const SizedBox(height: Dimensions.paddingSizeSmall,),

                      ],
                      ) : const PackageDetailsShimmer();
                    },
                  ):const PackageDetailsShimmer();
                }
            );
          }
        )
      ),
    );
  }
}
