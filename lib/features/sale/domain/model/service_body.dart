class ServiceBodySale {
  int? _saleId;
  String? _productId;
  String? _comment;
  List<String>? _fileUpload;

  ServiceBodySale(
      {int? saleId,
        String? productId,
        String? comment,
        String? rating,
        List<String>? fileUpload}) {
    _saleId = saleId;
    _productId = productId;
    _comment = comment;
    _fileUpload = fileUpload;
  }

  int? get salId => _saleId;
  String? get productId => _productId;
  String? get comment => _comment;
  List<String>? get fileUpload => _fileUpload;

  ServiceBodySale.fromJson(Map<String, dynamic> json) {
    _saleId = json['sale_id'];
    _productId = json['product_id'];
    _comment = json['comment'];
    _fileUpload = json['fileUpload'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sale_id'] = _saleId;
    data['product_id'] = _productId;
    data['comment'] = _comment;
    data['fileUpload'] = _fileUpload;
    return data;
  }
}
