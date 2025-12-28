import 'package:flutter_spareparts_store/features/package/provider/package_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';


class DropdownStatusList extends StatefulWidget {
  final List<String> list;

  const DropdownStatusList({super.key,required this.list});


  @override
  State<DropdownStatusList> createState() => _DropdownStatusList();
}

class _DropdownStatusList extends State<DropdownStatusList> {

  @override
  Widget build(BuildContext context) {
    return
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          child:

DropdownMenu<String>(
  textStyle:textBold.copyWith(fontSize: Dimensions.fontSizeDefault,color: ColorResources.blue),
  enabled: true,
  enableFilter: true,
  requestFocusOnTap: false,
  leadingIcon: const Icon(Icons.line_weight),
  label: const Text('Lines'),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    contentPadding: EdgeInsets.symmetric(vertical:5.0),
  ),
/*  inputDecorationTheme: InputDecorationTheme(
    border: MaterialStateOutlineInputBorder.resolveWith(
          (states) => states.contains(MaterialState.focused)
          ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
          : const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    ),
  ),*/
      initialSelection: widget.list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          //dropdownValue = value!;
          return Provider.of<PackageProvider>(context, listen: false).setLine(value!);
        });
      },
      dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    ));


/*    return DropdownSearch<String>.multiSelection(
      items: widget.list,
      popupProps: PopupPropsMultiSelection.menu(
        showSelectedItems: true,
        disabledItemFn: (String s) => s.startsWith('I'),
      ),
      onChanged: (List<String> value) {
        setState(() {
         // dropdownValue = value!;
          return Provider.of<PackageProvider>(context, listen: false).setIndex(value![0]);
        });
      },
      selectedItems: const ["pending"],
    );*/



  }
}
