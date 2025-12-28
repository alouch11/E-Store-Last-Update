import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:provider/provider.dart';
import '../../../utill/custom_themes.dart';
import '../provider/machines_provider.dart';

class MachineTabItem extends StatefulWidget {
  final String? text;
  final int? index;
  final String? image;
  final String? type;
  final bool? enableDisable;

  const MachineTabItem({super.key, required this.text, this.index, required this.image, this.type , this.enableDisable});


  @override
  State<MachineTabItem> createState() => _MachineTabItemState();

  }

  class _MachineTabItemState extends State<MachineTabItem> {

    @override
    void initState() {
      super.initState();
    }


  @override
  Widget build(BuildContext context) {
    return Tab(height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      SizedBox(child: Container(
            width: 90,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              //color: ColorResources.getPrimary(context).withOpacity(0.2),
              color:ColorResources.hintTextColor.withOpacity(0.3),
            ),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(widget.image!,width: 40, height: 40,color:
               // widget.type =='drawing'? Provider.of<MachinesProvider>(context, listen: false).machineSelectedhasgraphic==false ?Theme.of(context).hintColor:Theme.of(context).primaryColor:
                //widget.type =='threed'?  Provider.of<MachinesProvider>(context, listen: false).machineSelectedhas3D==false ?Theme.of(context).hintColor:Theme.of(context).primaryColor:
                widget.enableDisable !=null  ?  widget.enableDisable==false ?Theme.of(context).hintColor:Theme.of(context).primaryColor: Theme.of(context).primaryColor
      ),
                Text(maxLines: 2,textAlign: TextAlign.center,
                  widget.text!, style:titleRegular.copyWith(color:Colors.black,fontSize:14), overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
      //],
      ),
    ]));
  }
}
