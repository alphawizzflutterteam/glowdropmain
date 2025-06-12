class ReferalModel {
  bool? status;
  String? message;
  List<ReferalData>? data;

  ReferalModel({this.status, this.message, this.data});

  ReferalModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ReferalData>[];
      json['data'].forEach((v) {
        data!.add(new ReferalData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReferalData {
  int? id;
  int? parentId;
  int? referralId;
  String? referralName;
  String? amount;
  int? level;
  String? type;
  String? createdAt;
  String? updatedAt;

  ReferalData(
      {this.id,
      this.parentId,
      this.referralId,
      this.referralName,
      this.amount,
      this.level,
      this.type,
      this.createdAt,
      this.updatedAt});

  ReferalData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    referralId = json['referral_id'];
    referralName = json['referral_name'];
    amount = json['amount'];
    level = json['level'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['referral_id'] = this.referralId;
    data['referral_name'] = this.referralName;
    data['amount'] = this.amount;
    data['level'] = this.level;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
