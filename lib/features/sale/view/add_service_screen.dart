
import 'dart:io';
import 'package:flutter_spareparts_store/features/lines/domain/model/lines_model.dart';
import 'package:flutter_spareparts_store/features/lines/provider/lines_provider.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/sale/addService/widgets/add_product_section_widget.dart';
import 'package:flutter_spareparts_store/features/sale/domain/model/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class AddServiceScreen extends StatefulWidget {
  final ServiceModel? serviceModel;
  const AddServiceScreen({super.key, this.serviceModel});

  @override
  AddServiceScreenState createState() => AddServiceScreenState();
}

class AddServiceScreenState extends State<AddServiceScreen> {

   TextEditingController _servicePlaceReasonController = TextEditingController();

   TextEditingController _startDateController= TextEditingController();
   TextEditingController _endDateController= TextEditingController();
   bool? _duringProductionController;

   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool? duringProduction=false;

  String startDate = "";
  String startTime = "";

   DateTime? dateTime;
  DateTime? startDateTime1;
  DateTime? endDateTime1;

  String startDateSelected = "";
  String startTimeSelected = "";
  String endDateSelected = "";
  String endTimeSelected = "";
  String duration ="";

  LinesMachinesModel? _lines;
  List<MachinesGroup>? _machines=[];
   //final List<String>? _type=['Mechanical','Electrical','Repair'];
   final _type =Provider.of<SplashProvider>(Get.context!, listen: false).serviceTypeFilter!.split(',');

// these will be the values after selection of the item
  String? selectedline;
  String? selectedmachine;
  String? selectedtype;

  // this will help to show the widget after
  bool isLineSelected = false;
  bool isMachineSelected = false;

  bool isEdit= true;
  bool isCancel= false;


  TextEditingController? _durationController;
  List<String> serviceImage = [];

