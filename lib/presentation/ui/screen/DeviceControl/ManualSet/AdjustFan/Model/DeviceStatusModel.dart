class DeviceStatusModel {
  int? code;
  String? message;
  List<Data>? data;

  DeviceStatusModel({this.code, this.message, this.data});

  DeviceStatusModel.fromJson(Map<String, dynamic> json) {
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
  String? peripheralType;
  String? peripheralIndex;
  String? status;
  String? lastUpdatedStatus;

  Data(
      {this.id,
        this.peripheralType,
        this.peripheralIndex,
        this.status,
        this.lastUpdatedStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    peripheralType = json['peripheral_type'];
    peripheralIndex = json['peripheral_index'];
    status = json['status'];
    lastUpdatedStatus = json['last_updated_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['peripheral_type'] = this.peripheralType;
    data['peripheral_index'] = this.peripheralIndex;
    data['status'] = this.status;
    data['last_updated_status'] = this.lastUpdatedStatus;
    return data;
  }
}
