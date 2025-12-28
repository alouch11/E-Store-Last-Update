import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/machines_model.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spareparts_store/features/lines/widget/machine_emergency_image_pop.dart';

class MachineEmergencyWidget extends StatefulWidget {
  final EmergencyList? machineEmergencyList;
  final bool? isExpanded;
  final UniqueKey? keyTile;
  const MachineEmergencyWidget(
      {super.key, this.machineEmergencyList,required this.isExpanded,required this.keyTile});

  @override
  State<MachineEmergencyWidget> createState() => _MachineEmergencyWidgetState();
}

class _MachineEmergencyWidgetState extends State<MachineEmergencyWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 1))
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .cardColor
                      .withOpacity(Get.isDarkMode ? 0.5 : 1),
                  boxShadow: shadow),
              margin: const EdgeInsets.only(bottom: 3),
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeExtraExtraSmall,
                horizontal: Dimensions.paddingSizeExtraExtraSmall,
              ),
              child:  Column(children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ExpansionTile(
                        key: widget.keyTile,
                        initiallyExpanded:widget.isExpanded!,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.15),
                        leading: Image.asset(Images.assembly, width: 30, height: 30,color: Theme.of(context).primaryColor ),
                        trailing: const Icon(Icons.expand_more,
                            size: 35.0, color: ColorResources.blue),
                        title: Text(widget.machineEmergencyList!.assemblyCode!),
                        subtitle: Text(widget.machineEmergencyList!.assemblyDescription!),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: SizedBox(
                              height: 15,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 100,
                                    child: Text('${getTranslated('code', context)}',
                                      overflow: TextOverflow.ellipsis,
                                      style: ubuntuRegularLow.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      '${getTranslated('description', context)}',
                                      overflow: TextOverflow.ellipsis,
                                      style: ubuntuRegularLow.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      '${getTranslated('qty', context)}',
                                      overflow: TextOverflow.ellipsis,
                                      style: ubuntuRegularLow.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      '${getTranslated('uom', context)}',
                                      overflow: TextOverflow.ellipsis,
                                      style: ubuntuRegularLow.copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            endIndent: 10.0,
                            indent: 10.0,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.7),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:
                                    Dimensions.paddingSizeExtraExtraSmall,
                                vertical: Dimensions.paddingSizeSmall),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.machineEmergencyList!.assemblyemergencyitems!.length,
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (context, index) {
                                return Column(children: [
                                  Row(children: [
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 90,
                                      child: Text(
                                        widget.machineEmergencyList!.assemblyemergencyitems![index].partCode!,
                                        overflow: TextOverflow.ellipsis,
                                        style: ubuntuRegularLow.copyWith(
                                            color: Theme.of(context).hintColor),
                                      ),
                                    ),
                                    SizedBox(
                                        width: 240,
                                        child: Row(children: [
                                          InkWell(
                                            onTap: () async {
                                              final res = await http.get(Uri.parse(
                                                  '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productImageUrl}/${widget.machineEmergencyList!.assemblyemergencyitems![index].partCode}.webp'));
                                              if (res.statusCode == 200) {
                                                await showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        MachineEmergencyImagePop(
                                                            image:
                                                                '${widget.machineEmergencyList!.assemblyemergencyitems![index].partCode}.webp',
                                                            url: Provider.of<
                                                                        SplashProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .baseUrls!
                                                                .productImageUrl,
                                                            width: 400,
                                                            height: 400));
                                              } else {
                                                showCustomSnackBar(
                                                    '${getTranslated('no_image', context)}',
                                                    context);
                                              }
                                            },
                                            child: Icon(Icons.photo_camera,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${widget.machineEmergencyList!.assemblyemergencyitems![index].materialDescription}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: ubuntuRegularLow.copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor),
                                            ),
                                          )
                                        ])),
                                  ]),
                                  Row(children: [
                                    const SizedBox(width: 235),
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                        "${widget.machineEmergencyList!.assemblyemergencyitems![index].quantity}",
                                        overflow: TextOverflow.ellipsis,
                                        style: ubuntuRegularLow.copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                        "${widget.machineEmergencyList!.assemblyemergencyitems![index].uom}",
                                        overflow: TextOverflow.ellipsis,
                                        style: ubuntuRegularLow.copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ),
                                  ]),
                                ]);
                              },
                            ),
                          )
                        ],
                      ),

                    )
                  ])

            ),
          ),
        )
      ],
    ); //,
    //  );
  }
}
