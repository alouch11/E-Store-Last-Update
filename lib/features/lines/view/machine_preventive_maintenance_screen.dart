import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/paginated_list_view.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machine_preventive_maintenance_button.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machines_preventive_maintenance_widget.dart';
import 'package:flutter_spareparts_store/features/sale/widget/sale_shimmer.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';


class MachinePreventiveMaintenanceScreen extends StatefulWidget {
  final int? machineid;
  const MachinePreventiveMaintenanceScreen({super.key, required this.machineid});

  @override
  State<MachinePreventiveMaintenanceScreen> createState() => _MachinePreventiveMaintenanceScreenState();
}

class _MachinePreventiveMaintenanceScreenState extends State<MachinePreventiveMaintenanceScreen> {

  ScrollController scrollController  = ScrollController();


   UniqueKey keyTile=UniqueKey();
  bool isExpanded = false;

  void expandTile() {
    setState(() {
      //isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      //isExpanded = false;
      keyTile = UniqueKey();
    });
  }



  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {


    return Consumer<MachinesProvider>(
        builder: (context, machinesProvider, child) {
          return Column(children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),

          Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
          child: SizedBox(
          height: 40,
          child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            MachinePreventiveMaintenanceButton(text: getTranslated('3000H', context)!, index: 1,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('4000H', context)!, index: 2,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('6000H', context)!, index: 3,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('8000H', context)!, index: 4,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('9000H', context)!, index: 5,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('12000H', context)!, index: 6,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('15000H', context)!, index: 7,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('18000H', context)!, index: 8,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('21000H', context)!, index: 9,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('24000H', context)!, index: 10,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('27000H', context)!, index: 11,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('30000H', context)!, index: 12,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('33000H', context)!, index: 13,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('36000H', context)!, index: 14,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('39000H', context)!, index: 15,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('42000H', context)!, index: 16,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('45000H', context)!, index: 17,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('48000H', context)!, index: 18,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('51000H', context)!, index: 19,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('54000H', context)!, index: 20,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('57000H', context)!, index: 21,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('60000H', context)!, index: 22,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('63000H', context)!, index: 23,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('66000H', context)!, index: 24,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('69000H', context)!, index: 25,machineId:widget.machineid!),
            MachinePreventiveMaintenanceButton(text: getTranslated('72000H', context)!, index: 26,machineId:widget.machineid!),
          ],
          ),
          ),
          ),
           const Row(
          children: <Widget>[
          Expanded(
          child: Divider(thickness: 2,color: Colors.black,)
          ),
          Text(" List "),
          Expanded(
          child: Divider(thickness: 2,color: Colors.black,)
          ),
          ]
          ),

            /*   const SizedBox(height: Dimensions.paddingSizeLarge),

           Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
              child: SizedBox(
                height: 20,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox( width: 20),
                    SizedBox( width: 80,child:
                    Text("Assembly Code And Description", overflow: TextOverflow.ellipsis, style:  ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor),),
                    ),
                    SizedBox( width: 130,child:
                    Text("Description", overflow: TextOverflow.ellipsis, style:  ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor),),
                    ),
                    SizedBox( width: 50,child:
                    Text("QTY", overflow: TextOverflow.ellipsis, style:  ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor),),
                    ),
                    SizedBox( width: 50,child:
                    Text("UOM", overflow: TextOverflow.ellipsis, style:  ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor,),),
                    ),],
                ),
              ),
            ),
            Divider(thickness: 3,endIndent: 20.0,indent: 20.0,color:Theme.of(context).primaryColor.withOpacity(0.7) ,),*/
            //machinesProvider.machineMaintenance!= null  ? (machinesProvider.machineMaintenance!.maintenanceList != null && machinesProvider.machineMaintenance!.maintenanceList!.isNotEmpty)?
            Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(children: [
                  FlutterSwitch(
                    height: 27.0,
                    width: 47.0,
                    padding: 4.0,
                    toggleSize: 20.0,
                    borderRadius: 15.0,
                    activeColor: Theme.of(context).primaryColor,
                    value: isExpanded,
                    onToggle: (value) {
                      setState(() {
                       isExpanded = value;
                        //Provider.of<MachinesProvider>(context, listen: false).getMachineMaintenanceList(1,widget.machineid!,Provider.of<MachinesProvider>(context, listen: false).selectedMachineMaintenance);
                         isExpanded ? shrinkTile() : expandTile();

                      });
                    },
                  ),
                  const SizedBox(width: 10,),
                  Text(isExpanded?'${getTranslated('shrink_all', context)}':'${getTranslated('expand_all', context)}',style: textBold.copyWith( fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor))

                ])),//:const SizedBox(): const SaleShimmer(),

            Expanded(child: machinesProvider.machineMaintenance!= null  ? (machinesProvider.machineMaintenance!.maintenanceList != null && machinesProvider.machineMaintenance!.maintenanceList!.isNotEmpty)?
          SingleChildScrollView(
          controller: scrollController,
          child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: machinesProvider.machineMaintenance?.maintenanceList!.length,
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) => MachinePreventiveMaintenanceWidget(machineMaintenanceList: machinesProvider.machineMaintenance?.maintenanceList![index],isExpanded: isExpanded,keyTile: keyTile),
          ),
          ) :const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noProduct, message: 'no_products_found',)
                : const SaleShimmer()
          )
          ]);}
);
  }}
