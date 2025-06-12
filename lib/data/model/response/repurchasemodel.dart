class RepurchaseHistoryModel {
  bool? status;
  String? message;
  List<RepurchaseData>? data;

  RepurchaseHistoryModel({this.status, this.message, this.data});

  RepurchaseHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RepurchaseData>[];
      json['data'].forEach((v) {
        data!.add(new RepurchaseData.fromJson(v));
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

class RepurchaseData {
  int? id;
  int? parentId;
  int? referralId;
  String? parentType;
  String? amount;
  String? zipcode;
  String? type;
  String? transaction;
  int? level;
  String? userType;
  String? createdAt;
  String? updatedAt;
  String? referralName;

  RepurchaseData(
      {this.id,
      this.parentId,
      this.referralId,
      this.parentType,
      this.amount,
      this.zipcode,
      this.type,
      this.transaction,
      this.level,
      this.userType,
      this.createdAt,
      this.updatedAt,
      this.referralName});

  RepurchaseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    referralId = json['referral_id'];
    parentType = json['parent_type'];
    amount = json['amount'];
    zipcode = json['zipcode'].toString();
    type = json['type'];
    transaction = json['transaction'];
    level = json['level'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    referralName = json['referral_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['referral_id'] = this.referralId;
    data['parent_type'] = this.parentType;
    data['amount'] = this.amount;
    data['zipcode'] = this.zipcode;
    data['type'] = this.type;
    data['transaction'] = this.transaction;
    data['level'] = this.level;
    data['user_type'] = this.userType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['referral_name'] = this.referralName;
    return data;
  }
}
