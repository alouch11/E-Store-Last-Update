import 'package:flutter_spareparts_store/features/package/provider/package_provider.dart';
import 'package:flutter_spareparts_store/features/package/view/package_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';

//const List<String> list = <String>['3000H', '6000H', '9000H', '12000H'];


class DropdownMachineList extends StatefulWidget {
  final List<String> list;

  const DropdownMachineList({super.key,required this.list});


  @override
  State<DropdownMachineList> createState() => _DropdownMachineList();
}

class _DropdownMachineList extends State<DropdownMachineList> {

  @override
  Widget build(BuildContext context) {
    return
DropdownMenu<String>(
  textStyle:textBold.copyWith(fontSize: Dimensions.fontSizeDefault,color: ColorResources.blue),
  enabled: true,
  enableSearch: true,
  enableFilter: true,
  requestFocusOnTap: false,
  width: MediaQuery.of(context).size.width-20,
  menuHeight: MediaQuery.of(context).size.width,
  leadingIcon: const Icon(Icons.list_alt),
  label: const Text('Machines'),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    contentPadding: EdgeInsets.symmetric(vertical:5.0),
  ),
      //initialSelection: widget.list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
         // dropdownValue = value!;
          return Provider.of<PackageProvider>(context, listen: false).setMachine(value!);
        });
      },
      dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),

    );
  }
}




