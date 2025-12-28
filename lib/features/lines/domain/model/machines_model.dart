/*

class Machines {
  int? id;
  int? lineId;
  //String? statusImage;
  bool? hasBOM;
  String? code;
  //String? statusFont;
  //String? statusDesc;
  bool? hasEmergencyList;
  int? BOMId;
  bool? hasMaintenanceList;
  bool? hasInformations;
  String? name;
  int? machineId;
  bool? hasAttachments;
  bool? hasQR;
  String? status;
  String? model;
  String? yearOfConstraction;
  String? installationDate;
  String? make;


  Machines(
      {this.id,
        this.lineId,
        //this.statusImage,
        this.hasBOM,
        this.code,
       //this.statusFont,
        //this.statusDesc,
        this.hasEmergencyList,
        this.BOMId,
        this.hasMaintenanceList,
        this.hasInformations,
        this.name,
        this.machineId,
        this.hasAttachments,
        this.hasQR,
        this.status,
        this.model,
        this.yearOfConstraction,
        this.installationDate,
        this.make,
      });

  Machines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lineId = json['line_id'];
   // statusImage = json['statusImage'];
    if(json['hasBOM'] != null){
      try{
        hasBOM = json['hasBOM']??false;
      }catch(e){
        hasBOM = json['hasBOM']==1? true :false;
      }
    }
    code = json['code'];
    //statusFont = json['statusFont'];
   // statusDesc = json['status_desc'];
    if(json['hasEmergencyList'] != null){
      try{
        hasEmergencyList = json['hasEmergencyList']??false;
      }catch(e){
        hasEmergencyList = json['hasEmergencyList']==1? true :false;
      }
    }
    BOMId = json['BOM_id'];
    if(json['hasMaintenanceList'] != null){
      try{
        hasMaintenanceList = json['hasMaintenanceList']??false;
      }catch(e){
        hasMaintenanceList = json['hasMaintenanceList']==1? true :false;
      }
    }
    if(json['hasInformations'] != null){
      try{
        hasInformations = json['hasInformations']??false;
      }catch(e){
        hasInformations = json['hasInformations']==1? true :false;
      }
    }
    name = json['name'];
    machineId = json['machineId'];
    if(json['hasAttachments'] != null){
      try{
        hasAttachments = json['hasAttachments']??false;
      }catch(e){
        hasAttachments = json['hasAttachments']==1? true :false;
      }
    }
    if(json['hasQR'] != null){
      try{
        hasQR = json['hasQR']??false;
      }catch(e){
        hasQR = json['hasQR']==1? true :false;
      }
    }
    status = json['status'];
    yearOfConstraction = json['year_of_constraction'];
    installationDate = json['installation_date'];
    model = json['model'];
    make = json['make'];
  }
}
*/





import 'dart:convert';

/// Emergency List

class MachineEmergencyModel {
  int? totalProducts;
  List<EmergencyList>? emergencyList;

  MachineEmergencyModel({this.totalProducts, this.emergencyList});

  MachineEmergencyModel.fromJson(Map<String, dynamic> json) {
    totalProducts = json['total_products'];
    if (json['emergencylist'] != null) {
      emergencyList = <EmergencyList>[];
      json['emergencylist'].forEach((v) {
        emergencyList!.add(EmergencyList.fromJson(v));
      });
    }
  }

}

class EmergencyList {
  String? assemblyCode;
  String? assemblyDescription;
  String? assemblyPosition;
  List<AssemblyEmergencyItems>? assemblyemergencyitems;

  EmergencyList(
  {
  this.assemblyCode,
  this.assemblyDescription,
  this.assemblyPosition,
  this.assemblyemergencyitems,
  });

  EmergencyList.fromJson(Map<String, dynamic> json) {
    assemblyCode = json['assemblyCode'];
    assemblyDescription = json['assemblyDescription'];
    assemblyPosition = json['assemblyPosition'];
  if (json['assemblyitems'] != null) {
    assemblyemergencyitems = <AssemblyEmergencyItems>[];
  json['assemblyitems'].forEach((v) {
    assemblyemergencyitems!.add(AssemblyEmergencyItems.fromJson(v));
  });
  }
  }
  }


