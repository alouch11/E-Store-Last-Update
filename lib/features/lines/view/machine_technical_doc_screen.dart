import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/paginated_list_view.dart';
import 'package:flutter_spareparts_store/features/banner/widgets/banner_shimmer.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machine_emergency_level_button.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machines_emergency_widget.dart';
import 'package:flutter_spareparts_store/features/lines/widget/machines_technical_doc_widget.dart';
import 'package:flutter_spareparts_store/features/sale/widget/sale_shimmer.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';


class MachineTechnicalDocScreen extends StatefulWidget {
  final int? machineid;
  const MachineTechnicalDocScreen({super.key, required this.machineid});

  @override
  State<MachineTechnicalDocScreen> createState() => _MachineTechnicalDocScreenState();
}

class _MachineTechnicalDocScreenState extends State<MachineTechnicalDocScreen> {

  ScrollController scrollController  = ScrollController();
  UniqueKey keyTile=UniqueKey();
  bool isExpanded = false;

  void expandTile() {
    setState(() {
      //isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      //isExpanded = false;
      keyTile = UniqueKey();
    });
  }


  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {


    return Consumer<MachinesProvider>(
        builder: (context, machinesProvider, child) {
          return Column(children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),

          /* const Row(
          children: <Widget>[
          Expanded(
          child: Divider(thickness: 2,color: Colors.black,)
          ),
          Text(" List "),
          Expanded(
          child: Divider(thickness: 2,color: Colors.black,)
          ),
          ]
          ),*/

            Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(children: [
                  FlutterSwitch(
                    height: 27.0,
                    width: 47.0,
                    padding: 4.0,
                    toggleSize: 20.0,
                    borderRadius: 15.0,
                    activeColor: Theme.of(context).primaryColor,
                    value: isExpanded,
                    onToggle: (value) {
                      setState(() {
                        isExpanded = value;
                        isExpanded ? shrinkTile() : expandTile();
                      });
                    },
                  ),
                  const SizedBox(width: 10,),
                  Text(isExpanded?'${getTranslated('shrink_all', context)}':'${getTranslated('expand_all', context)}',style: textBold.copyWith( fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor))

                ])),

            Expanded(child: machinesProvider.machineTechnicalDoc!= null  ? (machinesProvider.machineTechnicalDoc!.technicalDocList != null && machinesProvider.machineTechnicalDoc!.technicalDocList!.isNotEmpty)?
          SingleChildScrollView(
          controller: scrollController,
          child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: machinesProvider.machineTechnicalDoc!.technicalDocList!.length,
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) => MachineTechnicalDocWidget(machineTechnicalDocList: machinesProvider.machineTechnicalDoc?.technicalDocList![index],isExpanded:isExpanded,keyTile: keyTile),
          ),
          )  :const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noProduct, message: 'no_products_found',)
                : const SaleShimmer()
          )


          ]);}
);
  }

}
