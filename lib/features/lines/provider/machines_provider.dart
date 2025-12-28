import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/lines_model.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/machines_model.dart';
import 'package:flutter_spareparts_store/features/lines/domain/repo/machines_repo.dart';
import 'package:flutter_spareparts_store/helper/api_checker.dart';
import 'dart:async';
import 'package:flutter/material.dart';



class MachinesProvider with ChangeNotifier {
  final MachinesRepo? machinesRepo;

  MachinesProvider({required this.machinesRepo});


   TabController? machineTabController;

     UniqueKey keyTile=UniqueKey();


  TabController? machineExtraTabController;


  //ScrollController machineAssemblyScrollController  = ScrollController();
  double machineAssemblyScrollControllerOffset = 1.0;


    List<bool> isExpanded0 = List.filled(100, false, growable: true);
    List<bool> isExpanded = List.filled(100, false, growable: true);
    List<bool> isExpanded1 = List.filled(100, false, growable: true);
    List<bool> isExpanded2 = List.filled(100, false, growable: true);
    List<bool> isExpanded3 = List.filled(100, false, growable: true);
    List<bool> isExpanded4 = List.filled(100, false, growable: true);
    List<bool> isExpanded5 = List.filled(100, false, growable: true);
    List<bool> isExpanded6 = List.filled(100, false, growable: true);


  int? _machineSelectedmachineid;
  int? get machineSelectedmachineid => _machineSelectedmachineid;

  String? _machineSelectedcode;
  String? get machineSelectedcode => _machineSelectedcode;


  bool? _machineSelectedhas3D=false;
  bool? get machineSelectedhas3D => _machineSelectedhas3D;

  bool? _machineSelectedhasgraphic=false;
  bool? get machineSelectedhasgraphic => _machineSelectedhasgraphic;



  String? _assemblySelectedDrawing='';
  String? get assemblySelectedDrawing => _assemblySelectedDrawing;