class AssemblyEmergencyItems {
  String? partCode;
  String? materialDescription;
  String? materialLongDescription;
  double? quantity;
  String? uom;
  String? assemblyCode;

  AssemblyEmergencyItems(
      {
        this.partCode,
        this.materialDescription,
        this.materialLongDescription,
        this.quantity,
        this.uom,
        this.assemblyCode,
      });

  AssemblyEmergencyItems.fromJson(Map<String, dynamic> json) {
    partCode = json['partCode'];
    materialDescription = json['materialDescription'];
    materialLongDescription = json['materialLongDescription'];
    quantity = json['quantity'].toDouble();
    uom = json['uom'];
    assemblyCode = json['assemblyCode'];

  }
}




///Machine Maintenance
class MachineMaintenanceModel {
  int? totalProducts;
  List<MaintenanceList>? maintenanceList;

  MachineMaintenanceModel({this.totalProducts, this.maintenanceList});

  MachineMaintenanceModel.fromJson(Map<String, dynamic> json) {
    totalProducts = json['total_products'];
    if (json['maintenancelist'] != null) {
      maintenanceList = <MaintenanceList>[];
      json['maintenancelist'].forEach((v) {
        maintenanceList!.add(MaintenanceList.fromJson(v));
      });
    }
  }

}

class MaintenanceList {
  String? assemblyCode;
  String? assemblyDescription;
  String? assemblyPosition;
  List<AssemblyMaintenanceItems>? assemblymaintenanceitems;

  MaintenanceList(
      {
        this.assemblyCode,
        this.assemblyDescription,
        this.assemblyPosition,
        this.assemblymaintenanceitems,
      });

  MaintenanceList.fromJson(Map<String, dynamic> json) {
    assemblyCode = json['assemblyCode'];
    assemblyDescription = json['assemblyDescription'];
    assemblyPosition = json['assemblyPosition'];
    if (json['assemblyitems'] != null) {
      assemblymaintenanceitems = <AssemblyMaintenanceItems>[];
      json['assemblyitems'].forEach((v) {
        assemblymaintenanceitems!.add(AssemblyMaintenanceItems.fromJson(v));
      });
    }
  }
}


class AssemblyMaintenanceItems {
  String? partCode;
  String? materialDescription;
  String? materialLongDescription;
  double? quantity;
  String? uom;
  String? assemblyCode;

  AssemblyMaintenanceItems(
      {
        this.partCode,
        this.materialDescription,
        this.materialLongDescription,
        this.quantity,
        this.uom,
        this.assemblyCode,
      });

  AssemblyMaintenanceItems.fromJson(Map<String, dynamic> json) {
    partCode = json['partCode'];
    materialDescription = json['materialDescription'];
    materialLongDescription = json['materialLongDescription'];
    quantity = json['quantity'].toDouble();
    uom = json['uom'];
    assemblyCode = json['assemblyCode'];

  }
}









class AssemblyGroup {
  String? assemblyPosition;
  String? assemblyCode;
  String? assemblyDescription;
  List<AssemblyItems>? assemblyItems;

  AssemblyGroup(
      {
        this.assemblyPosition,
        this.assemblyCode,
        this.assemblyDescription,
        this.assemblyItems,
      });

  AssemblyGroup.fromJson(Map<String, dynamic> json) {
    assemblyPosition = json['assemblyPosition'];
    assemblyCode = json['assemblyCode'];
    assemblyDescription = json['assemblyDescription'];
    if (json['assembly_items'] != null) {
      assemblyItems = <AssemblyItems>[];
      json['assembly_items'].forEach((v) {
        assemblyItems!.add(AssemblyItems.fromJson(v));
      });
    }
  }
}



class AssemblyItems {
  int? lineNumber;
  String? partCode;
  String? materialDescription;
  String? materialLongDescription;
  double? quantity;
  String? uom;
  String? maintenance;

