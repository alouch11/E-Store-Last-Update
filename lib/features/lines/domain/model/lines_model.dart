

class LinesModel {
  int? totalLines;
  String? limit;
  String? offset;
  List<Lines>? lines;

  LinesModel({this.totalLines, this.limit, this.offset, this.lines});

  LinesModel.fromJson(Map<String, dynamic> json) {
    totalLines = json['total_lines'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['lines'] != null) {
      lines = <Lines>[];
      json['lines'].forEach((v) {
        lines!.add(Lines.fromJson(v));
      });
    }
  }

}

class Lines {
  int? id;
  int? lineId;
  String? site;
  //String? statusFont;
  //String? statusDesc;
  String? name;
  String? productType;
  String? productSize;
  String? packagingMaterial;
  String? status;
  String? lineName;
  List<Machines>? machines;

  Lines(
      {this.id,
        this.lineId,
        this.site,
        //this.statusFont,
        //this.statusDesc,
        this.name,
        this.productType,
        this.productSize,
        this.packagingMaterial,
        this.status,
        this.lineName,
        this.machines,
      });


  Lines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lineId = json['line_id'];
    site = json['site'];
    //statusFont = json['statusFont'];
    //statusDesc = json['status_desc'];
    name = json['name'];
    productType = json['product_type'];
    productSize = json['product_size'];
    packagingMaterial = json['packaging_material'];
    status = json['status'];
    lineName = json['line_name'];
    if (json['machines'] != null) {
      machines = <Machines>[];
      json['machines'].forEach((v) {
        machines!.add(Machines.fromJson(v));
      });
    }


  }
}




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
  bool? hasTechnicalDoc;
  bool? hasParameters;
  bool? hasQR;
  String? status;
  String? model;
  String? yearOfConstraction;
  String? installationDate;
  String? make;


  Machines({this.id,
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
    this.hasTechnicalDoc,
    this.hasParameters,
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
    //statusImage = json['statusImage'];

    if (json['hasBOM'] != null) {
      try {
        hasBOM = json['hasBOM'] ?? false;
      } catch (e) {
        hasBOM = json['hasBOM'] == 1 ? true : false;
      }
    }


    code = json['code'];
    // statusFont = json['statusFont'];
    //statusDesc = json['status_desc'];
    if (json['hasEmergencyList'] != null) {
      try {
        hasEmergencyList = json['hasEmergencyList'] ?? false;
      } catch (e) {
        hasEmergencyList = json['hasEmergencyList'] == 1 ? true : false;
      }
    }
    BOMId = json['BOM_id'];

    if (json['hasMaintenanceList'] != null) {
      try {
        hasMaintenanceList = json['hasMaintenanceList'] ?? false;
      } catch (e) {
        hasMaintenanceList = json['hasMaintenanceList'] == 1 ? true : false;
      }
    }

    if (json['hasInformations'] != null) {
      try {
        hasInformations = json['hasInformations'] ?? false;
      } catch (e) {
        hasInformations = json['hasInformations'] == 1 ? true : false;
      }
    }

    name = json['name'];
    machineId = json['machine_id'];
    if (json['hasTechnicalDoc'] != null) {
      try {
        hasTechnicalDoc = json['hasTechnicalDoc'] ?? false;
      } catch (e) {
        hasTechnicalDoc = json['hasTechnicalDoc'] == 1 ? true : false;
      }
    }
    if (json['hasParameters'] != null) {
      try {
        hasParameters = json['hasParameters'] ?? false;
      } catch (e) {
        hasParameters = json['hasParameters'] == 1 ? true : false;
      }
    }

    if (json['hasQR'] != null) {
      try {
        hasQR = json['hasQR'] ?? false;
      } catch (e) {
        hasQR = json['hasQR'] == 1 ? true : false;
      }
    }
    status = json['status'];

    yearOfConstraction = json['year_of_constraction'];
    installationDate = json['installation_date'];
    model = json['model'];
    make = json['make'];
  }
}


class LinesMachinesModel {
  List<LinesMachinesGroupModel>? linesmachines;

  LinesMachinesModel({ this.linesmachines});

  LinesMachinesModel.fromJson(Map<String, dynamic> json) {
    if (json['lines'] != null) {
      linesmachines = <LinesMachinesGroupModel>[];
      json['lines'].forEach((v) {
        linesmachines!.add(LinesMachinesGroupModel.fromJson(v));
      });
    }
  }

}

class LinesMachinesGroupModel {
  int? id;
  String? lineName;
  List<MachinesGroup>? machinesGroup;

  LinesMachinesGroupModel(
      {this.id,
        this.lineName,
        this.machinesGroup,
      });


  LinesMachinesGroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //lineName = json['line_name'];
    lineName = json['line'];
    if (json['machinesnames'] != null) {
      machinesGroup = <MachinesGroup>[];
      json['machinesnames'].forEach((v) {
        machinesGroup!.add(MachinesGroup.fromJson(v));
      });
    }


  }
}

class MachinesGroup {
  int? id;
  String? machineName;

  MachinesGroup(
      {
        this.id,
        this.machineName,
      });

  MachinesGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    machineName = json['machine_name'];
  }
}