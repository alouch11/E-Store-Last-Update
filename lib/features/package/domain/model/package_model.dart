
import '../../../shop/domain/model/seller_model.dart';

class PackageModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<Packages>? packages;

  PackageModel({this.totalSize, this.limit, this.offset, this.packages});

  PackageModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(Packages.fromJson(v));
      });
    }
  }

}

class Packages {
  int? id;
  //int? customerId;
  String? packageCode;
  String? packageDescription;
  int? packageStatus;
  String? packageLine;
  String? packageMachine;
  //String? paymentMethod;
  //String? paymentNote;
  //double? packageAmount;
  String? createdAt;
  String? updatedAt;
 //double? discountAmount;
  //String? discountType;
  //String? packageGroupId;
  //int? sellerId;
  String? sellerIs;
  //String? packageNote;
  String? packageType;
  int? packageDetailsCount;
  double? packageAmountTotal;
  Seller? seller;

  Packages(
      {this.id,
        //this.customerId,
        this.packageCode,
        this.packageDescription,
        this.packageStatus,
        this.packageLine,
        this.packageMachine,
        //this.paymentMethod,
       // this.paymentNote,
        //this.packageAmount,
        this.createdAt,
        this.updatedAt,
        //this.discountAmount,
        //this.discountType,
        //this.packageGroupId,
        //this.sellerId,
        this.sellerIs,
       // this.packageNote,
        this.packageType,
        this.packageDetailsCount,
        this.packageAmountTotal,
        this.seller
    });

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['BLKODU'];
   // customerId = json['customer_id'];
    packageCode = json['PAKET_KODU'];
    packageDescription = json['PAKET_ADI'];
    packageStatus = json['AKTIF'];
    packageLine = json['GRUBU'];
    packageMachine = json['ARA_GRUBU'];
    //paymentMethod = json['payment_method'];
    //paymentNote = json['payment_note'];
    //packageAmount = json['package_amount'].toDouble();
    createdAt = json['KAYIT_TARIHI'];
    updatedAt = json['DEGISTIRME_TARIHI'];
    //discountAmount = json['discount_amount'].toDouble();
    //discountType = json['discount_type'];
    //packageGroupId = json['package_group_id'];
    //sellerId = json['seller_id'];
   sellerIs = json['ALT_GRUBU'];
   // packageNote = json['package_note'];
    packageType = json['ALT_GRUBU'];
    if(json['package_details_count'] != null){
      packageDetailsCount = int.parse(json['package_details_count'].toString());
    }else{
      packageDetailsCount = 0;
    }
    if(json['package_amount_total'] != null){
      packageAmountTotal = double.parse(json['package_amount_total'].toString());
    }else{
      packageAmountTotal = 0;
    }
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
  }

}