import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:provider/provider.dart';


class MachineEmergencyLevelButton extends StatelessWidget {
  final String? text;
  final int index;
  final int machineId;

  const MachineEmergencyLevelButton({super.key, required this.text, required this.index, required this.machineId});

  @override
  Widget build(BuildContext context) {
    return
        SizedBox(
      child: TextButton(
        onPressed: () => Provider.of<MachinesProvider>(context, listen: false).setIndexByMachine(machineId,index),
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
        child: Container(
          height: 35,
          width: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Provider.of<MachinesProvider>(context, listen: false).machineEmergencyIndex == index ? ColorResources.getPrimary(context).withOpacity(0.7) : Theme.of(context).primaryColor.withOpacity(0),
            borderRadius: BorderRadius.circular(10),
          ),
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text!,
                style:titleRegular.copyWith(color:Colors.black,fontSize:14),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}