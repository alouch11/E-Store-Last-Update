import 'package:flutter/material.dart';

import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';

class ApplicabilityImageScreen2 extends StatefulWidget {
  final String? title;
  final String? position;
  final String? imageList;
  final double? x;
  final double? y;
  final double ratio;
  final double fontsize;
  final double fontpadding;
  const ApplicabilityImageScreen2({super.key, required this.title, this.position, required this.imageList, required this.x, required this.y, required this.ratio, required this.fontsize, required this.fontpadding});

  @override
  ApplicabilityImageScreen2State createState() => ApplicabilityImageScreen2State();
}

class ApplicabilityImageScreen2State extends State<ApplicabilityImageScreen2> {

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
              backgroundDecoration: const BoxDecoration(color: Colors.white),
              customSize: MediaQuery.of(context).size,
              //minScale: PhotoViewComputedScale.contained * 0.5,
              //maxScale: PhotoViewComputedScale.covered * 3.0,
              initialScale: PhotoViewComputedScale.contained,
              basePosition: Alignment.center,
            child: Center(
              //child: GestureDetector(
              child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  //child: Stack(
                  children: <Widget>[
                    Image.network('${Provider.of<SplashProvider>(context, listen: false).baseUrls!.graphicImageUrl}/${widget.imageList}'),
                    Positioned(
                      left: widget.x! / widget.ratio,
                      top: widget.y! / widget.ratio,
                      //top: widget.y! * constraints.biggest.height,
                      //left: widget.x! * constraints.biggest.width,
                       //top:  widget.y! * MediaQuery.of(context).size.height , // 50% of the screen's height
                       //left: widget.x! * MediaQuery.of(context).size.width ,// 30% of the screen's width
                      // bottom: 0,
                      child: Align(alignment: Alignment.center,
                        child: Center(
                          child: Container(decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.paddingSizeEight),
                              color: Theme
                                  .of(context)
                                  .primaryColor
                          ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: widget.fontpadding,
                                    horizontal: widget.fontpadding),
                               child: Text('${widget.position}',
                               //child: Text('${constraints.biggest.height} ${constraints.biggest.width} ${MediaQuery.of(context).size.height}  ${MediaQuery.of(context).size.width}',
                                  style: textRegular.copyWith(
                                      fontSize: widget.fontsize,
                                      color: Colors.white),),
                              )
                          ),
                        ),
                      ),
                    ),
                  ],

                );}

              ),
             // ),
            ),
          ),
            ],
          ),
        ),


/*        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: <Widget>[
                  Image.network('${Provider.of<SplashProvider>(context,listen: false).baseUrls!.graphicImageUrl}/${widget.imageList}'),
                  Positioned(
                    top: widget.y,
                    left: widget.x,
                    // bottom: 0,
                    child: Align(alignment: Alignment.center,
                      child: Center(
                        child: Container( decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeEight),
                            color: Theme.of(context).primaryColor
                        ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical :widget.fontpadding, horizontal: widget.fontpadding),
                              child: Text('${widget.position}',
                                style: textRegular.copyWith(fontSize: widget.fontsize, color: Colors.white),),
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),*/

      ]),
    );
  }
}




