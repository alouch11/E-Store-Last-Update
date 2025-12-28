
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../utill/dimensions.dart';
import '../../product/provider/search_provider.dart';

class QrCode extends StatefulWidget {
  const QrCode({super.key});

  @override
  State<QrCode> createState() => _QrCodeState();
}


class _QrCodeState extends State<QrCode> {
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
    //return Scaffold(
    //body: Center(
      child:Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                var searchtype= Provider.of<SearchProvider>(context, listen: false).searchProvider.selectedType;
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));
                setState(() {
                  if (res is String) {
                    //Provider.of<SearchProvider>(context, listen: false).searchController.text = res;
                     //Provider.of<SearchProvider>(context, listen: false).searchController.clear();
                     Provider.of<SearchProvider>(context, listen: false).searchProduct( query : res.toString(), searchtype: searchtype, offset: 1);
                  }
                });
              },
              child: const Text('Open Scanner'),
            ),
           // Text('Barcode Result: $result'),
          ],
        ),
      ),


    );
  }
}
