import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/basewidget/custom_textfield.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:flutter_spareparts_store/features/product/widget/sale_close_bottom_sheet.dart';
import 'package:flutter_spareparts_store/features/product/widget/sale_close_bottom_sheet1.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/features/sale/view/service_image_screen.dart';
import 'package:flutter_spareparts_store/features/sale/widget/service_details_dialog.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/localization/provider/localization_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../domain/model/sale_model.dart';



class ServiceWidget extends StatelessWidget {
  final Sales? saleModel;
  const ServiceWidget({super.key, this.saleModel});

  @override
  Widget build(BuildContext context) {


    return Scaffold(appBar: AppBar(backgroundColor: Theme.of(context).cardColor,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new, color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black),
            onPressed: () => Navigator.of(context).pop()),
        title:
        Text(getTranslated(Provider.of<SaleProvider>(context, listen: false).sales!.alreadyServiced == null ? 'close_service' : 'view_service_details', context)!,
            style: titilliumRegular.copyWith(fontSize: 20,
              color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black,),
            maxLines: 1, overflow: TextOverflow.ellipsis),

      actions: [
        IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SaleCloseBottomSheet1(saleModel: saleModel)));
            }
        )
      ],
    ),


    body: SingleChildScrollView(
      child: Column(children: [
          Container(
            decoration: BoxDecoration(color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow:  [BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],),

            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(width: Dimensions.paddingSizeLarge),


                Expanded(flex: 5,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault), color: Theme.of(context).cardColor),
                        width: MediaQuery.of(context).size.width,
                       // padding: const EdgeInsets.all(Dimensions.homePagePadding),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Align(alignment: Alignment.centerLeft,
                              child: Text(getTranslated('start_date', context)!,
                                  style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.black))),
                          CustomTextField(
                            maxLines: 1,
                            isEnabled:false,
                            labelText: '${DateFormat("yyyy-MM-dd").format(DateTime.parse(saleModel!.startDate!))} ${DateFormat("HH:mm").format(DateTime.parse(saleModel!.startTime!))}',
                          ),
                        ],
                        ),
                      ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault), color: Theme.of(context).cardColor),
                      width: MediaQuery.of(context).size.width,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Align(alignment: Alignment.centerLeft,
                            child: Text(getTranslated('end_date', context)!,
                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.black))),
                        CustomTextField(
                          maxLines: 1,
                          isEnabled:false,
                          labelText: '${DateFormat("yyyy-MM-dd").format(DateTime.parse(saleModel!.endDate!))} ${DateFormat("HH:mm").format(DateTime.parse(saleModel!.endTime!))}',

                        ),
                      ],
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault), color: Theme.of(context).cardColor),
                      width: MediaQuery.of(context).size.width,
                      // padding: const EdgeInsets.all(Dimensions.homePagePadding),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Align(alignment: Alignment.centerLeft,
                            child: Text(getTranslated('duration', context)!,
                              style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.black))),
                        CustomTextField(
                          maxLines: 1,
                          isEnabled:false,
                          labelText:saleModel!.duration,
                        ),
                      ],
                      ),
                    ),


                    CheckboxListTile(
                      title:Text(getTranslated('during_production', context)!),
                        value:saleModel!.duringProduction  ==0 ?false:true,
                      enabled: false,
                      onChanged: (newValue) {
                      },
                      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                    ),

                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault), color: Theme.of(context).cardColor),
                      width: MediaQuery.of(context).size.width,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Align(alignment: Alignment.centerLeft,
                            child: Text(getTranslated('service_details', context)!,
                                style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                        CustomTextField(
                          maxLines: 4,
                          isEnabled:false,
                          labelText:saleModel!.servicePlace,
                        ),
                      ],
                      ),
                    ),


                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    if(saleModel!.attachments!=null)
                      Padding(padding: EdgeInsets.only(left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Dimensions.homePagePadding:0,
                          right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0:Dimensions.homePagePadding, bottom: Dimensions.paddingSizeLarge),
                        child:

                        InkWell(
                          child: SizedBox(
                            height: saleModel!.attachments!.length.toDouble() /2 * 150,
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing:0.2,mainAxisSpacing: 0.2,),
                              itemCount:saleModel!.attachments?.length,

                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                    child: Center(
                                      child:  Stack(alignment: Alignment.topRight, children: [
                                        ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                          child: CustomImage(height: 70, width: 70,
                                              image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.serviceImagesUrl}/'
                                                  '${saleModel!.attachments![index]}'
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (_) => ServiceImageScreen(title: saleModel!.attachments![index], image: saleModel!.attachments![index],url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.serviceImagesUrl)
                                    );
                                  },
                                );
                              },),
                          ),
                        ),

                      ),


                  ])),

              ]),
            ),
          ),


        ],
      ),
    ));
  }
}
