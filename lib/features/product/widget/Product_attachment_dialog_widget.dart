import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/pdf/pdf_viewer.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spareparts_store/features/product/domain/model/product_details_model.dart' as pd;
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class ProductAttachmentDialog extends StatelessWidget {
  final pd.StockAttachments productAttachmentModel;
  const ProductAttachmentDialog({super.key, required this.productAttachmentModel});

  @override
  Widget build(BuildContext context) {

    List<String> queryParams =productAttachmentModel.path.toString().split('.');
     String? text= queryParams[1] ??'';


    return Padding(padding: const EdgeInsets.fromLTRB(0, 10, 10 , 20),
    child: Row (
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width:MediaQuery.of(context).size.width * 0.2,
            child: InkWell(onTap : () async {

                if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){

      final res = await http.get(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).
      baseUrls!.productAttachmentUrl}/${productAttachmentModel.path}'));
      if (res.statusCode == 200) {
        Navigator.push(
          context, MaterialPageRoute<dynamic>(
          builder: (_) => PDFViewer(
            url: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productAttachmentUrl}/'
                '${productAttachmentModel.path}',
            title: '${productAttachmentModel.name}',
          ),
        ),
        );
      }
      else {
       // showCustomSnackBar('${getTranslated('no_file', context)}', context);
        showCustomSnackBar('${text}', context);
      }
    }
            },

              child:
                Image.asset((AppConstants.imageExtensions.contains(text)) ?  AppConstants.documentExtensions.contains(text) ? Images.file:Images.uploadImage:Images.pdf,
                  width: 30,height: 30,color: Theme.of(context).primaryColor)


            ),
          ),

          SizedBox(width:MediaQuery.of(context).size.width * 0.60,
              child: Align(alignment: Alignment.centerLeft,
                child:Text(
                  '${productAttachmentModel.name!}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: ubuntuMediumHigh.copyWith(color: Theme.of(context).hintColor),
                ),
              )),


          SizedBox(
            width:MediaQuery.of(context).size.width * 0.15,
            child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(height: 45,
                    child: InkWell(onTap : () async {
                        if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){

                        final res = await http.get(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).
                        baseUrls!.productAttachmentUrl}/${productAttachmentModel.path}'));

                        if (res.statusCode == 200) {
                          _launchUrl(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productAttachmentUrl}/'
                              '${productAttachmentModel.path}'));
                        }
                        else {
                          showCustomSnackBar('${getTranslated('no_file', context)}', context);

                        }

                     }
                    }
                        , child: Align(alignment: Alignment.center,
                            child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),
                                color: Theme.of(context).primaryColor),
                                alignment: Alignment.center,
                                child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  const SizedBox(width: Dimensions.paddingSizeExtraExtraSmall),
                                  SizedBox(width: Dimensions.iconSizeDefault,
                                      child: Image.asset(Images.fileDownload, color: Theme.of(context).cardColor,width:20,height:20 ))
                                ])))
                        ))

                )),
          )

        //const SizedBox(height: Dimensions.paddingSizeSmall)

      ],
      )) ;
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