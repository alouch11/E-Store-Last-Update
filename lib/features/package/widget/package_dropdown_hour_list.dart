import 'package:flutter_spareparts_store/features/package/provider/package_provider.dart';
import 'package:flutter_spareparts_store/features/package/view/package_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:provider/provider.dart';

import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';

//const List<String> list = <String>['3000H', '6000H', '9000H', '12000H'];


class DropdownHourList extends StatefulWidget {
  final List<String> list;

  const DropdownHourList({super.key,required this.list});


  @override
  State<DropdownHourList> createState() => _DropdownHourList();
}

class _DropdownHourList extends State<DropdownHourList> {

  @override
  Widget build(BuildContext context) {
    return
/*      Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(10),
          child: */
          DropdownMenu<String>(
          textStyle:textBold.copyWith(fontSize: Dimensions.fontSizeDefault,color: ColorResources.blue),
            enabled: true,
            enableSearch: true,
            enableFilter: true,
            requestFocusOnTap: false,
            width: MediaQuery.of(context).size.width-20,
            menuHeight: MediaQuery.of(context).size.width,
          leadingIcon: const Icon(Icons.timer),
          label: const Text('Hours'),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical:5.0),
          ),
      //initialSelection: widget.list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
         // dropdownValue = value!;
          return Provider.of<PackageProvider>(context, listen: false).setHour(value!);
        });
      },
      dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    //)
    );
  }
}
