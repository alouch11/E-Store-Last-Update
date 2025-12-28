import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

  class MachineAssemblyParts3DWidget extends StatefulWidget {
    final String? title;
    final String? file;

  const MachineAssemblyParts3DWidget({super.key, required this.title, required this.file,});


  @override
  State<MachineAssemblyParts3DWidget> createState() => _MachineAssemblyParts3DWidgetState();
  }

  class _MachineAssemblyParts3DWidgetState extends State<MachineAssemblyParts3DWidget> {


  Flutter3DController controller = Flutter3DController();
  String? chosenAnimation;
  String? chosenTexture;
  double? upBorder=0.0;
  double? downBorder=0.0;
  double? rightBorder=0.0;
  double? leftBorder=0.0;
  double? frontBorder=0.0;
  double? backBorder=0.0;
  double? restBorder=0.0;


  @override
  void initState() {
    super.initState();
    controller.onModelLoaded.addListener(() {
      debugPrint('model is loaded : ${controller.onModelLoaded.value}');
      controller.setCameraOrbit(45, 45, 100);
    });
    setState(() {
      restBorder=1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
       //backgroundColor: const Color(0xff0d2039),
      title: Text(widget.title!,style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
            color:Theme.of(context).textTheme.bodyLarge!.color),maxLines: 2, overflow: TextOverflow.ellipsis),

      ),*/
      floatingActionButton:
      Align(alignment: Alignment.bottomRight,

      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration( border: Border.all(color: Theme.of(context).primaryColor.withOpacity(upBorder!)),
                borderRadius: BorderRadius.circular(5)),
            child:IconButton(
              onPressed: () {
                setState(() {
                  upBorder = 1.0;
                  downBorder=0.0;
                  rightBorder=0.0;
                  leftBorder=0.0;
                  frontBorder=0.0;
                  backBorder=0.0;
                  restBorder=0.0;
                });
                controller.setCameraOrbit(0, 0, 100);
                //controller.setCameraTarget(0.3, 0.2, 0.4);
              },
              icon:SvgPicture.asset(Images.cubeIconUp,height: 20,width: 20, color: Theme.of(context).primaryColor),
            ),),
          const SizedBox(
            height: 4,
          ),


        Container(
          decoration: BoxDecoration( border: Border.all(color: Theme.of(context).primaryColor.withOpacity(downBorder!)),
               borderRadius: BorderRadius.circular(5)),
          child:IconButton(
            onPressed: () {
              setState(() {
                upBorder = 0.0;
                downBorder=1.0;
                rightBorder=0.0;
                leftBorder=0.0;
                frontBorder=0.0;
                backBorder=0.0;
                restBorder=0.0;
              });
              controller.setCameraOrbit(0, 180, 100);
              //controller.setCameraTarget(0.3, 0.2, 0.4);

            },
            icon:SvgPicture.asset(Images.cubeIconDown,height: 20,width: 20, color:Theme.of(context).primaryColor),
          ),),
          const SizedBox(
            height: 4,
          ),


          Container(
            decoration: BoxDecoration( border: Border.all(color: Theme.of(context).primaryColor.withOpacity(rightBorder!)),
                borderRadius: BorderRadius.circular(5)),
            child:IconButton(
              onPressed: () {
                setState(() {
                  upBorder = 0.0;
                  downBorder=0.0;
                  rightBorder=1.0;
                  leftBorder=0.0;
                  frontBorder=0.0;
                  backBorder=0.0;
                  restBorder=0.0;
                });
                controller.setCameraOrbit(90, 0, 100);
                //controller.setCameraTarget(0.3, 0.2, 0.4);

              },
              icon:SvgPicture.asset(Images.cubeIconRight,height: 20,width: 20, color:Theme.of(context).primaryColor),
            ),),
          const SizedBox(
            height: 4,
          ),


          Container(
            decoration: BoxDecoration( border: Border.all(color: Theme.of(context).primaryColor.withOpacity(leftBorder!)),
                borderRadius: BorderRadius.circular(5)),
            child:IconButton(
              onPressed: () {
                setState(() {
                  upBorder = 0.0;
                  downBorder=0.0;
                  rightBorder=0.0;
                  leftBorder=1.0;
                  frontBorder=0.0;
                  backBorder=0.0;
                  restBorder=0.0;
                });
                controller.setCameraOrbit(270, 00, 100);
                //controller.setCameraTarget(0.3, 0.2, 0.4);

              },
              icon:SvgPicture.asset(Images.cubeIconLeft,height: 20,width: 20, color:Theme.of(context).primaryColor),
            ),),
          const SizedBox(
            height: 4,
          ),

          Container(
            decoration: BoxDecoration( border: Border.all(color: Theme.of(context).primaryColor.withOpacity(frontBorder!)),
                borderRadius: BorderRadius.circular(5)),
            child:IconButton(
              onPressed: () {
                setState(() {
                  upBorder = 0.0;
                  downBorder=0.0;
                  rightBorder=0.0;
                  leftBorder=0.0;
                  frontBorder=1.0;
                  backBorder=0.0;
                  restBorder=0.0;
                });
                controller.setCameraOrbit(0, 90, 100);
                //controller.setCameraTarget(0.3, 0.2, 0.4);

              },
              icon:SvgPicture.asset(Images.cubeIconFront,height: 20,width: 20, color:Theme.of(context).primaryColor),
            ),),
          const SizedBox(
            height: 4,
          ),



          Container(
            decoration: BoxDecoration( border: Border.all(color: Theme.of(context).primaryColor.withOpacity(backBorder!)),
                borderRadius: BorderRadius.circular(5)),
            child:IconButton(
              onPressed: () {
                setState(() {
                  upBorder = 0.0;
                  downBorder=0.0;
                  rightBorder=0.0;
                  leftBorder=0.0;
                  frontBorder=0.0;
                  backBorder=1.0;
                  restBorder=0.0;
                });
                controller.setCameraOrbit(180, 90, 100);
                //controller.setCameraTarget(0.3, 0.2, 0.4);

              },
              icon:SvgPicture.asset(Images.cubeIconBack,height: 20,width: 20, color:Theme.of(context).primaryColor),
            ),),
          const SizedBox(
            height: 4,
          ),


          Container(
            decoration: BoxDecoration( border: Border.all(color: Theme.of(context).primaryColor.withOpacity(restBorder!) ),
                borderRadius: BorderRadius.circular(5)),
            child:IconButton(
              onPressed: () {
                setState(() {
                  upBorder = 0.0;
                  downBorder=0.0;
                  rightBorder=0.0;
                  leftBorder=0.0;
                  frontBorder=0.0;
                  backBorder=0.0;
                  restBorder=1.0;
                });
                //controller.resetCameraOrbit();
                controller.setCameraOrbit(45, 45, 100);

              },
              icon:Image.asset(Images.reset,height: 30,width: 30,),
            ),),




/*                   IconButton(
            onPressed: () {
              controller.resetAnimation();
            },
            icon: const Icon(Icons.replay_circle_filled),
          ),
          const SizedBox(
            height: 4,
          ),
          IconButton(
            onPressed: () async {
              List<String> availableAnimations =
              await controller.getAvailableAnimations();
              debugPrint(
                  'Animations : $availableAnimations --- Length : ${availableAnimations.length}');
              chosenAnimation = await showPickerDialog(
                  'Animations', availableAnimations, chosenAnimation);
              controller.playAnimation(animationName: chosenAnimation);
            },
            icon: const Icon(Icons.format_list_bulleted_outlined),
          ),
          const SizedBox(
            height: 4,
          ),
          IconButton(
            onPressed: () async {
              List<String> availableTextures =['white','0xff0d2039','HMC116'];
             // await controller.getAvailableTextures();
              debugPrint(
                  'Textures : $availableTextures --- Length : ${availableTextures.length}');
              chosenTexture = await showPickerDialog(
                  'Textures', availableTextures, chosenTexture);
              controller.setTexture(textureName: chosenTexture ?? '');
            },
            icon: const Icon(Icons.list_alt_rounded),
          ),
          const SizedBox(
            height: 4,
          ),
          IconButton(
            onPressed: () {
              controller.setCameraOrbit(20, 20, 5);
              //controller.setCameraTarget(0.3, 0.2, 0.4);
            },
            icon: const Icon(Icons.camera_alt),
          ),
          const SizedBox(
            height: 4,
          ),*/


        ],
      )),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          /*gradient: RadialGradient(
            colors: [
              Color(0xffffffff),
              Colors.white,
            ],
            stops: [0.1, 1.0],
            radius: 0.7,
            center: Alignment.center,
          )*/
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Flutter3DViewer(
                //If you pass 'true' the flutter_3d_controller will add gesture interceptor layer
                //to prevent gesture recognizers from malfunctioning on iOS and some Android devices.
                // the default value is true
                activeGestureInterceptor: true,
                //If you don't pass progressBarColor, the color of defaultLoadingProgressBar will be grey.
                //You can set your custom color or use [Colors.transparent] for hiding loadingProgressBar.
                progressBarColor: Colors.blue,
                //You can disable viewer touch response by setting 'enableTouch' to 'false'
                enableTouch: true,
                //This callBack will return the loading progress value between 0 and 1.0
                onProgress: (double progressValue) {
                  debugPrint('model loading progress : $progressValue');
                },
                //This callBack will call after model loaded successfully and will return model address
                onLoad: (String modelAddress) {
                  debugPrint('model loaded : $modelAddress');
                },
                //this callBack will call when model failed to load and will return failure error
                onError: (String error) {
                  debugPrint('model failed to load : $error');
                },
                //You can have full control of 3d model animations, textures and camera
                controller: controller,


                //src:widget.file!=null?'assets/images/${widget.file}':'assets/images/1.gltf', //3D model with different animations
                 //src: '${Provider.of<SplashProvider>(Get.context!, listen: false).baseUrls!.threeDModelsUrl}/1.gltf',


                       src: 'assets/images/gltf/1.gltf', //3D model with different textures
                   // src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
                    // src: 'http://192.168.155.137:8080/estore/storage/app/public/threedmodels/models/1.gltf', // 3D model from URL
              ),
            )
          ],
        ),
      ),
    );
  }

/*  Future<String?> showPickerDialog(String title, List<String> inputList,
      [String? chosenItem]) async {
    return await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 250,
          child: inputList.isEmpty
              ? Center(
            child: Text('$title list is empty'),
          )
              : ListView.separated(
            itemCount: inputList.length,
            padding: const EdgeInsets.only(top: 16),
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context, inputList[index]);
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${index + 1}'),
                      Text(inputList[index]),
                      Icon(
                        chosenItem == inputList[index]
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider(
                color: Colors.grey,
                thickness: 0.6,
                indent: 10,
                endIndent: 10,
              );
            },
          ),
        );
      },
    );
  }*/


}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}