class MyPlansModel {
  bool? status;
  MyPlanData? data;

  MyPlansModel({this.status, this.data});

  MyPlansModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new MyPlanData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MyPlanData {
  String? purchaseDate;
  String? expireDate;
  String? purchaseAmount;
  PlanData? planData;

  MyPlanData(
      {this.purchaseDate, this.expireDate, this.purchaseAmount, this.planData});

  MyPlanData.fromJson(Map<String, dynamic> json) {
    purchaseDate = json['purchase_date'];
    expireDate = json['expire_date'];
    purchaseAmount = json['purchase_amount'];
    planData = json['plan_data'] != null
        ? new PlanData.fromJson(json['plan_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purchase_date'] = this.purchaseDate;
    data['expire_date'] = this.expireDate;
    data['purchase_amount'] = this.purchaseAmount;
    if (this.planData != null) {
      data['plan_data'] = this.planData!.toJson();
    }
    return data;
  }
}

class PlanData {
  int? id;
  String? title;
  String? description;
  int? amount;
  int? discountAmount;
  int? days;
  int? level;
  int? status;
  int? frenchiseBonus;
  int? districtBonus;
  int? stateBonus;
  int? shopBonus;
  int? selfPurchaseBonus;
  String? dailyBonusTillDays;
  String? dailyBonusLimit;
  String? createdAt;
  String? updatedAt;
  List<Levels>? levels;

  PlanData(
      {this.id,
        this.title,
        this.description,
        this.amount,
        this.discountAmount,
        this.days,
        this.level,
        this.status,
        this.frenchiseBonus,
        this.districtBonus,
        this.stateBonus,
        this.shopBonus,
        this.selfPurchaseBonus,
        this.dailyBonusTillDays,
        this.dailyBonusLimit,
        this.createdAt,
        this.updatedAt,
        this.levels});

  PlanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    amount = json['amount'];
    discountAmount = json['discount_amount'];
    days = json['days'];
    level = json['level'];
    status = json['status'];
    frenchiseBonus = json['frenchise_bonus'];
    districtBonus = json['district_bonus'];
    stateBonus = json['state_bonus'];
    shopBonus = json['shop_bonus'];
    selfPurchaseBonus = json['self_purchase_bonus'];
    dailyBonusTillDays = json['daily_bonus_till_days'].toString();
    dailyBonusLimit = json['daily_bonus_limit'];
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
    data['frenchise_bonus'] = this.frenchiseBonus;
    data['district_bonus'] = this.districtBonus;
    data['state_bonus'] = this.stateBonus;
    data['shop_bonus'] = this.shopBonus;
    data['self_purchase_bonus'] = this.selfPurchaseBonus;
    data['daily_bonus_till_days'] = this.dailyBonusTillDays;
    data['daily_bonus_limit'] = this.dailyBonusLimit;
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
  String? planId;
  String? level;
  String? levelId;
  String? amount;
  String? dailyBonus;
  String? repurchaseIncome;
  String? frenchiseIncome;
  String? frenchiseWithdrawalIncome;
  String? dailyBonusTillDays;
  String? dailyBonusLimit;
  String? createdAt;
  String? updatedAt;

  Levels(
      {this.id,
        this.planId,
        this.level,
        this.levelId,
        this.amount,
        this.dailyBonus,
        this.repurchaseIncome,
        this.frenchiseIncome,
        this.frenchiseWithdrawalIncome,
        this.dailyBonusTillDays,
        this.dailyBonusLimit,
        this.createdAt,
        this.updatedAt});

  Levels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planId = json['plan_id'].toString();
    level = json['level'];
    levelId = json['level_id'].toString();
    amount = json['amount'].toString();
    dailyBonus = json['daily_bonus'].toString();
    repurchaseIncome = json['repurchase_income'].toString();
    frenchiseIncome = json['frenchise_income'].toString();
    frenchiseWithdrawalIncome = json['frenchise_withdrawal_income'].toString();
    dailyBonusTillDays = json['daily_bonus_till_days'].toString();
    dailyBonusLimit = json['daily_bonus_limit'].toString();
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
    data['daily_bonus'] = this.dailyBonus;
    data['repurchase_income'] = this.repurchaseIncome;
    data['frenchise_income'] = this.frenchiseIncome;
    data['frenchise_withdrawal_income'] = this.frenchiseWithdrawalIncome;
    data['daily_bonus_till_days'] = this.dailyBonusTillDays;
    data['daily_bonus_limit'] = this.dailyBonusLimit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}