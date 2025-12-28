
import 'package:flutter_spareparts_store/features/pdf/pdf_viewer.dart';
import 'package:flutter_spareparts_store/features/product/widget/product_quantities_view.dart';
import 'package:flutter_spareparts_store/features/product/widget/product_suppliers_view.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/product/domain/model/product_details_model.dart'as pd;
import 'package:flutter_spareparts_store/features/product/widget/product_location_view.dart';
import 'package:flutter_spareparts_store/features/product/widget/product_serialnumber_view.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../basewidget/show_custom_snakbar.dart';
import '../../../basewidget/title_row.dart';
import '../../../main.dart';
import '../../../utill/images.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../profile/provider/profile_provider.dart';
import '../../splash/provider/splash_provider.dart';
import 'dart:async';
import '../view/product_data_details_screen.dart';

 //class ProductTitleView extends StatelessWidget {
  class ProductTitleView extends StatefulWidget {

  final pd.ProductDetailsModel? productModel;
  final String? averageRatting;

   const ProductTitleView({super.key, required this.productModel, this.averageRatting});

  @override
  State<ProductTitleView> createState() => _ProductTitleViewState();
  }

class _ProductTitleViewState extends State<ProductTitleView> with SingleTickerProviderStateMixin {


  late AnimationController _animationController;
  @override
  void initState() {
    _animationController =
     AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    //double? startingPrice = 0;
    //double? endingPrice;
    String stockqty = '${widget.productModel!.currentStock} ${widget.productModel!.unit}';
    String seeqty =Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeqty ?? '';
    String seeorder =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeorder ?? '';
    List<int>? userauthlevel =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.userauthlevel;


    return widget.productModel != null? Container(
      padding: const EdgeInsets.symmetric(horizontal : Dimensions.homePagePadding),
      child: Consumer<ProductDetailsProvider>(
        builder: (context, details, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            if(widget.productModel?.productType =='physical')
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment :MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.25,
                child: Text('${getTranslated('stock_code', context)} : ', maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    //style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                     style: ubuntuBold.copyWith(color: Theme.of(context).hintColor)),
              ),

              Text(widget.productModel!.code ?? '',
                  style: ubuntuBold.copyWith( fontSize: Dimensions.fontSizeLarge), maxLines: 2)
            ]),
            if(widget.productModel?.productType =='physical')
            const SizedBox(height: Dimensions.paddingSizeDefault),

            //if(productModel?.productType =='physical')
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment :MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              if(widget.productModel?.productType =='physical')

               /* Text('${getTranslated('stock_description', context)} : ', maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),*/

                SizedBox(width: MediaQuery.of(context).size.width * 0.25,
                    child: Text('${getTranslated('stock_description', context)} : ',
                overflow: TextOverflow.ellipsis,
                style: ubuntuBold.copyWith(color: Theme.of(context).hintColor),
              )),

         Expanded(
             child:Text(widget.productModel!.description ?? '',
                  style: ubuntuBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge), maxLines: 6,overflow: TextOverflow.ellipsis,softWrap: true))

            ]),

          //  if(productModel?.productType =='physical')
            const SizedBox(height: Dimensions.paddingSizeDefault),

            if( widget.productModel?.productType =='physical' && seeqty == 'yes')
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment :MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.25,
                  child: Text('${getTranslated('stock_qty', context)} : ', maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    //style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                   style: ubuntuBold.copyWith(color: Theme.of(context).hintColor))),
                 if((widget.productModel!.minimumOrderQty! <= widget.productModel!.currentStock!)|| (widget.productModel!.minimumOrderQty! > widget.productModel!.currentStock! && widget.productModel!.qtyOrdered!=0)  )
                    Text(stockqty ,
                    style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: const Color(0xFF0000FF))),
                    if(widget.productModel!.minimumOrderQty! > widget.productModel!.currentStock! && widget.productModel!.qtyOrdered==0)
                 FadeTransition(
                 opacity: _animationController,
                 child:Container( decoration: BoxDecoration(
                   color: Colors.red,
                   borderRadius: BorderRadius.circular(5),
                   boxShadow: [
                     BoxShadow(
                         color: Colors.blue.withOpacity(.8),
                         spreadRadius: 1,
                         blurRadius: 7,
                         offset: const Offset(0, 1))
                   ],
                 ),
                   child: Padding(
                     padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                     child: Text(stockqty ,
                                   style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: const Color(0xFF0000FF))),
                   ),
                 ),
                  )


              ]),
            if(widget.productModel?.productType =='physical'&& seeqty == 'yes')
            const SizedBox(height: Dimensions.paddingSizeDefault),


            if(widget.productModel?.productType =='physical'&& seeqty == 'yes')
            const SizedBox(height: Dimensions.paddingSizeDefault),

                if(widget.productModel?.productType =='physical')
                  Row(children: [

                    if(seeqty == 'yes')
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: '${widget.productModel!.qtyIn} ', style: textMedium.copyWith(
                            color: Provider
                                .of<ThemeProvider>(context, listen: false)
                                .darkTheme ? Theme
                                .of(context)
                                .hintColor : Theme
                                .of(context)
                                .primaryColor,
                            fontSize: Dimensions.fontSizeDefault)),
                        TextSpan(text: '${getTranslated('qty_in', context)} | ',
                            style: textRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,))
                      ])),

                    if(seeqty == 'yes')
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: '${widget.productModel!.qtyOut} ', style: textMedium.copyWith(
                            color: Provider
                                .of<ThemeProvider>(context, listen: false)
                                .darkTheme ? Theme
                                .of(context)
                                .hintColor : Theme
                                .of(context)
                                .primaryColor,
                            fontSize: Dimensions.fontSizeDefault)),
                        TextSpan(text: '${getTranslated('qty_out', context)}',
                            style: textRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,))
                      ])),

                  ]),
                const SizedBox(height: Dimensions.paddingSizeSmall),

            /*if(widget.productModel?.productType =='physical')
            Row(children: [

              if(seeqty == 'yes')
                Text.rich(TextSpan(children: [
                  TextSpan(
                      //text: '${details.qtyorder} ', style: textMedium.copyWith(
                      text: '${widget.productModel!.qtyOrdered} ', style: textMedium.copyWith(
                      color: Provider
                          .of<ThemeProvider>(context, listen: false)
                          .darkTheme ? Theme
                          .of(context)
                          .hintColor : Theme
                          .of(context)
                          .primaryColor,
                      fontSize: Dimensions.fontSizeDefault)),
                  TextSpan(text: '${getTranslated('qty_order', context)} | ',
                      style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,))
                ])),

              if(seeqty == 'yes')
                Text.rich(TextSpan(children: [
                  TextSpan(
                     // text: '${details.qtyblock} ', style: textMedium.copyWith(
                      text: '${widget.productModel!.qtyBlocked} ', style: textMedium.copyWith(
                      color: Provider
                          .of<ThemeProvider>(context, listen: false)
                          .darkTheme ? Theme
                          .of(context)
                          .hintColor : Theme
                          .of(context)
                          .primaryColor,
                      fontSize: Dimensions.fontSizeDefault)),
                  TextSpan(text: '${getTranslated('qty_blocked', context)}',
                      style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,))
                ])),

            ]),
            const SizedBox(height: Dimensions.paddingSizeSmall),*/

            if( widget.productModel?.productType =='physical')
            Row(children: [
              if(seeorder == 'yes')
                Text.rich(TextSpan(children: [
                  TextSpan(text: '${details.orderCount} ',
                      style: textMedium.copyWith(
                          color: Provider
                              .of<ThemeProvider>(context, listen: false)
                              .darkTheme ? Theme
                              .of(context)
                              .hintColor : Theme
                              .of(context)
                              .primaryColor,
                          fontSize: Dimensions.fontSizeDefault)),
                  TextSpan(text: '${getTranslated('orders', context)} | ',
                      style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,))
                ])),

              if(seeorder == 'yes')
                Text.rich(TextSpan(children: [
                  TextSpan(text: '${details.saleCount} ',
                      style: textMedium.copyWith(
                          color: Provider
                              .of<ThemeProvider>(context, listen: false)
                              .darkTheme ? Theme
                              .of(context)
                              .hintColor : Theme
                              .of(context)
                              .primaryColor,
                          fontSize: Dimensions.fontSizeDefault)),
                  TextSpan(text: '${getTranslated('services', context)} | ',
                      style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,))
                ])),


              Text.rich(TextSpan(children: [
                TextSpan(text: '${details.wishCount} ', style: textMedium
                    .copyWith(
                    color: Provider
                        .of<ThemeProvider>(context, listen: false)
                        .darkTheme ? Theme
                        .of(context)
                        .hintColor : Theme
                        .of(context)
                        .primaryColor,
                    fontSize: Dimensions.fontSizeDefault)),
                TextSpan(text: '${getTranslated('wish_listed', context)}',
                    style: textRegular.copyWith(
                      fontSize: Dimensions.fontSizeDefault,))
              ])),
            ]),
            if(widget.productModel?.productType =='physical')
            const SizedBox(height: Dimensions.paddingSizeSmall),


               if( widget.productModel?.productType =='physical' && seeqty == 'yes'  && widget.productModel!.currentStock! >=0 && widget.productModel!.currentStock!= null  )
                // if( productModel?.productType =='physical' && seeqty == 'yes' )
                  ProductQuantitiesView(productModel: details.productDetailsModel),

            if( widget.productModel?.productType =='physical' && seeqty == 'yes'   && widget.productModel!.currentStock! >=0 && widget.productModel!.currentStock!= null )
             // if( productModel?.productType =='physical' && seeqty == 'yes' )
              ProductLocationView(productModel: details.productDetailsModel),

            if( widget.productModel?.productType =='physical' && seeqty == 'yes' && widget.productModel!.stockSerials != null && widget.productModel!.stockSerials!.isNotEmpty)
             // if( productModel?.productType =='physical' && seeqty == 'yes' )
              ProductSerialView(productModel: details.productDetailsModel),

                if( widget.productModel?.productType =='physical' && seeqty == 'yes' && widget.productModel!.stockSuppliers != null && widget.productModel!.stockSuppliers!.isNotEmpty)
                  ProductSupplierView(productModel: details.productDetailsModel),

            /// Colors////////////
