class InventoryModel {
  int? id;
  String? name;
  String? nameBangla;
  String? unitPrice;
  String? description;
  String? descriptionBangla;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;

  InventoryModel(
      {this.id,
        this.name,
        this.nameBangla,
        this.unitPrice,
        this.description,
        this.descriptionBangla,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameBangla = json['name_bangla'];
    unitPrice = json['unit_price'];
    description = json['description'];
    descriptionBangla = json['description_bangla'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_bangla'] = this.nameBangla;
    data['unit_price'] = this.unitPrice;
    data['description'] = this.description;
    data['description_bangla'] = this.descriptionBangla;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}