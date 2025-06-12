class WithdrawModel {
  bool? status;
  String? message;
  List<WithdrawData>? data;

  WithdrawModel({this.status, this.message, this.data});

  WithdrawModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WithdrawData>[];
      json['data'].forEach((v) {
        data!.add(new WithdrawData.fromJson(v));
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

class WithdrawData {
  int? id;
  int? userId;
  String? amount;
  String? walletType;
  String? tds;
  String? adminCommission;
  String? repurchaseIncome;
  int? status;
  String? remaningAmount;
  String? createdAt;
  String? updatedAt;

  WithdrawData(
      {this.id,
        this.userId,
        this.amount,
        this.walletType,
        this.tds,
        this.adminCommission,
        this.repurchaseIncome,
        this.status,
        this.remaningAmount,
        this.createdAt,
        this.updatedAt});

  WithdrawData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'].toString();
    walletType = json['wallet_type'];
    tds = json['tds'];
    adminCommission = json['admin_commission'];
    repurchaseIncome = json['repurchase_income'];
    status = json['status'];
    remaningAmount = json['remaning_amount'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['wallet_type'] = this.walletType;
    data['tds'] = this.tds;
    data['admin_commission'] = this.adminCommission;
    data['repurchase_income'] = this.repurchaseIncome;
    data['status'] = this.status;
    data['remaning_amount'] = this.remaningAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}