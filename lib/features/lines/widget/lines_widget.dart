import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/paginated_list_view.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/lines_model.dart';
import 'package:flutter_spareparts_store/features/lines/provider/lines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_screen.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_screen_extra.dart';
import 'package:flutter_spareparts_store/features/sale/widget/sale_shimmer.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;


class LinesWidget extends StatefulWidget {
  final Lines? linesModelBk;
  final Lines? linesModelMk;
  final String? site;

  const LinesWidget({super.key, this.linesModelBk,this.linesModelMk,required this.site});


  @override
  State<LinesWidget> createState() => _LinesWidgetState();
}

  class _LinesWidgetState extends State<LinesWidget> {

  ScrollController scrollController  = ScrollController();
  bool isGuestMode = !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();



  @override
  void initState() {
    if(!isGuestMode){
    //  Provider.of<LinesProvider>(context, listen: false).getLinesList(1,'Bekoko');
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

      return
        Consumer<LinesProvider>(
            builder: (context, linesProvider, child) {
              return Column(
                children: [
                const SizedBox(height: 0),
              Column(
              children: [
              Container(height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor, width: 1),
              color:   Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [

              Padding(padding: const EdgeInsets.only(right: 5),
              child: SizedBox(width: 30, child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Image.asset(Images.mapMarker),
              )),
              ),
              Flexible(
              child: Text(widget.site!, style: titilliumSemiBold.copyWith(fontSize: 16,
              color: Colors.white ,
              )),
              ),
              /* const Padding(padding: EdgeInsets.only(right: 5),
                      child: SizedBox(width: 30, child: Padding(
                        padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                        //child: Image.asset(Images.mapMarker),
                        child:Icon(Icons.factory,color: Colors.white,),
                      )),
                    ),*/
              ],
              ),
              ),]),
                     const SizedBox(height: 5,),


                Expanded(child:
                linesProvider.linesModelBk != null ? (linesProvider.linesModelBk!.lines != null && linesProvider.linesModelBk!.lines!.isNotEmpty)?
               SingleChildScrollView(
                  controller: scrollController,
                  child: PaginatedListView(
                      scrollController: scrollController,
                      onPaginate: (int? offset) async{
                        await linesProvider.getLinesList(offset!,'Bekoko');
                      },
                      totalSize: linesProvider.linesModelBk?.totalLines ,
                      offset: linesProvider.linesModelBk?.offset != null ? int.parse(linesProvider.linesModelBk!.offset!):1,
                      itemView:
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: linesProvider.linesModelBk?.lines!.length,
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          return  Column(
                              children: [
                                Card(elevation: 2,
                                    color:
                                    /*linesProvider.linesModelBk!.lines![index].productType =='CSD'? const Color(0xF6FAC620).withOpacity(0.5) :
                                    linesProvider.linesModelBk!.lines![index].productType =='Water - flat'? ColorResources.getFloatingBtn(context).withOpacity(.5):
                                    linesProvider.linesModelBk!.lines![index].productType =='Juice'?   const Color(0xfffa7c02).withOpacity(.5) :
                                    linesProvider.linesModelBk!.lines![index].productType =='CO2'?  ColorResources.getYellow1(context).withOpacity(.5) :
                                    linesProvider.linesModelBk!.lines![index].productType =='Utility'?  ColorResources.getCheris(context).withOpacity(.5) :
                                    linesProvider.linesModelBk!.lines![index].productType =='Power'?  ColorResources.red.withOpacity(0.5) :
                                    linesProvider.linesModelBk!.lines![index].productType =='Water/Syrup'?  const Color(0xff042cfc).withOpacity(0.7) :*/
                                    Colors.white,


                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child:ExpansionTile(
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                     // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.15),
                                     // backgroundColor:Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.15),
                                      //leading: const Icon(Icons.factory,color: ColorResources.blue),
                                      leading: Image.asset(width: 25 , height: 25, Images.line,color: ColorResources.blue,),
                                      trailing: const Icon(Icons.expand_more,size: 35.0,color: ColorResources.blue),
                                      title: Text(linesProvider.linesModelBk!.lines![index].lineName!, style: ubuntuBold,),
                                      subtitle: SizedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          //mainAxisSize: MainAxisSize.max,
                                          //mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                               /* Text('${getTranslated('name', context)}',style: ubuntuBold,),
                                                const SizedBox(height: Dimensions.paddingSizeSmall),*/

                                                Expanded(child: Text(linesProvider.linesModelBk!.lines![index].name!, overflow: TextOverflow.ellipsis, style: ubuntuBold,maxLines: 2,)),
                                              ],
                                            ),
                                            if(linesProvider.linesModelBk!.lines![index].productType !=null && linesProvider.linesModelBk!.lines![index].productType !='')
                                            Row(
                                              children: [
                                                Text('${getTranslated('product_type', context)}',style: ubuntuLight,),
                                                const SizedBox(height: Dimensions.paddingSizeSmall),

                                                Text(" : ${linesProvider.linesModelBk!.lines![index].productType!}", overflow: TextOverflow.ellipsis, style: ubuntuBold,maxLines: 2,),
                                              ],
                                            ),
                                            if(linesProvider.linesModelBk!.lines![index].packagingMaterial !='None' && linesProvider.linesModelBk!.lines![index].packagingMaterial !=null)
                                            Row(
                                              children: [
                                                // const Text('Service', style: ubuntuMedium,),
                                                Text('${getTranslated('product_materials', context)}',style: ubuntuLight,),
                                                const SizedBox(height: Dimensions.paddingSizeSmall),

                                                Text(" : ${linesProvider.linesModelBk!.lines![index].packagingMaterial!}", overflow: TextOverflow.ellipsis, style: ubuntuBold,maxLines: 2,),
                                              ],
                                            ),
                                            if(linesProvider.linesModelBk!.lines![index].productSize !='None' && linesProvider.linesModelBk!.lines![index].productSize !=null)
                                            Row(
                                              children: [
                                                // const Text('Service', style: ubuntuMedium,),
                                                Text('${getTranslated('product_Size', context)}',style: ubuntuLight,),
                                                const SizedBox(height: Dimensions.paddingSizeSmall),
                                               Text(" : ${linesProvider.linesModelBk!.lines![index].productSize!}", overflow: TextOverflow.ellipsis, style: ubuntuBold,maxLines: 2,),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: linesProvider.linesModelBk!.lines![index].machines!.length,
                                          padding: const EdgeInsets.only(left: 45,right: 0),
                                           itemBuilder: (context, i){
                                            return ListTile(
                                              splashColor: Colors.blueAccent.withOpacity(0.3),
                                              textColor: linesProvider.linesModelBk!.lines![index].machines![i].hasBOM! ? Colors.black:Colors.grey,

                                                onTap: ()=> {
                                                  if(linesProvider.linesModelBk!.lines![index].machines![i].hasBOM== true) {
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MachineScreen(machineModel:linesProvider.linesModelBk?.lines![index].machines![i])))
                                                }},
                                                //leading: const Icon(Icons.list_alt_rounded,color: ColorResources.blue),
                                                leading:  Image.asset(width: 25 , height: 25, Images.machine,color:linesProvider.linesModelBk!.lines![index].machines![i].hasBOM! ? ColorResources.primaryColor:ColorResources.hintTextColor,),
                                                trailing: InkWell(
                                                  onTap: ()=>
                                                  {
                                                    if(linesProvider.linesModelBk!.lines![index].machines![i].hasInformations == true) {
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MachineScreenExtra(machineModel: linesProvider.linesModelBk?.lines![index].machines![i])))
                                                    },
                                                  },
                                                child:  Icon(Icons.more_horiz,color: linesProvider.linesModelBk!.lines![index].machines![i].hasInformations == true ? ColorResources.blue:ColorResources.hintTextColor),
                                                ),
                                                title: Text(linesProvider.linesModelBk!.lines![index].machines![i].name!)
                                            );
                                          },
                                        ),
                                      ],
                                    ),

                                )]);
                        },

                  ),

                ),

                  //  const SizedBox(height: 30,),
                 // ]),

                )
                  : const NoInternetOrDataScreen(isNoInternet: false, icon: Images.icon, message: 'no_lines_found',) : const SaleShimmer()
                )
              ],
              );
            }



        );
    }
}