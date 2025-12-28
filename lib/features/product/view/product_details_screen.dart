import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:flutter_spareparts_store/features/home/shimmer/product_details_shimmer.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_provider.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/title_row.dart';
import 'package:flutter_spareparts_store/features/product/widget/product_image_view.dart';
import 'package:flutter_spareparts_store/features/product/widget/product_title_view.dart';
import 'package:flutter_spareparts_store/features/product/widget/related_product_view.dart';
import 'package:flutter_spareparts_store/features/product/widget/alternative_product_view.dart';
import 'package:provider/provider.dart';
import '../../profile/provider/profile_provider.dart';
import '../widget/product_applicability_list.dart';
import '../widget/product_transactions_view.dart';

class ProductDetails extends StatefulWidget {
  final int? productId;
  final String? slug;
  final bool isFromWishList;
  const ProductDetails({super.key, required this.productId, required this.slug, this.isFromWishList = false});



  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  _loadData( BuildContext context) async{
    Provider.of<ProductDetailsProvider>(context, listen: false).getProductDetails(context, widget.slug.toString());
    Provider.of<ProductDetailsProvider>(context, listen: false).removePrevReview();
    Provider.of<ProductDetailsProvider>(context, listen: false).initProduct(widget.productId, widget.slug, context);
    Provider.of<ProductProvider>(context, listen: false).removePrevAlternativeProduct();
    Provider.of<ProductProvider>(context, listen: false).initAlternativeProductList(widget.productId.toString(), context);
    Provider.of<ProductProvider>(context, listen: false).removePrevRelatedProduct();
    Provider.of<ProductProvider>(context, listen: false).initRelatedProductList(widget.productId.toString(), context);
    Provider.of<ProductDetailsProvider>(context, listen: false).getCount(widget.productId.toString(), context);
    //Provider.of<ProductDetailsProvider>(context, listen: false).getSharableLink(widget.slug.toString(), context);

  }

  @override
  void initState() {
    _loadData(context);
    super.initState();
  }
  //bool isApplicable = false;
  int isApplicable = 0;
  @override
  Widget build(BuildContext context) {
    String seetransactions =Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seetransactions ?? '';
    ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('product_details', context)),

