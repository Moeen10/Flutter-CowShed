class SchedulerModel {
  int? code;
  String? message;
  List<Data>? data;

  SchedulerModel({this.code, this.message, this.data});

  SchedulerModel.fromJson(Map<String, dynamic> json) {
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
  int? parameterId;
  String? lastStatus;
  String? lastUpdated;

  Data({this.parameterId, this.lastStatus, this.lastUpdated});

  Data.fromJson(Map<String, dynamic> json) {
    parameterId = json['parameter_id'];
    lastStatus = json['last_status'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parameter_id'] = this.parameterId;
    data['last_status'] = this.lastStatus;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}