  AssemblyItems(
      {
        this.lineNumber,
        this.partCode,
        this.materialDescription,
        this.materialLongDescription,
        this.quantity,
        this.uom,
        this.maintenance,
      });

  AssemblyItems.fromJson(Map<String, dynamic> json) {
    lineNumber = json['lineNumber'];
    partCode = json['partCode'];
    materialDescription = json['materialDescription'];
    materialLongDescription = json['materialLongDescription'];
    quantity = json['quantity'].toDouble();
    uom = json['uom'];
    maintenance = json['maintenance'];

  }
}







///Machine Assembly
class MachineAssemblyModel {
  int? totalProducts;
  List<AssemblyList>? machineassembly;

  MachineAssemblyModel({this.totalProducts, this.machineassembly});

  MachineAssemblyModel.fromJson(Map<String, dynamic> json) {
    totalProducts = json['total_products'];
    if (json['machineassembly'] != null) {
      machineassembly = <AssemblyList>[];
      json['machineassembly'].forEach((v) {
        machineassembly!.add(AssemblyList.fromJson(v));
      });
    }
  }

}



class AssemblyList {
  int? machineid;
  String? code;
  String? description;
  int? level;
  bool? has3D;
  bool? hasgraphic;
  String? graphic;
  List<ChildrenGroup>? childrenGroup;

  AssemblyList(
      {
        this.machineid,
        this.code,
        this.description,
        this.level,
        this.has3D,
        this.hasgraphic,
        this.graphic,
        this.childrenGroup,
      });

  AssemblyList.fromJson(Map<String, dynamic> json) {
    machineid = json['machineid'];
    code = json['children'].toString();
    description = json['description'];
    level = json['level'];
    has3D = json['has3D'];
    hasgraphic = json['hasgraphic'];
    if (json['graphic'] != null) {
      graphic = json['graphic'];
    }
    else {
      graphic='';
    }
    if (json['child'] != null) {
      childrenGroup = <ChildrenGroup>[];
      json['child'].forEach((v) {
        childrenGroup!.add(ChildrenGroup.fromJson(v));
      });
    }
  }
}


class ChildrenGroup {
  int? machineid;
  String? code;
  String? description;
  int? level;
  bool? has3D;
  bool? hasgraphic;
  String? graphic;
  List<ChildrenGroup1>? childrenGroup1;

  ChildrenGroup(
      {
        this.machineid,
        this.code,
        this.description,
        this.level,
        this.has3D,
        this.hasgraphic,
        this.graphic,
        this.childrenGroup1,
      });

  ChildrenGroup.fromJson(Map<String, dynamic> json) {
    machineid = json['id'];
    code = json['children'].toString();
    description = json['description'];
    level = json['level'];
    has3D = json['has3D'];
    hasgraphic = json['hasgraphic'];
    if (json['graphic'] != null) {
      graphic = json['graphic'];
    }
    else {
      graphic='';
    }
    if (json['child'] != null) {
      childrenGroup1 = <ChildrenGroup1>[];
      json['child'].forEach((v) {
        childrenGroup1!.add(ChildrenGroup1.fromJson(v));
      });
    }
  }
}



class ChildrenGroup1 {
  int? machineid;
  String? code;
  String? description;
  int? level;
  bool? has3D;
  bool? hasgraphic;
  String? graphic;
  List<ChildrenGroup2>? childrenGroup2;

  ChildrenGroup1(
      {
        this.machineid,
        this.code,
        this.description,
        this.level,
        this.has3D,
        this.hasgraphic,
        this.graphic,
        this.childrenGroup2,
      });

  ChildrenGroup1.fromJson(Map<String, dynamic> json) {
    machineid = json['id'];
    code = json['children'].toString();
    description = json['description'];
    level = json['level'];
    has3D = json['has3D'];
    hasgraphic = json['hasgraphic'];
    if (json['graphic'] != null) {
      graphic = json['graphic'];
    }
    else {
      graphic='';
    }
    if (json['child'] != null) {
      childrenGroup2 = <ChildrenGroup2>[];
      json['child'].forEach((v) {
        childrenGroup2!.add(ChildrenGroup2.fromJson(v));
      });
    }
  }
}



