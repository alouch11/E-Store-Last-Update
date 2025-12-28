import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/basewidget/custom_textfield.dart';
import 'package:flutter_spareparts_store/basewidget/delete_account_bottom_sheet.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/product/widget/sale_close_bottom_sheet1.dart';
import 'package:flutter_spareparts_store/features/product/widget/service_update_bottom_sheet.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/add_product_section_widget.dart';
import 'package:flutter_spareparts_store/features/sale/widget/delete_service_bottom_sheet.dart';
import 'package:flutter_spareparts_store/features/sale/widget/icon_with_text_row.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/localization/provider/localization_provider.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../home/shimmer/order_details_shimmer.dart';
import 'service_image_screen.dart';
import 'package:http/http.dart' as http;


class ServiceDetailsScreen extends StatefulWidget {
  final int? serviceId;
  const ServiceDetailsScreen({super.key, required this.serviceId,});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {

   TextEditingController? _servicePlaceReasonController;

  void _loadData(BuildContext context) async {

      await Provider.of<SaleProvider>(Get.context!, listen: false).getServiceFromServiceId(widget.serviceId.toString());

      _servicePlaceReasonController = TextEditingController();
      _servicePlaceReasonController!.text = Provider.of<SaleProvider>(context, listen: false).service!.servicePlace!;

  }

  @override
  void initState() {
    _loadData(context);
   // _servicePlaceReasonController = TextEditingController();
    // _servicePlaceReasonController!.text = Provider.of<SaleProvider>(context, listen: false).service!.servicePlace!;

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (val) async{
      },
      child: Scaffold(
        appBar: AppBar(elevation: 1, backgroundColor: Theme.of(context).cardColor,
            toolbarHeight: 120,
          //leadingWidth: 0,
          automaticallyImplyLeading: false,
            title:  Consumer<SaleProvider>(builder: (context, serviceProvider, child) {

              return
                serviceProvider.service != null?
                Stack(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center, children: [
                    RichText(text: TextSpan(
                      text: '${getTranslated('service', context)}# ',
                      //text: 'BK-PO- ',
                      style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeDefault), children:[
                      TextSpan(text: serviceProvider.service!.saleNumber,
                          style: textBold.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeLarge)),
                    ],
                    ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall,),

                    RichText(text: TextSpan(
                        text: getTranslated('your_service_is', context),
                        style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getHint(context)),
                        children:[
                          TextSpan(text: ' ${getTranslated('${serviceProvider.service?.saleStatus}', context)}',
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                                  color:
                                  //serviceProvider.service?.saleStatus == '4'? ColorResources.getGrey(context) :
                                  serviceProvider.service?.saleStatus == '4'? ColorResources.getRed(context) :
                                  serviceProvider.service?.saleStatus == '2'? ColorResources.getGreen(context) :
                                  serviceProvider.service?.saleStatus == '8'? ColorResources.getCheris(context) :
                                  serviceProvider.service?.saleStatus == '10'? ColorResources.getCheris(context) :
                                  serviceProvider.service!.saleStatus == '1'? ColorResources.getYellow(context) :
                                  serviceProvider.service!.saleStatus == '5'? ColorResources.getFloatingBtn(context) :
                                  ColorResources.getGreen(context)

                              ))]),),
                    const SizedBox(height: Dimensions.paddingSizeSmall,),

                    Text(DateConverter.localDateToIsoStringAMPMOrder(DateTime.parse(serviceProvider.service!.createdAt!)),
                        style: titilliumRegular.copyWith(color: ColorResources.getHint(context),
                            fontSize: Dimensions.fontSizeSmall)),

                    Padding(padding:  const EdgeInsets.only(top: Dimensions.paddingSizeSmall),//,left: MediaQuery.of(context).size.width * .65),
                      child: Row(children: [
                        //SizedBox(height: 14,width: 14, child: Image.asset(Images.profile,color:Colors.red)),
                        Text( getTranslated('created_by', context)!,  style: titilliumRegular.copyWith(color: ColorResources.getHint(context), fontSize: Dimensions.fontSizeSmall)),
                        const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
                        Text(serviceProvider.service!.createdBy!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color:ColorResources.red)),
                      ],
                      ),
                    ),
                                  ],
                                  ),
                                ],
                                ),
                    InkWell(onTap: (){
                        Navigator.pop(context);

                    }, child: const Padding(padding: EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault),
                        child: Icon(CupertinoIcons.back)))
                  ],
                ): const SizedBox();
              },
        ),


          /*actions: [
            (widget.servicenamid! == Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.id)?
            InkWell(
              onTap: () => showModalBottomSheet(backgroundColor: Colors.transparent,
                  context: context, builder: (_)=>  DeleteServiceBottomSheet(serviceId: widget.serviceId!)),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0,top: 10.0),
                  child: Container(alignment: Alignment.center,height: 20,child: Image.asset(Images.delete)),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault,),
              ],),
            ):const SizedBox()
          ],*/
        ),

          body: Consumer<SaleProvider>(builder: (context, serviceProvider, child) {

            return ( serviceProvider.service != null) ?
              ListView(padding: const EdgeInsets.all(0), children: [

                    Container(height: 10, color: Theme.of(context).primaryColor.withOpacity(.1)),

                    Container(decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage(Images.mapBg), fit: BoxFit.cover)),
                        child: Card(margin: const EdgeInsets.all(Dimensions.marginSizeDefault),
                          child: Padding(padding: const EdgeInsets.all(Dimensions.homePagePadding),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              IconWithTextRow(
                                  icon: Icons.list_alt,
                                  iconColor: Theme.of(context).primaryColor,
                                  text: getTranslated('service_info', context)!,
                                  textColor: Theme.of(context).primaryColor),

                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                const Divider(),

                                Row(children: [
                                  // Expanded(child: Text(getTranslated('vendor', context)!)),
                                  Expanded(child: Text(getTranslated('machine', context)!)),
                                ]),
                                const SizedBox(height: Dimensions.marginSizeSmall),


                                Row(children: [
                                  Expanded(child: IconWithTextRow(
                                      icon: Icons.factory,
                                      text: '${serviceProvider.service != null ? serviceProvider.service!.department : ''}')),
                                ]),


                                Row(children: [
                                  Expanded(child: IconWithTextRow(
                                      icon: Icons.list_alt_rounded,
                                      text: '${serviceProvider.service != null ? serviceProvider.service!.machine : ''}')),
                                ]),

                                Row(children: [
                                  Expanded(child: IconWithTextRow(
                                      icon: Icons.person,
                                      text: '${serviceProvider.service != null ? serviceProvider.service!.serviceman : ''}')),
                                ]),


                                Row(children: [
                                  Expanded(child: IconWithTextRow(
                                      icon: Icons.task,
                                      text: '${serviceProvider.service != null ? serviceProvider.service!.saleType: ''}')),
                                ]),


                              ],
                              ),

                              const SizedBox(height: Dimensions.paddingSizeDefault),
                            ],
                            ),

                          ),

                        )
                    ),

                AddProductSectionWidget(
                  //title: getTranslated('Dates And Times', context)!,
                    title: 'Dates And Times',
                    childrens: [
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      Padding(padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraSmall,
                          horizontal: Dimensions.paddingSizeDefault),
                        child: Container(decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeSmall),
                            border: Border.all(color: Theme
                                .of(context)
                                .primaryColor
                                .withOpacity(.25))),
                          child:
                           SizedBox(
                              height: 50.0,
                              child:TextField(
                                enabled:false,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: '${DateFormat("yyyy-MM-dd").format(DateTime.parse(serviceProvider.service!.startDate!))} ${DateFormat("HH:mm").format(DateTime.parse(serviceProvider.service!.startTime!))}',
                                  filled: true,
                                  prefixIcon: const Icon(Icons.calendar_today,color: Color(0xff0461A5),),
                                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                                  focusedBorder:  const OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                                ),
                                readOnly:true,
                              )),     ),
                      ),

                      Padding(padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraSmall,
                          horizontal: Dimensions.paddingSizeDefault),
                        child: Container(decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeSmall),
                            border: Border.all(color: Theme
                                .of(context)
                                .primaryColor
                                .withOpacity(.25))),
                          child:
                           SizedBox(
                              height: 50.0,
                              child:
                              TextField(
                                enabled:false,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: '${DateFormat("yyyy-MM-dd").format(DateTime.parse(serviceProvider.service!.endDate!))} ${DateFormat("HH:mm").format(DateTime.parse(serviceProvider.service!.endDate!))}',
                                  filled: true,
                                  prefixIcon: const Icon(Icons.calendar_today,color: Color(0xff0461A5),),
                                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                                  focusedBorder:  const OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                                ),
                                readOnly:true,

                              )),     ),
                      ),

                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child:
                          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault), ),
                            width: MediaQuery.of(context).size.width,
                            // padding: const EdgeInsets.all(Dimensions.homePagePadding),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Align(alignment: Alignment.centerLeft,
                                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                      child:Text(getTranslated('duration', context)!,
                                          style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.black)))),
                              CustomTextField(
                                maxLines: 1,
                                isEnabled:false,
                                labelText:serviceProvider.service!.duration
                              ),
                            ],
                            ),
                          )),


                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child:
                          CheckboxListTile(
                            title:Text(getTranslated('during_production', context)!),
                            value: serviceProvider.service!.duringProduction == 1 ? true:false,
                            enabled: false,
                            onChanged: (newValue) {
                            },
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          )

                      ),

                    ]),




                AddProductSectionWidget(
                  //title: getTranslated('Dates And Times', context)!,
                    title: 'Service Details',
                    childrens: [
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child: Row(children: [
                            Text(getTranslated('service_place', context)!, style: textRegular),
                            Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 30)])),


                      Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: CustomTextField(
                              borderColor: ColorResources.hintTextColor,
                              maxLines: 10,
                              //titleText: serviceProvider.service!.servicePlace,
                              controller:_servicePlaceReasonController,

                              isEnabled: false,
                              inputAction: TextInputAction.done)),

                      if(serviceProvider.service!.attachments != null && serviceProvider.service!.attachments!= [] ? serviceProvider.service!.attachments!.isNotEmpty: false)
                        Padding(padding: EdgeInsets.only(left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Dimensions.homePagePadding:0,
                            right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0:Dimensions.homePagePadding, bottom: Dimensions.paddingSizeLarge),
                          child: InkWell(
                            child: SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: serviceProvider.service!.attachments!.length,
                                itemBuilder: (BuildContext context, index){
                                  return  serviceProvider.service!.attachments!.isNotEmpty?
                                  Padding(padding: const EdgeInsets.all(8.0),
                                    child: Stack(children: [

                                      InkWell(
                                        child:
                                        Container(width: 100, height: 100,
                                            decoration: const BoxDecoration(color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(20))),
                                            child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault)),
                                                child: CustomImage(height: 70, width: 70,
                                                    image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.serviceImagesUrl}/'
                                                    //'${widget.serviceModel!.attachments![index]}'
                                                        '${serviceProvider.service!.attachments![index]}'
                                                ))),

                                        onTap: () async {
                                          final res = await http.get(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).
                                          baseUrls!.serviceImagesUrl}/${serviceProvider.service!.attachments![index]}'));
                                          if (res.statusCode == 200) {
                                            await showDialog(
                                                context: context,
                                                builder: (_) => ServiceImageScreen(title: serviceProvider.service!.attachments![index], image: serviceProvider.service!.attachments![index],url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.serviceImagesUrl)

                                            );
                                          }
                                          else {
                                            showCustomSnackBar('${getTranslated('no_image', context)}', context);
                                          }
                                        },
                                      ),
                                    ],
                                    ),
                                  ):const SizedBox();
                                },),
                            ),

                          ),

                        ),
                    ]),


         /*       ///View Service details
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                (serviceProvider.service != null && (serviceProvider.service!.alreadyServiced == 1)) ?
                CustomButton(textColor: ColorResources.white,
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(1),
                    buttonText: getTranslated('view_service_details', context),
                    onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ServiceUpdateBottomSheet(serviceModel: serviceProvider.service)))) :
                   const SizedBox(width: Dimensions.paddingSizeSmall),*/

                      ],
                      ) : const OrderDetailsShimmer();
                    },
        )
      ),
    );
  }


static String getFormattedDateSimple(int date) {
DateFormat newFormat = DateFormat("yyyy-MM-dd");
return newFormat.format(DateTime.fromMillisecondsSinceEpoch(date));
}
static String getFormattedTimeSimple(int time) {
DateFormat newFormat = DateFormat("HH:mm");
return newFormat.format(DateTime.fromMillisecondsSinceEpoch(time));
}

static String getFormattedDateTimeSimple(int datetime) {
DateFormat newFormat = DateFormat("yyyy-MM-dd HH:mm");
return newFormat.format(DateTime.fromMillisecondsSinceEpoch(datetime));
}

String hoursBetween(DateTime from, DateTime to) {
from = DateTime(from.year, from.month, from.day ,from.hour,from.minute);
to = DateTime(to.year, to.month, to.day,to.hour,to.minute);
Duration difference = to.difference(from);
int days = difference.inDays;
int hours = difference.inHours % 24;
int minutes = difference.inMinutes % 60;
String totalDifference="$days days $hours hours $minutes minutes";
return totalDifference;
}

}