      body: RefreshIndicator(onRefresh: () async => _loadData(context),
        child: Consumer<ProductDetailsProvider>(
          builder: (context, details, child) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: !details.isDetails?
              Column(children: [

                ProductImageView(productModel: details.productDetailsModel),

                Column(children: [

                  ProductTitleView(productModel: details.productDetailsModel),


                  const SizedBox(width: Dimensions.paddingSizeDefault),

                  (details.productDetailsModel?.productType =='physical')?


                Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child:

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, children: [

                      InkWell(onTap: (){
                        setState(() {
                          isApplicable = 0;

                        });
                      },

                          child: Column(children: [
                            Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                  //color:!isApplicable? Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor.withOpacity(.25) : Theme.of(context).primaryColor.withOpacity(.05):Colors.transparent),
                      color:Theme.of(context).primaryColor.withOpacity(.05)),
              child: Text('${getTranslated('part_info', context)}', style: textRegular.copyWith(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor),),),
                            //if(!isApplicable)
                              if(isApplicable==0)
                              Container(width: 60, height: 3,color: Theme.of(context).primaryColor,)])),

                      const SizedBox(width: Dimensions.paddingSizeDefault),


                      InkWell(onTap: (){
                        setState(() {
                          //isApplicable = false;
                          isApplicable = 1;
                        });
                      },

                          child: Column(children: [
                            Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                  //color:!isApplicable? Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor.withOpacity(.25) : Theme.of(context).primaryColor.withOpacity(.05):Colors.transparent),
                                  color:Theme.of(context).primaryColor.withOpacity(.05)),
                              child: Text('${getTranslated('part_manuf', context)}', style: textRegular.copyWith(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor),),),
                            //if(!isApplicable)
                              if(isApplicable==1)
                              Container(width: 60, height: 3,color: Theme.of(context).primaryColor,)])),

                      const SizedBox(width: Dimensions.paddingSizeDefault),

                      InkWell(onTap: (){
                        setState(() {
                          isApplicable = 2;
                        });
                      },
                        child: Stack(clipBehavior: Clip.none, children: [
                          Column(children: [
                            Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                  color: Theme.of(context).primaryColor.withOpacity(.05)
                              ),
                              child: Text('${getTranslated('applicability', context)}', style: textRegular.copyWith(
                                  color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor),),),

                            if(isApplicable==2)
                              Container(width: 60, height: 3,color: Theme.of(context).primaryColor)]),

                          Positioned(top: -10,right: -10,
                            child: Align(alignment: Alignment.topRight,
                              child: Center(
                                child: Container( decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                                    color: Theme.of(context).primaryColor
                                ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeSmall),
                                      child: Text('${details.productDetailsModel!= null ? details.productDetailsModel!.applicabilityOptions!.length : 0}',
                                        style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.white),),
                                    )),
                              ),
                            ),
                          )
                        ],
                        ),
                      ),

                      const SizedBox(width: Dimensions.paddingSizeDefault),

                    ],),

                     // ]))
                  ): const SizedBox(),




                  if(isApplicable==2)
                  ProductApplicabilityList(productDetailsModel:details.productDetailsModel)
                  else

                  ///Part Info
                    if(isApplicable==0)
                  Column(children: [
                    (details.productDetailsModel?.productType =='physical' && details.productDetailsModel!.choiceOptions != null &&
                        details.productDetailsModel!.choiceOptions!.isNotEmpty)?
                    Container(height: 230,
                      margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: details.productDetailsModel!.choiceOptions!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${details.productDetailsModel!.choiceOptions![index].title} :',
                                    style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.fontSizeLarge)),
                                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: SizedBox(height: 40,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: details.productDetailsModel!.choiceOptions![index]
                                            .options!.length,
                                        itemBuilder: (context, i) {
                                          return Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: Dimensions.paddingSizeDefault),
                                              child: Text(
                                                  details.productDetailsModel!.choiceOptions![index]
                                                      .options![i].trim(), maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: textRegular.copyWith(
                                                      fontSize: Dimensions.fontSizeLarge,
                                                      color: Provider
                                                          .of<ThemeProvider>(
                                                          context, listen: false)
                                                          .darkTheme
                                                          ? Colors.white
                                                          : Theme
                                                          .of(context)
                                                          .primaryColor
                                                  )),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ]);
                        },

                      ),): const SizedBox(),

                    (details.productDetailsModel?.productType =='physical' && details.productDetailsModel != null) ?
                     ProductsTransactions(productId: widget.productId): const SizedBox.shrink(),


                    //const SizedBox(height: Dimensions.paddingSizeLarge),
                    (details.productDetailsModel?.productType =='physical') ?
                    Consumer<ProductProvider>(
                        builder: (context, productProvider,_) {
                          return (productProvider.alternativeProductList != null && productProvider.alternativeProductList!.isNotEmpty)?
                          Column(children: [
                            const SizedBox(height: Dimensions.paddingSizeLarge),
                            Padding(padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeExtraSmall),
                              child: TitleRow(title: getTranslated('alternative_products', context), isDetailsPage: true),),
                            const SizedBox(height: 5),
                            const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                              child: AlternativeProductView(),
                            ),
                          ],
                          ):const SizedBox();
                        }
                    ): const SizedBox.shrink(),


                    /*(details.productDetailsModel?.videoUrl != null && details.isValidYouTubeUrl(details.productDetailsModel!.videoUrl!))?
                    YoutubeVideoWidget(url: details.productDetailsModel!.videoUrl):const SizedBox(),*/



                    (details.productDetailsModel?.productType =='physical') ?
                    Consumer<ProductProvider>(
                      builder: (context, productProvider,_) {
                        return (productProvider.relatedProductList != null && productProvider.relatedProductList!.isNotEmpty)?
                        Column(children: [
                          const SizedBox(height: Dimensions.paddingSizeLarge),
                          Padding(padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeExtraSmall),
                            child: TitleRow(title: getTranslated('related_products', context), isDetailsPage: true),),
                          const SizedBox(height: 5),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                            child: RelatedProductView(),
                          ),
                        ],
                        ):const SizedBox();
                      }
                    ): const SizedBox.shrink(),

                  ],),
                  ///Part Info

///Part Manufacture
                  if(isApplicable==1)
                  Column(children: [
                    (details.productDetailsModel?.productType =='physical' && details.productDetailsModel!.partManufacture != null &&
                        details.productDetailsModel!.partManufacture!.isNotEmpty)?
                    Container(height: 100,
                      margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: details.productDetailsModel!.partManufacture!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${details.productDetailsModel!.partManufacture![index].title} :',
                                    style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.fontSizeLarge)),
                                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: SizedBox(height: 40,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: details.productDetailsModel!.partManufacture![index]
                                            .options!.length,
                                        itemBuilder: (context, i) {
                                          return Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: Dimensions.paddingSizeDefault),
                                              child: Text(
                                                  details.productDetailsModel!.partManufacture![index]
                                                      .options![i].trim(), maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: textRegular.copyWith(
                                                      fontSize: Dimensions.fontSizeLarge,
                                                      color: Provider
                                                          .of<ThemeProvider>(
                                                          context, listen: false)
                                                          .darkTheme
                                                          ? Colors.white
                                                          : Theme
                                                          .of(context)
                                                          .primaryColor
                                                  )),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ]);
                        },

                      ),): const SizedBox(),

                    const SizedBox(height: Dimensions.paddingSizeLarge),
                  ],),
                  ///Part Manufacture
                ],),
              ],
              )
                  : const ProductDetailsShimmer(),
            );
          },
        ),
      ),

    //  bottomNavigationBar: Consumer<ProductDetailsProvider>(
    //      builder: (context, details, child) {
    //        return !details.isDetails?
    //        BottomCartView(product: details.productDetailsModel):const SizedBox();
    //      }
    //  ),



    );
  }
}
