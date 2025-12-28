import 'package:flutter/material.dart';

import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';

class ApplicabilityImageScreen3 extends StatefulWidget {
  final String? title;
  final List<String>? imageList;
  const ApplicabilityImageScreen3({super.key, required this.title, this.imageList});

  @override
  ApplicabilityImageScreen3State createState() => ApplicabilityImageScreen3State();
}

class ApplicabilityImageScreen3State extends State<ApplicabilityImageScreen3> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [

        CustomAppBar(title: widget.title),

        Expanded(
          child: Stack(
            children: [
            PhotoView.customChild(
            //enableRotation: true,
              enableRotation: false,
            child: Center(
              child: GestureDetector(
                  child: Stack(
                    children: <Widget>[
                      Image.network('${Provider.of<SplashProvider>(context,listen: false).baseUrls!.graphicImageUrl}/${widget.imageList}'),
              Positioned(
                top: 50,
                left: 50,
               // bottom: 0,
                child: Align(alignment: Alignment.topRight,
                  child: Center(
                    child: Container( decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeEight),
                        color: Theme.of(context).primaryColor
                    ),
                        child:
                        Text('1',
                            style: textRegular.copyWith(fontSize: Dimensions.fontSizeFive, color: Colors.white),),
                        ),
                  ),
                ),
              ),
                    ],
                  )),
            ),
          ),
            ],
          ),
        ),

      ]),
    );
  }
}