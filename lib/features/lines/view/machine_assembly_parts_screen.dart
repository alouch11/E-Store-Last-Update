import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/paginated_list_view.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machines_assembly_parts_widget.dart';
import 'package:flutter_spareparts_store/features/sale/widget/sale_shimmer.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:provider/provider.dart';



class MachineAssemblyPartsScreen extends StatefulWidget {
  final int? machineid;
  final String? assemblecode;

  const MachineAssemblyPartsScreen({super.key, required this.machineid,required this.assemblecode});

  @override
  State<MachineAssemblyPartsScreen> createState() => _MachineAssemblyPartsScreenState();

}

class _MachineAssemblyPartsScreenState extends State<MachineAssemblyPartsScreen> {

  ScrollController scrollController  = ScrollController();

  @override
  void initState() {

    //Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!);
   // Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(Provider.of<MachinesProvider>(context, listen: false).machineSelectedmachineid!, Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!, Provider.of<MachinesProvider>(context, listen: false).machineSelectedhas3D!,  Provider.of<MachinesProvider>(context, listen: false).machineSelectedhasgraphic!, Provider.of<MachinesProvider>(context, listen: false).assemblySelectedDrawing!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

      return Consumer<MachinesProvider>(
          builder: (context, machinesProvider, child) {
            return
              machinesProvider.machineAssemblyPartsModel!= null  ? (machinesProvider.machineAssemblyPartsModel!.machineAssemblyPartsList!.isNotEmpty )?
              Column(children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),

              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 10),
                child: Row(
                     mainAxisSize:MainAxisSize.max ,
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${getTranslated('code', context)}',
                          overflow: TextOverflow.ellipsis,
                          style: ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor),
                        ),
                       Text(
                          '${getTranslated('description', context)}',
                          overflow: TextOverflow.ellipsis, style: ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor),
                        ),
                      Text(
                          '${getTranslated('qty', context)}',
                          overflow: TextOverflow.ellipsis, style: ubuntuRegularLow.copyWith(color: Theme.of(context).primaryColor),
                        ),
                    ],
                  ),
                ),

              Divider(
                thickness: 2,
                endIndent: 10.0,
                indent: 10.0,
                color:
                Theme.of(context).primaryColor.withOpacity(0.7),
              ),

              Expanded(child:SingleChildScrollView(
                controller: scrollController,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: machinesProvider.machineAssemblyPartsModel!.machineAssemblyPartsList!.length,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) => MachineAssemblyPartsWidget(machineAssemblyPartsList: machinesProvider.machineAssemblyPartsModel!.machineAssemblyPartsList![index]),
                  ),
              )
              )
            ])
                  : const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noProduct, message: 'no_products_found',) : const SaleShimmer()
            ;}
      );
    }

}
