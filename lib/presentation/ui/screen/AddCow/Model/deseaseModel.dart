class DESEASE {
  int? id;
  String? deseaseName;
  String? deseaseDescription;
  String? deseaseDescriptionBangla;

  DESEASE(
      {this.id,
        this.deseaseName,
        this.deseaseDescription,
        this.deseaseDescriptionBangla});

  DESEASE.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deseaseName = json['desease_name'];
    deseaseDescription = json['desease_description'];
    deseaseDescriptionBangla = json['desease_description_bangla'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['desease_name'] = this.deseaseName;
    data['desease_description'] = this.deseaseDescription;
    data['desease_description_bangla'] = this.deseaseDescriptionBangla;
    return data;
  }
}
