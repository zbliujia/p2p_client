class DeviceFileInfo {
  List<Items>? items;

  DeviceFileInfo({this.items});

  DeviceFileInfo.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  bool? isFile;
  int? size;
  String? lastModified;

  Items({this.name, this.isFile, this.size, this.lastModified});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isFile = json['isFile'];
    size = json['size'];
    lastModified = json['lastModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isFile'] = this.isFile;
    data['size'] = this.size;
    data['lastModified'] = this.lastModified;
    return data;
  }
}
