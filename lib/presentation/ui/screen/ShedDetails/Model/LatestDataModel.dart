class LatestSensorModel {
  int? code;
  String? message;
  List<Data>? data;

  LatestSensorModel({this.code, this.message, this.data});

  LatestSensorModel.fromJson(Map<String, dynamic> json) {
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
  String? deviceCode;
  String? sensorName;
  double? value;
  String? timeime;

  Data({this.id, this.deviceCode, this.sensorName, this.value, this.timeime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceCode = json['DeviceCode'];
    sensorName = json['SensorName'];

    // Convert 'value' from dynamic to double?
    if (json['value'] is int) {
      value = (json['value'] as int).toDouble();
    } else if (json['value'] is double) {
      value = json['value'];
    } else {
      value = null;
    }

    timeime = json['Timeime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['DeviceCode'] = this.deviceCode;
    data['SensorName'] = this.sensorName;
    data['value'] = this.value;
    data['Timeime'] = this.timeime;
    return data;
  }
}
