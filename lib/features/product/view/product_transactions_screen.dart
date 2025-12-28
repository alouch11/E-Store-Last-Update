import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/product/view/product_transactions_tab_item.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../main.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../order/provider/order_provider.dart';
import '../../order/view/order_screen_by_product.dart';
import '../../sale/provider/sale_provider.dart';
import '../../sale/view/sale_screen_by_product.dart';


class ProductTransactionsScreen extends StatefulWidget {
  final int? productId;

  const ProductTransactionsScreen({super.key,required this.productId});
  @override
  State<ProductTransactionsScreen> createState() => _ProductTransactionsScreenState();
}

  class _ProductTransactionsScreenState extends State<ProductTransactionsScreen> {
  ScrollController scrollController  = ScrollController();
  bool isGuestMode = !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();

  @override
  void initState() {
      Provider.of<OrderProvider>(context, listen: false).setIndexByProduct(0,widget.productId.toString(), notify: false);
      Provider.of<OrderProvider>(context, listen: false).getOrderListByProduct(1,'pending',widget.productId.toString(),startDate:Provider.of<OrderProvider>(context, listen: false).selectedOrderStartDate,endDate:Provider.of<OrderProvider>(context, listen: false).selectedOrderEndDate);
      Provider.of<SaleProvider>(context, listen: false).setIndexByProduct(0,widget.productId.toString(), notify: false);
      Provider.of<SaleProvider>(context, listen: false).getSaleListByProduct(1, 'pending', widget.productId.toString(),Provider.of<SaleProvider>(context, listen: false).selectedSearchType,startDate:Provider.of<SaleProvider>(context, listen: false).selectedSaleStartDate,endDate:Provider.of<SaleProvider>(context, listen: false).selectedSaleEndDate);


      super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
      int countOrders=  orderProvider.orderModelByProduct?.totalOrders??0;
      return Consumer<SaleProvider>(
          builder: (context, saleProvider, child) {
            int countSales=  saleProvider.saleModelByProduct?.totalSales??0;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:
          Text('${getTranslated('prodcut_transactions', context)}'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                alignment: Alignment.center,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.transparent,
                ),

                child:  TabBar(
                   isScrollable: true,
                  padding: const EdgeInsets.all(0),
                  labelColor: ColorResources.blue,
                unselectedLabelColor: ColorResources.black,
                indicatorColor: ColorResources.blue,
                indicatorWeight: 2,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                unselectedLabelStyle: textRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    fontWeight: FontWeight.w400),
                labelStyle: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  fontWeight: FontWeight.w700,
                ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                 // indicator: BoxDecoration(
                 //   color: Colors.blue,
                  //  borderRadius: BorderRadius.all(Radius.circular(10)),
                 // ),
                 // labelColor: Colors.white,
                 // unselectedLabelColor: Colors.black54,
                  tabs:  [
                    ProductTrasnsactionsTabItem(title: '${getTranslated('purchase_order', context)}',count: countOrders,),
                    ProductTrasnsactionsTabItem(title: '${getTranslated('sale_order', context)}',count: countSales,),
                  ],
                ),

              ),
            ),
          ),
        ),
        body:  TabBarView(
          children: [
             Padding(padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,0),
                child: OrderScreenByProduct(productId:widget.productId)),

             Padding(padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,0),
                  child:SaleScreenByProduct(productId:widget.productId)),

          ],
        ),
      ),
    );
  }
    );}
    );}
}

