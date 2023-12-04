import 'package:p2p_client/models/device_info.dart';

class User {
  int? id;
  String? uid;
  String? device;
  List<DeviceInfo>? devices;

  User({this.id, this.uid, this.device, this.devices});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    device = json['device'];
    if (json['devices'] != null) {
      devices = <DeviceInfo>[];
      json['devices'].forEach((v) {
        devices!.add(DeviceInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['device'] = this.device;
    if (this.devices != null) {
      data['devices'] = this.devices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}