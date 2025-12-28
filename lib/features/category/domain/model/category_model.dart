class CategoryModel {
  int? _id;
  String? _name;
  String? _slug;
  String? _icon;
  int? _parentId;
  int? _position;
  String? _createdAt;
  String? _updatedAt;
  int? _productCount;
  List<SubCategory>? _subCategories;
  bool? isSelected;

  CategoryModel(
      {int? id,
        String? name,
        String? slug,
        String? icon,
        int? parentId,
        int? position,
        String? createdAt,
        String? updatedAt,
        int? productCount,
        List<SubCategory>? subCategories,
        bool? isSelected,
      }) {
    _id = id;
    _name = name;
    _slug = slug;
    _icon = icon;
    _parentId = parentId;
    _position = position;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _productCount= productCount;
    _subCategories = subCategories;
    isSelected = isSelected;
  }

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get icon => _icon;
  int? get parentId => _parentId;
  int? get position => _position;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get productCount => _productCount;
  List<SubCategory>? get subCategories => _subCategories;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _icon = json['icon'];
    _parentId = json['parent_id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _productCount =  int.parse(json['product_count']);
    if (json['childes'] != null) {
      _subCategories = [];
      json['childes'].forEach((v) {
        _subCategories!.add(SubCategory.fromJson(v));
      });
    }
    isSelected = false;
  }

}

class SubCategory {
  int? _id;
  String? _name;
  String? _slug;
  String? _icon;
  int? _parentId;
  int? _position;
  String? _createdAt;
  String? _updatedAt;
  String? _fullname;
  int? _productCount;
  List<SubSubCategory>? _subSubCategories;
  bool? isSelected;

  SubCategory(
      {int? id,
        String? name,
        String? slug,
        String? icon,
        int? parentId,
        int? position,
        String? createdAt,
        String? updatedAt,
        String? fullname,
        int? productCount,
        List<SubSubCategory>? subSubCategories,
        bool? isSelected,
      }) {
    _id = id;
    _name = name;
    _slug = slug;
    _icon = icon;
    _parentId = parentId;
    _position = position;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _fullname = fullname;
    _productCount= productCount;
    _subSubCategories = subSubCategories;
    isSelected = isSelected;
  }

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get icon => _icon;
  int? get parentId => _parentId;
  int? get position => _position;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get fullname => _fullname;
  int? get productCount => _productCount;
  List<SubSubCategory>? get subSubCategories => _subSubCategories;

  SubCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _icon = json['icon'];
    _parentId = json['parent_id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _fullname = json['full_name'];
    _productCount = int.parse(json['sub_category_product_count']);
    if (json['childes'] != null) {
      _subSubCategories = [];
      json['childes'].forEach((v) {
        _subSubCategories!.add(SubSubCategory.fromJson(v));
      });
    }
    isSelected = false;
  }

}

class SubSubCategory {
  int? _id;
  String? _name;
  String? _slug;
  String? _icon;
  int? _parentId;
  int? _position;
  String? _createdAt;
  String? _updatedAt;
  String? _fullname;
  int? _productCount;

  SubSubCategory(
      {int? id,
        String? name,
        String? slug,
        String? icon,
        int? parentId,
        int? position,
        String? createdAt,
        String? updatedAt,
        String? fullname,
        int? productCount,}) {
    _id = id;
    _name = name;
    _slug = slug;
    _icon = icon;
    _parentId = parentId;
    _position = position;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _fullname = fullname;
    _productCount= productCount;
  }

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get icon => _icon;
  int? get parentId => _parentId;
  int? get position => _position;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get fullname => _fullname;
  int? get productCount => _productCount;

  SubSubCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _icon = json['icon'];
    _parentId = json['parent_id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _fullname = json['full_name'];
    _productCount = int.parse(json['sub_sub_category_product_count']);
  }

}
