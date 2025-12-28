import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/features/product/widget/service_image_screen.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/sale/domain/model/sale_model.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/localization/provider/localization_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/basewidget/custom_textfield.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';

import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class SaleCloseBottomSheet1 extends StatefulWidget {
  final Sales? saleModel;
  const SaleCloseBottomSheet1({super.key, required this.saleModel});

  @override
  SaleCloseBottomSheet1State createState() => SaleCloseBottomSheet1State();
}

class SaleCloseBottomSheet1State extends State<SaleCloseBottomSheet1> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  bool isEdit= true;
  bool isCancel= false;

  TextEditingController? _startDateController;
  TextEditingController? _endDateController;

  TextEditingController? _startDateController1;
  TextEditingController? _endDateController1;

  bool? _duringProductionController;
  TextEditingController? _servicePlaceReasonController;
  TextEditingController? _durationController;
  List<String> serviceImage = [];

  String startDate = "";
 String startTime = "";

  DateTime? startDateTime1;
  DateTime? endDateTime1;

  String startDateSelected = "";
  String startTimeSelected = "";
  String endDateSelected = "";
  String endTimeSelected = "";
  String duration ="";

  String? serviceNumber;
  String? serviceStatus;
  String? createdBy;


  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();

    _startDateController1 = TextEditingController();
    _endDateController1 = TextEditingController();

    _servicePlaceReasonController = TextEditingController();
    _durationController = TextEditingController();

   _startDateController1!.text = '${DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.saleModel!.startDate!))} ${DateFormat("hh:mm a").format(DateTime.parse(widget.saleModel!.startTime!))}';
    _endDateController1!.text = '${DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.saleModel!.endDate!))} ${DateFormat("hh:mm a").format(DateTime.parse(widget.saleModel!.endTime!))}';

    _startDateController!.text = '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.saleModel!.startDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.saleModel!.startTime!))}';
    _endDateController!.text = '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.saleModel!.endDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.saleModel!.endTime!))}';

    _servicePlaceReasonController!.text =widget.saleModel!.servicePlace!;
    // ignore: unrelated_type_equality_checks
    _duringProductionController=widget.saleModel!.duringProduction==1?true:false;
    _durationController!.text=widget.saleModel!.duration!;

    serviceImage=widget.saleModel!.attachments!;

    serviceNumber= widget.saleModel!.saleNumber;
    serviceStatus= widget.saleModel!.saleStatus;
    createdBy= widget.saleModel!.createdBy;
  }

  @override
  void dispose() {
    _startDateController!.dispose();
    _endDateController!.dispose();

    _startDateController1!.dispose();
    _endDateController1!.dispose();

    _servicePlaceReasonController!.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

   // Provider.of<SaleProvider>(context, listen: false).getServiceInfo(widget.saleModel!.id);



    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(elevation: 1, backgroundColor: Theme.of(context).cardColor,
        toolbarHeight: 120,   automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(icon: Icon(Icons.arrow_back_ios_new, color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop()),
        title:Column(
             children: [
               Text(getTranslated(isCancel ? 'update_service_details' : 'view_service_details', context)!,
                  style: titilliumRegular.copyWith(fontSize: 20,
                color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black,),
                maxLines: 1, overflow: TextOverflow.ellipsis),
               const SizedBox(height: Dimensions.paddingSizeSmall,),
               Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                 Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center, children: [
                   RichText(text: TextSpan(
                     text: '${getTranslated('service', context)}# ',
                     style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeDefault), children:[
                     TextSpan(text: serviceNumber,
                         style: textBold.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeLarge)),
                   ],
                   ),
                   ),
                   const SizedBox(height: Dimensions.paddingSizeSmall,),

                   RichText(text: TextSpan(
                       text: getTranslated('your_service_is', context),
                       style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getHint(context)),
                       children:[
                         TextSpan(text: ' ${getTranslated('$serviceStatus', context)}',
                             style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                                 color:
                                 serviceStatus == '4'? ColorResources.getGrey(context) :
                                 serviceStatus == '2'? ColorResources.getGreen(context) :
                                 serviceStatus == '8'? ColorResources.getCheris(context) :
                                 serviceStatus == '10'? ColorResources.getYellow1(context) :
                                 serviceStatus == '11'? ColorResources.getCheris(context) :
                                 serviceStatus == '1'? ColorResources.getYellow(context) :
                                 serviceStatus == '5'? ColorResources.getFloatingBtn(context) :
                                 ColorResources.getGreen(context)

                             ))]),),

                   Padding(padding:  const EdgeInsets.only(top: Dimensions.paddingSizeSmall),//,left: MediaQuery.of(context).size.width * .65),
                     child: Row(children: [
                       //SizedBox(height: 14,width: 14, child: Image.asset(Images.profile,color:Colors.red)),
                       Text( getTranslated('created_by', context)!,  style: titilliumRegular.copyWith(color: ColorResources.getHint(context), fontSize: Dimensions.fontSizeSmall)),
                       const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
                       Text(createdBy!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color:ColorResources.red)),
                     ],
                     ),
                   ),
                 ],
                 ),
               ],
               ),

             ],
           ),


          actions: [
            (widget.saleModel!.saleStatus != '2' && (widget.saleModel!.serviceman! == Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.userServiceName))?
            Visibility(
                visible: isEdit,
                child: IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color:  Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      isEdit=false;
                      isCancel=true;
                    });
                   // Navigator.of(context).pop();
                  },
                )):const SizedBox(),

            Visibility(
                visible: isCancel,
                child: IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color:  Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      isEdit=true;
                      isCancel=false;
                      _startDateController1!.text = '${DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.saleModel!.startDate!))} ${DateFormat("hh:mm a").format(DateTime.parse(widget.saleModel!.startTime!))}';
                      _endDateController1!.text = '${DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.saleModel!.endDate!))} ${DateFormat("hh:mm a").format(DateTime.parse(widget.saleModel!.endTime!))}';

                      _startDateController!.text = '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.saleModel!.startDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.saleModel!.startTime!))}';
                      _endDateController!.text = '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.saleModel!.endDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.saleModel!.endTime!))}';

                      _servicePlaceReasonController!.text =widget.saleModel!.servicePlace!;
                      _duringProductionController=widget.saleModel!.duration==1?true:false;
                    });
                   // Navigator.of(context).pop();
                  },
                )),

    ],
      ),

      body: SingleChildScrollView(
        child: Consumer<SaleProvider>(
            builder: (context,saleProvider,_) {
              return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                 // const SizedBox(height: Dimensions.paddingSizeSmall),


                  /*Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center, children: [
                      RichText(text: TextSpan(
                        //text: '${getTranslated('sale_order', context)}# ',
                        text: '${getTranslated('service', context)}# ',
                        //text: 'BK-PO- ',
                        style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeDefault), children:[
                        //TextSpan(text: saleProvider.sales?.id.toString(),
                        TextSpan(text: saleProvider.sales!.saleNumber,
                            style: textBold.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeLarge)),
                      ],
                      ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall,),

                      RichText(text: TextSpan(
                          text: getTranslated('your_service_is', context),
                          style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getHint(context)),
                          children:[
                            TextSpan(text: ' ${getTranslated('${saleProvider.sales?.saleStatus}', context)}',
                                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                                    color:
                                    saleProvider.sales?.saleStatus == '4'? ColorResources.getGrey(context) :
                                    //saleProvider.sales?.saleStatus == 'delivered'? ColorResources.getGreen(context) :
                                    saleProvider.sales?.saleStatus == '2'? ColorResources.getGreen(context) :
                                    saleProvider.sales?.saleStatus == '8'? ColorResources.getCheris(context) :
                                    saleProvider.sales?.saleStatus == '10'? ColorResources.getCheris(context) :
                                    saleProvider.sales!.saleStatus == '1'? ColorResources.getYellow(context) :
                                    saleProvider.sales!.saleStatus == '5'? ColorResources.getFloatingBtn(context) :
                                    ColorResources.getGreen(context)

                                ))]),),

                      Padding(padding:  const EdgeInsets.only(top: Dimensions.paddingSizeSmall),//,left: MediaQuery.of(context).size.width * .65),
                        child: Row(children: [
                          //SizedBox(height: 14,width: 14, child: Image.asset(Images.profile,color:Colors.red)),
                          Text( getTranslated('created_by', context)!,  style: titilliumRegular.copyWith(color: ColorResources.getHint(context), fontSize: Dimensions.fontSizeSmall)),
                          const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
                          Text(saleProvider.sales!.createdBy!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color:ColorResources.red)),
                        ],
                        ),
                      ),
                    ],
                    ),
                  ],
                  ),*/
                      const SizedBox(height: Dimensions.paddingSizeDefault),





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
                    enabled:isCancel,
                    controller: _startDateController1,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      labelText: "Start Date Time",
                      hintText: "Select Start Date Time",
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_today,color: Color(0xff0461A5),),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                      focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                    ),
                    readOnly:true,
                    onTap: () async {
                      /*final DateTime? startDateTime =
                      await showOmniDateTimePicker(
                          minutesInterval: 5,context: context);*/

                      DateTime? startDate =await pickDate();
                      if (startDate==null) return;

                      TimeOfDay? starTime =await pickTime();
                      if (starTime==null) return;
                      final startDateTime=DateTime(
                          startDate.year,
                          startDate.month,
                          startDate.day,
                          starTime.hour,
                          starTime.minute
                      ) ;

                      setState(() {
                        _startDateController!.text=getFormattedDateTimeSimple(startDateTime.millisecondsSinceEpoch);
                        _startDateController1!.text=getFormattedDateTimeSimple1(startDateTime.millisecondsSinceEpoch);
                        startDateSelected = getFormattedDateSimple(startDateTime.millisecondsSinceEpoch);
                        startTimeSelected = getFormattedTimeSimple(startDateTime.millisecondsSinceEpoch);
                        startDateTime1 = startDateTime;

                      });
                    },
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
                        controller: _endDateController1,
                        enabled:isCancel,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          labelText: "End Date Time",
                          hintText: "Select End Date Time",
                          filled: true,
                          prefixIcon: Icon(Icons.calendar_today,color: Color(0xff0461A5),),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                          focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                        ),
                        readOnly:true,
                        onTap: () async {
                          /*final DateTime? endDateTime =
                          await showOmniDateTimePicker(
                              minutesInterval: 5,context: context);*/

                          DateTime? endDate =await pickDate();
                          if (endDate==null) return;

                          TimeOfDay? endTime =await pickTime();
                          if (endTime==null) return;
                          final endDateTime=DateTime(
                              endDate.year,
                              endDate.month,
                              endDate.day,
                              endTime.hour,
                              endTime.minute
                          ) ;

                          setState(() {
                            //if(endDateTime == null) return;
                            _endDateController!.text=getFormattedDateTimeSimple(endDateTime.millisecondsSinceEpoch);
                            _endDateController1!.text=getFormattedDateTimeSimple1(endDateTime.millisecondsSinceEpoch);
                            endDateSelected = getFormattedDateSimple(endDateTime.millisecondsSinceEpoch);
                            endTimeSelected = getFormattedTimeSimple(endDateTime.millisecondsSinceEpoch);
                            endDateTime1 = endDateTime;

                          });
                        },
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
                        labelText:_durationController!.text.trim(),
                      ),
                    ],
                    ),
                  )),


                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child:
                        CheckboxListTile(
                          title:Text(getTranslated('during_production', context)!),
                          value: _duringProductionController,
                          enabled: isCancel,
                          onChanged: (newValue) {
                                 setState(() {
                                   _duringProductionController = newValue;
                             });
                                 },
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          )

                      ),



                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                        child: Row(children: [
                              Text(getTranslated('service_place', context)!, style: textRegular),
                             Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 30)])),


                    Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: /*CustomTextField(
                              borderColor: Theme.of(context).hintColor,
                            //  maxLines: 10,
                           maxLines: _servicePlaceReasonController!.text.length >30 ?(_servicePlaceReasonController!.text.length.toInt()/15).round(): 4,
                          controller: _servicePlaceReasonController,
                          isEnabled: isCancel,
                          inputAction: TextInputAction.done)*/
                        TextField(
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Theme.of(context).primaryColor,
                                    width: .75,)),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Theme.of(context).primaryColor,//widget.borderColor,
                                    width: .75,)),

                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color:Theme.of(context).primaryColor,
                                    width: .75,)),

                              fillColor: Theme.of(context).cardColor,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            // maxLines: null ,
                            maxLines: _servicePlaceReasonController!.text.length >30 ?(_servicePlaceReasonController!.text.length.toInt()/15).round(): 10,
                            controller: _servicePlaceReasonController,
                            enabled: isCancel,
                            //textInputAction: TextInputAction.newline
                            textInputAction: TextInputAction.none,
                             //keyboardType: TextInputType.multiline,
                        )
                    ),


                if(widget.saleModel!.attachments != null && widget.saleModel!.attachments!= "[]" ? widget.saleModel!.attachments!.isNotEmpty: false)
                    Padding(padding: EdgeInsets.only(left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Dimensions.homePagePadding:0,
                        right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0:Dimensions.homePagePadding, bottom: Dimensions.paddingSizeLarge),
                      child: InkWell(
                        child: SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            //itemCount: widget.saleModel!.attachments?.length,
                            itemCount: serviceImage.length,
                            itemBuilder: (BuildContext context, index){
                             // return  widget.saleModel!.attachments!.isNotEmpty?
                              return  serviceImage.isNotEmpty?
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
                                                  //'${widget.saleModel!.attachments![index]}'
                                                  '${serviceImage[index]}'
                                          ))),

                                  onTap: () async {
                                final res = await http.get(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).
                                //baseUrls!.serviceImagesUrl}/${widget.saleModel!.attachments![index]}'));
                                baseUrls!.serviceImagesUrl}/${serviceImage[index]}'));
                                if (res.statusCode == 200) {

                                  Provider.of<SaleProvider>(context, listen: false).setImageSliderSelectedIndex(index);
                                 /* await showDialog(
                                  context: context,
                                  builder: (_) => ServiceImageScreen(title: serviceImage[index], image: serviceImage[index],url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.serviceImagesUrl)

                                  ); */

                                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>ServiceImagesScreen(title: getTranslated('images', context), imageList: serviceImage,)));

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


                  Consumer<SaleProvider>(
                          builder: (context, serviceProvider,_) {
                            return serviceProvider.serviceImage.isNotEmpty?
                            SizedBox(height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: serviceProvider.serviceImage.length,
                                itemBuilder: (BuildContext context, index){
                                  return  serviceProvider.serviceImage.isNotEmpty?
                                  Padding(padding: const EdgeInsets.all(8.0),
                                    child: Stack(children: [
                                        Container(width: 100, height: 100,
                                          decoration: const BoxDecoration(color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                          child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault)),
                                            child: Image.file(File(serviceProvider.serviceImage[index]!.path), width: 100, height: 100,
                                              fit: BoxFit.cover))),
                                        Positioned(top:0,right:0,
                                          child: InkWell(onTap :() => serviceProvider.removeImage(index),
                                            child: Container(decoration: BoxDecoration(
                                                color: Theme.of(context).hintColor,
                                                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault))),
                                                child: const Padding(padding: EdgeInsets.all(4.0),
                                                  child: Icon(Icons.clear,color: Colors.white,size: Dimensions.iconSizeExtraSmall))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ):const SizedBox();
                                },),
                            ):const SizedBox();
                          }
                      ),

                  widget.saleModel!.saleStatus!='2'&& isCancel?
                      Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: InkWell(onTap: () => isCancel?Provider.of<SaleProvider>(context, listen: false).pickImage(false):'',
                          child: SizedBox(height: 30,
                              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                  Text(getTranslated('upload_image', context)!),
                                  const SizedBox(width: Dimensions.paddingSizeDefault),
                                  Image.asset(Images.uploadImage)])))):const SizedBox(),

                  saleProvider.isLoading ?

                  const Center(child: CircularProgressIndicator(),) :

                      isCancel?
                  Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: CustomButton(
                          buttonText:getTranslated(widget.saleModel!.alreadyServiced!=1 ? 'close_service' : 'update', context)!,
                          onTap: () {

                            String startDate_1 = _startDateController!.text.trim();
                            String endDate_1 = _endDateController!.text.trim();

                            //DateTime startDate_1 =  DateFormat("dd/MM/yyyy hh:mm a").parse(_endDateController!.text.trim());
                            //DateTime endDate_1 = DateFormat("dd/MM/yyyy hh:mm a").parse(_endDateController!.text.trim());


                            int? duringProduction= _duringProductionController==true?1:0;
                            String servicePlace  = _servicePlaceReasonController!.text.trim().toString();

                            DateTime dt1 = DateTime.parse(_startDateController!.text);
                            DateTime dt2 = DateTime.parse(_endDateController!.text);


                            if(isCancel){
                             // if ('${DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.saleModel!.startDate!))} ${DateFormat("hh:mm a").format(DateTime.parse(widget.saleModel!.startTime!))}' == startDate_1
                                //&& '${DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.saleModel!.endDate!))} ${DateFormat("hh:mm a").format(DateTime.parse(widget.saleModel!.endTime!))}' == endDate_1
                              if ('${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.saleModel!.startDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.saleModel!.startTime!))}' == startDate_1
                            && '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.saleModel!.endDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.saleModel!.endTime!))}' == endDate_1

                            && saleProvider.sales!.servicePlace == servicePlace
                                  && saleProvider.sales!.duringProduction == duringProduction
                                  && saleProvider.serviceImage.isEmpty
                                  ) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(getTranslated('change_something', context)!), backgroundColor: ColorResources.red));
                              }

                             else if(startDate_1.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(getTranslated('start_date_required', context)!),
                                  backgroundColor: Colors.red));
                            }
                             else if(endDate_1.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(getTranslated('end_date_required', context)!),
                                  backgroundColor: Colors.red));
                            }
                            else if(dt1.compareTo(dt2) > 0){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(getTranslated('end_date_great_than_start_date', context)!),
                                  backgroundColor: Colors.red));
                            }

                            else if(servicePlace.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text(getTranslated('service_place_required', context)!),
                                backgroundColor: Colors.red));
                            }

                           else if(dt1.compareTo(dt2) <= 0 && servicePlace.isNotEmpty && startDate_1.isNotEmpty && endDate_1.isNotEmpty){
                                saleProvider.serviceClose(context, widget.saleModel!.id,
                                    DateFormat("yyyy-MM-dd").format(DateTime.parse(startDate_1)),
                                    DateFormat("HH:mm").format(DateTime.parse(startDate_1)),
                                    DateFormat("yyyy-MM-dd").format(DateTime.parse(endDate_1)),
                                    DateFormat("HH:mm").format(DateTime.parse(endDate_1)),

                                   /* getFormattedDateSimple(DateTime.parse(_startDateController!.text).millisecondsSinceEpoch),
                                    getFormattedTimeSimple(DateTime.parse(_startDateController!.text).millisecondsSinceEpoch),
                                    getFormattedDateSimple(DateTime.parse(_endDateController!.text).millisecondsSinceEpoch),
                                    getFormattedTimeSimple(DateTime.parse(_endDateController!.text).millisecondsSinceEpoch),*/

                                     /*DateFormat("dd/MM/yyyy").format(DateTime.parse(startDate_1)),
                                     DateFormat("hh:mm a").format(DateTime.parse(startDate_1)),
                                     DateFormat("dd/MM/yyyy").format(DateTime.parse(endDate_1)),
                                     DateFormat("hh:mm a").format(DateTime.parse(endDate_1)),*/

                                    //DateFormat("dd/MM/yyyy hh:mm a").parse(_endDateController!.text.trim());

                                    duration,duringProduction,
                                    servicePlace,
                                     Provider.of<AuthController>(context, listen: false).getUserToken()).then((value) {
                                if(value.statusCode==200 ){
                                  Provider.of<SaleProvider>(context, listen: false).setIndex(4, notify: false);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  _startDateController!.clear();
                                  _endDateController!.clear();
                                  _startDateController1!.clear();
                                  _endDateController1!.clear();
                                  _servicePlaceReasonController!.clear();
                                  _durationController!.clear();

                                   showCustomSnackBar(getTranslated(widget.saleModel!.alreadyServiced!=1 ?'successfully_close_service': 'successfully_update_service', context), context, isError: false);
                                }
                              }
                              );
                            }
                          }},
                        ),
                      ):const SizedBox(),