class ChildrenGroup2 {
  int? machineid;
  String? code;
  String? description;
  int? level;
  bool? has3D;
  bool? hasgraphic;
  String? graphic;
  List<ChildrenGroup3>? childrenGroup3;

  ChildrenGroup2(
      {
        this.machineid,
        this.code,
        this.description,
        this.level,
        this.has3D,
        this.hasgraphic,
        this.graphic,
        this.childrenGroup3,
      });

  ChildrenGroup2.fromJson(Map<String, dynamic> json) {
    machineid = json['id'];
    code = json['children'].toString();
    description = json['description'];
    level = json['level'];
    has3D = json['has3D'];
    hasgraphic = json['hasgraphic'];
    if (json['graphic'] != null) {
      graphic = json['graphic'];
    }
    else {
      graphic='';
    }
     if (json['child'] != null) {
       childrenGroup3 = <ChildrenGroup3>[];
      json['child'].forEach((v) {
        childrenGroup3!.add(ChildrenGroup3.fromJson(v));
      });
    }
  }
}



class ChildrenGroup3 {
  int? machineid;
  String? code;
  String? description;
  int? level;
  bool? has3D;
  bool? hasgraphic;
  String? graphic;
  List<ChildrenGroup4>? childrenGroup4;

  ChildrenGroup3(
      {
        this.machineid,
        this.code,
        this.description,
        this.level,
        this.has3D,
        this.hasgraphic,
        this.graphic,
        this.childrenGroup4,
      });

  ChildrenGroup3.fromJson(Map<String, dynamic> json) {
    machineid = json['id'];
    code = json['children'].toString();
    description = json['description'];
    level = json['level'];
    has3D = json['has3D'];
    hasgraphic = json['hasgraphic'];
    if (json['graphic'] != null) {
      graphic = json['graphic'];
    }
    else {
      graphic='';
    }
     if (json['children'] != null) {
       childrenGroup4 = <ChildrenGroup4>[];
      json['child'].forEach((v) {
        childrenGroup4!.add(ChildrenGroup4.fromJson(v));
      });
    }
  }
}



class ChildrenGroup4 {
  int? machineid;
  String? code;
  String? description;
  int? level;
  bool? has3D;
  bool? hasgraphic;
  String? graphic;
  List<ChildrenGroup5>? childrenGroup5;

  ChildrenGroup4(
      {
        this.machineid,
        this.code,
        this.description,
        this.level,
        this.has3D,
        this.hasgraphic,
        this.graphic,
        this.childrenGroup5,
      });

  ChildrenGroup4.fromJson(Map<String, dynamic> json) {
    machineid = json['id'];
    code = json['children'].toString();
    description = json['description'];
    level = json['level'];
    has3D = json['has3D'];
    hasgraphic = json['hasgraphic'];
    if (json['graphic'] != null) {
      graphic = json['graphic'];
    }
    else {
      graphic='';
    }
     if (json['children'] != null) {
       childrenGroup5 = <ChildrenGroup5>[];
      json['child'].forEach((v) {
        childrenGroup5!.add(ChildrenGroup5.fromJson(v));
      });
    }
  }
}


class ChildrenGroup5 {
  int? machineid;
  String? code;
  String? description;
  int? level;
  bool? has3D;
  bool? hasgraphic;
  String? graphic;
  List<ChildrenGroup6>? childrenGroup6;

  ChildrenGroup5(
      {
        this.machineid,
        this.code,
        this.description,
        this.level,
        this.has3D,
        this.hasgraphic,
        this.graphic,
        this.childrenGroup6,
      });

  ChildrenGroup5.fromJson(Map<String, dynamic> json) {
    machineid = json['id'];
    code = json['children'].toString();
    description = json['description'];
    level = json['level'];
    has3D = json['has3D'];
    hasgraphic = json['hasgraphic'];
    if (json['graphic'] != null) {
      graphic = json['graphic'];
    }
    else {
      graphic='';
    }
     if (json['children'] != null) {
       childrenGroup6 = <ChildrenGroup6>[];
      json['child'].forEach((v) {
        childrenGroup6!.add(ChildrenGroup6.fromJson(v));
      });
    }
  }
}


