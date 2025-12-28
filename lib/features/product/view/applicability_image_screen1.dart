import 'package:flutter/material.dart';

import 'package:flutter_spareparts_store/features/product/provider/product_details_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';

class ApplicabilityImageScreen1 extends StatefulWidget {
  final String? title;
  final String? position;
  final String? imageList;
  const ApplicabilityImageScreen1({super.key, required this.title, this.position, required this.imageList});

  @override
  ApplicabilityImageScreen1State createState() => ApplicabilityImageScreen1State();
}

class ApplicabilityImageScreen1State extends State<ApplicabilityImageScreen1> {
  int? pageIndex;
  PageController? _pageController;
  @override
  void initState() {
    super.initState();
    pageIndex = Provider.of<ProductDetailsProvider>(context, listen: false).imageSliderIndex;
    _pageController = PageController(initialPage: pageIndex!);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [

        CustomAppBar(title: widget.title),

        Expanded(
          child: Stack(
            children: [
            PhotoView.customChild(
            enableRotation: true,
            child: Center(
              child: GestureDetector(
                  child: Stack(
                    children: <Widget>[
                      //Image.asset('assets/images/quadrants.jpg'),
                      Image.asset('assets/images/033CV0400000_03.png'),
                      const Positioned(
                        left: 53,
                        top: 89,
                        child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.blue,
                            child: Text('4')
                        ),
                      ),
                      const Positioned(
                          left: 220,
                          bottom: 80,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.blue,
                            child: Text('1'),
                          )),
                    ],
                  )),
            ),
          ),

              pageIndex != 0 ? Positioned(
                left: 5, top: 0, bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      if(pageIndex! > 0) {
                        _pageController!.animateToPage(pageIndex!-1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    },
                    child: const Icon(Icons.chevron_left_outlined, size: 40),
                  ),
                ),
              ) : const SizedBox.shrink(),

              pageIndex != widget.imageList!.length-1 ? Positioned(
                right: 5, top: 0, bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      if(pageIndex! < widget.imageList!.length) {
                        _pageController!.animateToPage(pageIndex!+1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    },
                    child: const Icon(Icons.chevron_right_outlined, size: 40),
                  ),
                ),
              ) : const SizedBox.shrink(),

              ///Drawings Reference
              Positioned(
                //right: 50, top: 50, bottom: 0,
                right: 50,
                top: 50,
                bottom: 0,
                child: Align(alignment: Alignment.topRight,
                  child: Center(
                    child: Container( decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                        color: Theme.of(context).primaryColor
                    ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeSmall),
                          child: Text('${widget.position}',
                            style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.white),),
                        )),
                  ),
                ),
              ),
              ///Drawings Reference
              ///
              ///
              ///

            ],
          ),
        ),

      ]),
    );
  }
}