  @override
  void initState() {

    //setState(() {
      _lines =Provider.of<LinesProvider>(context, listen: false).linesMachinesGroupModelBk;
   // });


    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _servicePlaceReasonController = TextEditingController();
    _durationController = TextEditingController();

    if(widget.serviceModel != null) {
      _startDateController.text = '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.serviceModel!.startDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.serviceModel!.startTime!))}';
      _endDateController.text = '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.serviceModel!.endDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.serviceModel!.endTime!))}';
      _servicePlaceReasonController.text = widget.serviceModel!.servicePlace!;
      _duringProductionController =
      widget.serviceModel!.duringProduction == 1 ? true : false;
      _durationController!.text = widget.serviceModel!.duration!;
      serviceImage = widget.serviceModel!.attachments!;
    }


    super.initState();
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _servicePlaceReasonController.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

   Provider.of<LinesProvider>(context, listen: false).getLinesMachinesGroupList("Bekoko");

    return Scaffold(
     key: _scaffoldKey,

      appBar: AppBar(backgroundColor: Theme.of(context).cardColor,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new, color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black),
              /*onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();

                  }
                  else{
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const SaleScreen()));
                  }
              Navigator.pop(context);
            }*/
            onPressed: () =>  Navigator.pop(context)
            ),
        title:
        Text(getTranslated(isCancel ? 'update_service' : 'add_service', context)!,
            style: titilliumRegular.copyWith(fontSize: 20,
              color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black,),
            maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [

         widget.serviceModel != null?
          (widget.serviceModel!.serviceStatus != '2' && (widget.serviceModel!.serviceman! == Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.userServiceName ))?
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
              )):const SizedBox():const SizedBox(),

          widget.serviceModel != null ?
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
                    _startDateController.text = '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.serviceModel!.startDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.serviceModel!.startTime!))}';
                    _endDateController.text = '${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.serviceModel!.endDate!))} ${DateFormat("HH:mm").format(DateTime.parse(widget.serviceModel!.endTime!))}';
                    _servicePlaceReasonController.text =widget.serviceModel!.servicePlace!;
                    _duringProductionController=widget.serviceModel!.duration =="1" ?true:false;
                  });
                  // Navigator.of(context).pop();
                },
              )):const SizedBox(),

        ],
      ),


      body: SingleChildScrollView(
        child: Consumer<SaleProvider>(
            builder: (context,serviceClose,_) {
              return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

                  AddProductSectionWidget(
                    title: getTranslated('general', context)!,
                    childrens: [
                       Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(getTranslated('lines', context)! , style: robotoRegular.copyWith(
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
                                  border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only( top: 12,bottom: 12),
                                  child: DropdownButton<String>(
                                       elevation: 10,
                                       menuMaxHeight: 250,
                                      dropdownColor:ColorResources.homeBg,
                                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                      underline: Container(),
                                      hint: const Text("Select Line", style: TextStyle(color: ColorResources.hintTextColor)),
                                      icon:  Icon(Icons.keyboard_arrow_down,color: ColorResources.primaryColor),
                                      style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor),
                                      isDense: true,
                                      isExpanded: true,
                                      items: _lines!.linesmachines!.map((ln){
                                        return DropdownMenuItem<String>(
                                          value: ln.lineName,
                                          child: Text(maxLines: 1, ln.lineName!, style: const TextStyle(color: ColorResources.black)),
                                        );
                                      }).toList(),
                                      value: selectedline,
                                      onChanged: (value){
                                        setState(() {
                                          _machines = [];
                                          selectedmachine=null;
                                          selectedline = value!;
                                          for(int i =0; i<_lines!.linesmachines!.length; i++){
                                            if(_lines!.linesmachines![i].lineName == value){
                                              _machines = _lines!.linesmachines![i].machinesGroup!;
                                            }
                                          }
                                          isLineSelected = true;
                                        });
                                      }),
                                ),

                              ),
                            ],
                          ),
                      ),

                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(getTranslated('machines', context)! , style: robotoRegular.copyWith(
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
                                border: Border.all(width: 1, color: isLineSelected ?  ColorResources.blue:ColorResources.hintTextColor ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only( top: 12,bottom: 12),
                                child: DropdownButton<String>(
                                    elevation: 10,
                                    menuMaxHeight: 250,
                                    dropdownColor:ColorResources.homeBg,
                                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                    underline: Container(),
                                    hint:  const Text( "Select Machine", style: TextStyle(color: ColorResources.hintTextColor),
                                    ),
                                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor),
                                    icon: Icon(Icons.keyboard_arrow_down,color:isLineSelected ?  ColorResources.blue:ColorResources.hintTextColor),
                                    isDense: true,
                                    isExpanded: true,
                                    items: _machines!.map((mch){
                                      return DropdownMenuItem<String>(
                                        value: mch.machineName,
                                        child: Text(maxLines: 1, mch.machineName!, style: const TextStyle(color: ColorResources.black)),
                                      );
                                    }).toList(),
                                    value: selectedmachine,
                                    onChanged: (value){
                                      setState(() {
                                        selectedmachine = value!;
                                      });
                                    }),
                              ),

                            ),
                          ],
                        ),
                      ),

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
                                border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only( top: 12,bottom: 12),
                                child: DropdownButton<String>(
                                    elevation: 10,
                                    menuMaxHeight: 250,
                                    dropdownColor:ColorResources.homeBg,
                                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                    underline: Container(),
                                    hint: const Text("Select Type", style: TextStyle(color: ColorResources.hintTextColor)),
                                    icon:  Icon(Icons.keyboard_arrow_down,color: ColorResources.primaryColor),
                                    isDense: true,
                                    isExpanded: true,
                                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor),
                                    items: _type.map((type){
                                      return DropdownMenuItem<String>(
                                        value: type,
                                        child: Text(maxLines: 1, type, style: const TextStyle(color: ColorResources.black)),
                                      );
                                    }).toList(),
                                    value: selectedtype,
                                    onChanged: (value){
                                      setState(() {
                                        selectedtype = value!;
                                        }
                                      );
                                    }),
                              ),

                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                    ],
                  ),




              AddProductSectionWidget(
                title: getTranslated('dates_and_times', context)!,

              childrens: [
                const SizedBox(height: Dimensions.paddingSizeSmall),

                  Padding(
                    padding: const EdgeInsets.only(left:12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Start Date Time' , style: robotoRegular.copyWith(
                                color: ColorResources.primaryColor, fontSize: Dimensions.fontSizeDefault)),
                            Text('*',style: robotoBold.copyWith(color: ColorResources.primaryColor,
                                fontSize: Dimensions.fontSizeDefault),),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeExtraSmall,
                        horizontal: Dimensions.paddingSizeDefault),
                                      child: Container(decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                      Dimensions.paddingSizeSmall),
                                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.25))),
                                      child:
                                       SizedBox(
                                        height: 50.0,
                                        child:TextField(
                                           controller: _startDateController,
                                           textAlign: TextAlign.left,
                                        decoration: const InputDecoration(
                            //labelText: "Start Date Time",
                             hintText: "Select Start Date Time",
                            filled: true,
                            //prefixIcon: Icon(Icons.calendar_today,color: Color(0xff0461A5),),
                            suffixIcon: Icon(Icons.calendar_today,color: Color(0xff0461A5),),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                            focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                          ),
                          readOnly:true,
                          onTap: () async {
                            /* final DateTime? startDateTime =
                            await showOmniDateTimePicker(
                                minutesInterval: 5,
                                context: context);*/

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
                              //if(startDateTime == null) return;
                              _startDateController.text=getFormattedDateTimeSimple(startDateTime.millisecondsSinceEpoch);
                              startDateSelected = getFormattedDateSimple(startDateTime.millisecondsSinceEpoch);
                              startTimeSelected = getFormattedTimeSimple(startDateTime.millisecondsSinceEpoch);
                              startDateTime1 = startDateTime;

                            });
                          },
                        )
                                       ),     ),
                                      ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('End Date Time' , style: robotoRegular.copyWith(
                                color: ColorResources.primaryColor, fontSize: Dimensions.fontSizeDefault)),
                            Text('*',style: robotoBold.copyWith(color: ColorResources.primaryColor,
                                fontSize: Dimensions.fontSizeDefault),),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeExtraSmall,
                            horizontal: Dimensions.paddingSizeDefault),
                          child: Container(decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.paddingSizeSmall),
                              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.25))),
                            child:
                            SizedBox(
                              height: 50.0,
                              child:
                            TextField(
                              controller: _endDateController,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                //labelText: "End Date Time",
                                hintText: "Select End Date Time",
                                filled: true,
                                //prefixIcon: Icon(Icons.calendar_today,color: Color(0xff0461A5),),
                                suffixIcon: Icon(Icons.calendar_today,color: Color(0xff0461A5),),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                                focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0461A5)),),
                              ),
                              readOnly:true,
                              onTap: () async {
                                //final DateTime? endDateTime =
                                /* await showOmniDateTimePicker(
                                    minutesInterval: 5,
                                    context: context);*/
                                //await pickDateTime();


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
                                  _endDateController.text=getFormattedDateTimeSimple(endDateTime.millisecondsSinceEpoch);
                                  endDateSelected = getFormattedDateSimple(endDateTime.millisecondsSinceEpoch);
                                  endTimeSelected = getFormattedTimeSimple(endDateTime.millisecondsSinceEpoch);
                                  endDateTime1 = endDateTime;

                                });
                              },
                            )),     ),
                        ),
                      ],
                    ),
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

            ]),

            AddProductSectionWidget(
            //title: getTranslated('Dates And Times', context)!,
            title: 'Service Details',
              childrens: [
                const SizedBox(height: Dimensions.paddingSizeSmall),

                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                        child: Row(children: [
                             Text(getTranslated('service_place', context)! , style: robotoRegular.copyWith(
                              color: ColorResources.primaryColor, fontSize: Dimensions.fontSizeDefault)),
                             //Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 30),
                          Text('*',style: robotoBold.copyWith(color: ColorResources.primaryColor,
                              fontSize: Dimensions.fontSizeDefault),),
                        ])),


                      Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                       child:/*CustomTextField(
                          //maxLines:10,
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

                      ) ,


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
                                 // Text(getTranslated('upload_image', context)!,),

                                Text(getTranslated('upload_image', context)!,
                                    style: textRegular.copyWith(color: Theme.of(context).primaryColor),
                                    maxLines: 1, overflow: TextOverflow.ellipsis),

                                  const SizedBox(width: Dimensions.paddingSizeDefault),
                                  Image.asset(Images.uploadImage,color: Theme.of(context).primaryColor)])))),

                  ]),

                  serviceClose.isLoading ?

                  const Center(child: CircularProgressIndicator(),) :

                  Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: CustomButton(
                          buttonText: getTranslated('save', context),
                          onTap: () {
                            String servicePlace  = _servicePlaceReasonController.text.trim().toString();
                             int? duringProduction1= duringProduction==true?1:0;

                            if(selectedline==null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(getTranslated('select_line', context)!),
                                  backgroundColor: Colors.red));
                            }

                            if(selectedmachine==null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(getTranslated('select_machine', context)!),
                                  backgroundColor: Colors.red));
                            }

                            if(selectedtype==null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(getTranslated('select_type', context)!),
                                  backgroundColor: Colors.red));
                            }

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

                              if(dt1.compareTo(dt2) <= 0 && servicePlace.isNotEmpty && startDateSelected.isNotEmpty && endDateSelected.isNotEmpty  && selectedline!.isNotEmpty && selectedmachine!.isNotEmpty && selectedtype!.isNotEmpty){
                              serviceClose.serviceCreate(context, selectedline!,selectedmachine!,selectedtype!,startDateSelected,startTimeSelected,endDateSelected,endTimeSelected,duration,duringProduction1,servicePlace,
                                  Provider.of<AuthController>(context, listen: false).getUserToken()).then((value) {
                                if(value.statusCode==200 ){
                                  //serviceClose.getServiceInfo(widget.serviceModel!.id);
                                  Provider.of<SaleProvider>(context, listen: false).setIndex(4, notify: false);
                                 // Navigator.pop(context);
                                  Navigator.pop(context);
                                  showCustomSnackBar(getTranslated('successfully_create_service', context), context, isError: false);
                                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SaleDetailsScreen(saleId: widget.serviceModel!.id)));
                                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SaleDetailsScreen(saleId: 1500)));
                                  //Provider.of<SaleProvider>(context, listen: false).scrollControllerService.animateTo(Provider.of<SaleProvider>(context, listen: false).scrollControllerService.position.maxScrollExtent,
                                  //    duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
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


/*  Future pickDateTime() async{
    DateTime? date =await pickDate();
    if (date==null) return;

    TimeOfDay? time =await pickTime();
    if (time==null) return;
     final endDateTimeSelected=DateTime(
         date.year,
         date.month,
         date.day,
         time.hour,
         time.minute
    ) ;
//setState(()=> endDateTime=endDateTimeSelected);
  }*/

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
