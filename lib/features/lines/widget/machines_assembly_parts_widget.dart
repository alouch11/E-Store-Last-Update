import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/machines_model.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_assembly_parts_screen.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machine_assembly_part_dialog.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:provider/provider.dart';




class MachineAssemblyPartsWidget extends StatefulWidget {
  final MachineAssemblyPartsList? machineAssemblyPartsList;

  const MachineAssemblyPartsWidget({super.key, this.machineAssemblyPartsList});

  @override
  State<MachineAssemblyPartsWidget> createState() => _MachineAssemblyPartsWidgetWidgetState();
}

class _MachineAssemblyPartsWidgetWidgetState extends State<MachineAssemblyPartsWidget> {
  
  @override
  Widget build(BuildContext context) {

    return
      Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(
        horizontal: 0, vertical: 8),
                        child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    (widget.machineAssemblyPartsList!.hasassembly ==true) ?
                                    InkWell(
                                        onTap: () => {
                                          Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(widget.machineAssemblyPartsList!.machineid!,widget.machineAssemblyPartsList!.componentcode!,widget.machineAssemblyPartsList!.has3D!,widget.machineAssemblyPartsList!.hasgraphic!,widget.machineAssemblyPartsList!.graphic!),
                                          Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(Provider.of<MachinesProvider>(context, listen: false).machineSelectedmachineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!),
                                          Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1),
                                        },
                                        child:const Icon( Icons.playlist_play_rounded,size: 30 ,color: ColorResources.blue)
                                           ):const SizedBox(width: 30,),

                                    InkWell(onTap: () =>

                                        showModalBottomSheet(context: context,
                                        isScrollControlled: true, backgroundColor: Colors.transparent,
                                           builder: (c) =>    MachineAssemblyPartDialog(productCode: widget.machineAssemblyPartsList!.componentcode)),

                                      child:Text('${widget.machineAssemblyPartsList!.componentcode}',
                                        overflow: TextOverflow.ellipsis,
                                        style: ubuntuRegularLow.copyWith(
                                            color: Theme.of(context).hintColor),
                                      ),

                                    ),




                                    Icon(Icons.photo_camera,
                                          color: Theme.of(context)
                                              .primaryColor),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${widget.machineAssemblyPartsList!.componentdescription}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: ubuntuRegularLow.copyWith(
                                              color: Theme.of(context)
                                                  .hintColor),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        child: Text(
                                          "${widget.machineAssemblyPartsList!.quantity}",
                                          overflow: TextOverflow.ellipsis,
                                          style: ubuntuRegularLow.copyWith(
                                              color:
                                              Theme.of(context).primaryColor),
                                        ),
                                      ),
                                    //]),

                            ]))]);

    //showModalBottomSheet(backgroundColor: Colors.transparent,
    //   context: context, builder: (context) => NotificationDialog(notificationModel: notification.notificationModel!.notification![index]));

  /*  InkWell(onTap: () => showModalBottomSheet(context: context,

        isScrollControlled: true, backgroundColor: Colors.transparent,
        builder: (c) =>  const ProductFilterDialog(fromShop: false,)),

      child: Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,
          horizontal: Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Theme.of(context).hintColor.withOpacity(.25))),
        child: SizedBox(width: 25,height: 24, child: Image.asset(Images.dropdown, color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.white:Theme.of(context).primaryColor)),
      ),
    )*/









  }
}

