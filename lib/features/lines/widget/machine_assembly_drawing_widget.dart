import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machine_assembly_drawing_full_screen.dart';
import 'package:flutter_spareparts_store/features/sale/view/service_image_screen.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class MachineAssemblyPartsDrawingWidget extends StatefulWidget {
  final String? graphic;

  const MachineAssemblyPartsDrawingWidget({super.key, required this.graphic,});

  @override
  State<MachineAssemblyPartsDrawingWidget> createState() => _MachineAssemblyPartsDrawingWidgetState();

}

class _MachineAssemblyPartsDrawingWidgetState extends State<MachineAssemblyPartsDrawingWidget> {


  @override
  void initState() {
    setState(() {
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Stack(
            children: [
            PhotoView.customChild(
              minScale:PhotoViewComputedScale.contained *1 ,
              //maxScale: PhotoViewComputedScale.contained *5,
              enableRotation: false,

              backgroundDecoration: const BoxDecoration(color: Colors.white),
              customSize: MediaQuery.of(context).size,
              //initialScale: PhotoViewComputedScale.contained,
              initialScale: PhotoViewComputedScale.contained  *2,
              basePosition: Alignment.centerLeft,
            child: Center(
              //child: GestureDetector(
              child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  //child: Stack(
                  children: <Widget>[
                    Image.network('${Provider.of<SplashProvider>(context, listen: false).baseUrls!.graphicImageUrl}/${widget.graphic}'),
                  ],


                );}

              ),
             // ),
            ),
          ),


              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 10,),
                  Container(decoration:  BoxDecoration(color: ColorResources.primaryColor.withOpacity(0.2),borderRadius: BorderRadius.circular(20)),
                    child: IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.open_in_full_outlined,color: ColorResources.primaryColor),
                        onPressed:() {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  MachineAssemblyDrawingFullScreen(
                              image:  widget.graphic,url: Provider.of<SplashProvider>(context, listen: false).baseUrls!.graphicImageUrl)));
                        }
                    ),
                  ),
                ],
              ),

            ],
          ),
        );
  }
}