/*            productModel?.productType =='physical' && productModel!.colors != null && productModel!.colors!.isNotEmpty ?
            Row(children: [
              Text('${getTranslated('select_variant', context)} : ',
                  style: titilliumRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge)),
              Expanded(
                child: SizedBox(height: 40,
                  child: ListView.builder(
                    itemCount: productModel!.colors!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,

                    itemBuilder: (context, index) {
                      String colorString = '0xff${productModel!.colors![index]
                          .code!.substring(1, 7)}';
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.paddingSizeExtraSmall)),
                          child: Padding(padding: const EdgeInsets.all(
                              Dimensions.paddingSizeExtraSmall),
                            child: Container(height: 20,
                              width: 20,
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeExtraSmall),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(int.parse(colorString)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]) : const SizedBox(),
            productModel?.productType =='physical' && productModel!.colors != null && productModel!.colors!.isNotEmpty
                ? const SizedBox(height: Dimensions.paddingSizeSmall)
                : const SizedBox(),*/

/// choiceOptions////////////
/*            productModel?.productType =='physical' && productModel!.choiceOptions != null &&
                productModel!.choiceOptions!.isNotEmpty ?
            ListView.builder(
              shrinkWrap: true,
              itemCount: productModel!.choiceOptions!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text('${getTranslated('available', context)} ${productModel!.choiceOptions![index].title} :',
                      Text('${productModel!.choiceOptions![index].title} :',
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
                              itemCount: productModel!.choiceOptions![index]
                                  .options!.length,
                              itemBuilder: (context, i) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: Dimensions.paddingSizeDefault),
                                    child: Text(
                                        productModel!.choiceOptions![index]
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

            ) : const SizedBox(),*/
