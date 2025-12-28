import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machines_parameters_widget.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machines_technical_doc_widget.dart';
import 'package:flutter_spareparts_store/features/sale/widget/sale_shimmer.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';


class MachineParametersScreen extends StatefulWidget {
  final int? machineid;
  const MachineParametersScreen({super.key, required this.machineid});

  @override
  State<MachineParametersScreen> createState() => _MachineParametersScreenState();
}

class _MachineParametersScreenState extends State<MachineParametersScreen> {

  ScrollController scrollController  = ScrollController();
  UniqueKey keyTile=UniqueKey();
  bool isExpanded = false;

  void expandTile() {
    setState(() {
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
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
                        isExpanded ? shrinkTile() : expandTile();
                      });
                    },
                  ),
                  const SizedBox(width: 10,),
                  Text(isExpanded?'${getTranslated('shrink_all', context)}':'${getTranslated('expand_all', context)}',style: textBold.copyWith( fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor))

                ])),

            Expanded(child: machinesProvider.machineParameters!= null  ? (machinesProvider.machineParameters!.parametersList != null && machinesProvider.machineParameters!.parametersList!.isNotEmpty)?
          SingleChildScrollView(
          controller: scrollController,
          child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: machinesProvider.machineParameters!.parametersList!.length,
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) => MachineParametersWidget(machineParametersList: machinesProvider.machineParameters?.parametersList![index],isExpanded:isExpanded,keyTile: keyTile),
          ),
          )  :const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noProduct, message: 'no_products_found',)
                : const SaleShimmer()
          )


          ]);}
);
  }

}
