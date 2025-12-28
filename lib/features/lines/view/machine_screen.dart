import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/lines_model.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_assembly_parts_screen.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_assembly_screen.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machine_assembly_3D_widget.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machine_assembly_drawing_widget.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machine_tab_item.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_screen_extra.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';



class MachineScreen extends StatefulWidget {
final Machines? machineModel;
const MachineScreen({super.key, required this.machineModel,});

@override
State<MachineScreen> createState() => _MachineScreenState();

}

  class _MachineScreenState extends State<MachineScreen> with TickerProviderStateMixin{

    /*bool? hasBOM=false;
    bool? machineSelectedhas3D=false;
    bool? machineSelectedhasgraphic=false;*/



  @override
  void initState() {
    setState(() {
      Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyList(widget.machineModel!.machineId!);
      Provider.of<MachinesProvider>(context, listen: false).machineTabController = TabController(initialIndex:1,vsync: this, length:4);
      Provider.of<MachinesProvider>(context, listen: false).isExpanded0= List.filled(100, false, growable: true);
      Provider.of<MachinesProvider>(context, listen: false).isExpanded=  List.filled(100, false, growable: true);
      Provider.of<MachinesProvider>(context, listen: false).isExpanded1= List.filled(100, false, growable: true);
      Provider.of<MachinesProvider>(context, listen: false).isExpanded2= List.filled(100, false, growable: true);
      Provider.of<MachinesProvider>(context, listen: false).isExpanded3= List.filled(100, false, growable: true);
      Provider.of<MachinesProvider>(context, listen: false).isExpanded4= List.filled(100, false, growable: true);
      Provider.of<MachinesProvider>(context, listen: false).isExpanded5= List.filled(100, false, growable: true);
      Provider.of<MachinesProvider>(context, listen: false).isExpanded6= List.filled(100, false, growable: true);
    });


    /* setState(() {
       hasBOM=   widget.machineModel!.hasBOM == true? true:false ;
       machineSelectedhas3D=Provider.of<MachinesProvider>(context, listen: false).machineSelectedhas3D== true? true:false ;
       machineSelectedhasgraphic=Provider.of<MachinesProvider>(context, listen: false).machineSelectedhasgraphic== true? true:false ;

    });*/

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child:
      Scaffold(
        appBar: AppBar(
          title:  Text(maxLines: 3,
            '${widget.machineModel!.name!} - ${widget.machineModel!.code!}',
            style: const TextStyle(fontSize: 15),
          ),
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child:  TabBar(
                     key: Provider.of<MachinesProvider>(context, listen: false).keyTile,
                tabAlignment: TabAlignment.start,
                controller: Provider.of<MachinesProvider>(context, listen: false).machineTabController,
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
                  //if(widget.machineModel!.hasBOM== true)
                  InkWell(
                      onTap: () =>
                     {
                       SideSheet.left(width: MediaQuery.of(context).size.width * 0.85,
                          // barrierLabel:  "Side Sheet",
                         barrierDismissible: true,
                           //barrierColor :Colors.transparent,
                           sheetBorderRadius : 10,
                           sheetColor: Colors.white,
                           transitionDuration : const Duration(milliseconds: 500),
                         context: context,
                          body:
                          Column(
                            children: [
                              const SizedBox(height:30 ,),
                              MachineAssemblyScreen(machineid: widget.machineModel!.machineId)
                            ],
                          ),

                     ),
                     }, child: MachineTabItem(text: getTranslated('heirarchy', context),image:Images.heirarchy,enableDisable:widget.machineModel!.hasBOM)),


                  InkWell(onTap:() {
                    setState(() {
                      if(widget.machineModel!.hasBOM== true) {
                        Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1);}
                      Provider.of<MachinesProvider>(context, listen: false).machineSelectedhas3D;
                      Provider.of<MachinesProvider>(context, listen: false).machineSelectedhasgraphic;
                      Provider.of<MachinesProvider>(context, listen: false).assemblySelectedDrawing;
                    });


                                  },
                       child: MachineTabItem(text: getTranslated('list', context), image:Images.list,enableDisable:widget.machineModel!.hasBOM)),



                  InkWell(onTap:() {
                    setState(() {
                    if(Provider.of<MachinesProvider>(context, listen: false).machineSelectedhasgraphic== true) {
                      Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(2);
                    }
                      Provider.of<MachinesProvider>(context, listen: false).machineSelectedhas3D;
                      Provider.of<MachinesProvider>(context, listen: false).machineSelectedhasgraphic;
                      Provider.of<MachinesProvider>(context, listen: false).assemblySelectedDrawing;
                    });
                    },
                       child: MachineTabItem(text: getTranslated('drawing', context), image:Images.drawing,enableDisable: Provider.of<MachinesProvider>(context, listen: false).machineSelectedhasgraphic)),


                     InkWell(onTap:() {
                       setState(() {
                         if(Provider.of<MachinesProvider>(context, listen: false).machineSelectedhas3D== true) {
                           Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(3);
                         }
                         Provider.of<MachinesProvider>(context, listen: false).machineSelectedhas3D;
                         Provider.of<MachinesProvider>(context, listen: false).machineSelectedhasgraphic;
                         Provider.of<MachinesProvider>(context, listen: false).assemblySelectedDrawing;
                       });
                       },
                        child: MachineTabItem(text: getTranslated('3d_model', context), image:Images.threeD,enableDisable: Provider.of<MachinesProvider>(context, listen: false).machineSelectedhas3D)),
                ],
              ),
            ),
          actions: [
            InkWell(
              onTap: ()=> {Navigator.of(context).push(MaterialPageRoute(builder: (context) => MachineScreenExtra(machineModel:widget.machineModel)))},
              child: Image.asset(Images.dot,width: 40, height: 40,color:Theme.of(context).primaryColor),
            ),],
          ),

       /* floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller!.animateTo(1);
          },
          child: const Icon(Icons.move_down),
        ),*/

        body:
          TabBarView(
            key: Provider.of<MachinesProvider>(context, listen: false).keyTile,
           physics:const NeverScrollableScrollPhysics(),
           controller: Provider.of<MachinesProvider>(context, listen: false).machineTabController,
          children: [
            //if(widget.machineModel!.hasBOM== true)
            //Center(child: Text('Drawer')),
            MachineAssemblyScreen(machineid: widget.machineModel!.machineId),
            //const Center(child: Text('Heirarchy')),

              MachineAssemblyPartsScreen(machineid: widget.machineModel!.machineId,assemblecode:Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode),

               MachineAssemblyPartsDrawingWidget(graphic: Provider.of<MachinesProvider>(context, listen: false).assemblySelectedDrawing),


             //Center(child: Text( '${widget.machineModel!.machineId}')),
              //const Center(child: Text('3D Model')),
            MachineAssemblyParts3DWidget(title: widget.machineModel!.name, file: '',)
          ],
        ),


          /*Positioned(top: 0, right: 0, child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
             child: MachineTabItem(text: getTranslated('more', context), index: 4,image:Images.dot),
          ))*/
      ),
    );
  }
}