  MachineEmergencyModel? machineEmergency;
  Future<void> getMachineEmergencyList(int offset,int machineid,int? level) async {
    if(offset == 1){
      machineEmergency = null;
    }

    ApiResponse apiResponse = await machinesRepo!.getMachineEmergencyList(machineid,level);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        machineEmergency = MachineEmergencyModel.fromJson(apiResponse.response?.data);
      }else {
        machineEmergency!.emergencyList!.addAll(MachineEmergencyModel.fromJson(apiResponse.response?.data).emergencyList!);
        machineEmergency!.totalProducts = MachineEmergencyModel.fromJson(apiResponse.response?.data).totalProducts;
      }
    }
    else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }



  MachineMaintenanceModel? machineMaintenance;
  Future<void> getMachineMaintenanceList(int offset,int machineid,int? maintenance) async {
    if(offset == 1){
      machineMaintenance = null;
    }
    ApiResponse apiResponse = await machinesRepo!.getMachineMaintenanceList(machineid,maintenance);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      //if(offset == 1){
        machineMaintenance = MachineMaintenanceModel.fromJson(apiResponse.response?.data);
      /*}else {
        machineMaintenance!.maintenanceList!.addAll(MachineMaintenanceModel.fromJson(apiResponse.response?.data).maintenanceList!);
        machineMaintenance!.totalProducts = MachineMaintenanceModel.fromJson(apiResponse.response?.data).totalProducts;
      }*/
    }
    else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  int _machineEmergencyIndex = 1;
  int get machineEmergencyIndex => _machineEmergencyIndex;

  int selectedMachineEmergencyLevel = 1;

  void setIndexByMachine(int machineId,int index, {bool notify = true}) {
    _machineEmergencyIndex = index;

    if(_machineEmergencyIndex == 1){
      selectedMachineEmergencyLevel = 1;
      getMachineEmergencyList(1,machineId,1);
    }
    else if(_machineEmergencyIndex == 2){
      selectedMachineEmergencyLevel = 2;
      getMachineEmergencyList(1,machineId,2 );
    }
    else if(_machineEmergencyIndex == 3){
      selectedMachineEmergencyLevel = 3;
      getMachineEmergencyList(1,machineId,3 );
    }

    if(notify) {
      notifyListeners();
    }
  }


  int _machineMaintenanceIndex = 1;
  int get machineMaintenanceIndex => _machineMaintenanceIndex;

  int selectedMachineMaintenance = 1;

  void setIndexByMachineMaintenance(int machineId,int index, {bool notify = true}) {
    _machineMaintenanceIndex = index;

    if(_machineMaintenanceIndex == 1){
      selectedMachineMaintenance = 3000;
      getMachineMaintenanceList(1,machineId,3000);
    }
    else if(_machineMaintenanceIndex == 2){
      selectedMachineMaintenance = 4000;
      getMachineMaintenanceList(1,machineId,4000 );
    }
    else if(_machineMaintenanceIndex == 3){
      selectedMachineMaintenance = 6000;
      getMachineMaintenanceList(1,machineId,6000 );
    }
    else if(_machineMaintenanceIndex == 4){
      selectedMachineMaintenance = 8000;
      getMachineMaintenanceList(1,machineId,8000 );
    }
    else if(_machineMaintenanceIndex == 5){
      selectedMachineMaintenance = 9000;
      getMachineMaintenanceList(1,machineId,9000 );
    }
    else if(_machineMaintenanceIndex == 6){
      selectedMachineMaintenance = 12000;
      getMachineMaintenanceList(1,machineId,12000 );
    }
    else if(_machineMaintenanceIndex == 7){
      selectedMachineMaintenance = 15000;
      getMachineMaintenanceList(1,machineId,15000);
    }else if(_machineMaintenanceIndex == 8){
      selectedMachineMaintenance = 18000;
      getMachineMaintenanceList(1,machineId,18000 );
    }
    else if(_machineMaintenanceIndex == 9){
      selectedMachineMaintenance = 21000;
      getMachineMaintenanceList(1,machineId,21000 );
    }
    else if(_machineMaintenanceIndex == 10){
      selectedMachineMaintenance = 24000;
      getMachineMaintenanceList(1,machineId,24000 );
    }
    else if(_machineMaintenanceIndex == 11){
      selectedMachineMaintenance = 27000;
      getMachineMaintenanceList(1,machineId,27000 );
    }
    else if(_machineMaintenanceIndex == 12){
      selectedMachineMaintenance = 30000;
      getMachineMaintenanceList(1,machineId,30000 );
    }
    else if(_machineMaintenanceIndex == 13){
      selectedMachineMaintenance = 33000;
      getMachineMaintenanceList(1,machineId,33000 );
    } else if(_machineMaintenanceIndex == 14){
      selectedMachineMaintenance = 36000;
      getMachineMaintenanceList(1,machineId,36000 );
    }
    else if(_machineMaintenanceIndex == 15){
      selectedMachineMaintenance = 39000;
      getMachineMaintenanceList(1,machineId,39000 );
    }
    else if(_machineMaintenanceIndex == 16){
      selectedMachineMaintenance = 42000;
      getMachineMaintenanceList(1,machineId,42000 );
    }
    else if(_machineMaintenanceIndex == 17){
      selectedMachineMaintenance = 45000;
      getMachineMaintenanceList(1,machineId,45000 );
    }
    else if(_machineMaintenanceIndex == 18){
      selectedMachineMaintenance = 48000;
      getMachineMaintenanceList(1,machineId,48000 );
    }
    else if(_machineMaintenanceIndex == 19){
      selectedMachineMaintenance = 51000;
      getMachineMaintenanceList(1,machineId,51000 );
    }

    else if(_machineMaintenanceIndex == 20){
      selectedMachineMaintenance = 54000;
      getMachineMaintenanceList(1,machineId,54000 );
    }
    else if(_machineMaintenanceIndex == 21){
      selectedMachineMaintenance = 57000;
      getMachineMaintenanceList(1,machineId,57000 );
    }
    else if(_machineMaintenanceIndex == 22){
      selectedMachineMaintenance = 60000;
      getMachineMaintenanceList(1,machineId,60000 );
    }
    else if(_machineMaintenanceIndex == 23){
      selectedMachineMaintenance = 63000;
      getMachineMaintenanceList(1,machineId,63000 );
    }
    else if(_machineMaintenanceIndex == 24){
      selectedMachineMaintenance = 66000;
      getMachineMaintenanceList(1,machineId,66000 );
    }
    else if(_machineMaintenanceIndex == 25){
      selectedMachineMaintenance = 69000;
      getMachineMaintenanceList(1,machineId,69000 );
    }
    else if(_machineMaintenanceIndex == 26){
      selectedMachineMaintenance = 72000;
      getMachineMaintenanceList(1,machineId,72000 );
    }

    if(notify) {
      notifyListeners();
    }
  }


  MachineTechnicalDocModel? machineTechnicalDoc;
  Future<void> getMachineTechnicalDocList(int offset,int machineid) async {
      machineTechnicalDoc = null;

    ApiResponse apiResponse = await machinesRepo!.getMachineTechnicalDocList(machineid);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        machineTechnicalDoc = MachineTechnicalDocModel.fromJson(apiResponse.response?.data);
    }
    else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }




  MachineParametersModel? machineParameters;
  Future<void> getMachineParametersList(int machineid) async {
    machineParameters = null;

    ApiResponse apiResponse = await machinesRepo!.getMachineParametersList(machineid);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      machineParameters = MachineParametersModel.fromJson(apiResponse.response?.data);
    }
    else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }



  MachineAssemblyModel? machineAssembly;
  Future<void> getMachineAssemblyList(int machineid) async {

      machineAssembly = null;

    ApiResponse apiResponse = await machinesRepo!.getMachineAssemblyList(machineid);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        machineAssembly = MachineAssemblyModel.fromJson(apiResponse.response?.data);
        _machineSelectedmachineid=machineAssembly!.machineassembly![0].machineid;
        _machineSelectedcode=machineAssembly!.machineassembly![0].code;
        _machineSelectedhasgraphic=machineAssembly!.machineassembly![0].hasgraphic;
        _assemblySelectedDrawing=machineAssembly!.machineassembly![0].graphic;
        _machineSelectedhas3D=machineAssembly!.machineassembly![0].has3D;
    }
    else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }


  MachineAssemblyPartsModel? machineAssemblyPartsModel;
  Future<void> getMachineAssemblyParts(int machineid,String assemblycode,) async {

      machineAssemblyPartsModel = null;

    ApiResponse apiResponse = await machinesRepo!.getMachineAssemblyParts(machineid,assemblycode);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
     // if(offset == 1){
      machineAssemblyPartsModel = MachineAssemblyPartsModel.fromJson(apiResponse.response?.data);
      /*}else {
        machineAssemblyPartsModel!.machineAssemblyPartsList!.addAll(MachineAssemblyPartsModel.fromJson(apiResponse.response?.data).machineAssemblyPartsList!);
        machineAssemblyPartsModel!.totalProducts = MachineAssemblyPartsModel.fromJson(apiResponse.response?.data).totalProducts;
      }*/
    }
    else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }





  Machines? machinesSearch;
  bool searching = false;
  Future<ApiResponse> searchAsset({String? assetCode}) async {
    searching = true;
    notifyListeners();
    ApiResponse apiResponse = await machinesRepo!.searchAsset(assetCode!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      searching = false;
      machinesSearch = null;
      machinesSearch = Machines.fromJson(apiResponse.response?.data);
    } else {
      searching = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }



  void changeSelectedAssembly(int? Selectedmachineid,String selectedAssemblyCode,bool has3D,bool hasGraphic,String graphic) {

    _machineSelectedmachineid=Selectedmachineid;
    _machineSelectedcode=selectedAssemblyCode;
    _machineSelectedhas3D=has3D;
    _machineSelectedhasgraphic=hasGraphic;
    _assemblySelectedDrawing=graphic;


    notifyListeners();
  }



int? _imageSliderIndex=0;

int? get imageSliderIndex => _imageSliderIndex;



  Future<void> initMachineParameters(BuildContext context) async {
    _imageSliderIndex = 0;
    notifyListeners();
  }


void setImageSliderSelectedIndex(int selectedIndex) {
  _imageSliderIndex = selectedIndex;
  notifyListeners();
}






}
