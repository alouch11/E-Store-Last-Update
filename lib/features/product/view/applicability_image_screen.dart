import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';

class ApplicabilityImageScreen extends StatefulWidget {
  final String? title;
  final String? image;
  final String? url;
  const ApplicabilityImageScreen({super.key, required this.title, required this.image, required this.url});

  @override
  ApplicabilityImageScreenState createState() => ApplicabilityImageScreenState();
}

class ApplicabilityImageScreenState extends State<ApplicabilityImageScreen> {


  @override
  Widget build(BuildContext context) {

    return Dialog(
      //backgroundColor: Colors.white,
      // elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Dimensions.marginSizeDefault),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child:
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Expanded
                (child:
              Text('${widget.title}',
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                  maxLines: 3, overflow: TextOverflow.ellipsis)),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close_rounded),
                    color: Colors.redAccent,
                  ),

                ]),


          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-200,
            //child: Image.network('${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productImageUrl}/${widget.image}'),
            child: Image.network('${widget.url}/${widget.image}'),
          ),
        ],
      ),
    );


/*
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
                customSize: MediaQuery
                    .of(context).size,
                initialScale: PhotoViewComputedScale.contained,
                basePosition: Alignment.center,
                child: Center(
                  //child: GestureDetector(
                  child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          //child: Stack(
                          children: <Widget>[
                            Image.network('${Provider
                                .of<SplashProvider>(context, listen: false)
                                .baseUrls!.productImageUrl}/${widget.image}'),
                          ],

                        );
                      }

                  ),
                  // ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );*/


  }
}
