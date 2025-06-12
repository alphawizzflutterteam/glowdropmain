class UserInfoModel {
  int? id;
  String? name;
  String? method;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  String? email;
  String? city;
  String? passbook;
  String? state;
  String? zipcode;
  String? panfront;
  String? panback;
  String? aadharback;
  String? aadharfront;
  String? accountImage;
  String? plan_id;
  String? emailVerifiedAt;
  String? certificate;
  String? plan_expire_date;
  String? address;
  String? area;
  String? lat;
  String? long;

  ///yyyy-MM-dd

  ///
  String? createdAt;
  String? updatedAt;
  String? referral_code;
  double? walletBalance;
  double? repurchaseWallet;
  double? loyaltyPoint;
  ReferrData? referrData;

  UserInfoModel(
      {this.id,
      this.name,
      this.method,
      this.fName,
      this.lName,
      this.phone,
      this.image,
      this.email,
      this.panfront,
      this.panback,
      this.aadharfront,
      this.aadharback,
      this.accountImage,
      this.plan_id,
      this.emailVerifiedAt,
      this.certificate,
      this.plan_expire_date,
      this.createdAt,
      this.updatedAt,
      this.referral_code,
      this.walletBalance,
      this.repurchaseWallet,
      this.referrData,
      this.loyaltyPoint,
      this.address,
      this.area,
      this.city,
      this.state,
      this.lat,
      this.long,
      this.zipcode
      });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    area = json['area'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    method = json['_method'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
    zipcode = json['zipcode'];
    city = json['city'];
    plan_id = json['plan_id'].toString();
    state = json['state'];
    referral_code = json['referral_code'];
    emailVerifiedAt = json['email_verified_at'];
    certificate = json['certificate'].toString();
    panfront = json['panfront'];
    aadharback = json['aadharback'];
    aadharfront = json['aadharfront'];
    plan_expire_date = json['plan_expire_date'];
    accountImage = json['accountImage'];
    panback = json['panback'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    referrData = json['referr_data'] != null
        ? new ReferrData.fromJson(json['referr_data'])
        : null;
    if (json['wallet_balance'] != null) {
      walletBalance = json['wallet_balance'].toDouble();
    }
    if (json['repurchase_wallet'] != null) {
      repurchaseWallet = json['repurchase_wallet'].toDouble();
    }
    if (json['loyalty_point'] != null) {
      loyaltyPoint = json['loyalty_point'].toDouble();
    } else {
      walletBalance = 0.0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['_method'] = method;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['zipcode'] = zipcode;
    data['city'] = city;
    data['state'] = state;
    data['phone'] = phone;
    data['image'] = image;
    data['plan_id'] = plan_id;
    data['email'] = email;
    data['plan_expire_date'] = plan_expire_date;
    data['email_verified_at'] = emailVerifiedAt;
    data['accountImage'] = accountImage;
    data['panfront'] = panfront;
    data['panback'] = panback;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['wallet_balance'] = walletBalance;
    data['repurchase_wallet'] = repurchaseWallet;
    data['loyalty_point'] = loyaltyPoint;
    if (this.referrData != null) {
      data['referr_data'] = this.referrData!.toJson();
    }
    return data;
  }
}

class ReferrData {
  String? name;
  String? number;
  String? email;

  ReferrData({this.name, this.number, this.email});

  ReferrData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['number'] = this.number;
    data['email'] = this.email;
    return data;
  }
}
