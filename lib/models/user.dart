class User {
  int? id;
  String? uid;
  String? device;

  User({this.id, this.uid, this.device});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    device = json['device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['device'] = this.device;
    return data;
  }
}