class ChildrenGroup6 {
  int? machineid;
  String? code;
  String? description;
  int? level;
  bool? has3D;
  bool? hasgraphic;
  String? graphic;
  //List<ChildrenGroup1>? childrenGroup1;

  ChildrenGroup6(
      {
        this.machineid,
        this.code,
        this.description,
        this.level,
        this.has3D,
        this.hasgraphic,
        this.graphic,
        //this.childrenGroup1,
      });

  ChildrenGroup6.fromJson(Map<String, dynamic> json) {
    machineid = json['id'];
    code = json['children'].toString();
    description = json['description'];
    level = json['level'];
    has3D = json['has3D'];
    hasgraphic = json['hasgraphic'];
    if (json['graphic'] != null) {
      graphic = json['graphic'];
    }
    else {
      graphic='';
    }
/* if (json['children'] != null) {
      childrenGroup1 = <ChildrenGroup1>[];
      json['child'].forEach((v) {
        childrenGroup1!.add(ChildrenGroup1.fromJson(v));
      });
    }*/

  }
}




///Machine Assembly Parts

class MachineAssemblyPartsModel {
  int? totalProducts;
  List<MachineAssemblyPartsList>? machineAssemblyPartsList;

  MachineAssemblyPartsModel({this.totalProducts, this.machineAssemblyPartsList});

  MachineAssemblyPartsModel.fromJson(Map<String, dynamic> json) {
    totalProducts = json['total_products'];
    if (json['machineassemblyparts'] != null) {
      machineAssemblyPartsList = <MachineAssemblyPartsList>[];
      json['machineassemblyparts'].forEach((v) {
        machineAssemblyPartsList!.add(MachineAssemblyPartsList.fromJson(v));
      });
    }
  }

}



class MachineAssemblyPartsList {
  int? machineid;
  String? componentcode;
  String? componentdescription;
  bool? has3D;
  int? id;
  int? parentid;
  bool? hasgraphic;
  String? graphic;
  String? assemblycode;
  int? position;
  int? quantity;
  bool? hasassembly;

  MachineAssemblyPartsList(
      {
        this.machineid,
        this.componentcode,
        this.componentdescription,
        this.has3D,
        this.id,
        this.parentid,
        this.hasgraphic,
        this.graphic,
        this.assemblycode,
        this.position,
        this.quantity,
        this.hasassembly,
      });

  MachineAssemblyPartsList.fromJson(Map<String, dynamic> json) {
    machineid = json['machineid'];
    componentcode = json['componentcode'];
    componentdescription = json['componentdescription'];
    has3D = json['has3D'];
    id = json['id'];
    parentid = json['parentid'];
    hasgraphic = json['hasgraphic'];
    graphic = json['graphic'];
    assemblycode = json['assemblycode'];
    position = json['position'];
    quantity = json['quantity'];
    //hasassembly = json['hasassembly'];
    if(json['hasassembly'] != null){
      try{
        hasassembly = json['hasassembly']??false;
      }catch(e){
        hasassembly = json['hasassembly']==1? true :false;
      }
    }
  }
}





///Machine Technical Doc List
class MachineTechnicalDocModel {
  int? totalProducts;
  List<TechnicalDocList>? technicalDocList;

  MachineTechnicalDocModel({this.totalProducts, this.technicalDocList});

  MachineTechnicalDocModel.fromJson(Map<String, dynamic> json) {
    totalProducts = json['total_products'];
    if (json['technicaldoclist'] != null) {
      technicalDocList = <TechnicalDocList>[];
      json['technicaldoclist'].forEach((v) {
        technicalDocList!.add(TechnicalDocList.fromJson(v));
      });
    }
  }

}


class TechnicalDocList {
  String? catalogueTitle;
  String? line;
  int? machineid;
  String? docIcon;

  List<MachineDocItems>? machinedocitems;

