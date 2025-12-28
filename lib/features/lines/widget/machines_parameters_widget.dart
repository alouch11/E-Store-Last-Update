import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/machines_model.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machine_parameters_details_screen.dart';
//import 'package:flutter_spareparts_store/features/pdf/pdf_viewer.dart';
import 'package:flutter_spareparts_store/features/product/domain/model/product_details_model.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MachineParametersWidget extends StatefulWidget {
  final ParametersList? machineParametersList;
  final bool? isExpanded;
  final UniqueKey? keyTile;
  const MachineParametersWidget(
      {super.key, this.machineParametersList,required this.isExpanded,required this.keyTile});

  @override
  State<MachineParametersWidget> createState() => _MachineParametersWidgetState();
}

class _MachineParametersWidgetState extends State<MachineParametersWidget> {

  @override
  Widget build(BuildContext context) {

    List<int>? userauthlevel =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.userauthlevel;


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
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ExpansionTile(
                        key: widget.keyTile,
                        initiallyExpanded:widget.isExpanded!,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        leading: Image.asset(widget.machineParametersList!.docIcon!, width: 40, height: 40,color: Theme.of(context).primaryColor ),
                        trailing: const Icon(Icons.expand_more,
                            size: 35.0, color: ColorResources.blue),
                        title: Text(widget.machineParametersList !.parametersTitle!),
                        //subtitle: Text(widget.machineTechnicalDocList !.catalogueTitle!),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            child: SizedBox(
                              height: 15,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  const SizedBox(width: 20),


                                SizedBox(width: MediaQuery.of(context).size.width* 0.7,
                                  child: Text(
                                        '${getTranslated('description', context)}',
                                        overflow: TextOverflow.ellipsis,
                                        style: ubuntuRegularLow.copyWith(
                                            color:
                                            Theme.of(context).primaryColor),
                                      ),
                                ),


                                   SizedBox(width: MediaQuery.of(context).size.width* 0.4,
                                     child: Text(
                                        '${getTranslated('view', context)}',
                                        overflow: TextOverflow.ellipsis,
                                        style: ubuntuRegularLow.copyWith(
                                          color: Theme.of(context).primaryColor,

                                      ),
                                                                       ),
                                   ),
                                    ]
                            )),
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
                                horizontal:0,
                                vertical:0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.machineParametersList!.machineparametersitems!.length,
                              //padding: const EdgeInsets.all(0),
                              padding: const EdgeInsets.only(bottom: 10),
                              itemBuilder: (context, index) {
                                final Size txtSize1 = _textSize('${widget.machineParametersList!.machineparametersitems![index].imagesgroup}');
                                return

                                   Column(
                                     children: [
                                       Row(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                           children: [


                                             SizedBox(width:MediaQuery.of(context).size.width * 0.02
                                             ),

                                             SizedBox(width:MediaQuery.of(context).size.width * 0.60,
                                                   child:Text(
                                                     ' ${widget.machineParametersList!.machineparametersitems![index].imagesgroup}',
                                                     maxLines: 3,
                                                     overflow: TextOverflow.ellipsis,
                                                     style: ubuntuMediumHigh.copyWith(color: Theme.of(context).hintColor),
                                                   ),
                                                 ),


                                              SizedBox(
                                                width:MediaQuery.of(context).size.width * 0.3,
                                                child: InkWell(onTap : () async {
                                                                       if(userauthlevel!.contains(widget.machineParametersList !.parametersAuth) ){

                                                                       if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){

                                                                       Navigator.push(context, MaterialPageRoute(builder: (_) => MachineParametersDetailsScreen(imagesList: widget.machineParametersList!.machineparametersitems![index].imageslist![0].images!, line: widget.machineParametersList!.line!, machine: widget.machineParametersList!.machine!, parametersTitle: widget.machineParametersList!.parametersTitle!, imagesGroup: widget.machineParametersList!.machineparametersitems![index].imagesgroup!,
                                                                       )));
                                                                       }
                                                                       }
                                                                       else
                                                                       {
                                                                       showCustomSnackBar('${getTranslated('no_auth', context)}', context);
                                                                       }
                                                                       },


                                                // child: Image.asset(Images.pdf,width: 30,height: 30,color: Theme.of(context).primaryColor,)
                                                 child: Icon(Icons.remove_red_eye,size: 30,color: Theme.of(context).primaryColor,)
                                                ),
                                              ),

                                                                       ]),
                                Divider(
                                thickness: 1,
                                endIndent: 25.0,
                                indent: 25.0,
                                color:
                                Theme.of(context).hintColor.withOpacity(0.7),
                                ),
                                     ],
                                   );

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

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}


Size _textSize(String text) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.white,)), maxLines: 1, textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}
