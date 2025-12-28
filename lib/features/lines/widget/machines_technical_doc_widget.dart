import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/machines_model.dart';
import 'package:flutter_spareparts_store/features/pdf/pdf_viewer.dart';
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

class MachineTechnicalDocWidget extends StatefulWidget {
  final TechnicalDocList? machineTechnicalDocList;
  final bool? isExpanded;
  final UniqueKey? keyTile;
  const MachineTechnicalDocWidget(
      {super.key, this.machineTechnicalDocList,required this.isExpanded,required this.keyTile});

  @override
  State<MachineTechnicalDocWidget> createState() => _MachineTechnicalDocWidgetState();
}

class _MachineTechnicalDocWidgetState extends State<MachineTechnicalDocWidget> {

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
                        leading: Image.asset(widget.machineTechnicalDocList!.docIcon!, width: 40, height: 40,color: Theme.of(context).primaryColor ),
                        trailing: const Icon(Icons.expand_more,
                            size: 35.0, color: ColorResources.blue),
                        title: Text(widget.machineTechnicalDocList !.catalogueTitle!),
                        //subtitle: Text(widget.machineTechnicalDocList !.catalogueTitle!),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            child: SizedBox(
                              height: 15,
                              child: ListView(
                                shrinkWrap: true,
                                //scrollDirection: Axis.horizontal,
                                children: [
                                 // const SizedBox(width: 20),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                     /* const SizedBox(
                                        width: 1,
                                      ),*/
                                      Text(
                                          '${getTranslated('view', context)}',
                                          overflow: TextOverflow.ellipsis,
                                          style: ubuntuRegularLow.copyWith(
                                              color:
                                              Theme.of(context).primaryColor),
                                        ),
                                       const SizedBox(
                                        width: 1,
                                      ),
                                Text(
                                      '${getTranslated('description', context)}',
                                      overflow: TextOverflow.ellipsis,
                                      style: ubuntuRegularLow.copyWith(
                                          color:
                                          Theme.of(context).primaryColor),
                                    ),

                                      const SizedBox(
                                        width: 1,
                                      ),
                                   Text(
                                      '${getTranslated('download', context)}',
                                      overflow: TextOverflow.ellipsis,
                                      style: ubuntuRegularLow.copyWith(
                                        color: Theme.of(context).primaryColor,

                                    ),
                                  ),
                                    ],
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
                                horizontal:0,
                                vertical:0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.machineTechnicalDocList !.machinedocitems!.length,
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (context, index) {
                                final Size txtSize1 = _textSize('${widget.machineTechnicalDocList !.machinedocitems![index].catalogueLang}');
                                return
                               // Column(children: [
                                   Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       mainAxisSize: MainAxisSize.max,
                                       children: [
                                     /*const SizedBox(
                                       width: 10,
                                     ),*/
                                          SizedBox(
                                            width:MediaQuery.of(context).size.width * 0.2,
                                            child: InkWell(onTap : () async { if(userauthlevel!.contains(widget.machineTechnicalDocList !.machinedocitems![index].catalogueAuth) ){
                                                    if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){

                                                         Navigator.push(
                                                         context, MaterialPageRoute<dynamic>(
                                                         builder: (_) => PDFViewer(
                                                         url: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.machineCataloguesUrl}/'
                                                         '${widget.machineTechnicalDocList!.machinedocitems![index].line}/'
                                                         '${widget.machineTechnicalDocList!.machinedocitems![index].machine}/'
                                                         '${widget.machineTechnicalDocList!.machinedocitems![index].cataloguePath}',
                                                           title: '${widget.machineTechnicalDocList !.machinedocitems![index].catalogueTitle}',
                                                         ),
                                                         ),
                                                         );
                                                         }
                                                         }
                                                         else
                                                         {
                                                         showCustomSnackBar('${getTranslated('no_auth', context)}', context);
                                                         }
                                                         },




                                              child: Image.asset(Images.pdf,width: 30,height: 30,color: Theme.of(context).primaryColor,)
                                            ),
                                          ),
                                          /*const SizedBox(
                                            width: 10,
                                          ),*/
                                SizedBox(width:MediaQuery.of(context).size.width * 0.46,
                                            child: Align(alignment: Alignment.center,
                                              child:Text(
                                                ' ${widget.machineTechnicalDocList !.machinedocitems![index].catalogueTitle}',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: ubuntuMediumHigh.copyWith(color: Theme.of(context).hintColor),
                                              ),
                                          )),

                                     /*   ]),

                                      Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,

                                    children: [*/
                                     SizedBox(
                                           width:MediaQuery.of(context).size.width * 0.30,
                                            child: Padding(
                                           padding: const EdgeInsets.all(2.0),
                                           child: SizedBox(height: 45,
                                               child: InkWell(onTap : () async {
                                                   if(userauthlevel!.contains(widget.machineTechnicalDocList !.machinedocitems![index].catalogueAuth) ){
                                                     if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){

                                                       _launchUrl(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).baseUrls!.machineCataloguesUrl}/'
                                                           '${widget.machineTechnicalDocList!.machinedocitems![index].line}/'
                                                           '${widget.machineTechnicalDocList!.machinedocitems![index].machine}/'
                                                           '${widget.machineTechnicalDocList!.machinedocitems![index].cataloguePath}'));


                                                     }
                                                   }
                                                   else
                                                   {
                                                     showCustomSnackBar('${getTranslated('no_auth', context)}', context);
                                                   }

                                                 }
                                                 , child: Align(alignment: Alignment.center,
                                                         child: Container(
                                                             width: txtSize1.width+30, padding: const EdgeInsets.only(left: 1),
                                                             height: 30, decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),
                                                             color: Theme.of(context).primaryColor),
                                                             alignment: Alignment.center,
                                                             child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                               Text('${widget.machineTechnicalDocList!.machinedocitems![index].catalogueLang} ', maxLines: 1,
                                                                   overflow: TextOverflow.ellipsis,
                                                                   style: textRegular.copyWith(
                                                                     fontSize: Dimensions.fontSizeSmall,
                                                                     color: Colors.white,
                                                                   )),
                                                               const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
                                                               SizedBox(width: Dimensions.iconSizeDefault,
                                                                   child: Image.asset(Images.fileDownload, color: Theme.of(context).cardColor,width:15,height:15 ))
                                                             ])))
                                                     ))

                                           )),
                                     )
                               // ])
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
