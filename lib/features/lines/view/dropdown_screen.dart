import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/lines_model.dart';
import 'package:flutter_spareparts_store/features/lines/provider/lines_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:provider/provider.dart';

class DropdownScreen extends StatefulWidget {
  const DropdownScreen({super.key});


  @override
  State<DropdownScreen> createState() => _DropdownScreenState();
}

class _DropdownScreenState extends State<DropdownScreen> {

  String url = "http://192.168.155.137:8080/response.json";

  LinesMachinesModel? _lines;
  List<MachinesGroup>? _machines=[];


// these will be the values after selection of the item
  String? line;
  String? machine;

// this will help to show the widget after 
  bool isLineSelected = false;
  bool isMachineSelected = false;


  @override
  void initState() {
    setState(() {
      _lines =Provider.of<LinesProvider>(context, listen: false).linesMachinesGroupModelBk;
     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: const Text("Multiple Dynamic Dependent Dropdown")),
      body:

      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //========================Machine

          //if (_lines!.linesmachines!.isNotEmpty && _lines !=null && _lines!.linesmachines !=null) const Center(child: CircularProgressIndicator()) else
            Card(
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: DropdownButton<String>(
              underline: Container(),
                hint: const Text("Select Line", style: TextStyle(color: ColorResources.white)),
                icon: const Icon(Icons.keyboard_arrow_down,color: ColorResources.white),
                isDense: true,
                isExpanded: true,
                items: _lines!.linesmachines!.map((ln){
                return DropdownMenuItem<String>(
                  value: ln.lineName,
                  child: Text(maxLines: 1, ln.lineName!, style: const TextStyle(color: ColorResources.white)),
                  );
              }).toList(), 
               value: line,
              onChanged: (value){
                  setState(() {
                    _machines = [];
                    machine=null;
                    line = value!;
                   for(int i =0; i<_lines!.linesmachines!.length; i++){
                    if(_lines!.linesmachines![i].lineName == value){
                      _machines = _lines!.linesmachines![i].machinesGroup!;
                    }
                   }
                    isLineSelected = true;
                  });
              }),
            ),
          ),
//======================================= Machine
      //if(isLineSelected)
            Card(
               color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Container(
            
                 padding: const EdgeInsets.all(15.0),
                child: DropdownButton<String>(
                underline: Container(),
                hint:  const Text( "Select Machine", style: TextStyle(color: ColorResources.white),
                    ),

                icon: const Icon(Icons.keyboard_arrow_down,color: ColorResources.white),
                isDense: true,
                isExpanded: true,
                items: _machines!.map((mch){
                return DropdownMenuItem<String>(
                  value: mch.machineName,
                    child: Text(maxLines: 1, mch.machineName!, style: const TextStyle(color: ColorResources.white)),
                  );
                      }).toList(), 
                       value: machine,
                      onChanged: (value){
                  setState(() {
                 //  _cities = [];
                   machine = value!;
                 /*for(int i =0; i<_machines!.length; i++){
                  if(_machines![i].machineName == value){
                  //  _cities = _states[i]["cities"];
                  }
                 }
                   isMachineSelected = true;*/
                  });
                      }
                      ),
              ),
            ) //else Container(),

            /*
        //=============================== City
if(isStateSelected)
            Card(
              color: Colors.purple.withOpacity(0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Container(
                padding: EdgeInsets.all(15),
                child: DropdownButton<String>(
                underline: Container(),
                hint: Text("Select City"),
                icon: const Icon(Icons.keyboard_arrow_down),
                isDense: true,
                isExpanded: true,
                items: _cities.map((ct){
                return DropdownMenuItem<String>(
                  value: ct["name"],
                  child: Text(ct["name"])
                  );
                      }).toList(), 
                       value: city,
                      onChanged: (value){
                  setState(() {
                 
                
                 city = value!;
              
                  });
                      }),
              ),
            ) else Container(),*/

        ],),
  ),
    );
  }
}