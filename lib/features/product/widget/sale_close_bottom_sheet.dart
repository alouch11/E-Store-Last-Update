
import 'dart:io';
import 'package:flutter_spareparts_store/features/sale/view/sale_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class SaleCloseBottomSheet extends StatefulWidget {
  final int? saleId;
  const SaleCloseBottomSheet({super.key, required this.saleId});

  @override
  SaleCloseBottomSheetState createState() => SaleCloseBottomSheetState();
}

class SaleCloseBottomSheetState extends State<SaleCloseBottomSheet> {

  final TextEditingController _servicePlaceReasonController = TextEditingController();

  final TextEditingController _startDateController= TextEditingController();
  final TextEditingController _endDateController= TextEditingController();

  //final TextEditingController _startDateController1= TextEditingController();
  //final TextEditingController _endDateController1= TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool? duringProduction=false;

  String startDate = "";
  String startTime = "";

  DateTime? startDateTime1;
  DateTime? endDateTime1;

  String startDateSelected = "";
  String startTimeSelected = "";
  String endDateSelected = "";
  String endTimeSelected = "";
  String duration ="";


  @override
  Widget build(BuildContext context) {

    Provider.of<SaleProvider>(context, listen: false).getServiceInfo(widget.saleId);
    return Scaffold(appBar: AppBar(backgroundColor: Theme.of(context).cardColor,
      centerTitle: true,
      leading: IconButton(icon: Icon(Icons.arrow_back_ios_new, color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop()),
        title:
         Text(getTranslated(Provider.of<SaleProvider>(context, listen: false).sales!.alreadyServiced == null ? 'close_service' : 'view_service_details', context)!,
            style: titilliumRegular.copyWith(fontSize: 20,
          color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black,),
          maxLines: 1, overflow: TextOverflow.ellipsis)),

      body: SingleChildScrollView(
        child: Consumer<SaleProvider>(
            builder: (context,serviceClose,_) {
              return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

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
                        _startDateController.text=getFormattedDateTimeSimple(startDateTime.millisecondsSinceEpoch);
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
                            _endDateController.text=getFormattedDateTimeSimple(endDateTime.millisecondsSinceEpoch);
                            endDateSelected = getFormattedDateSimple(endDateTime.millisecondsSinceEpoch);
                            endTimeSelected = getFormattedTimeSimple(endDateTime.millisecondsSinceEpoch);
                            endDateTime1 = endDateTime;

                          });
                        },
                      )),     ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child:
                        CheckboxListTile(
                          title:Text(getTranslated('during_production', context)!),
                          value: duringProduction,
                          onChanged: (newValue) {
                                 setState(() {
                                   duringProduction = newValue;
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
                        child:
                        /*CustomTextField(
                          maxLines: _servicePlaceReasonController.text.length >30 ?(_servicePlaceReasonController.text.length.toInt()/15).round(): 4,
                          controller: _servicePlaceReasonController,
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
                  maxLines: _servicePlaceReasonController.text.length >30 ?(_servicePlaceReasonController.text.length.toInt()/15).round(): 10,
                  controller: _servicePlaceReasonController,
                  textInputAction: TextInputAction.newline)

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


                      Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: InkWell(onTap: () => Provider.of<SaleProvider>(context, listen: false).pickImage(false),
                          child: SizedBox(height: 30,
                              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                  Text(getTranslated('upload_image', context)!),
                                  const SizedBox(width: Dimensions.paddingSizeDefault),
                                  Image.asset(Images.uploadImage)])))),

                  serviceClose.isLoading ?

                  const Center(child: CircularProgressIndicator(),) :

                  Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: CustomButton(
                          buttonText: getTranslated('close_service', context),
                          onTap: () {
                            String servicePlace  = _servicePlaceReasonController.text.trim().toString();
                             int? duringProduction1= duringProduction==true?1:0;

                              if(startDateSelected.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(getTranslated('start_date_required', context)!),
                                  backgroundColor: Colors.red));
                            }
                              if(endDateSelected.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(getTranslated('end_date_required', context)!),
                                  backgroundColor: Colors.red));
                            }
                            //DateTime dt1 = DateTime.parse(startDateSelected);
                           // DateTime dt2 = DateTime.parse(endDateSelected);
                            DateTime dt1 = startDateTime1!;
                            DateTime dt2 = endDateTime1!;
                              if(dt1.compareTo(dt2) > 0){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(getTranslated('end_date_great_than_start_date', context)!),
                                  backgroundColor: Colors.red));
                            }

                              if(startDateTime1 != null || endDateTime1 != null) {
                            duration=hoursBetween(startDateTime1!,endDateTime1!);
                             }

                            if(servicePlace.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text(getTranslated('service_place_required', context)!),
                                backgroundColor: Colors.red));
                            }

                            //else {
                              if(dt1.compareTo(dt2) <= 0 && servicePlace.isNotEmpty && startDateSelected.isNotEmpty && endDateSelected.isNotEmpty){
                              serviceClose.serviceClose(context, widget.saleId,startDateSelected,startTimeSelected,endDateSelected,endTimeSelected,duration,duringProduction1,servicePlace,
                                  Provider.of<AuthController>(context, listen: false).getUserToken()).then((value) {
                                if(value.statusCode==200 ){
                                  serviceClose.getServiceInfo(widget.saleId);
                                  //Provider.of<SaleProvider>(context, listen: false).setIndex(2, notify: false);
                                  Provider.of<SaleProvider>(context, listen: false).setIndex(4, notify: false);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  showCustomSnackBar(getTranslated('successfully_close_service', context), context, isError: false);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SaleDetailsScreen(saleId: widget.saleId)));

                                  Provider.of<SaleProvider>(context, listen: false).scrollControllerService.animateTo(Provider.of<SaleProvider>(context, listen: false).scrollControllerService.position.maxScrollExtent,
                                      duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
                                }
                              }
                              );
                            }
                          },
                        ),
                      ),

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
    //DateFormat newFormat = DateFormat("yyyy-MM-dd HH:mm");
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
