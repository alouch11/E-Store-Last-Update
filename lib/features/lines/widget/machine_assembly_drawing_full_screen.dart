import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:photo_view/photo_view.dart';



class MachineAssemblyDrawingFullScreen extends StatefulWidget {

  final String? image;
  final String? url;
  const MachineAssemblyDrawingFullScreen({super.key, required this.image, required this.url});

  @override
  MachineAssemblyDrawingFullScreenState createState() => MachineAssemblyDrawingFullScreenState();
}

class MachineAssemblyDrawingFullScreenState extends State<MachineAssemblyDrawingFullScreen> {
  @override
  Widget build(BuildContext context) {


  return   Stack(children: [
    SizedBox( width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                            child: PhotoView(imageProvider:  NetworkImage('${widget.url}/${widget.image}'),
                          backgroundDecoration: const BoxDecoration(color: Colors.white),
                          //enablePanAlways: true,
                          //enableRotation: true,
                          minScale:PhotoViewComputedScale.contained *1 ,
                          //maxScale: PhotoViewComputedScale.contained *2,
                          initialScale:  PhotoViewComputedScale.contained *2.2,
                            basePosition: Alignment.centerLeft,
                        ) ),


    Positioned(top: 40, right:20, child: Container(decoration:  BoxDecoration(color: ColorResources.primaryColor.withOpacity(0.2),borderRadius: BorderRadius.circular(20)),
        child:
        IconButton(autofocus: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
          //icon: const Icon(Icons.close_rounded,size: 40,),
          icon:Icon(Icons.close_fullscreen,size: 30, color: ColorResources.primaryColor),
          //color: Colors.redAccent,

        ))),
  ]);

  }
}
