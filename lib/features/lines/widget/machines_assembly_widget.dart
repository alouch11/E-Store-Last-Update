import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/machines_model.dart';
import 'package:flutter_spareparts_store/features/lines/provider/lines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_assembly_parts_screen.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_screen.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MachineAssemblyWidget extends StatefulWidget {
  final AssemblyList? machineAssemblyList;
  final int? index0;

  const MachineAssemblyWidget({super.key, required this.machineAssemblyList,required this.index0});

  @override
  State<MachineAssemblyWidget> createState() => _MachineAssemblyWidgetState();
}

class _MachineAssemblyWidgetState extends State<MachineAssemblyWidget> with SingleTickerProviderStateMixin {



 @override
 void initState() {
   super.initState();

 }

 @override
 void dispose() {
  // controller.
   super.dispose();
 }


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding:
          const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
          child: SizedBox(
              width: double.infinity,
              //width:MediaQuery.of(context).size.width ,
              /*decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode ? 0.5 : 1),
                  boxShadow: shadow),
              margin: const EdgeInsets.only(bottom: 3),
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeExtraExtraSmall,
                horizontal: Dimensions.paddingSizeExtraExtraSmall,
              ),*/
              child:  Column(children: [
                      ExpansionTile(
                        controlAffinity:ListTileControlAffinity.leading,
                    expandedAlignment: Alignment.center,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                    //backgroundColor: Theme.of(context).hintColor.withOpacity(0.1),
                   // leading: Image.asset(Images.assembly, width: 30, height: 30,color: Theme.of(context).primaryColor ),
                  initiallyExpanded: Provider.of<MachinesProvider>(context, listen: false).isExpanded0[widget.index0!],
                  onExpansionChanged: (bool expanded0) {
                                    setState(() {
                                     Provider.of<MachinesProvider>(context, listen: false).isExpanded0[widget.index0!]= expanded0;
                                    });
                                  },
                        leading: Icon(
                      Provider.of<MachinesProvider>(context, listen: false).isExpanded0[widget.index0!]
                          ? Icons.expand_less
                          : Icons.expand_more, size: 25.0, color: Theme.of(context).primaryColor
                  ),
                  textColor:Theme.of(context).primaryColor,
                  title: Row(children: [
                    Expanded(child: Text('${widget.machineAssemblyList!.code!} - ${widget.machineAssemblyList!.description!}',
                        overflow: TextOverflow.ellipsis, style: ubuntuRegularLow.copyWith(
                            color: Colors.black,fontSize: 12), maxLines: 3
                    )),


                   // Text( widget.machineAssemblyList!.code!),
                   //  Text(' (${widget.machineAssemblyList!.childrenGroup!.length.toString()})',overflow: TextOverflow.ellipsis, style: ubuntuBold.copyWith(color: Theme.of(context).primaryColor),),
                    if(widget.machineAssemblyList!.has3D==true)
                      Row(children: [
                      const SizedBox(width: 5),
                    SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                    ]),
                     //subtitle: Text('${widget.machineAssemblyList!.description!}'),

                  ///Level 1
                  children: [
                       ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.machineAssemblyList!.childrenGroup!.length,
                          //padding: const EdgeInsets.only(left: 10),
                          itemBuilder: (context, index) {
                            late ChildrenGroup childrenGroup;
                            childrenGroup=widget.machineAssemblyList!.childrenGroup![index];
                              if(childrenGroup.childrenGroup1!.isNotEmpty) {
                                return Column(children: [
                              Row(children: [
                                const SizedBox(width: 20),
                            Expanded(child: Container(
                             color: Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),
                            child: ExpansionTile(
                                  controlAffinity:ListTileControlAffinity.leading,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                                  textColor:Theme.of(context).primaryColor,
                                  initiallyExpanded: Provider.of<MachinesProvider>(context, listen: false).isExpanded[index],
                                  onExpansionChanged: (bool expanded) {
                                    setState(() {
                                      Provider.of<MachinesProvider>(context, listen: false).isExpanded[index]= expanded;
                                      Provider.of<MachinesProvider>(context, listen: false).isExpanded1= List.filled(100, false, growable: true);
                                      Provider.of<MachinesProvider>(context, listen: false).isExpanded2= List.filled(100, false, growable: true);
                                      Provider.of<MachinesProvider>(context, listen: false).isExpanded3= List.filled(100, false, growable: true);
                                      Provider.of<MachinesProvider>(context, listen: false).isExpanded4= List.filled(100, false, growable: true);
                                      Provider.of<MachinesProvider>(context, listen: false).isExpanded5= List.filled(100, false, growable: true);
                                      Provider.of<MachinesProvider>(context, listen: false).isExpanded6= List.filled(100, false, growable: true);


                                    });
                                  },
                                  leading: Icon(
                                      Provider.of<MachinesProvider>(context, listen: false).isExpanded[index]
                                          ? Icons.expand_less
                                          : Icons.expand_more, size: 25.0, color: ColorResources.yellow
                                  ),
                                   title: Container(
                                      // color:
                                   //Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),

                              child: InkWell(
                              onTap: ()   {

                                setState(() {
                                   Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(widget.machineAssemblyList!.machineid,childrenGroup.code!,childrenGroup.has3D!,childrenGroup.hasgraphic!,childrenGroup.graphic!);
                                   Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!);
                                   Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1);
                                   Navigator.pop(context);
                                   });
                               },


                              child:Row(children: [
                                       //Text(childrenGroup.code!),
                                       Expanded(
                                         child: Text( '${childrenGroup.code!} - ${childrenGroup.description!}',overflow: TextOverflow.ellipsis,
                                           style: ubuntuRegularLow.copyWith(color: Colors.black,fontSize: 12),maxLines: 3,),
                                       ),
                                       if(childrenGroup.has3D==true)
                                         Row(children: [
                                           const SizedBox(width: 5),
                                           SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                                     ]),
                              )),
                              /*subtitle:
                              InkWell(
                              onTap: () => {
                              Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup.machineid!,childrenGroup.code!,childrenGroup.has3D!,childrenGroup.has3D!),
                              Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(1,childrenGroup.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!),
                              Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1),
                              },
                              child:Text(childrenGroup.description!)),*/



                                         ///Level 2
                                          children: [
                                          ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: childrenGroup.childrenGroup1!.length,
                                          padding: const EdgeInsets.all(0),
                                          itemBuilder: (context, index1) {
                                            late ChildrenGroup1 childrenGroup1;
                                            childrenGroup1=childrenGroup.childrenGroup1![index1];
                                          if(childrenGroup1.childrenGroup2!.isNotEmpty) {
                                          return Column(children: [
                                          Row(children: [
                                          const SizedBox(width: 15),
                                          Expanded(child: Container(
                                            color: Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup1.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),
                                            child: ExpansionTile(
                                                controlAffinity:ListTileControlAffinity.leading,
                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                                                textColor:Theme.of(context).primaryColor,
                                                //backgroundColor: Colors.grey.withOpacity(0.2),
                                               // leading: childrenGroup1.childrenGroup2!.isNotEmpty ? Image.asset(Images.assembly, width: 30, height: 30,color: Theme.of(context).primaryColor ):const SizedBox(width: 30,),
                                                //trailing:  const Icon(Icons.expand_more, size: 35.0, color: ColorResources.red),
                                                initiallyExpanded: Provider.of<MachinesProvider>(context, listen: false).isExpanded1[index1],
                                                onExpansionChanged: (bool expanded1) {
                                                  setState(() {
                                                    Provider.of<MachinesProvider>(context, listen: false).isExpanded1[index1]= expanded1;
                                                    Provider.of<MachinesProvider>(context, listen: false).isExpanded2= List.filled(100, false, growable: true);
                                                    Provider.of<MachinesProvider>(context, listen: false).isExpanded3= List.filled(100, false, growable: true);
                                                    Provider.of<MachinesProvider>(context, listen: false).isExpanded4= List.filled(100, false, growable: true);
                                                    Provider.of<MachinesProvider>(context, listen: false).isExpanded5= List.filled(100, false, growable: true);
                                                    Provider.of<MachinesProvider>(context, listen: false).isExpanded6= List.filled(100, false, growable: true);
                                                  });
                                                },
                                                leading: Icon(
                                                    Provider.of<MachinesProvider>(context, listen: false).isExpanded1[index1]
                                                        ? Icons.expand_less
                                                        : Icons.expand_more, size: 25.0, color: ColorResources.red
                                                ),
                                                title: InkWell(
                                                    onTap: ()  {
                                                      setState(() {
                                                        Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup1.machineid!,childrenGroup1.code!,childrenGroup1.has3D!,childrenGroup1.hasgraphic!,childrenGroup1.graphic!);
                                                        Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!);
                                                        Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1);
                                                        Navigator.pop(context);
                                                      });

                                                    },
                                                    child:Row(children: [
                                                                                  /*Text( childrenGroup1.code!),
                                                                                  Text( ' (${childrenGroup1.childrenGroup2!.length.toString()})',overflow: TextOverflow.ellipsis,
                                                                                    style: ubuntuBold.copyWith(color: Theme.of(context).primaryColor),),*/
                                                      Expanded(
                                                        child: Text( '${childrenGroup1.code!} - ${childrenGroup1.description!}',overflow: TextOverflow.ellipsis,
                                                          style: ubuntuRegularLow.copyWith(color: Colors.black,fontSize: 12),maxLines: 3,),
                                                      ),


                                                                                  if(childrenGroup1.has3D==true)
                                                                                    Row(children: [
                                            const SizedBox(width: 5),
                                            SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                                                                                  ])),
                                            /*subtitle: InkWell(
                                              onTap: () => {
                                              Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup1.machineid!,childrenGroup1.code!,childrenGroup1.has3D!,childrenGroup1.has3D!),
                                              Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(1,childrenGroup1.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!),
                                              Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1),
                                              },
                                              child:Text(childrenGroup1.description!)),*/



                                                ///Level 3
                                              children: [
                                                 ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: childrenGroup1.childrenGroup2!.length,
                                              padding: const EdgeInsets.all(0),
                                              itemBuilder: (context, index2) {
                                                late ChildrenGroup2 childrenGroup2;
                                                childrenGroup2=childrenGroup1.childrenGroup2![index2];
                                                if(childrenGroup2.childrenGroup3!.isNotEmpty) {
                                                return Column(children: [
                                                  Row(children: [
                                                    const SizedBox(width: 15),
                                                    Expanded(child: Container(
                                                      color: Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup2.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),
                                                      child: ExpansionTile(
                                                          controlAffinity:ListTileControlAffinity.leading,
                                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                                                          textColor:Theme.of(context).primaryColor,
                                                          //leading: childrenGroup2.childrenGroup3!.isNotEmpty ? Image.asset(Images.assembly, width: 30, height: 30,color: Theme.of(context).primaryColor ):const SizedBox(width: 30,),
                                                          //trailing: const Icon(Icons.expand_more, size: 35.0, color: ColorResources.black),
                                                          initiallyExpanded: Provider.of<MachinesProvider>(context, listen: false).isExpanded2[index2],
                                                          onExpansionChanged: (bool expanded2) {
                                                            setState(() {
                                                                            Provider.of<MachinesProvider>(context, listen: false).isExpanded2[index2]= expanded2;
                                                                            Provider.of<MachinesProvider>(context, listen: false).isExpanded3= List.filled(100, false, growable: true);
                                                                            Provider.of<MachinesProvider>(context, listen: false).isExpanded4= List.filled(100, false, growable: true);
                                                                            Provider.of<MachinesProvider>(context, listen: false).isExpanded5= List.filled(100, false, growable: true);
                                                                            Provider.of<MachinesProvider>(context, listen: false).isExpanded6= List.filled(100, false, growable: true);
                                                            });
                                                          },
                                                          leading: Icon(
                                                                            Provider.of<MachinesProvider>(context, listen: false).isExpanded2[index2]
                                                                                ? Icons.expand_less
                                                                                : Icons.expand_more, size: 25.0, color: ColorResources.black
                                                          ),
                                                        title: InkWell(
                                                                                                      onTap: (){
                                                                                                      setState(() {
                                                                                                        Provider
                                                                                                            .of<
                                                                                                            MachinesProvider>(
                                                                                                            context,
                                                                                                            listen: false)
                                                                                                            .changeSelectedAssembly(
                                                                                                            childrenGroup2
                                                                                                                .machineid!,
                                                                                                            childrenGroup2
                                                                                                                .code!,
                                                                                                            childrenGroup2
                                                                                                                .has3D!,
                                                                                                            childrenGroup2
                                                                                                                .hasgraphic!,
                                                                                                            childrenGroup2
                                                                                                                .graphic!)
                                                                                                        ;
                                                                                                        Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!);
                                                                                                        Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1);
                                                                                                        Navigator.pop(context);
                                                                                                      });
                                                                                                      },
                                                                                                      child: Row(children: [
                                                                                                      /*Text( childrenGroup2.code!),
                                                                                                      Text( ' (${childrenGroup2.childrenGroup3!.length.toString()})',overflow: TextOverflow.ellipsis,
                                                                                                      style: ubuntuBold.copyWith(color: Theme.of(context).primaryColor),),*/
                                                                                                        Expanded(
                                                      child: Text( '${childrenGroup2.code!} - ${childrenGroup2.description!}',overflow: TextOverflow.ellipsis,
                                                        style: ubuntuRegularLow.copyWith(color: Colors.black,fontSize: 12),maxLines: 3,),
                                                                                                        ),
                                                                                                      if(childrenGroup2.has3D==true)
                                                                                                      Row(children: [
                                                                                                      const SizedBox(width: 5),
                                                                                                      SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                                                                                                      ])),
                                                        /*subtitle: InkWell(
                                                                                                      onTap: () => {
                                                                                                      Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup2.machineid!,childrenGroup2.code!,childrenGroup2.has3D!,childrenGroup2.has3D!),
                                                                                                      Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(1,childrenGroup2.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!),
                                                                                                      Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1),
                                                                                                      },
                                                                                                      child:Text(childrenGroup2.description!)),*/



                                                          ///Level 4
                                                      children: [
                                                        ListView.builder(
                                                                              shrinkWrap: true,
                                                                              physics: const NeverScrollableScrollPhysics(),
                                                                              itemCount: childrenGroup2.childrenGroup3!.length,
                                                                              padding: const EdgeInsets.all(0),
                                                                              itemBuilder: (context, index3) {
                                                                                late ChildrenGroup3 childrenGroup3;
                                                                                childrenGroup3=childrenGroup2.childrenGroup3![index3];
                                                                                if(childrenGroup3.childrenGroup4!.isNotEmpty) {
                                                                                return Column(children: [
                                                                                    Row(children: [
                                                                                    const SizedBox(width: 15),
                                                                                    Expanded(child:
                                                                                     Container(
                                                                                       color: Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup3.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),
                                                                                       child: ExpansionTile(
                                                                                                     controlAffinity:ListTileControlAffinity.leading,
                                                                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                                                                                                    textColor:Theme.of(context).primaryColor,
                                                                                                    //leading: childrenGroup3.childrenGroup4!.isNotEmpty ? Image.asset(Images.assembly, width: 30, height: 30,color: Theme.of(context).primaryColor ):const SizedBox(width: 30,),
                                                                                                    initiallyExpanded: Provider.of<MachinesProvider>(context, listen: false).isExpanded3[index3],
                                                                                                    onExpansionChanged: (bool expanded3) {
                                                                                                      setState(() {
                                                                                                        Provider.of<MachinesProvider>(context, listen: false).isExpanded3[index3]= expanded3;
                                                                                                        Provider.of<MachinesProvider>(context, listen: false).isExpanded4= List.filled(100, false, growable: true);
                                                                                                        Provider.of<MachinesProvider>(context, listen: false).isExpanded5= List.filled(100, false, growable: true);
                                                                                                        Provider.of<MachinesProvider>(context, listen: false).isExpanded6= List.filled(100, false, growable: true);
                                                                                                      });
                                                                                                    },
                                                                                                     leading: Icon(
                                                                                                        Provider.of<MachinesProvider>(context, listen: false).isExpanded3[index3]
                                                                                                                                             ? Icons.expand_less
                                                                                                                                             : Icons.expand_more, size: 25.0, color: ColorResources.green
                                                                                                    ),
                                                                                                    title: InkWell(
                                                                                                                                                                       onTap: () {
                                                                                                                                                                          setState(() {
                                                                                                                                                                         Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup3.machineid!,childrenGroup3.code!,childrenGroup3.has3D!,childrenGroup3.hasgraphic!,childrenGroup3.graphic!);
                                                                                                                                                                         Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!);
                                                                                                                                                                         Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1);
                                                                                                                                                                         Navigator.pop(context);
                                                                                                                                                                       });},

                                                                                                                                                                        child:Row(children: [
                                                                                                    /*Text( childrenGroup3.code!),
                                                                                                    Text( ' (${childrenGroup3.childrenGroup4!.length.toString()})',overflow: TextOverflow.ellipsis,
                                                                                                      style: ubuntuBold.copyWith(color: Theme.of(context).primaryColor),),*/
                                                                                                                                                                          Expanded(
                                                                                       child: Text( '${childrenGroup3.code!} - ${childrenGroup3.description!}',overflow: TextOverflow.ellipsis,
                                                                                         style: ubuntuRegularLow.copyWith(color: Colors.black,fontSize: 12),maxLines: 3,),
                                                                                                                                                                          ),
                                                                                                    if(childrenGroup3.has3D==true)
                                                                                                      Row(children: [
                                                                                                        const SizedBox(width: 5),
                                                                                                        SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                                                                                        ])),
                                                                                        /*subtitle: InkWell(
                                                                                                                                                                       onTap: () => {
                                                                                                                                                                       Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup3.machineid!,childrenGroup3.code!,childrenGroup3.has3D!,childrenGroup3.has3D!),
                                                                                                                                                                       Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(1,childrenGroup3.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!),
                                                                                                                                                                       Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1),
                                                                                                                                                                       },
                                                                                                                                                                          child:Text(childrenGroup3.description!)),*/



                                                                                                    ///Level 5
                                                                                                                                                                           children: [
                                                                                        ListView.builder(
                                                                                                          shrinkWrap: true,
                                                                                                          physics: const NeverScrollableScrollPhysics(),

                                                                                                          itemCount: childrenGroup3.childrenGroup4!.length,
                                                                                                          padding: const EdgeInsets.all(0),
                                                                                                          itemBuilder: (context, index4) {
                                                                                                                                             late ChildrenGroup4 childrenGroup4;
                                                                                                                                             childrenGroup4=childrenGroup3.childrenGroup4![index4];
                                                                                                                                             if(childrenGroup4.childrenGroup5!.isNotEmpty) {
                                                                                                                                             return Column(children: [
                                                                                                                                               Row(children: [
                                                                                                                                                 const SizedBox(width: 15),
                                                                                                                                                 Expanded(child: Container(
                                                                                                                                                   color: Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup4.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),
                                                                                                                                                   child: ExpansionTile(
                                                                                                                                                       controlAffinity:ListTileControlAffinity.leading,
                                                                                                                                                       textColor:Theme.of(context).primaryColor,
                                                                                                                                                     //leading: childrenGroup3.childrenGroup4!.isNotEmpty ? Image.asset(Images.assembly, width: 30, height: 30,color: Theme.of(context).primaryColor ):const SizedBox(width: 30,),
                                                                                                                                                     //trailing: const Icon(Icons.expand_more, size: 35.0, color: ColorResources.blue),
                                                                                                                                                       initiallyExpanded: Provider.of<MachinesProvider>(context, listen: false).isExpanded4[index4],
                                                                                                                                                       onExpansionChanged: (bool expanded4) {
                                                                                                                                                         setState(() {
                                                                                                                                                           Provider.of<MachinesProvider>(context, listen: false).isExpanded4[index4]= expanded4;
                                                                                                                                                           Provider.of<MachinesProvider>(context, listen: false).isExpanded5= List.filled(100, false, growable: true);
                                                                                                                                                           Provider.of<MachinesProvider>(context, listen: false).isExpanded6= List.filled(100, false, growable: true);
                                                                                                                                                         });
                                                                                                                                                       },
                                                                                                                                                       leading: Icon(
                                                                                                                                                           Provider.of<MachinesProvider>(context, listen: false).isExpanded4[index4]
                                                                                                                                                               ? Icons.expand_less
                                                                                                                                                               : Icons.expand_more, size: 25.0, color: ColorResources.blue
                                                                                                                                                       ),
                                                                                                                                                     title: InkWell(
                                                                                                                                                                                                                                                                                                 onTap: () => {
                                                                                                                                                                                                                                                                                                Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup4.machineid!,childrenGroup4.code!,childrenGroup4.has3D!,childrenGroup4.hasgraphic!,childrenGroup4.graphic!),
                                                                                                                                                                                                                                                                                                   Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!),
                                                                                                                                                                                                                                                                                                   Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1),
                                                                                                                                                                                                                                                                                                   Navigator.pop(context),
                                                                                                                                                                                                                                                                                                },
                                                                                                                                                                                                                                                                                                child:Row(children: [
                                                                                                                                                      // Text( childrenGroup4.code!),
                                                                                                                                                                                                                                                                                                  Expanded(
                                                                                                                                                   child: Text( '${childrenGroup4.code!} - ${childrenGroup4.description!}',overflow: TextOverflow.ellipsis,
                                                                                                                                                     style: ubuntuRegularLow.copyWith(color: Colors.black,fontSize: 12),maxLines: 3,),
                                                                                                                                                                                                                                                                                                  ),


                                                                                                                                                       if(childrenGroup4.has3D==true)
                                                                                                                                                         Row(children: [
                                                                                                                                                           const SizedBox(width: 5),
                                                                                                                                                           SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                                                                                                                                                     ])),
                                                                                                                                                    /* subtitle: InkWell(
                                                                                                                                                     onTap: () => {
                                                                                                                                                                                                                                                                                                Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup4.machineid!,childrenGroup4.code!,childrenGroup4.has3D!,childrenGroup4.has3D!),
                                                                                                                                                                                                                                                                                                Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(1,childrenGroup4.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!),
                                                                                                                                                                                                                                                                                                Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1),
                                                                                                                                                                                                                                                                                                },
                                                                                                                                                                                                                                                                                                child:Text(childrenGroup4.description!)),*/


                                                                                                                                                       ///Level 6
                                                                                                                                                   children: [
                                                                                                                                                   ListView.builder(
                                                                                                                                                   shrinkWrap: true,
                                                                                                                                                   physics: const NeverScrollableScrollPhysics(),
                                                                                                                                                   itemCount:childrenGroup4.childrenGroup5!.length,
                                                                                                                                                   padding: const EdgeInsets.all(0),
                                                                                                                                                                                                                                                                                                itemBuilder: (context, index5) {
                                                                                                                                                                                                                                                                                                late ChildrenGroup5 childrenGroup5;
                                                                                                                                                                                                                                                                                                childrenGroup5=childrenGroup4.childrenGroup5![index5];
                                                                                                                                                                                                                                                                                                if(childrenGroup5.childrenGroup6!.isNotEmpty) {
                                                                                                                                                                                                                                                                                                return Column(children: [
                                                                                                                                                                                                                                                                                                Row(children: [
                                                                                                                                                                                                                                                                                                const SizedBox(width: 15),
                                                                                                                                                                                                                                                                                                Expanded(child: Container(
                                                                                                                                                                                                                                                                                                  color: Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup5.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),
                                                                                                                                                                                                                                                                                                  child: ExpansionTile(
                                                                                                                                                                                                                                                                                                  controlAffinity:ListTileControlAffinity.leading,
                                                                                                                                                                                                                                                                                                  textColor:Theme.of(context).primaryColor,
                                                                                                                                                                                                                                                                                                  //leading: childrenGroup4.childrenGroup5!.isNotEmpty ? Image.asset(Images.assembly, width: 30, height: 30,color: Theme.of(context).primaryColor ):const SizedBox(width: 30,),
                                                                                                                                                                                                                                                                                                  //trailing: const Icon(Icons.expand_more, size: 35.0, color: ColorResources.blue),
                                                                                                                                                                                                                                                                                                                                                                                                                                                     initiallyExpanded: Provider.of<MachinesProvider>(context, listen: false).isExpanded5[index5],
                                                                                                                                                                                                                                                                                                                                                                                                                                                     onExpansionChanged: (bool expanded5) {
                                                                                                                                                                                                                                                                                                                                                                                                                                                       setState(() {
                                                                                                                                                                                                                                                                                                                                                                                                                                                         Provider.of<MachinesProvider>(context, listen: false).isExpanded5[index5]= expanded5;
                                                                                                                                                                                                                                                                                                                                                                                                                                                         Provider.of<MachinesProvider>(context, listen: false).isExpanded6= List.filled(100, false, growable: true);
                                                                                                                                                                                                                                                                                                                                                                                                                                                       });
                                                                                                                                                                                                                                                                                                                                                                                                                                                     },
                                                                                                                                                                                                                                                                                                                                                                                                                                                     leading: Icon(
                                                                                                                                                                                                                                                                                                                                                                                                                                                         Provider.of<MachinesProvider>(context, listen: false).isExpanded5[index5]
                                                                                                                                                                                                                                                                                                                                                                                                                                                             ? Icons.expand_less
                                                                                                                                                                                                                                                                                                                                                                                                                                                             : Icons.expand_more, size: 25.0, color: ColorResources.blue
                                                                                                                                                                                                                                                                                                                                                                                                                                                     ),
                                                                                                                                                                                                                                                                                                  title: InkWell(
                                                                                                                                                                                                                                                                                                                                                                                                                                                     onTap: ()  {
                                                                                                                                                                                                                                                                                                                                                                                                                                                      setState(() {
                                                                                                                                                                                                                                                                                                                                                                                                                                                       Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup5.machineid!,childrenGroup5.code!,childrenGroup5.has3D!,childrenGroup5.hasgraphic!,childrenGroup5.graphic!);
                                                                                                                                                                                                                                                                                                                                                                                                                                                       Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!);
                                                                                                                                                                                                                                                                                                                                                                                                                                                       Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1);
                                                                                                                                                                                                                                                                                                                                                                                                                                                       Navigator.pop(context);
                                                                                                                                                                                                                                                                                                                                                                                                                                                     });},
                                                                                                                                                                                                                                                                                                                                                                                                                                                     child:Row(children: [
                                                                                                                                                                                                                                                                                                  //Text( childrenGroup5.code!),
                                                                                                                                                                                                                                                                                                                                                                                                                                                       Expanded(
                                                                                                                                                                                                                                                                                                                                                                                                                                                         child: Text( '${childrenGroup5.code!} - ${childrenGroup5.description!}',overflow: TextOverflow.ellipsis,
                                                                                                                                                                                                                                                                                                                                                                                                                                                           style: ubuntuRegularLow.copyWith(color: Colors.black,fontSize: 12),maxLines: 3,),
                                                                                                                                                                                                                                                                                                                                                                                                                                                       ),

                                                                                                                                                                                                                                                                                                                                                                                                                                                       if(childrenGroup5.has3D==true)
                                                                                                                                                                                                                                                                                                  Row(children: [
                                                                                                                                                                                                                                                                                                  const SizedBox(width: 5),
                                                                                                                                                                                                                                                                                                  SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                                                                                                                                                                                                                                                                                                  ])),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                /* subtitle: InkWell(
                                                                                                                                                                                                                                                                                                  onTap: () => {
                                                                                                                                                                                                                                                                                                    Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup5.machineid!,childrenGroup5.code!,childrenGroup5.has3D!,childrenGroup5.has3D!),
                                                                                                                                                                                                                                                                                                    Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(1,childrenGroup5.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!),
                                                                                                                                                                                                                                                                                                    Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1),
                                                                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                                                                    child:Text(childrenGroup5.description!)),*/



                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ///Level 7
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           children: [
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ListView.builder(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           shrinkWrap: true,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           physics: const NeverScrollableScrollPhysics(),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           itemCount:childrenGroup5.childrenGroup6!.length,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           padding: const EdgeInsets.all(0),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           itemBuilder: (context, index6) {
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           late ChildrenGroup6 childrenGroup6;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           childrenGroup6=childrenGroup5.childrenGroup6![index6];
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           return Column(children: [
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Row(children: [
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           const SizedBox(width: 15),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Expanded(child: Container(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             color: Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup6.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             child: ExpansionTile(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             controlAffinity:ListTileControlAffinity.leading,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             textColor:Theme.of(context).primaryColor,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             //leading: childrenGroup5.childrenGroup6!.isNotEmpty ? Image.asset(Images.assembly, width: 30, height: 30,color: Theme.of(context).primaryColor ):const SizedBox(width: 30,),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                              //trailing:Icon(Icons.navigate_next, color: Theme.of(context).textTheme.bodyLarge!.color ,size: 22.0,),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               initiallyExpanded: Provider.of<MachinesProvider>(context, listen: false).isExpanded6[index6],
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               onExpansionChanged: (bool expanded6) {
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 setState(() {
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Provider.of<MachinesProvider>(context, listen: false).isExpanded6[index6]= expanded6;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 });
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               },
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 leading: Icon(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Provider.of<MachinesProvider>(context, listen: false).isExpanded6[index6]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ? Icons.expand_less
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             : Icons.expand_more, size: 25.0, color: ColorResources.black
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             title: InkWell(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 onTap: () => {
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup6.machineid!,childrenGroup6.code!,childrenGroup6.has3D!,childrenGroup6.hasgraphic!,childrenGroup6.graphic!),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Navigator.pop(context),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 },
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 child:Row(children: [
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Expanded(child: Text('${childrenGroup6.code!} - ${childrenGroup6.description!}', style: ubuntuRegularLow.copyWith(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             fontSize: 12, color: Colors.black),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis)),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             if(childrenGroup6.has3D==true)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             Row(children: [
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             const SizedBox(width: 5),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ])),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             /*subtitle: InkWell(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             onTap: () => {
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup6.machineid!,childrenGroup6.code!,childrenGroup6.has3D!,childrenGroup6.has3D!),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(1,childrenGroup6.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               },
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               child:Text(childrenGroup6.description!),)*/
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ))
                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ])]);


                                                                                                                                                                                                                                                                                                                                                                                                                                                                           })]),
                                                                                                                                                                                                                                                                                                ))])]);
                                                                                                                                                                         }
                                                                                                                                                                         else {
                                                                                                                                                                         return  Container(
                                                                                                                                                                           color: Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup5.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),
                                                                                                                                                                           child: ListTile(
                                                                                                                                                                           title: Row(children: [
                                                                                                                                                                           const SizedBox(width: 70,),
                                                                                                                                                                             Expanded(child: Text('${childrenGroup5.code!} - ${childrenGroup5.description!}', style: ubuntuRegularLow.copyWith(
                                                                                                                                                                                                                                             fontSize: 12, color: Colors.black),
                                                                                                                                                                                                                                             maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis)),
                                                                                                                                                                           if(childrenGroup5.has3D==true)
                                                                                                                                                                           Row(children: [
                                                                                                                                                                           const SizedBox(width: 5),
                                                                                                                                                                           SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                                                                                                                                                                           ]),
                                                                                                                                                                           subtitle: Row(children: [
                                                                                                                                                                           const SizedBox(width: 70,),
                                                                                                                                                                           Expanded(child: Text(childrenGroup5.description!, style: textMedium.copyWith(
                                                                                                                                                                           fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge?.color),
                                                                                                                                                                           maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis))
                                                                                                                                                                           //
                                                                                                                                                                           ]),
                                                                                                                                                                           trailing:Icon(Icons.navigate_next, color: Theme.of(context).primaryColor ,size: 22.0,),
                                                                                                                                                                           onTap: () {
                                                                                                                                                                             setState((){
                                                                                                                                                                           Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup5.machineid!,childrenGroup5.code!,childrenGroup5.has3D!,childrenGroup5.hasgraphic!,childrenGroup5.graphic!);
                                                                                                                                                                           Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!);
                                                                                                                                                                             Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1);
                                                                                                                                                                             Navigator.pop(context);
                                                                                                                                                                           });},
                                                                                                                                                                           ),
                                                                                                                                                                         );
                                                                                                                                                                         }
                                                                                                                                                                                                                                                                                                })
                                                                                                                                                                                                                                                              ]),
                                                                                                                                                 ))])]);

                                                                                                                                                                       }
                                                                                                                                                                       else {
                                                                                                                                                                       return  Container(
                                                                                                                                                                         color: Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup4.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),
                                                                                                                                                                         child: ListTile(
                                                                                                                                                                         title: Row(children: [
                                                                                                                                                                         const SizedBox(width: 70,),
                                                                                                                                                                           Expanded(child: Text('${childrenGroup4.code!} - ${childrenGroup4.description!}', style: ubuntuRegularLow.copyWith(
                                                                                                                                                                                                                                                                 fontSize: 12, color: Colors.black),
                                                                                                                                                                                                                                                                 maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis)),
                                                                                                                                                                         if(childrenGroup4.has3D==true)
                                                                                                                                                                         Row(children: [
                                                                                                                                                                         const SizedBox(width: 5),
                                                                                                                                                                         SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                                                                                                                                                                         ]),
                                                                                                                                                                         subtitle: Row(children: [
                                                                                                                                                                         const SizedBox(width: 70,),
                                                                                                                                                                         Expanded(child: Text(childrenGroup4.description!, style: textMedium.copyWith(
                                                                                                                                                                         fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge?.color),
                                                                                                                                                                         maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis))
                                                                                                                                                                         //
                                                                                                                                                                         ]),
                                                                                                                                                                         trailing:Icon(Icons.navigate_next, color: Theme.of(context).primaryColor ,size: 22.0,),
                                                                                                                                                                         onTap: () {
                                                                                                                                                                           setState((){
                                                                                                                                                                         Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup4.machineid!,childrenGroup4.code!,childrenGroup4.has3D!,childrenGroup4.hasgraphic!,childrenGroup4.graphic!);
                                                                                                                                                                         Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!);
                                                                                                                                                                           Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1);
                                                                                                                                                                           Navigator.pop(context);
                                                                                                                                                                         });},
                                                                                                                                                                         ),
                                                                                                                                                                       );
                                                                                                                                                                       }

                                                                                                                                                                     })]



                                                                                                                                                                    ),
                                                                                     )) ])]);

                                                                                }
                                                                                else {
                                                                                return  Container(
                                                                                  color: Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup3.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),
                                                                                  child: ListTile(
                                                                                  title: Row(children: [
                                                                                  const SizedBox(width: 70,),
                                                                                    Expanded(child: Text('${childrenGroup3.code!} - ${childrenGroup3.description!}', style: ubuntuRegularLow.copyWith(
                                                                                        fontSize: 12, color: Colors.black),
                                                                                        maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis)),
                                                                                  if(childrenGroup3.has3D==true)
                                                                                  Row(children: [
                                                                                  const SizedBox(width: 5),
                                                                                  SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                                                                                  ]),
                                                                                  subtitle: Row(children: [
                                                                                  const SizedBox(width: 70,),
                                                                                  Expanded(child: Text(childrenGroup3.description!, style: textMedium.copyWith(
                                                                                  fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge?.color),
                                                                                  maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis))
                                                                                  //
                                                                                  ]),
                                                                                  trailing:Icon(Icons.navigate_next, color: Theme.of(context).primaryColor ,size: 22.0,),
                                                                                  onTap: () {
                                                                                    setState((){
                                                                                  Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup3.machineid!,childrenGroup3.code!,childrenGroup3.has3D!,childrenGroup3.hasgraphic!,childrenGroup3.graphic!);
                                                                                  Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!);
                                                                                    Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1);
                                                                                    Navigator.pop(context);
                                                                                  });},
                                                                                  ),
                                                                                );
                                                                                }

                                                                              })]


                                                                             ),
                                                    ))])]);

                                                                              }
                                                                              else {
                                                                              return  Container(
                                                                                color: Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup2.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),
                                                                                child: ListTile(
                                                                                title: Row(children: [
                                                                                const SizedBox(width: 70,),
                                                                                  Expanded(child: Text('${childrenGroup2.code!} - ${childrenGroup2.description!}', style: ubuntuRegularLow.copyWith(
                                                                                      fontSize: 12, color: Colors.black),
                                                                                      maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis)),
                                                                                if(childrenGroup2.has3D==true)
                                                                                Row(children: [
                                                                                const SizedBox(width: 5),
                                                                                SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                                                                                ]),
                                                                                subtitle: Row(children: [
                                                                                const SizedBox(width: 70,),
                                                                                Expanded(child: Text(childrenGroup2.description!, style: textMedium.copyWith(
                                                                                fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge?.color),
                                                                                maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis))
                                                                                //
                                                                                ]),
                                                                                trailing:Icon(Icons.navigate_next, color: Theme.of(context).primaryColor ,size: 22.0,),
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup2.machineid!,childrenGroup2.code!,childrenGroup2.has3D!,childrenGroup2.hasgraphic!,childrenGroup2.graphic!);
                                                                                Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!);
                                                                                  Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1);
                                                                                  Navigator.pop(context);
                                                                                });},
                                                                                ),
                                                                              );
                                                                              }


                                                                           })]



                                                                            ),
                                          ))])]);
                                  }
                                  else {
                                  return  Container(
                                      color: Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup1.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),
                                            child:ListTile(
                                  title: Row(children: [
                                    const SizedBox(width: 70,),
                                      Expanded(child:
                                      Text('${childrenGroup1.code!} - ${childrenGroup1.description!}', style: ubuntuRegularLow.copyWith(
                                          fontSize: 12, color: Colors.black),
                                          maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis)),
                                    if(childrenGroup1.has3D==true)
                                    Row(children: [
                                    const SizedBox(width: 5),
                                    SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                                    ]),

                                 /* subtitle: Row(children: [
                                  const SizedBox(width: 70,),
                                  Expanded(child: Text(childrenGroup1.description!, style: textMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge?.color),
                                  maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis))
                                  //
                                  ]),*/
                                  trailing:Icon(Icons.navigate_next, color: Theme.of(context).primaryColor ,size: 22.0,),
                                  onTap: () {
                                    setState(() {
                                  Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup1.machineid!,childrenGroup1.code!,childrenGroup1.has3D!,childrenGroup1.hasgraphic!,childrenGroup1.graphic!);
                                  Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!);
                                    Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1);
                                    Navigator.pop(context);
                                  });},
                                  ));
                                  }


                                          })]


                               ),
                            )

                            )]),
                            ]);
                              }
                              else {
                                return  Container(
                                  color: Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode! == childrenGroup.code! ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0),
                                  child: ListTile(
                                      title: InkWell(
                                          onTap: () {
                                            Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup.machineid!,childrenGroup.code!,childrenGroup.has3D!,childrenGroup.hasgraphic!,childrenGroup.graphic!);
                                            Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!);
                                            Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1);
                                            Navigator.pop(context);
                                          },
                                          child:Row(children: [
                                          const SizedBox(width: 70,),
                                         Expanded(child:
                                                Text('${childrenGroup.code!} - ${childrenGroup.description!}', style: ubuntuRegularLow.copyWith(
                                               fontSize: 12, color: Colors.black),
                                               maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis)),

                                          if(childrenGroup.has3D==true)
                                            Row(children: [
                                              const SizedBox(width: 5),
                                              SizedBox(width: 20, height: 20,child: SvgPicture.asset(Images.threeDIcon1,height: 20,width: 20, color:Theme.of(context).primaryColor)),])
                                      ])),
                                      /*subtitle: Row(children: [
                                         const SizedBox(width: 70,),
                                         Expanded(child: Text(childrenGroup.description!, style: textMedium.copyWith(
                                                 fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge?.color),
                                             maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis))
                                          //
                                       ]),*/
                                       trailing:Icon(Icons.navigate_next, color: Theme.of(context).primaryColor ,size: 22.0,),
                                      onTap: () {
                                         setState(() {
                                        Provider.of<MachinesProvider>(context, listen: false).changeSelectedAssembly(childrenGroup.machineid!,childrenGroup.code!,childrenGroup.has3D!,childrenGroup.hasgraphic!,childrenGroup.graphic!);
                                        Provider.of<MachinesProvider>(context, listen: false).getMachineAssemblyParts(widget.machineAssemblyList!.machineid!,Provider.of<MachinesProvider>(context, listen: false).machineSelectedcode!);
                                        Provider.of<MachinesProvider>(context, listen: false).machineTabController!.animateTo(1);
                                        Navigator.pop(context);
                                      });},
                                  ),
                                );
                              }

                          },
                        ),

                    ],
                  ),

              ])

          ),
        )
      ],
    ); //,
    //  );
  }
}
