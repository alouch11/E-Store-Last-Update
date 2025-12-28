import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machines_assembly_widget.dart';
import 'package:flutter_spareparts_store/features/sale/widget/sale_shimmer.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:provider/provider.dart';



class MachineAssemblyScreen extends StatefulWidget {
  final int? machineid;
  final ScrollController? scrollController1;

  const MachineAssemblyScreen({super.key, required this.machineid, this.scrollController1});

  @override
  State<MachineAssemblyScreen> createState() => _MachineAssemblyScreenState();

}

class _MachineAssemblyScreenState extends State<MachineAssemblyScreen> {

  final  ScrollController _controller  = ScrollController();


  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        Provider.of<MachinesProvider>(context, listen: false).machineAssemblyScrollControllerOffset =_controller.offset;
      });
    });
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

      return Consumer<MachinesProvider>(
          builder: (context, machinesProvider, child) {
            return Container( width:MediaQuery.of(context).size.width-50,height:MediaQuery.of(context).size.height-30,
                alignment: Alignment.topLeft,
                        child:
               Column(children: [
               const SizedBox(height: Dimensions.paddingSizeSmall),

              Row(mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                Container(height: Dimensions.paddingSizeExtraLarge,
                  width:MediaQuery.of(context).size.width-170 ,
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault)) ,child: const Center(child: Text('Assembly List')),),

                    //const SizedBox(width: Dimensions.paddingSizeDefault,),

                    InkWell(onTap: ()=> _controller.jumpTo(Provider.of<MachinesProvider>(context, listen: false).machineAssemblyScrollControllerOffset),
                      child:  const Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.playlist_play, size: 30,color:Colors.green),
                        ],
                      ),
                    ),



                    InkWell(onTap: ()=>
                        setState(() {
                          Provider.of<MachinesProvider>(context, listen: false).isExpanded0= List.filled(100, false, growable: true);
                          Provider.of<MachinesProvider>(context, listen: false).isExpanded= List.filled(100, false, growable: true);
                          Provider.of<MachinesProvider>(context, listen: false).isExpanded1= List.filled(100, false, growable: true);
                          Provider.of<MachinesProvider>(context, listen: false).isExpanded2= List.filled(100, false, growable: true);
                          Provider.of<MachinesProvider>(context, listen: false).isExpanded3= List.filled(100, false, growable: true);
                          Provider.of<MachinesProvider>(context, listen: false).isExpanded4= List.filled(100, false, growable: true);
                          Provider.of<MachinesProvider>(context, listen: false).isExpanded5= List.filled(100, false, growable: true);
                          Provider.of<MachinesProvider>(context, listen: false).isExpanded6= List.filled(100, false, growable: true);
                          Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyList(widget.machineid!);
                          Provider.of<MachinesProvider>(context, listen: false).machineAssemblyScrollControllerOffset=0;
                        }

                          //MachineAssemblyScreen(machineid: widget.machineid);

                        ),

                      child:  const Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.restart_alt, size: 30,color:Colors.blueAccent,),
                        ],
                      ),
                    ),

                InkWell(onTap: ()=>Navigator.of(context).pop(),
                  child:  const Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.close_rounded, size: 30,color:Colors.red,),
                    ],
                  ),
                ),

         ]),
                 const SizedBox(height: Dimensions.paddingSizeDefault),


                 /* Text(Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!),
                  Text(Provider.of<MachinesProvider>(context, listen: false).machineSelectedmachineid.toString()),
                  Text(Provider.of<MachinesProvider>(context, listen: false).machineSelectedhas3D!.toString()),
                  Text(Provider.of<MachinesProvider>(context, listen: false).machineSelectedhasgraphic!.toString()),
                  Text(Provider.of<MachinesProvider>(context, listen: false).assemblySelectedDrawing!),*/



                Expanded(child: machinesProvider.machineAssembly!= null  ? (machinesProvider.machineAssembly!.machineassembly != null)?
                 ListView.builder(
                      controller: _controller,
                      itemCount: machinesProvider.machineAssembly?.machineassembly!.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) => MachineAssemblyWidget(machineAssemblyList: machinesProvider.machineAssembly?.machineassembly![index], index0: index,),

                ) : const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noOrder, message: 'no_order_found',) : const SaleShimmer()
                )

                ,

                /* Padding(
                   padding: const EdgeInsets.only(top: 20, left: 20),
                   child: Text(
                     "Offset: ${_scrollOffset.toString()}",
                     style: const TextStyle(
                         fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold),
                   ),
                 ),*/

                 /*  FloatingActionButton(
                                child :const Icon(Icons.add)
                                    ,
                     onPressed:() {
                      // scrollController.jumpTo(scrollController.position.maxScrollExtent);
                       _controller.jumpTo(Provider.of<MachinesProvider>(context, listen: false).machineAssemblyScrollControllerOffset);
                     }
                 ),
               Padding(
                   padding: const EdgeInsets.only(top: 20, left: 20),
                   child: Text(
                     "Offset: ${_scrollOffset.toString()}",
                     style: const TextStyle(
                         fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold),
                   ),
                 ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    "Offset: ${Provider.of<MachinesProvider>(context, listen: false).machineAssemblyScrollControllerOffset.toString()}",
                    style: const TextStyle(
                        fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),*/



              ]),
            );}
      );
    }

}
