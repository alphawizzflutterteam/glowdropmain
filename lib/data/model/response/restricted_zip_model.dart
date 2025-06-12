class RestrictedZipModel {
  int? id;
  String? zipcode;
  RestrictedZipModel({this.id, this.zipcode});

  RestrictedZipModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['zipcode'] = zipcode;
    return data;
  }
}
class RegisterZipModel {
  String? id;
  String? zipcode;
  RegisterZipModel({this.id, this.zipcode});

  RegisterZipModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    zipcode = json['zipcode'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['zipcode'] = zipcode;
    return data;
  }
}
