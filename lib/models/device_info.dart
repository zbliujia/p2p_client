class DeviceInfo {
  String? brand;
  String? model;
  String? name;
  String? id;
  String? deviceToken;
  String? publicAddr;

  DeviceInfo({this.brand, this.model, this.name, this.id, this.publicAddr});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    model = json['model'];
    deviceToken = json['deviceToken'];
    name = json['name'];
    id = json['id'];
    publicAddr = json['publicAddr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['name'] = this.name;
    data['deviceToken'] = this.deviceToken;
    data['id'] = this.id;
    data['publicAddr'] = this.publicAddr;
    return data;
  }
}
