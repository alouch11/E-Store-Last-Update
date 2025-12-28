import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class DViewer extends StatelessWidget{
  const DViewer({super.key});

  @override
  Widget build(BuildContext context) {

     const String src1 = 'https://modelviewer.dev/shared-assets/models/Horse.glb';
     const String src2 = 'https://superd.oss-cn-beijing.aliyuncs.com/pub_upload/2022-03-04/ciawb49ie51dq3f0ho.glb';

    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Model Viewer")),
        body: ModelViewer(
          xrEnvironment: true,
          //src: '${Provider.of<SplashProvider>(Get.context!, listen: false).baseUrls!.appsUrl}/1.glb',
          //src: 'http://192.168.155.137:8080/3D/3d.html',
          src:'assets/images/1.glb',
          //src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
          alt: "A 3D model of an astronaut",
          ar: true,
          cameraOrbit:"0deg 0deg 1m" ,
          autoRotate: false,
          cameraControls: true,
        ),


        /*ModelViewer(
          src: src1,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          autoRotate: true,
          autoPlay: true,
          rotationPerSecond: "50deg",
          autoRotateDelay: 500,
          cameraControls: true,
        ),*/


      ),
    );
  }

}