import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/features/dashboard/dashboard_screen.dart';
import 'package:flutter_spareparts_store/helper/price_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/amount_widget.dart';
import 'package:provider/provider.dart';
import '../../home/shimmer/order_details_shimmer.dart';
import '../../profile/provider/profile_provider.dart';
import '../widget/service_bottons_details.dart';
import '../widget/sale_details_top_portion_widget.dart';
import '../widget/sales_product_list.dart';
import '../widget/sale_informations_widget.dart';


class SaleDetailsScreen extends StatefulWidget {
  final bool isNotification;
  final int? saleId;
  final bool fromTrack;
  const SaleDetailsScreen({super.key, required this.saleId, this.isNotification = false,  this.fromTrack = false,});

  @override
  State<SaleDetailsScreen> createState() => _SaleDetailsScreenState();
}

class _SaleDetailsScreenState extends State<SaleDetailsScreen> {


  void _loadData(BuildContext context) async {
    if(Provider.of<AuthController>(context, listen: false).isLoggedIn() && !widget.fromTrack){

        await Provider.of<SaleProvider>(Get.context!, listen: false).getSaleDetails(widget.saleId.toString());
      await Provider.of<SaleProvider>(Get.context!, listen: false).getSaleFromSaleId(widget.saleId.toString());
    }else{
      await Provider.of<SaleProvider>(Get.context!, listen: false).getSaleFromSaleId(widget.saleId.toString());

    }

  }

  @override
  void initState() {
    super.initState();
    if(Provider.of<SplashProvider>(context, listen: false).configModel == null ){
      Provider.of<SplashProvider>(context, listen: false).initConfig(context).then((value){
        _loadData(context);
        Provider.of<SaleProvider>(context, listen: false).digitalOnly(true);
      });
    }else{
      _loadData(context);
      Provider.of<SaleProvider>(context, listen: false).digitalOnly(true);
    }

  }


  @override
  Widget build(BuildContext context) {
    String seeprice =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeprice ?? '';

    return PopScope(
      onPopInvoked: (val) async{
       if(widget.isNotification){
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
       }
      },
      child: Scaffold(
        appBar: AppBar(elevation: 1, backgroundColor: Theme.of(context).cardColor,
            toolbarHeight: 120, leadingWidth: 0, automaticallyImplyLeading: false,
            title: Consumer<SaleProvider>(builder: (context, saleProvider, _) {

                return (saleProvider.saleDetails != null && saleProvider.sales != null) ?
                SaleDetailTopPortion(saleProvider: saleProvider, fromNotification: widget.isNotification):const SizedBox();
              }
              )),

          body: Consumer<SaleProvider>(builder: (context, saleProvider,_) {
            return Consumer<SplashProvider>(builder: (context, config, _) {
              return config.configModel != null?
              Consumer<SaleProvider>(builder: (context, saleProvider, child) {

                double sale = 0;

                if (saleProvider.saleDetails != null && saleProvider.saleDetails!.isNotEmpty) {
                  for (var saleDetails in saleProvider.saleDetails!) {
                    sale = sale + (saleDetails.price! * saleDetails.qty!);
                  }

                }

                return (saleProvider.saleDetails != null && saleProvider.sales != null) ?
                  ListView(padding: const EdgeInsets.all(0), children: [

                    Container(height: 10, color: Theme.of(context).primaryColor.withOpacity(.1)),

                    SaleInformationsWidget(saleProvider: saleProvider),


                    saleProvider.sales != null && saleProvider.sales!.saleNote != null?
                    Padding(padding : const EdgeInsets.all(Dimensions.marginSizeSmall),
                        child: Text.rich(TextSpan(children: [
                          TextSpan(text: '${getTranslated('service_info', context)} : ',
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getReviewRattingColor(context))),

                          TextSpan(text:  saleProvider.sales!.saleNote != null? saleProvider.sales!.saleNote ?? '': "",
                              style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).textTheme.bodyLarge?.color)),
                        ]))):const SizedBox(),
                    const SizedBox(height: Dimensions.paddingSizeSmall),


                    if(saleProvider.sales != null)
                      SaleProductList(sale: saleProvider,saleType: saleProvider.sales!.saleType,
                        fromTrack: widget.fromTrack,isGuest: 0),


                    const SizedBox(height: Dimensions.marginSizeDefault),

                    if(seeprice =='yes')
                    Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      color: Theme.of(context).highlightColor,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                        AmountWidget(title: getTranslated('sub_total', context), amount: PriceConverter.convertPrice(context, sale)),


                        const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                          child: Divider(height: 2, color: ColorResources.hintTextColor),),


                        AmountWidget(title: getTranslated('total_payable', context),
                          amount: PriceConverter.convertPrice(context,sale ),),
                      ])),

                    const SizedBox(height: Dimensions.paddingSizeSmall,),

                    ServiceButtons(saleModel: saleProvider.sales),

                      ],
                      ) : const OrderDetailsShimmer();
                    },
                  ):const OrderDetailsShimmer();
                }
            );
          }
        )
      ),
    );
  }
}
