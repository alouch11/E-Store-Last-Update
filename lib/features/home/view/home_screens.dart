import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/lines/provider/lines_provider.dart';
import 'package:flutter_spareparts_store/helper/product_type.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/banner/controllers/banner_controller.dart';
import 'package:flutter_spareparts_store/features/brand/controllers/brand_controller.dart';
import 'package:flutter_spareparts_store/features/category/controllers/category_controller.dart';
import 'package:flutter_spareparts_store/features/product/provider/home_category_product_provider.dart';
import 'package:flutter_spareparts_store/features/notification/provider/notification_provider.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_provider.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/features/wishlist/provider/wishlist_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/title_row.dart';
import 'package:flutter_spareparts_store/features/brand/views/all_brand_screen.dart';
import 'package:flutter_spareparts_store/features/category/view/all_category_screen.dart';
import 'package:flutter_spareparts_store/features/home/widget/announcement.dart';
import 'package:flutter_spareparts_store/features/brand/widgets/brand_view.dart';
import 'package:flutter_spareparts_store/features/home/widget/notifications_widget_home_page.dart';
import 'package:flutter_spareparts_store/features/category/widget/category_view.dart';
import 'package:flutter_spareparts_store/features/banner/widgets/single_banner.dart';
import 'package:flutter_spareparts_store/features/product/widget/home_category_product_view.dart';
import 'package:flutter_spareparts_store/features/product/widget/latest_product_view.dart';
import 'package:flutter_spareparts_store/features/product/widget/products_view.dart';
import 'package:flutter_spareparts_store/features/home/widget/search_widget_home_page.dart';
import 'package:flutter_spareparts_store/features/search/search_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();


  Future<void> _loadData(bool reload) async {
     await Provider.of<CategoryController>(Get.context!, listen: false).getCategoryList(reload);
     await Provider.of<HomeCategoryProductProvider>(Get.context!, listen: false).getHomeCategoryProductList(reload);
     await Provider.of<BrandController>(Get.context!, listen: false).getBrandList(reload);
     await Provider.of<ProductProvider>(Get.context!, listen: false).getLatestProductList(1, reload: reload);
     await Provider.of<ProductProvider>(Get.context!, listen: false).getLProductList('1', reload: reload);
     await Provider.of<NotificationProvider>(Get.context!, listen: false).getNotificationList(1,'unread');
     await Provider.of<LinesProvider>(Get.context!, listen: false).getLinesMachinesGroupList('Bekoko');
     await Provider.of<LinesProvider>(Get.context!, listen: false).getLinesList(1,'Bekoko');


    if(Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()){
      await  Provider.of<ProfileProvider>(Get.context!, listen: false).getUserInfo(Get.context!);
      await Provider.of<WishListProvider>(Get.context!, listen: false).getWishList();
    }


  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();
    singleVendor = Provider.of<SplashProvider>(context, listen: false).configModel!.businessMode == "single";
    _loadData(false);

  }


  @override
  Widget build(BuildContext context) {
    //List<String?> types =[getTranslated('new_arrival', context),getTranslated('top_product', context), getTranslated('best_selling', context),  getTranslated('discounted_product', context)];
   List<String?> types =[getTranslated('new_arrival', context), getTranslated('top_selling', context)];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _loadData( true);
            },
          child: CustomScrollView(controller: _scrollController, slivers: [
              SliverAppBar(
                floating: true,
                elevation: 0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).highlightColor,
                title: Image.asset(Images.logoWithNameImage, height: 35), actions:   const [
                NotificationsWidgetHomePage(),
                ],
              ),

              SliverToBoxAdapter(child: Provider.of<SplashProvider>(context, listen: false).configModel!.announcement!.status == '1'?
              Consumer<SplashProvider>(
                builder: (context, announcement, _){
                  return (announcement.configModel!.announcement!.announcement != null && announcement.onOff)?
                  AnnouncementScreen(announcement: announcement.configModel!.announcement):const SizedBox();
                },

              ):const SizedBox(),),

              SliverPersistentHeader(pinned: true,
                  delegate: SliverDelegate(
                      child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
                        child: const SearchWidgetHomePage()))),

              SliverToBoxAdapter(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    //const BannersView(),
                    //const SizedBox(height: Dimensions.homePagePadding),


/*                    // Flash Deal
                    Consumer<FlashDealProvider>(
                      builder: (context, megaDeal, child) {
                        return  megaDeal.flashDeal != null ? megaDeal.flashDealList.isNotEmpty ?
                        Column(children: [
                            Padding(padding: const EdgeInsets.fromLTRB(Dimensions.homePagePadding,
                                  Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault, Dimensions.paddingSizeExtraExtraSmall),
                              child: TitleRow(title: getTranslated('flash_deal', context),
                                  eventDuration: megaDeal.flashDeal != null ? megaDeal.duration : null,
                                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const FlashDealScreen()));
                                  },isFlash: true),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),

                            Text(getTranslated('hurry_up_the_offer_is_limited_grab_while_it_lasts', context)??'',
                                style: textRegular.copyWith(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor)),
                            const SizedBox(height: Dimensions.paddingSizeDefault),

                            const SizedBox(height: 350, child: Padding(
                                padding: EdgeInsets.only(bottom: Dimensions.homePagePadding),
                                child: FlashDealsView())),
                          ],
                        ) : const SizedBox.shrink() :  const FlashDealShimmer();},),*/


                  // Category
                  Consumer<CategoryController>(
                    builder: (context, categoryController,_) {
                      return (categoryController.categoryList != null && categoryController.categoryList!.isNotEmpty)?
                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraExtraSmall,vertical: Dimensions.paddingSizeExtraSmall),
                        child: TitleRow(title: getTranslated('CATEGORY', context),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>  AllCategoryScreen(isBackButton:true)))),):const SizedBox();
                    }
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                   const CategoryView(isHomePage: true),



 /*                 // Featured Deal

                  Consumer<FeaturedDealProvider>(
                    builder: (context, featuredDealProvider, child) {
                      return  featuredDealProvider.featuredDealProductList != null? featuredDealProvider.featuredDealProductList!.isNotEmpty ?
                      Stack(children: [
                        Container(width: MediaQuery.of(context).size.width,height: 150,
                            color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(.20):Theme.of(context).primaryColor.withOpacity(.125)),
                           Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding),
                              child: Column(children: [
                                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                                  child: TitleRow(title: '${getTranslated('featured_deals', context)}',
                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeaturedDealScreen())),),
                                ),
                                  const FeaturedDealsView(),
                                ],
                              )),
                      ]) : const SizedBox.shrink() : const FindWhatYouNeedShimmer();},),*/



                  //footer banner
                  Consumer<BannerController>(builder: (context, footerBannerProvider, child){
                    return footerBannerProvider.footerBannerList != null && footerBannerProvider.footerBannerList!.isNotEmpty?
                     Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.homePagePadding, right: Dimensions.homePagePadding ),
                        child: SingleBannersView( bannerModel : footerBannerProvider.footerBannerList?[0])):const SizedBox();}),


