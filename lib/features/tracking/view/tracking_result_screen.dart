import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/tracking/widget/line_dashed_painter.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:provider/provider.dart';

class TrackingResultScreen extends StatefulWidget {
  final String orderID;
  const TrackingResultScreen({super.key, required this.orderID});


  @override
  State<TrackingResultScreen> createState() => _TrackingResultScreenState();
}

class _TrackingResultScreenState extends State<TrackingResultScreen> {

  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false).initTrackingInfo(widget.orderID);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<String> statusList = ['1','7','5','6','2'];

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('TRACK_ORDER', context)),
      body: Column(children: [


          Expanded(child: Consumer<OrderProvider>(
              builder: (context, tracking, child) {
                String? status = tracking.trackingModel != null ? tracking.trackingModel!.orderStatus : '';
                String? ordernumber = tracking.trackingModel!.orderNumber;
                return tracking.trackingModel != null?
                ListView( children: [

                  Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Center(child: RichText(text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: '${getTranslated('your_order', context)}: ', style: textBold.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),

                          TextSpan(text:ordernumber, style: textBold.copyWith(color: Theme.of(context).primaryColor)),
                ])))),

                  CustomStepper(title: getTranslated('order_placed', context), icon: Images.orderIdIcon, checked: true,
                      dateTime: tracking.trackingModel!.createdAt,createdBy: tracking.trackingModel!.createdBy!,modifiedBy:null),

                  CustomStepper(icon: Images.signed, title: '${getTranslated('order_is_signed', context)}',
                      checked: (status == statusList[1] || status == statusList[2] ||status == statusList[3] || status == statusList[4]),createdBy: null,modifiedBy:null),

                  CustomStepper(title: '${getTranslated('order_confirmed', context)}', icon: Images.orderConfirmedIcon,
                   checked: (status == statusList[2] ||status == statusList[3] || status == statusList[4]),createdBy: null,modifiedBy:null),


                  CustomStepper(icon: Images.partiallyDeliveryIcon, title: '${getTranslated('order_is_partially_delivered', context)}',
                     checked: (status == statusList[3] || status == statusList[4]), dateTime:  status == statusList[3] ? tracking.trackingModel!.accDate:null,accDoc: status == statusList[3] ?tracking.trackingModel!.accDocNumber:null,createdBy: status == statusList[3] ?tracking.trackingModel!.orderDelivery!.delivery!.createdBy:null),

                  CustomStepper(icon: Images.deliveredIcon, title: '${getTranslated('order_delivered', context)}',
                     checked: (status == statusList[4] ), isLastItem: true, dateTime:  tracking.trackingModel!.accDate,accDoc: tracking.trackingModel!.accDocNumber,createdBy:  status == statusList[4] ?tracking.trackingModel!.orderDelivery!.delivery!.createdBy:null,modifiedBy:  status == statusList[4] ?tracking.trackingModel!.orderDelivery!.delivery!.modifiedBy:null),
                ],
                ): const Center(child: CircularProgressIndicator(),);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomStepper extends StatelessWidget {
  final String? title;
  final bool isLastItem;
  final String icon;
  final bool checked;
  final String? dateTime;
  final String? accDoc;
  final String? createdBy;
  final String? modifiedBy;
  const CustomStepper({super.key, required this.title,
    this.isLastItem = false, required this.icon, this.checked = false, this.dateTime, this.accDoc, this.createdBy, this.modifiedBy});

  @override
  Widget build(BuildContext context) {
    Color myColor;
    if (checked) {
      myColor = Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.white  : Theme.of(context).primaryColor;
    } else {
      myColor = Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor.withOpacity(.75) : Theme.of(context).hintColor;
    }
    return Container(height:modifiedBy != null || createdBy != null ? 165:100,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [

                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      color: Theme.of(context).primaryColor.withOpacity(.075)),
                    child: SizedBox(height: 30,child: Image.asset(icon, color: myColor)),)),

                Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  checked?
                    Text(title!, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor)):
                    Text(title!, style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).hintColor)),
                    if(dateTime != null && checked)
                    Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                      child: Row(children: [
                          SizedBox(height: 20, child: Image.asset(Images.dateTimeIcon,color: Theme.of(context).hintColor)),
                          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                          Text(DateConverter.dateTimeStringToDateAndTime(dateTime!), style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        ],
                      ),
                    ),
                  if(accDoc != null && checked)
                    Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                      child: Row(children: [
                        SizedBox(height: 20, child: Image.asset(Images.orderImage,color: Theme.of(context).hintColor)),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Text(accDoc!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                      ],
                      ),
                    ),

                  if(createdBy != null && checked)
                    Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                      child: Row(children: [
                        SizedBox(height: 20, child: Text('${getTranslated('created_by', context)} :',style: titilliumRegular.copyWith(color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeSmall))),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Text(createdBy!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color:Colors.red)),
                      ],
                      ),
                    ),
                  if(modifiedBy != null && checked)
                    Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                      child: Row(children: [
                        SizedBox(height: 20, child: Text('${getTranslated('modified_by', context)} :',style: titilliumRegular.copyWith(color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeSmall))),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Text(modifiedBy!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color:Colors.red)),
                      ],
                      ),
                    ),
                  ],
                )]),

              isLastItem ? const SizedBox.shrink() :
              Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall, left: 35),
                child: CustomPaint(painter: LineDashedPainter(myColor))),

              /*createdBy == null ? const SizedBox.shrink() :
              const SizedBox(height: 50,)*/
            ],
            ),
          ),
          if(checked)
          Padding(padding: const EdgeInsets.all(8.0),
            child: SizedBox(child: Icon(CupertinoIcons.checkmark_alt_circle_fill, color: Theme.of(context).primaryColor))),

        ],
      ),
    );
  }
}
