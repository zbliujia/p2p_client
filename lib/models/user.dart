class User {
  int? id;
  String? uid;

  User({this.id, this.uid});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    return data;
  }
}