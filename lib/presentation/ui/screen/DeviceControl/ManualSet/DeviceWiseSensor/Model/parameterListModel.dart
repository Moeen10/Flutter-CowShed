class ParameterListModel {
  int? code;
  String? message;
  List<Data>? data;

  ParameterListModel({this.code, this.message, this.data});

  ParameterListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? parameterId;
  String? parameterName;
  String? unit;
  String? value;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.parameterId,
        this.parameterName,
        this.unit,
        this.value,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parameterId = json['parameter_id'];
    parameterName = json['parameter_name'];
    unit = json['unit'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parameter_id'] = this.parameterId;
    data['parameter_name'] = this.parameterName;
    data['unit'] = this.unit;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
