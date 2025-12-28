// ignore_for_file: use_build_context_synchronously

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/product/view/product_data_image_screen.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../basewidget/custom_image.dart';
import '../../../basewidget/show_custom_snakbar.dart';
import '../../../localization/provider/localization_provider.dart';
import '../../../theme/provider/theme_provider.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../splash/provider/splash_provider.dart';
import 'package:http/http.dart' as http;





class MachineParametersDetailsScreen extends StatefulWidget {
  final List<String> imagesList;
  final String line;
  final String machine;
  final String parametersTitle;
  final String imagesGroup;


  const MachineParametersDetailsScreen({super.key, required this.imagesList, required this.line, required this.machine, required this.parametersTitle, required this.imagesGroup});




  @override
  State<MachineParametersDetailsScreen> createState() => _MachineParametersDetailsScreenState();
}

class _MachineParametersDetailsScreenState extends State<MachineParametersDetailsScreen> {



  String text = '';
  String subject = '';
  String uri = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];

  _loadData( BuildContext context) async{
    Provider.of<MachinesProvider>(context, listen: false).initMachineParameters(context);
  }

  @override
  void initState() {
    _loadData(context);
    super.initState();
  }

  HashSet<String> selectedItem = HashSet();
  bool isMultiSelectionEnabled = false;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    var datatitle= widget.parametersTitle;
    int? index1=Provider.of<MachinesProvider>(context).imageSliderIndex!;
    var machineDataUrl=Provider.of<SplashProvider>(context,listen: false).baseUrls!.machineDataUrl;


    final files = <XFile>[];
    //final box = context.findRenderObject() as RenderBox?;
    ShareResult shareResult;
    //final scaffoldMessenger = ScaffoldMessenger.of(context);


    return Scaffold(
      appBar: AppBar(
        centerTitle: isMultiSelectionEnabled ? false : true,
        leading: isMultiSelectionEnabled
            ? IconButton(
            onPressed: () {
              selectedItem.clear();
              isMultiSelectionEnabled = false;
              setState(() {});
            },
            icon: const Icon(Icons.close))
            : null,
        title: Text(isMultiSelectionEnabled
            ? getSelectedItemCount() :
        '$datatitle-'
            '${widget.imagesGroup}',
            style: textMedium.copyWith(
                fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge?.color),
            maxLines: 1,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),

        actions: [


          ///Select the selected images
          Visibility(
              visible: selectedItem.isNotEmpty,
              child: IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () async {
                    if (selectedItem.isNotEmpty) {
                   // final files = <XFile>[];
                       //for (var index = 0; index < datalist.imageslist!.length; index++) {
                         for (var index = 0; index < selectedItem.length; index++) {

                         final url = Uri.parse('$machineDataUrl/'
                             '${widget.line}'
                             '${widget.machine}'
                             '$datatitle/'
                             '${widget.imagesGroup}/'
                             '${widget.imagesList[index]}');



                         final url1 = Uri.parse(imagePaths[index]);

                         final response = await http.get(url1);

                         files.add(XFile.fromData(
                           response.bodyBytes,
                          // name: datalist.imageslist![index],
                           name: imageNames[index],

                           mimeType: 'image/webp',
                         ));



                       }


                         shareResult = await Share.shareXFiles(
                           files,
                           text: text,
                           subject: subject,
                           //sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                         );
                       //scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
                  }
                      else {

                    showCustomSnackBar('Unable to share, there is some error', context);

                    }



                  }

      )
          ),
          ///Select all images
          Visibility(
              visible: isMultiSelectionEnabled,
              child: IconButton(
                icon: Icon(
                  Icons.select_all,
                  color: selectedItem.length == widget.imagesList.length
                      ? Colors.blue
                      : Colors.black,
                ),
                onPressed: () {
                  if (selectedItem.length == widget.imagesList.length){
                    selectedItem.clear();
                  } else {
                    for (int index = 0; index < widget.imagesList.length; index++) {
                      selectedItem.add(widget.imagesList[index]);
                    }
                  }
                  setState(() {});
                },
              )),

        ],
      ),


      body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child:
                Column(children: [

                  Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

                    InkWell(onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>
                        ProductDataImageScreen(title: getTranslated('images', context),
                            imagePath:'${widget.line}/${widget.machine}/${widget.parametersTitle}/${widget.imagesGroup}/',
                            imageList: widget.imagesList,machineParameters: true,))),


                      child: (widget.imagesList.isNotEmpty ) ?

                      Padding(padding: const EdgeInsets.all(Dimensions.homePagePadding),
                        child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          child: Container(decoration:  BoxDecoration(
                              color: Theme.of(context).cardColor,
                              border: Border.all(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?Theme.of(context).hintColor.withOpacity(.25) : Theme.of(context).primaryColor.withOpacity(.25)),
                              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                            child: Stack(children: [
                              SizedBox(height: MediaQuery.of(context).size.height*0.50,
                                child: widget.imagesList.isNotEmpty ?

                                PageView.builder(
                                  controller: _controller,
                                  itemCount: widget.imagesList.length,
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                      borderRadius:BorderRadius.circular(Dimensions.paddingSizeSmall),
                                      child: CustomImage(height: MediaQuery.of(context).size.height*0.50, width: MediaQuery.of(context).size.width,
                                          image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.machineDataUrl}/'
                                              '${widget.line}/'
                                              '${widget.machine}/'
                                              '${widget.parametersTitle}/'
                                              '${widget.imagesGroup}/'
                                              '${widget.imagesList[index]}'),
                                    );

                                  },
                                  onPageChanged: (index) {
                                    Provider.of<MachinesProvider>(context, listen: false).setImageSliderSelectedIndex(index);
                                  },
                                ):const SizedBox(),
                              ),

                              ///page _indicators
                              Positioned(left: 0, right: 0, bottom: 10,
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  const SizedBox(),
                                  const Spacer(),
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: _indicators(context)),
                                  const Spacer(),
                                ],
                                ),
                              ),
                              ///page _indicators

                              ///Share
                              Positioned(top: 5, right: 5,
                                child: Column(children: [
                                  const SizedBox(height: Dimensions.paddingSizeSmall,),
                                  InkWell(onTap: () async {
                                    final url = Uri.parse('${Provider.of<SplashProvider>(context,listen: false).baseUrls!.machineDataUrl}/'
                                        '${widget.line}/'
                                        '${widget.machine}/'
                                        '${widget.parametersTitle}/'
                                        '${widget.imagesGroup}/'
                                        '${widget.imagesList[index1]}');
                                    final response = await http.get(url);
                                    Share.shareXFiles([
                                      XFile.fromData(
                                        response.bodyBytes,
                                        name: widget.imagesList[index1],
                                        mimeType: 'image/webp',
                                      ),
                                    ],
                                        subject:widget.imagesList[index1]
                                    );
                                  },

                                      child: Card(elevation: 2,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                          child: Container(width: 40, height: 40,
                                              decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
                                              child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                                  child: Image.asset(Images.share, color: Theme.of(context).primaryColor)))))
                                ],
                                ),
                              ),
                              ///Share


                              ///page number / total page
                              Positioned(right: 3, bottom: 10,
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault,bottom: Dimensions.paddingSizeDefault),
                                    child: Text('${Provider.of<MachinesProvider>(context).imageSliderIndex!+1}/${widget.imagesList.length.toString()}'),
                                  ),//:const SizedBox(),
                                ],
                                ),
                              ),
                              ///page number / total page

                            ]),
                          ),
                        ),
                      ):const SizedBox(),
                    ),
                    Padding(padding: EdgeInsets.only(left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Dimensions.homePagePadding:0,
                        right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0:Dimensions.homePagePadding, bottom: Dimensions.paddingSizeLarge),
                      child: SizedBox(height: MediaQuery.of(context).size.height,
                        //child: ListView.builder(
                        child: GridView.builder(
                          //gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio: 1.0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing:0.2,mainAxisSpacing: 0.2,),
                          itemCount: widget.imagesList.length,

                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: (){
                                  if(isMultiSelectionEnabled ){
                                 //doMultiSelection(datalist.imageslist![index]);

                                   if (selectedItem.contains(widget.imagesList[index])) {
                                     selectedItem.remove(widget.imagesList[index]);
                                     imagePaths.remove('$machineDataUrl/${widget.line}/${widget.machine}/$datatitle/${widget.imagesGroup}/${widget.imagesList[index]}');
                                     imageNames.remove(widget.imagesList[index]);

                                   } else {
                                     selectedItem.add(widget.imagesList[index]);
                                     imagePaths.add('$machineDataUrl/${widget.line}/${widget.machine}/$datatitle/${widget.imagesGroup}/${widget.imagesList[index]}');
                                     imageNames.add(widget.imagesList[index]);
                                   }
                                   setState(() {});






                                  }
                                  Provider.of<MachinesProvider>(context, listen: false).setImageSliderSelectedIndex(index);
                                  _controller.animateToPage(index, duration: const Duration(microseconds: 50), curve:Curves.ease);

                                },
                                onLongPress: () {
                                  isMultiSelectionEnabled = true;
                                 // doMultiSelection(datalist.imageslist![index]);

                                  if (selectedItem.contains(widget.imagesList[index])) {
                                    selectedItem.remove(widget.imagesList[index]);
                                    imagePaths.remove('$machineDataUrl/${widget.line}/${widget.machine}/$datatitle/${widget.imagesGroup}/${widget.imagesList[index]}');
                                    imageNames.remove(widget.imagesList[index]);

                                  } else {
                                    selectedItem.add(widget.imagesList[index]);
                                    imagePaths.add('$machineDataUrl/${widget.line}/${widget.machine}/$datatitle/${widget.imagesGroup}/${widget.imagesList[index]}');
                                    imageNames.add(widget.imagesList[index]);
                                  }
                                  setState(() {});

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                  child: Center(
                                    child:  Stack(alignment: Alignment.topRight, children: [
                                      // child:
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(width: index == Provider.of<MachinesProvider>(context).imageSliderIndex? 2:0,
                                                color: (index == Provider.of<MachinesProvider>(context).imageSliderIndex && Provider.of<ThemeProvider>(context, listen: false).darkTheme)? Theme.of(context).primaryColor:
                                                (index == Provider.of<MachinesProvider>(context).imageSliderIndex && !Provider.of<ThemeProvider>(context, listen: false).darkTheme)?Theme.of(context).primaryColor: Colors.transparent),
                                            color: Theme.of(context).cardColor,
                                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                                        child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                          child: CustomImage(height: 70, width: 70,
                                              image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.machineDataUrl}/'
                                                  '${widget.line}/'
                                                  '${widget.machine}/'
                                                  '$datatitle/'
                                                  '${widget.imagesGroup}/'
                                                  '${widget.imagesList[index]}'
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                          visible: isMultiSelectionEnabled,
                                          child: Icon(
                                            selectedItem.contains(widget.imagesList[index])
                                                ? Icons.check_circle
                                                : Icons.radio_button_unchecked,
                                            size: 20,
                                            color: Colors.red,
                                          ))
                                    ]),
                                  ),
                                ));
                          },),
                      ),
                    )
                  ],
                  )


                ],
                )
              //: const ProductDetailsShimmer(),


    ));
  }

  String getSelectedItemCount() {
    return selectedItem.isNotEmpty
        ? "${selectedItem.length} item selected"
        : "No item selected";
  }


  void doMultiSelection(String imagelist) {
   // var machineDataUrl=Provider.of<SplashProvider>(context,listen: false).baseUrls!.machineDataUrl;
   // var line=Provider.of<MachinesProvider>(context).productDetailsModel!.productData![widget.productdataindexno].line;
   // var machine=Provider.of<MachinesProvider>(context).productDetailsModel!.productData![widget.productdataindexno].machine;
   // var datalist=Provider.of<MachinesProvider>(context).productDetailsModel!.productData![widget.productdataindexno].datalist![widget.datalistindexno];
   // var datatitle= Provider.of<MachinesProvider>(context).productDetailsModel!.productData![widget.productdataindexno].datatitle;

    if (isMultiSelectionEnabled) {
      if (selectedItem.contains(imagelist)) {
        selectedItem.remove(imagelist);
        //imagePaths.remove('${Provider.of<SplashProvider>(context,listen: false).baseUrls!.machineDataUrl}/${Provider.of<MachinesProvider>(context).productDetailsModel!.productData![widget.productdataindexno].line}/${Provider.of<MachinesProvider>(context).productDetailsModel!.productData![widget.productdataindexno].machine}/$datatitle/${datalist.imagesgroup}/$imagelist');
       // imagePaths.remove('$machineDataUrl/$line/$machine/$datatitle/${datalist.imagesgroup}/${datalist.imageslist}');
        imageNames.remove(imagelist);

      } else {
        selectedItem.add(imagelist);
        //imagePaths.add('${Provider.of<SplashProvider>(context,listen: false).baseUrls!.machineDataUrl}/${Provider.of<MachinesProvider>(context).productDetailsModel!.productData![widget.productdataindexno].line}/${Provider.of<MachinesProvider>(context).productDetailsModel!.productData![widget.productdataindexno].machine}/$datatitle/${datalist.imagesgroup}/$imagelist');
        //imagePaths.add('${Provider.of<SplashProvider>(context,listen: false).baseUrls!.machineDataUrl}/${Provider.of<MachinesProvider>(context).productDetailsModel!.productData![widget.productdataindexno].line}/${Provider.of<MachinesProvider>(context).productDetailsModel!.productData![widget.productdataindexno].machine}/$datatitle1/${datalist1.imagesgroup}/${datalist1.imageslist![1]}');
        //imageNames.add(imagelist);
        //imagePaths.add('$machineDataUrl/$line/$machine/$datatitle/${datalist.imagesgroup}/${datalist.imageslist}');

      }
      setState(() {});
    } else {
      //Other logic
    }
  }


  List<Widget> _indicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int index = 0; index < widget.imagesList.length; index++) {
      indicators.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraExtraSmall),
        child: Container(width: index == Provider.of<MachinesProvider>(context).imageSliderIndex? 20 : 6, height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: index == Provider.of<MachinesProvider>(context).imageSliderIndex ?
            Theme.of(context).primaryColor : Theme.of(context).hintColor,
          ),

        ),
      ));
    }
    return indicators;
  }




  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    if (uri.isNotEmpty) {
      await Share.shareUri(Uri.parse(uri));
    } else if (imagePaths.isNotEmpty) {
      final files = <XFile>[];
      for (var i = 0; i < imagePaths.length; i++) {
        files.add(XFile(imagePaths[i], name: imageNames[i]));
      }
      await Share.shareXFiles(files,
          text: text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  void _onShareWithResult(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    ShareResult shareResult;
    if (imagePaths.isNotEmpty) {
      final files = <XFile>[];
      for (var i = 0; i < imagePaths.length; i++) {
        files.add(XFile(imagePaths[i], name: imageNames[i]));
      }
      shareResult = await Share.shareXFiles(files,
          text: text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
         shareResult = await Share.shareWithResult(text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
    scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  void _onShareXFileFromAssets(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final data = await rootBundle.load('assets/flutter_logo.png');
    final buffer = data.buffer;
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: 'flutter_logo.png',
          mimeType: 'image/png',
        ),
      ],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }


  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Share result: ${result.status}"),
          if (result.status == ShareResultStatus.success)
            Text("Shared to: ${result.raw}")
        ],
      ),
    );
  }





}

