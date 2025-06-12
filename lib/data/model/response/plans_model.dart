class PlansModel {
  bool? status;
  List<PlansData>? data;

  PlansModel({this.status, this.data});

  PlansModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PlansData>[];
      json['data'].forEach((v) {
        data!.add(new PlansData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlansData {
  int? id;
  bool? selected =false;
  String? title;
  String? description;
  int? amount;
  int? discountAmount;
  int? days;
  int? level;
  int? frenchise_bonus;
  int? district_bonus;
  int? state_bonus;
  int? shop_bonus;
  int? self_purchase_bonus;
  String? daily_bonus_till_days;
  String? daily_bonus_limit;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Levels>? levels;
  bool isExpanded = false;

  PlansData(
      {this.id,
        this.title,
        this.description,
        this.amount,
        this.discountAmount,
        this.days,
        this.level,
        this.frenchise_bonus,
        this.status,
        this.selected,

        this.createdAt,
        this.updatedAt,
        this.levels});

  PlansData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    amount = json['amount'];
    discountAmount = json['discount_amount'];
    days = json['days'];
    level = json['level'];
    frenchise_bonus = json['frenchise_bonus'];
    district_bonus = json['district_bonus'];
    state_bonus = json['state_bonus'];
    shop_bonus = json['shop_bonus'];
    self_purchase_bonus = json['self_purchase_bonus'];
    if(json['daily_bonus_till_days'] != null)
    daily_bonus_till_days = json['daily_bonus_till_days'];
    daily_bonus_limit = json['daily_bonus_limit'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['levels'] != null) {
      levels = <Levels>[];
      json['levels'].forEach((v) {
        levels!.add(new Levels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['discount_amount'] = this.discountAmount;
    data['days'] = this.days;
    data['level'] = this.level;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.levels != null) {
      data['levels'] = this.levels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Levels {
  int? id;
  int? planId;
  String? level;
  int? levelId;
  String? amount;
  double? daily_bonus;
  String? repurchase_income;
  String? frenchise_income;
  String? frenchise_withdrawal_income;

  String? createdAt;
  String? updatedAt;

  Levels(
      {this.id,
        this.planId,
        this.level,
        this.levelId,
        this.amount,
        this.createdAt,
        this.updatedAt});

  Levels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planId = json['plan_id'];
    level = json['level'];
    daily_bonus = json['daily_bonus'] != null ? double.parse(json['daily_bonus'].toString()) : 0.0;
    repurchase_income = json['repurchase_income'].toString();
    frenchise_income = json['frenchise_income'].toString();
    frenchise_withdrawal_income = json['frenchise_withdrawal_income'].toString();
    levelId = json['level_id'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan_id'] = this.planId;
    data['level'] = this.level;
    data['level_id'] = this.levelId;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}