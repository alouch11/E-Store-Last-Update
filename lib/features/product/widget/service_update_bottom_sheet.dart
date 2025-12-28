import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/lines_model.dart';
import 'package:flutter_spareparts_store/features/lines/provider/lines_provider.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/add_product_section_widget.dart';
import 'package:flutter_spareparts_store/features/sale/domain/model/sale_model.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/features/sale/view/service_image_screen.dart';
import 'package:flutter_spareparts_store/features/sale/widget/delete_service_bottom_sheet.dart';
import 'package:flutter_spareparts_store/features/sale/widget/icon_with_text_row.dart';
import 'package:flutter_spareparts_store/features/sale/widget/sale_details_top_portion_widget.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
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
import 'package:flutter_spareparts_store/utill/styles.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';




class ServiceUpdateBottomSheet extends StatefulWidget {
  final Sales? serviceModel;
  final int? servicenamid;
  const ServiceUpdateBottomSheet({super.key, required this.serviceModel,this.servicenamid});

  @override
  ServiceUpdateBottomSheetState createState() => ServiceUpdateBottomSheetState();
}

class ServiceUpdateBottomSheetState extends State<ServiceUpdateBottomSheet> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  bool isEdit= true;
  bool isCancel= false;

  TextEditingController? _startDateController;
  TextEditingController? _endDateController;
  bool? _duringProductionController;
  TextEditingController? _servicePlaceReasonController;

  //String _serviceLineController="";
  //TextEditingController? _serviceMachineController;

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


  // this will help to show the widget after
 // bool isLineSelected = false;
 // bool isMachineSelected = false;


  //LinesMachinesModel? _lines;
 // List<MachinesGroup>? _machines=[];

 // List<String> _type =[];
  final _type =Provider.of<SplashProvider>(Get.context!, listen: false).serviceTypeFilter!.split(',');
  // these will be the values after selection of the item
  //String? selectedline ;
  //String? selectedmachine;
  String? selectedServiceType;

  //String? selectedValue ;



  @override
  void initState() {


    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _servicePlaceReasonController = TextEditingController();
    _durationController = TextEditingController();

    //_serviceLineController = TextEditingController();
    //_serviceMachineController = TextEditingController();

    if(widget.serviceModel != null) {
    _startDateController!.text = '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.serviceModel!.startDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.serviceModel!.startTime!))}';
    _endDateController!.text = '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.serviceModel!.endDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.serviceModel!.endTime!))}';
    _servicePlaceReasonController!.text =widget.serviceModel!.servicePlace!;
    _duringProductionController=widget.serviceModel!.duringProduction==1?true:false;
    _durationController!.text=widget.serviceModel!.duration!;
     serviceImage=widget.serviceModel!.attachments!;

   // selectedline =widget.serviceModel!.department!;
    //selectedtype = widget.serviceModel!.saleType ;
    }

    setState(() {
      //_lines =Provider.of<LinesProvider>(context, listen: false).linesMachinesGroupModelBk;
     // selectedline =widget.serviceModel!.department ;
      selectedServiceType = widget.serviceModel!.saleType ;
    });

    super.initState();
  }

  @override
  void dispose() {
    _startDateController!.dispose();
    _endDateController!.dispose();
    _servicePlaceReasonController!.dispose();
    //_serviceLineController!.dispose();
    //_serviceMachineController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Theme.of(context).cardColor,
      centerTitle: true,
      leading: IconButton(icon: Icon(Icons.arrow_back_ios_new, color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop()),
        title:
         Column(
           children: [
             Text(getTranslated(isCancel ? 'update_service' : 'view_service_details', context)!,
                style: titilliumRegular.copyWith(fontSize: 20,
              color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black,),
              maxLines: 1, overflow: TextOverflow.ellipsis),
             const SizedBox(height: 20),
             Consumer<SaleProvider>(builder: (context, saleProvider, _) {
              return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center, children: [
                  RichText(text: TextSpan(
                    text: '${getTranslated('service', context)}# ',
                    //text: 'BK-PO- ',
                    style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeDefault), children:[
                    TextSpan(text: widget.serviceModel!.saleNumber,
                        style: textBold.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeLarge)),
                  ],
                  ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall,),

                  RichText(text: TextSpan(
                      text: getTranslated('your_service_is', context),
                      style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getHint(context)),
                      children:[
                        TextSpan(text: ' ${getTranslated('${widget.serviceModel!.saleStatus}', context)}',
                            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                                color:
                                widget.serviceModel!.saleStatus == '4'? ColorResources.getGrey(context) :
                                widget.serviceModel!.saleStatus == '2'? ColorResources.getGreen(context) :
                                widget.serviceModel!.saleStatus == '8'? ColorResources.getCheris(context) :
                                widget.serviceModel!.saleStatus == '10'? ColorResources.getYellow1(context) :
                                widget.serviceModel!.saleStatus == '11'? ColorResources.getCheris(context) :
                                widget.serviceModel!.saleStatus == '1'? ColorResources.getYellow(context) :
                                widget.serviceModel!.saleStatus == '5'? ColorResources.getFloatingBtn(context) :
                                ColorResources.getGreen(context)
                            ))]),),
                  const SizedBox(height: Dimensions.paddingSizeSmall,),

                  Text(DateConverter.localDateToIsoStringAMPMOrder(DateTime.parse(widget.serviceModel!.createdAt!)),
                      style: titilliumRegular.copyWith(color: ColorResources.getHint(context),
                          fontSize: Dimensions.fontSizeSmall)),

                  Padding(padding:  const EdgeInsets.only(top: Dimensions.paddingSizeSmall),//,left: MediaQuery.of(context).size.width * .65),
                    child: Row(children: [
                      Text( getTranslated('created_by', context)!,  style: titilliumRegular.copyWith(color: ColorResources.getHint(context), fontSize: Dimensions.fontSizeSmall)),
                      const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
                       Text(widget.serviceModel!.createdBy!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color:ColorResources.red)),
                    ],
                    ),
                  ),
                ],
                ),
              ]);

            }
            ),

           ],
         ),

          actions: [
            Column(
              children: [
                (widget.serviceModel != null && widget.serviceModel!.saleStatus != '2' && (widget.serviceModel!.customerId! == Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.id))?
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
              ],
            ),

            Column(
              children: [
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
                          _startDateController!.text = '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.serviceModel!.startDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.serviceModel!.startTime!))}';
                          _endDateController!.text = '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.serviceModel!.endDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.serviceModel!.endTime!))}';
                          _servicePlaceReasonController!.text =widget.serviceModel!.servicePlace!;
                          _duringProductionController=widget.serviceModel!.duration =="1"?true:false;
                          selectedServiceType = widget.serviceModel!.saleType!;
                        });
                      },
                    )),
              ],
            ),

            (widget.serviceModel != null && widget.serviceModel!.saleStatus != '2' && (widget.serviceModel!.customerId! == Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.id))?
            Column(
              children: [
                Visibility(
                    visible: isEdit,
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete_forever_rounded,size: 25,
                        color:  Colors.red,
                      ),
                      onPressed: () {
                       showModalBottomSheet(backgroundColor: Colors.transparent,
                            context: context, builder: (_)=>  DeleteServiceBottomSheet(serviceId: widget.serviceModel!.id!));
                      },
                    )),
              ],
            ):const SizedBox(),
    ],

      ),

      body: SingleChildScrollView(
        child: Consumer<SaleProvider>(
            builder: (context,saleProvider,_) {
              return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),

                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

                      const SizedBox(height: Dimensions.paddingSizeDefault),


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
                                      text: '${widget.serviceModel != null ? widget.serviceModel!.department : ''}')),

                                ]),


                                Row(children: [
                                  Expanded(child: IconWithTextRow(
                                      icon: Icons.list_alt_rounded,
                                      text: '${widget.serviceModel != null ? widget.serviceModel!.machine : ''}')),
                                ]),

                                Row(children: [
                                  Expanded(child: IconWithTextRow(
                                      icon: Icons.person,
                                      text: '${widget.serviceModel != null ? widget.serviceModel!.serviceman : ''}')),
                                ]),


                                Row(children: [
                                  Expanded(child: IconWithTextRow(
                                      icon: Icons.task,
                                      text: '${widget.serviceModel != null ? widget.serviceModel!.saleType: ''}')),
                                ]),


                              ],
                              ),

                              const SizedBox(height: Dimensions.paddingSizeDefault),
                            ],
                            ),

                          ),

                        )
                    ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),


                AddProductSectionWidget(
                    title: getTranslated('general', context)!,
                    childrens: [
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(getTranslated('type', context)! , style: robotoRegular.copyWith(
                                color: ColorResources.primaryColor, fontSize: Dimensions.fontSizeDefault)),
                            Text('*',style: robotoBold.copyWith(color: ColorResources.primaryColor,
                                fontSize: Dimensions.fontSizeDefault),),
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                            border: Border.all(width: 1, color:isCancel ? ColorResources.primaryColor:ColorResources.hintTextColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only( top: 12,bottom: 12),
                            child: IgnorePointer(
                                ignoring:  isEdit,
                                child: DropdownButton<String>(
                                    elevation: 10,
                                    menuMaxHeight: 250,
                                    dropdownColor:ColorResources.homeBg,
                                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                    underline: Container(),
                                    // hint: const Text("Select Line", style: TextStyle(color: ColorResources.hintTextColor)),
                                    hint:  Text(widget.serviceModel!.saleType!, style:  TextStyle(color: isCancel ? ColorResources.black:ColorResources.hintTextColor)),
                                    icon:  Icon(Icons.keyboard_arrow_down,color: isCancel ? ColorResources.primaryColor:ColorResources.hintTextColor),
                                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor),
                                    isDense: true,
                                    isExpanded: true,
                                    items:_type.map(
                                          (String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(maxLines: 1, item, style: const TextStyle(color: ColorResources.black)),
                                      ),
                                    ).toList(),
                                    value: selectedServiceType,
                                    onChanged: (value){
                                      setState(() {
                                        selectedServiceType = value!;

                                      });
                                    })),
                          ),

                        ),
                      ],
                    ),
                  ),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                ]),

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
                    enabled:isCancel,
                    controller: _startDateController,
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
                        if(startDateTime == null) return;
                        _startDateController!.text=getFormattedDateTimeSimple(startDateTime.millisecondsSinceEpoch);
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
                        controller: _endDateController,
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
                         /* final DateTime? endDateTime =
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
                            if(endDateTime == null) return;
                            _endDateController!.text=getFormattedDateTimeSimple(endDateTime.millisecondsSinceEpoch);
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
                        child:
                        /*CustomTextField(
                          borderColor: isCancel ? ColorResources.primaryColor:ColorResources.hintTextColor,
                          maxLines: 4,
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
                  textInputAction: TextInputAction.newline)
                    ),


                if(widget.serviceModel!.attachments != null && widget.serviceModel!.attachments!= [] ? widget.serviceModel!.attachments!.isNotEmpty: false)
                    Padding(padding: EdgeInsets.only(left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Dimensions.homePagePadding:0,
                        right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0:Dimensions.homePagePadding, bottom: Dimensions.paddingSizeLarge),
                      child: InkWell(
                        child: SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: serviceImage.length,
                            itemBuilder: (BuildContext context, index){
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
                                                  //'${widget.serviceModel!.attachments![index]}'
                                                  '${serviceImage[index]}'
                                          ))),

                                  onTap: () async {
                                final res = await http.get(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).
                                //baseUrls!.serviceImagesUrl}/${widget.serviceModel!.attachments![index]}'));
                                baseUrls!.serviceImagesUrl}/${serviceImage[index]}'));
                                if (res.statusCode == 200) {
                                  await showDialog(
                                  context: context,
                                 builder: (_) => ServiceImageScreen(title: serviceImage[index], image: serviceImage[index],url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.serviceImagesUrl)

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
                  ]),

                  widget.serviceModel!.saleStatus!='2'&& isCancel?
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
                          buttonText:getTranslated(widget.serviceModel!.alreadyServiced!=1 ? 'send_request' : 'update', context)!,
                          onTap: () {

                            String startDate = _startDateController!.text.trim();
                            String endDate = _endDateController!.text.trim();
                            int? duringProduction= _duringProductionController==true?1:0;
                            String servicePlace  = _servicePlaceReasonController!.text.trim().toString();
                            //String line =_serviceLineController.trim().toString();
                            //String machine = _serviceMachineController!.text.trim().toString();
                            String serviceType = selectedServiceType!;
                            DateTime dt1 = DateTime.parse(_startDateController!.text);
                            DateTime dt2 = DateTime.parse(_endDateController!.text);

                            if(isCancel){
                              if (
                                  '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.serviceModel!.startDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.serviceModel!.startTime!))}' == startDate
                                  && '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.serviceModel!.endDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.serviceModel!.endTime!))}' == endDate
                                  && widget.serviceModel!.servicePlace == servicePlace
                                  && widget.serviceModel!.duringProduction == duringProduction
                                  && saleProvider.serviceImage.isEmpty
                                  && widget.serviceModel!.saleType == serviceType
                                  ) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(getTranslated('change_something', context)!), backgroundColor: ColorResources.red));
                              }

                             else if(startDate.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(getTranslated('start_date_required', context)!),
                                  backgroundColor: Colors.red));
                            }
                             else if(endDate.isEmpty) {
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

                           else if(dt1.compareTo(dt2) <= 0 && servicePlace.isNotEmpty && startDate.isNotEmpty && endDate.isNotEmpty){
                                saleProvider.serviceUpdate(
                                    context, widget.serviceModel!.id,
                                    DateFormat("yyyy-MM-dd").format(DateTime.parse(startDate)),
                                    DateFormat("HH:mm").format(DateTime.parse(startDate)),
                                    DateFormat("yyyy-MM-dd").format(DateTime.parse(endDate)),
                                    DateFormat("HH:mm").format(DateTime.parse(endDate)),
                                    duration,duringProduction,
                                    servicePlace,
                                    serviceType,
                                  Provider.of<AuthController>(context, listen: false).getUserToken()).then((value) {
                                if(value.statusCode==200 ){
                                  Provider.of<SaleProvider>(context, listen: false).setIndex(4, notify: false);
                                  Navigator.pop(context);
                                  //Navigator.pop(context);
                                  _startDateController!.clear();
                                  _endDateController!.clear();
                                  _servicePlaceReasonController!.clear();
                                  _durationController!.clear();
                                   showCustomSnackBar(getTranslated(widget.serviceModel!.alreadyServiced!=1 ?'successfully_close_service': 'successfully_update_service', context), context, isError: false);
                                }
                              }
                              );
                            }
                          }},
                        ),
                      ):const SizedBox(),


                    ]),
              );
            }
        ),
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