/// choiceOptions////////////



            /// machine_catalogue////////////
                widget.productModel!= null && widget.productModel?.productType =='digital' && widget.productModel!.catalogueList!.isNotEmpty ?
          Column(children: [
          Padding(padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraSmall),
          child: TitleRow(title: getTranslated('machine_catalogue', context), isDetailsPage: true),),
          const SizedBox(height: 5),
          const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          ),
          ],
          ):const SizedBox(),

                widget.productModel!= null && widget.productModel?.productType =='digital' && widget.productModel!.catalogueList!.isNotEmpty ?
            ListView.builder(
              shrinkWrap: true,
              physics: const  NeverScrollableScrollPhysics(),
              itemCount: widget.productModel!.catalogueList!.length,
              //scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return
                  Column(
                    children: [
                              Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                child: ExpansionTile(
                                    //shape:const RoundedRectangleBorder(),
                                    shape: const RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                    title:
                                     Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                       SizedBox(width: Dimensions.iconSizeDefault,
                                          child: Image.asset(Images.fileDownload, color: Theme.of(context).primaryColor,)),
                                        const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
                                      Text(' ${widget.productModel!.catalogueList![index].cataloguetitle}', maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                                     ]),

                                    children: [
                                            Padding(
                                             padding: const EdgeInsets.all(2.0),
                                            child:
                                                 ListView.builder(
                                                     padding: const EdgeInsets.symmetric( horizontal:0, vertical:0),
                                                     shrinkWrap: true,
                                                     physics: const NeverScrollableScrollPhysics(),
                                                      itemCount: widget.productModel!.catalogueList![index].catalogueoptions!.length,
                                                      itemBuilder: (context, i) {
                                                        final Size txtSize1 = _textSize('${widget.productModel!.catalogueList![index].catalogueoptions![i].cataloguelang}');

                                                        return Padding(
                                                          padding: const EdgeInsets.only(top: 5.0),
                                                          child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              mainAxisSize: MainAxisSize.max,
                                                            children: [

                                                              SizedBox(
                                                                width:MediaQuery.of(context).size.width * 0.10,
                                                                child: InkWell(onTap : () async { if(userauthlevel!.contains(widget.productModel!.catalogueList![index].catalogueauth) ){
                                                                  if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){

                                                                    Navigator.push(
                                                                      context, MaterialPageRoute<dynamic>(
                                                                      builder: (_) => PDFViewer(
                                                                        url: '${Provider.of<SplashProvider>(Get.context!, listen: false).baseUrls!.machineCataloguesUrl}/'
                                                                            '${widget.productModel!.catalogueList![index].line}/'
                                                                            '${widget.productModel!.catalogueList![index].machine}/'
                                                                            '${widget.productModel!.catalogueList![index].catalogueoptions![i].cataloguepath}',

                                                                        title: '${widget.productModel!.catalogueList![index].cataloguetitle}',
                                                                      ),
                                                                    ),
                                                                    );
                                                                  }
                                                                }
                                                                else
                                                                {
                                                                  showCustomSnackBar('${getTranslated('no_auth', context)}', context);
                                                                }
                                                                },
                                                                    child: Image.asset(Images.pdf,width: 30,height: 30,color: Theme.of(context).primaryColor,)
                                                                ),
                                                              ),

                                                              SizedBox(width:MediaQuery.of(context).size.width * 0.45,
                                                                  child: Align(alignment: Alignment.centerLeft,
                                                                    child:Text(
                                                                      ' ${widget.productModel!.catalogueList![index].cataloguetitle}',
                                                                      maxLines: 3,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: ubuntuMediumHigh.copyWith(color: Theme.of(context).hintColor),
                                                                    ),
                                                                  )),



                                                          SizedBox(
                                                          width:MediaQuery.of(context).size.width * 0.30,
                                                          child:

                                                                                                    InkWell(onTap : () async {
                                                                                                          if(userauthlevel!.contains(widget.productModel!.catalogueList![index].catalogueauth) ){
                                                                                                            if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){

                                                                                                              _launchUrl(Uri.parse('${Provider.of<SplashProvider>(Get.context!, listen: false).baseUrls!.machineCataloguesUrl}/'
                                                          '${widget.productModel!.catalogueList![index].line}/'
                                                          '${widget.productModel!.catalogueList![index].machine}/'
                                                          '${widget.productModel!.catalogueList![index].catalogueoptions![i].cataloguepath}'));
                                                                                                            }
                                                                                                          }
                                                                                                          else
                                                                                                          {
                                                                                                            showCustomSnackBar('${getTranslated('no_auth', context)}', context);
                                                                                                          }

                                                                                                        }

                                                                                                        , child: Align(alignment: Alignment.center,
                                                                                                            child: Container(
                                                                                                                width: txtSize1.width+50, padding: const EdgeInsets.only(left: 1),
                                                                                                                height: 38, decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),
                                                                                                                color: Theme.of(context).primaryColor),
                                                                                                                alignment: Alignment.center,
                                                                                                                child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                          Text('${widget.productModel!.catalogueList![index].catalogueoptions![i].cataloguelang} ', maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: textRegular.copyWith(
                                                                fontSize: Dimensions.fontSizeLarge,
                                                                color: Colors.white,
                                                              )),
                                                          const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
                                                          SizedBox(width: Dimensions.iconSizeDefault,
                                                              child: Image.asset(Images.fileDownload, color: Theme.of(context).cardColor,))
                                                              ])))
                                                              ))
                                                          ),const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                                              ]),
                                                        );
                                                            }),
                                ),
                                 ])),
                    ],
                  );
              },
            ): const SizedBox(),
            /// machine_catalogue////////////


            const SizedBox(height: Dimensions.paddingSizeLarge),


            /// View Product data////////////
                widget.productModel!= null && widget.productModel?.productType =='digital' && widget.productModel!.productData!.isNotEmpty ?
            Column(children: [
              Padding(padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeExtraSmall),
                child: TitleRow(title: getTranslated('machine_data', context), isDetailsPage: true),),
              const SizedBox(height: 5),
              const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              ),
            ],
            ):const SizedBox(),

                widget.productModel!= null && widget.productModel?.productType =='digital' && widget.productModel!.productData!.isNotEmpty ?
            ListView.builder(
              shrinkWrap: true,
              physics: const  NeverScrollableScrollPhysics(),
              itemCount: widget.productModel!.productData!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: ExpansionTile(
                        shape:const RoundedRectangleBorder(),
                        title:
                        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          SizedBox(width: Dimensions.iconSizeDefault,
                              child: Image.asset(Images.view, color: Theme.of(context).primaryColor,)),
                          const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
                          Text(' ${widget.productModel!.productData![index].datatitle}', maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                        ]),
                        children: [
                         // Row(
                    Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,

                              children: [

                                Padding(
                                    padding: const EdgeInsets.all(2.0),
                                   // child: SizedBox(height: 45,
                                        child: SizedBox(height: 250,
                                      child:

                                      ListView.builder(
                                          shrinkWrap: true,
                                         //scrollDirection: Axis.horizontal,
                                          scrollDirection: Axis.vertical,
                                          //physics: const  NeverScrollableScrollPhysics(),
                                          physics: const  AlwaysScrollableScrollPhysics(),
                                          itemCount: widget.productModel!.productData![index].datalist!.length,
                                          itemBuilder: (context, i) {
                                            final Size txtSize = _textSize('${widget.productModel!.productData![index].datalist![i].imagesgroup}');
                                            //return  Card(color: Theme.of(context).cardColor, child: Column(children: [
                                           return Row(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               mainAxisAlignment: MainAxisAlignment.start,
                                               children: [

                                                 Padding(
                                                     padding: const EdgeInsets.all(2.0),
                                                     child:
                                               SizedBox(height: 45,
                                                         child:
                                                          Consumer<ProductDetailsProvider>(builder: (context, details, child) {
                                                            return InkWell(onTap : () async {
                                                              if(userauthlevel!.contains(widget.productModel!.productData![index].dataauth) ){
                                                                if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){

                                                                 Navigator.push(context, MaterialPageRoute(builder: (_) => ProductData(
                                                                      productId: widget.productModel?.id,productdataindexno:index,datalistindexno:i)));
                                                                }
                                                              }
                                                              else
                                                              {
                                                                showCustomSnackBar('${getTranslated('no_auth', context)}', context);
                                                              }

                                                            }, child: Align(alignment: Alignment.center,
                                                                child: Container(
                                                                    //width: 250, padding: const EdgeInsets.only(left: 1),
                                                                    width: txtSize.width+50, padding: const EdgeInsets.only(left: 1),
                                                                    height: 38, decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),
                                                                    color: Theme.of(context).primaryColor),
                                                                    alignment: Alignment.center,
                                                                    child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                      Text(' ${widget.productModel!.productData![index].datalist![i].imagesgroup} ', maxLines: 1,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style: textRegular.copyWith(
                                                                            fontSize: Dimensions.fontSizeLarge,
                                                                            color: Colors.white,
                                                                          )),
                                                                      const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
                                                                      SizedBox(width: Dimensions.iconSizeDefault,
                                                                          child: Image.asset(Images.view, color: Theme.of(context).cardColor,))
                                                                    ])))));
                                                          })
                                               ))]);
                                          }),
                                    ))
                          ]),
                        ]));
              },
            ): const SizedBox(),
            /// View Product data////////////

            const SizedBox(height: Dimensions.paddingSizeLarge),

          ]);
        },
      ),
    ):const SizedBox();
  }

}


Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}


Size _textSize(String text) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.white,)), maxLines: 1, textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}
