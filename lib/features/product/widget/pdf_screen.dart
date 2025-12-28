import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PDFScreen extends StatefulWidget {
  final String? url;
  final String? title;

  const PDFScreen({super.key, this.url,this.title});

  @override
  PDFScreenState createState() => PDFScreenState();

}

  //class PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
    class PDFScreenState extends State<PDFScreen>  {

    String remotePDFPath = "";
    String filename = "";

    @override
    void initState() {
      super.initState();
      createFileOfPdfUrl(widget.url!).then((f) {
        setState(() {
          remotePDFPath = f.path;
           filename = widget.url!.substring(widget.url!.lastIndexOf("/") + 1);
        });
      });
    }

    //final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text(filename),
/*        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],*/
  ),
  body: Stack(
  children: <Widget>[
 /* PDFView(
  filePath: remotePDFPath,
  enableSwipe: true,
  swipeHorizontal: true,
  autoSpacing: false,
  pageFling: true,
  pageSnap: true,
  defaultPage: currentPage!,
  fitPolicy: FitPolicy.BOTH,
  preventLinkNavigation: false, // if set to true the link is handled in flutter
  onRender: (pages) {
  setState(() {
  pages = pages;
  isReady = true;
  });
  },
  onError: (error) {
  setState(() {
  errorMessage = error.toString();
  });
  if (kDebugMode) {
  print(error.toString());
  }
  },
  onPageError: (page, error) {
  setState(() {
  errorMessage = '$page: ${error.toString()}';
  });
  if (kDebugMode) {
  print('$page: ${error.toString()}');
  }
  },
  onViewCreated: (PDFViewController pdfViewController) {
  _controller.complete(pdfViewController);
  },
  onLinkHandler: (String? uri) {
  if (kDebugMode) {
  print('goto uri: $uri');
  }
  },
  onPageChanged: (int? page, int? total) {
  if (kDebugMode) {
  print('page change: $page/$total');
  }
  setState(() {
  currentPage = page;
  });
  },
  ),*/
  errorMessage.isEmpty
  ? !isReady
  ? const Center(
  child: CircularProgressIndicator(),
  )
      : Container()
      : Center(
  child: Text(errorMessage),
  )
  ],
  ),
  );
  }
  }


  Future<File> createFileOfPdfUrl(String url) async {
  Completer<File> completer = Completer();
  try {
  final filename = url.substring(url.lastIndexOf("/") + 1);
  var request = await HttpClient().getUrl(Uri.parse(url));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);
  var dir = await getApplicationDocumentsDirectory();
  File file = File("${dir.path}/$filename");


  await file.writeAsBytes(bytes, flush: true);
  completer.complete(file);
  } catch (e) {
  throw Exception('Error parsing asset file!');
  }

  return completer.future;
  }