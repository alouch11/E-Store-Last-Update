import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/paginated_list_view.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/lines_model.dart';
import 'package:flutter_spareparts_store/features/lines/provider/lines_provider.dart';
import 'package:flutter_spareparts_store/features/sale/widget/sale_shimmer.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:provider/provider.dart';


class LinesWidget1 extends StatefulWidget {
  final Lines? linesModelMk;
  final String? site;

  const LinesWidget1({super.key, this.linesModelMk,required this.site});


  @override
  State<LinesWidget1> createState() => _LinesWidget1State();
}

  class _LinesWidget1State extends State<LinesWidget1> {

  ScrollController scrollController  = ScrollController();
  bool isGuestMode = !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();



  @override
  void initState() {
    if(!isGuestMode){
      Provider.of<LinesProvider>(context, listen: false).getLinesList(1,'Muyuka');
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    ScrollController scrollController  = ScrollController();
      return
        Consumer<LinesProvider>(
            builder: (context, linesProvider, child) {

              return
                Expanded(child:Column(
                children: [
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Expanded(child: linesProvider.linesModelMk != null ? (linesProvider.linesModelMk!.lines != null && linesProvider.linesModelMk!.lines!.isNotEmpty)?
               SingleChildScrollView(
                  controller: scrollController,
                  child:

                  Column(
              children: [

                     CustomButton(buttonText: widget.site,isBorder: true,leftIcon: 'assets/images/location.png',),
                    const SizedBox(height: 5,),
                    PaginatedListView(scrollController: scrollController,
                      onPaginate: (int? offset) async{
                        await linesProvider.getLinesList(offset!,'Muyuka');
                      },
                      totalSize: linesProvider.linesModelMk?.totalLines,
                      offset: linesProvider.linesModelMk?.offset != null ? int.parse(linesProvider.linesModelMk!.offset!):1,
                      itemView:
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: linesProvider.linesModelMk?.lines!.length,
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          return  Column(
                              children: [
                                Card(elevation: 5,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                                    child:ExpansionTile(
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                                      leading: const Icon(Icons.factory,color: ColorResources.blue),
                                      trailing: const Icon(Icons.expand_more,size: 35.0,color: ColorResources.blue),
                                      title: Text(linesProvider.linesModelMk!.lines![index].lineName!),
                                      subtitle: Text(linesProvider.linesModelMk!.lines![index].name!),
                                      children: linesProvider.linesModelMk!.lines![index].machines!.map<Widget>((machines) {
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: ListTile(
                                            //leading: const Icon(Icons.list_alt_rounded,color: ColorResources.blue)
                                              leading:  Image.asset(width: 25 , height: 25, Images.machine,color: ColorResources.blue,),
                                              trailing: const Icon(Icons.more_horiz,color: ColorResources.blue),
                                              title: Text(machines.name!)
                                          ),
                                        );
                                      }).toList(),
                                    ))]);
                        },



                      ),

                    ),

                    const SizedBox(height: 30,),
                  ]),

                ) : const NoInternetOrDataScreen(isNoInternet: false, icon: Images.icon, message: 'no_lines_found',) : const SaleShimmer()
                )
              ],
              ));
            }



        );
    }
}