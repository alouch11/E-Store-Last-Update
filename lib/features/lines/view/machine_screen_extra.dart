import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/dashboard/dashboard_screen.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/lines_model.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_emergency_screen.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_parameters_screen.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_preventive_maintenance_screen.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_technical_doc_screen.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machine_card_UI.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machine_tab_item.dart';
import 'package:flutter_spareparts_store/features/sale/view/sale_screen_by_product.dart';
import 'package:flutter_spareparts_store/features/sale/view/sale_screen_by_machine.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:provider/provider.dart';



class MachineScreenExtra extends StatefulWidget {
final Machines? machineModel;
final bool isNotification;
const MachineScreenExtra({super.key, this.machineModel,this.isNotification = false,});

@override
State<MachineScreenExtra> createState() => _MachineScreenExtraState();

}

class _MachineScreenExtraState extends State<MachineScreenExtra> with TickerProviderStateMixin{

  bool? hasInformations=false;
  bool? hasTechnicalDoc=false;
  bool? hasParameters=false;
  bool? hasMaintenanceList=false;
  bool? hasEmergencyList=false;
  bool? hasQR=false;

  @override
  void initState() {

    Provider.of<MachinesProvider>(context, listen: false).machineExtraTabController = TabController(initialIndex:0,vsync: this, length:7);

    Provider.of<MachinesProvider>(context, listen: false).getMachineTechnicalDocList(1,widget.machineModel!.machineId!);
    Provider.of<MachinesProvider>(context, listen: false).getMachineParametersList(widget.machineModel!.machineId!);
    Provider.of<MachinesProvider>(context, listen: false).setIndexByMachineMaintenance(widget.machineModel!.machineId!,1, notify: false);
    //Provider.of<MachinesProvider>(context, listen: false).getMachineMaintenanceList(1,widget.machineModel!.machineId!,3000);
    Provider.of<MachinesProvider>(context, listen: false).setIndexByMachine(widget.machineModel!.machineId!,1, notify: false);
   // Provider.of<MachinesProvider>(context, listen: false).getMachineEmergencyList(1,widget.machineModel!.machineId!,1);

    /*if(Provider.of<MachinesProvider>(context, listen: false).machineMaintenance!.maintenanceList!.isNotEmpty){

    }*/

    setState(() {
      hasInformations= widget.machineModel!.hasInformations== true? true:false ;
      hasTechnicalDoc= widget.machineModel!.hasTechnicalDoc== true? true:false ;
      hasParameters= widget.machineModel!.hasParameters== true? true:false ;
      hasMaintenanceList= widget.machineModel!.hasMaintenanceList== true? true:false ;
      hasEmergencyList= widget.machineModel!.hasEmergencyList== true? true:false ;
      hasQR= widget.machineModel!.hasQR== true? true:false ;

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (val) async{
        if(widget.isNotification){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
        }
      },
      child:DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title:
          Text(maxLines: 3,
            '${widget.machineModel!.name!} - ${widget.machineModel!.code!}',
            style: const TextStyle(fontSize: 15),
          ),
          leading: InkWell(onTap: (){
              if(widget.isNotification){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
              }else{
                Navigator.pop(context);
              }
            }, child: const Padding(padding: EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault),
                child: Icon(CupertinoIcons.back))),

          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child:  TabBar(
               tabAlignment: TabAlignment.start,
                controller: Provider.of<MachinesProvider>(context, listen: false).machineExtraTabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
               // indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorWeight: 4,
                indicator:  BoxDecoration(
                  color:ColorResources.primaryColor.withOpacity(0.76),
                  //color:ColorResources.hintTextColor,
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                tabs: [

                  InkWell(onTap:() {
                    if( hasInformations== true){
                      Provider.of<MachinesProvider>(context, listen: false).machineExtraTabController!.animateTo(0);
                    }
                  },
                      child: MachineTabItem(text: getTranslated('machine_info', context), image:Images.listInfo,enableDisable: hasInformations)
                  ),



                  InkWell(onTap:() {
                    if(hasTechnicalDoc== true){
                      Provider.of<MachinesProvider>(context, listen: false).machineExtraTabController!.animateTo(1);
                    }
                  },
                      child: MachineTabItem(text: getTranslated('technical_doc', context), image:Images.technicalDoc,enableDisable:hasTechnicalDoc)
                  ),


                  InkWell(onTap:() {
                    if(hasParameters== true){
                      Provider.of<MachinesProvider>(context, listen: false).machineExtraTabController!.animateTo(2);
                    }
                  },
                      child: MachineTabItem(text: getTranslated('parameters', context), image:Images.parameters,enableDisable:hasParameters)
                  ),

                  InkWell(onTap:() {
                     if( hasMaintenanceList== true){
                      Provider.of<MachinesProvider>(context, listen: false).machineExtraTabController!.animateTo(3);
                    }
                    },
                      child: MachineTabItem(text: getTranslated('preventive_maintenance', context), image:Images.preventiveMaintenance,enableDisable:hasMaintenanceList)
                  ),

                  InkWell(onTap:() {
                    if(hasEmergencyList== true){
                      Provider.of<MachinesProvider>(context, listen: false).machineExtraTabController!.animateTo(4);
                    }},

                      child: MachineTabItem(text: getTranslated('emergency_list', context), image:Images.emergencyList,enableDisable:hasEmergencyList)
                         ),


                  InkWell(onTap:() {
                    if(hasQR== true){
                      Provider.of<MachinesProvider>(context, listen: false).machineExtraTabController!.animateTo(5);
                    }},
                      child:  MachineTabItem(text: getTranslated('qr_code', context),image:Images.qrCode,enableDisable: hasQR)
                  ),

                  InkWell(onTap:() {
                      Provider.of<MachinesProvider>(context, listen: false).machineExtraTabController!.animateTo(6);
                    },
                      child:  MachineTabItem(text: getTranslated('services', context),image:Images.serviceIcon,enableDisable: true)
                  ),

                ],
              ),
            ),
          ),

        body:  TabBarView(
            physics:const NeverScrollableScrollPhysics(),
          controller: Provider.of<MachinesProvider>(context, listen: false).machineExtraTabController,
          children: [

             MachineCardUI(machineModel :widget.machineModel),

            //if(widget.machineModel!.hasAttachments== true)
            MachineTechnicalDocScreen(machineid: widget.machineModel!.machineId),

            MachineParametersScreen(machineid: widget.machineModel!.machineId),

            //if(widget.machineModel!.hasMaintenanceList== true)
            MachinePreventiveMaintenanceScreen(machineid: widget.machineModel!.machineId),

           // if(widget.machineModel!.hasEmergencyList== true)
            MachineEmergencyScreen(machineid: widget.machineModel!.machineId),

           // if(widget.machineModel!.hasQR== true)
            const Center(child: Text('QR Code')),

            SaleScreenByMachine(indexId:2,machineId:widget.machineModel!.machineId),
          ],
        ),
      ),
    )
    );
  }
}

