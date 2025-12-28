import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/paginated_list_view.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machine_emergency_level_button.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machines_emergency_widget.dart';
import 'package:flutter_spareparts_store/features/sale/widget/sale_shimmer.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';


class MachineEmergencyScreen extends StatefulWidget {
  final int? machineid;
  const MachineEmergencyScreen({super.key, required this.machineid});

  @override
  State<MachineEmergencyScreen> createState() => _MachineEmergencyScreenState();
}

class _MachineEmergencyScreenState extends State<MachineEmergencyScreen> {

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
            MachineEmergencyLevelButton(text: getTranslated('level_1', context)!, index: 1,machineId:widget.machineid!),
            MachineEmergencyLevelButton(text: getTranslated('level_2', context)!, index: 2,machineId:widget.machineid!),
            MachineEmergencyLevelButton(text: getTranslated('level_3', context)!, index: 3,machineId:widget.machineid!),
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
                    Text("Code", overflow: TextOverflow.ellipsis, style:  ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor),),
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
            Divider(thickness: 3,endIndent: 20.0,indent: 20.0,color:Theme.of(context).primaryColor.withOpacity(0.7) ,),
*/

            //machinesProvider.machineEmergency!= null  ? (machinesProvider.machineEmergency!.emergencyList != null && machinesProvider.machineEmergency!.emergencyList!.isNotEmpty)?
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
                        //Provider.of<MachinesProvider>(context, listen: false).getMachineEmergencyList(1,widget.machineid!,Provider.of<MachinesProvider>(context, listen: false).selectedMachineEmergencyLevel);
                        isExpanded = value;
                        isExpanded ? shrinkTile() : expandTile();
                      });
                    },
                  ),
                  const SizedBox(width: 10,),
                  Text(isExpanded?'${getTranslated('shrink_all', context)}':'${getTranslated('expand_all', context)}',style: textBold.copyWith( fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor))

                ])),//:const SizedBox(): const SaleShimmer(),

            Expanded(child: machinesProvider.machineEmergency!= null  ? (machinesProvider.machineEmergency!.emergencyList != null && machinesProvider.machineEmergency!.emergencyList!.isNotEmpty)?
          SingleChildScrollView(
          controller: scrollController,
          child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: machinesProvider.machineEmergency?.emergencyList!.length,
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) => MachineEmergencyWidget(machineEmergencyList: machinesProvider.machineEmergency?.emergencyList![index],isExpanded:isExpanded,keyTile: keyTile),
          ),
            ) :const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noProduct, message: 'no_products_found',)
                : const SaleShimmer()
          )
          ]);}
);
  }

}