  TechnicalDocList(
      {
        this.catalogueTitle,
        this.line,
        this.machineid,
        this.docIcon,
        this.machinedocitems,
      });

  TechnicalDocList.fromJson(Map<String, dynamic> json) {
    catalogueTitle = json['catalogue_title'];
    line = json['line'];
    machineid = json['machineid'];
    docIcon = json['doc_icon'];
    if (json['technicaldocs'] != null) {
      machinedocitems = <MachineDocItems>[];
      json['technicaldocs'].forEach((v) {
        machinedocitems!.add(MachineDocItems.fromJson(v));
      });
    }
  }
}


class MachineDocItems {
  String? catalogueTitle;
  int? catalogueAuth;
  String? catalogueLang;
  String? cataloguePath;
  String? details;
  String? line;
  String? machine;

  MachineDocItems(
      {
        this.catalogueTitle,
        this.catalogueAuth,
        this.catalogueLang,
        this.cataloguePath,
        this.details,
        this.line,
        this.machine,
      });

  MachineDocItems.fromJson(Map<String, dynamic> json) {
    catalogueTitle = json['catalogue_title'];
    catalogueAuth = json['catalogue_auth'];
    catalogueLang = json['catalogue_lang'];
    cataloguePath = json['catalogue_path'];
    details = json['details'];
    line = json['line'];
    machine = json['machine'];

  }
}







///Machine Parameters List
class MachineParametersModel {
  int? totalProducts;
  List<ParametersList>? parametersList;

  MachineParametersModel({this.totalProducts, this.parametersList});

  MachineParametersModel.fromJson(Map<String, dynamic> json) {
    totalProducts = json['total_products'];
    if (json['parameterslist'] != null) {
      parametersList = <ParametersList>[];
      json['parameterslist'].forEach((v) {
        parametersList!.add(ParametersList.fromJson(v));
      });
    }
  }

}


class ParametersList {

  String? line;
  String? machine;
  int? lineid;
  int? machineid;
  String? parametersTitle;
  int? parametersAuth;
  String? docIcon;

  List<MachineParametersItems>? machineparametersitems;

  ParametersList(
      {
        this.line,
        this.machine,
        this.lineid,
        this.machineid,
        this.parametersTitle,
        this.parametersAuth,
        this.docIcon,
        this.machineparametersitems,
      });

  ParametersList.fromJson(Map<String, dynamic> json) {
    line = json['line'];
    machine = json['machine'];
    lineid = json['line_id'];
    machineid = json['machine_id'];
    parametersTitle = json['parameters_title'];
    parametersAuth = json['parameters_auth'];
    docIcon = json['doc_icon'];
    if (json['parameters'] != null) {
      machineparametersitems = <MachineParametersItems>[];
      json['parameters'].forEach((v) {
        machineparametersitems!.add(MachineParametersItems.fromJson(v));
      });
    }
  }
}


class MachineParametersItems {
  String? parametersTitle;
  String? imagesgroup;
  List<ImagesList>? imageslist;


  MachineParametersItems(
      {
        this.parametersTitle,
        this.imagesgroup,
        this.imageslist,
      });

  MachineParametersItems.fromJson(Map<String, dynamic> json) {
    parametersTitle = json['parameters_title'];
    imagesgroup = json['images_group'];
    if (json['images_list'] != null) {
      imageslist = <ImagesList>[];
      json['images_list'].forEach((v) {
        imageslist!.add(ImagesList.fromJson(v));
      });
    }

  }
}




class ImagesList {

  String? imagesgroup;
  //String? images;
  List<String>? images;


  ImagesList(
      {
        this.imagesgroup,
        this.images,
      });

  ImagesList.fromJson(Map<String, dynamic> json) {
    imagesgroup = json['images_group'];
    //images = json['image'];
    if(json['images_list'] != null){
      try{
        images = json['images_list'] != null ? json['images_list'].cast<String>() : [];
      }catch(e){
        images = json['images_list'] != null ? jsonDecode(json['images_list']).cast<String>() : [];
      }

    }

  }
}