/*

                  // Featured Products
                  Consumer<ProductProvider>(
                      builder: (context, featured,_) {
                        return  featured.featuredProductList != null? featured.featuredProductList!.isNotEmpty ?
                        Stack(children: [
                            Padding(padding: const EdgeInsets.only(left: 50, bottom: 25),
                              child: Container(width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width-50,
                                decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft : Radius.circular(Dimensions.paddingSizeDefault),
                                      bottomLeft: Radius.circular(Dimensions.paddingSizeDefault)),
                                color: Theme.of(context).colorScheme.onSecondaryContainer),)),
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall,vertical: Dimensions.paddingSizeExtraSmall),
                                  child: Padding(padding: const EdgeInsets.only(top: 20, left: 50,bottom: Dimensions.paddingSizeSmall),
                                      child: TitleRow(title: getTranslated('featured_products', context),
                                          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductScreen(productType: ProductType.featuredProduct))))),
                                ),
                                Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding),
                                  child: FeaturedProductView(scrollController: _scrollController, isHome: true,),),
                              ],
                            ),
                          ],
                        ):const SizedBox(): const FeaturedProductShimmer();}),*/




/*                  //top seller
                  singleVendor?const SizedBox():
                  Consumer<TopSellerProvider>(
                    builder: (context, topSellerProvider, child) {
                      return (topSellerProvider.topSellerList != null && topSellerProvider.topSellerList!.isNotEmpty)?
                      TitleRow(title: getTranslated('top_seller', context),
                          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const AllTopSellerScreen(topSeller: null, title: 'top_seller',)))):const SizedBox();
                    }
                  ),
                  singleVendor?const SizedBox(height: 0):const SizedBox(height: Dimensions.paddingSizeSmall),
                  singleVendor?const SizedBox():
                  Consumer<TopSellerProvider>(
                    builder: (context, topSellerProvider, child) {
                      return (topSellerProvider.topSellerList != null && topSellerProvider.topSellerList!.isNotEmpty)?
                      const Padding(padding: EdgeInsets.only(bottom: Dimensions.homePagePadding),
                          child: SizedBox(height: 165, child: TopSellerView(isHomePage: true))):const SizedBox();
                    }
                  ),*/


                  ///Recommended Product View
                  //  const Padding(padding: EdgeInsets.only(bottom: Dimensions.homePagePadding),
                  //    child: RecommendedProductView()),


                  // Latest Products
                    const Padding(padding: EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                      child: LatestProductView()),



                  /// Brand
                  Provider.of<SplashProvider>(context, listen: false).configModel!.brandSetting == "1"?
                  Consumer<BrandController>(
                    builder: (context, brandController,_) {
                      return (brandController.brandList != null && brandController.brandList!.isNotEmpty)?
                      TitleRow(title: getTranslated('brand', context),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllBrandScreen()))): const SizedBox();
                    }
                  ):const SizedBox(),
                  SizedBox(height: Provider.of<SplashProvider>(context, listen: false).configModel!.brandSetting == "1"?Dimensions.paddingSizeSmall: 0),
                  Provider.of<SplashProvider>(context, listen: false).configModel!.brandSetting == "1"?
                  const BrandView(isHomePage: true) : const SizedBox(),





                    //Home category
                    const HomeCategoryProductView(isHomePage: true),
                    const SizedBox(height: Dimensions.homePagePadding),



                    //footer banner
                    Consumer<BannerController>(builder: (context, footerBannerProvider, child){
                      return footerBannerProvider.footerBannerList != null && footerBannerProvider.footerBannerList!.length>1?
                      SingleBannersView(bannerModel : footerBannerProvider.footerBannerList?[1]):const SizedBox();}),
                    const SizedBox(height: Dimensions.homePagePadding),


                    //Category filter
                  Consumer<ProductProvider>(builder: (context,prodProvider,child) {
                      return Container(decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSecondaryContainer),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeSmall, 0),
                              child: Row(children: [
                                Expanded(child: Text(prodProvider.title == 'xyz' ? getTranslated('new_arrival',context)!:prodProvider.title!, style: titleHeader)),
                                prodProvider.latestProductList != null ? PopupMenuButton(itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(value: ProductType.newArrival, textStyle: textRegular.copyWith(
                                        color: Theme.of(context).hintColor,
                                         ), child: Text(getTranslated('new_arrival',context)!)),
                                     PopupMenuItem(value: ProductType.bestSelling, textStyle: textRegular.copyWith(
                                        color: Theme.of(context).hintColor,
                                       ), child: Text(getTranslated('top_selling',context)!)),
                                    ];
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                                  child: Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeExtraSmall,Dimensions.paddingSizeSmall ),
                                    child: Image.asset(Images.dropdown, scale: 3)),
                                  onSelected: (dynamic value) {
                                    if(value == ProductType.newArrival){
                                      Provider.of<ProductProvider>(context, listen: false).changeTypeOfProduct(value, types[0]);
                                    }else if(value == ProductType.bestSelling){
                                      Provider.of<ProductProvider>(context, listen: false).changeTypeOfProduct(value, types[1]);
                                    }
                                   /* else if(value == ProductType.bestSelling){
                                      Provider.of<ProductProvider>(context, listen: false).changeTypeOfProduct(value, types[2]);
                                    }else if(value == ProductType.discountedProduct){
                                      Provider.of<ProductProvider>(context, listen: false).changeTypeOfProduct(value, types[3]);
                                    }*/

                                    ProductView(isHomePage: false, productType: value, scrollController: _scrollController);
                                    Provider.of<ProductProvider>(context, listen: false).getLatestProductList(1, reload: true);


                                  }
                                ) : const SizedBox(),
                              ]),
                            ),
                          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding),
                            child: ProductView(isHomePage: false, productType: ProductType.newArrival, scrollController: _scrollController)
                            ,),

                            const SizedBox(height: Dimensions.homePagePadding),
                          ],
                        ),
                      );
                    }),



                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  SliverDelegate({required this.child, this.height = 70});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
  }
}