/*
                 Container(
                    margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                    child: isCancel?
                    CustomButton(onTap: _updateService,
                      buttonText: getTranslated('update', context),) : const SizedBox(),
                  )*/


                    ]),
              );
            }
        ),
      ),
    );
  }


  static String getFormattedDateSimple(int date) {
    DateFormat newFormat = DateFormat("yyyy-MM-dd");
    //DateFormat newFormat = DateFormat("dd/MM/yyyy");
    return newFormat.format(DateTime.fromMillisecondsSinceEpoch(date));
  }
  static String getFormattedTimeSimple(int time) {
    DateFormat newFormat = DateFormat("HH:mm");
    //DateFormat newFormat = DateFormat("hh:mm a");
    return newFormat.format(DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getFormattedDateTimeSimple(int datetime) {
      DateFormat newFormat = DateFormat("yyyy-MM-dd HH:mm");
      //DateFormat newFormat = DateFormat("dd/MM/yyyy hh:mm a");
    return newFormat.format(DateTime.fromMillisecondsSinceEpoch(datetime));
  }
  static String getFormattedDateTimeSimple1(int datetime) {
    DateFormat newFormat = DateFormat("dd/MM/yyyy hh:mm a");
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
  Future<DateTime?> pickDate() => showDatePicker(
    context:context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),

  );

  Future<TimeOfDay?> pickTime() => showTimePicker(
    context:context,
    initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),

  );
}