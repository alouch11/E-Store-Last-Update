import 'dart:async';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'dart:ui' as ui;


class ServiceImageScreen extends StatefulWidget {
  final String? title;
  final String? image;
  final String? url;
  const ServiceImageScreen({super.key, required this.title, required this.image, required this.url});

  @override
  ServiceImageScreenState createState() => ServiceImageScreenState();
}

class ServiceImageScreenState extends State<ServiceImageScreen> {
  @override
  Widget build(BuildContext context) {


     Size? size;

    Completer<Size> completer = Completer();
    Image image = Image.network('${widget.url}/${widget.image}');
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
           size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );


  return Dialog(backgroundColor:  Colors.transparent,
      child:
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Expanded(
               child:Text('${widget.title}',
                // child:Text(size!.height.toString(),
                    style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall,
                    color: Colors.white),
                  maxLines: 2, overflow: TextOverflow.ellipsis)),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close_rounded),
                  color: Colors.redAccent,
                ),
              ],
            ),


          ),

       SizedBox(
           //width: size!.width,
          // height: size!.height,
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height-200,
                      child: PhotoView(imageProvider:  NetworkImage('${widget.url}/${widget.image}'),
                    backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                    enablePanAlways: true,
                    enableRotation: true,
                    //minScale:PhotoViewComputedScale.contained *1 ,
                    //maxScale: PhotoViewComputedScale.contained *2,
                    initialScale:  PhotoViewComputedScale.contained ,
                  ) ),
        ],
      ),
  );


  }
}