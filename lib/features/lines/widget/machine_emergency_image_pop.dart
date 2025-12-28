import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';



class MachineEmergencyImagePop extends StatefulWidget {
  final String? title;
  final String? image;
  final String? url;
  final double? width;
  final double? height;
  const MachineEmergencyImagePop({super.key, this.title, required this.image, required this.url, required this.width, required this.height});

  @override
  MachineEmergencyImagePopState createState() => MachineEmergencyImagePopState();
}

class MachineEmergencyImagePopState extends State<MachineEmergencyImagePop> {
  @override
  Widget build(BuildContext context) {


  return Dialog(backgroundColor:  Colors.transparent,
      child:
     /* Column(
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
                      width: widget.width,
                      height: widget.height,
                      child: PhotoView(imageProvider:  NetworkImage('${widget.url}/${widget.image}'),
                    backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                    enablePanAlways: true,
                    enableRotation: true,
                  ) ),
        ],
      ),
*/
    SizedBox(
        width: widget.width,
        height: widget.height,
        child: PhotoView(imageProvider: NetworkImage('${widget.url}/${widget.image}'),
          backgroundDecoration: const BoxDecoration(color: Colors.transparent),
          enablePanAlways: true,
          enableRotation: true,
        ) ),

  );


  }
}
