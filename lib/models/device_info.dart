class DeviceInfo {
  String? brand;
  String? model;
  String? name;
  String? id;

  DeviceInfo({this.brand, this.model, this.name, this.id});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    model = json['model'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
