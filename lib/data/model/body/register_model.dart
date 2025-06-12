class RegisterModel {
  String? email;
  String? friend_code;
  String? password;
  String? zipcode;
  String? fName;
  String? lName;
  dynamic? longitute;
  dynamic? latitute;
  String? Dob;
  String? gender;
  String? phone;
  String? socialId;
  String? city;
  String? state;
  String? address;
  String? area;
  String? lat;
  String? long;
  String? loginMedium;
  String? deviceToken;

  RegisterModel(
      {this.email,
      this.friend_code,
      this.zipcode,
      this.longitute,
      this.Dob,
      this.latitute,
      this.password,
      this.fName,
      this.lName,
      this.socialId,
      this.gender,
      this.loginMedium,
      this.city,
      this.area,
      this.state,
      this.address,
      this.long,
      this.lat,
      this.phone,
      this.deviceToken});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    gender = json['gender'];
    Dob = json['dob'];
    longitute = json['longitude'];
    latitute = json['latitude'];
    password = json['password'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    socialId = json['social_id'];
    zipcode = json['zipcode'];

    city = json['city'];
    state = json['state'];
    address = json['address'];
    area = json['area'];
    lat = json['latitude'];
    long = json['longitude'];
    friend_code = json['friend_code'];
    loginMedium = json['login_medium'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['gender'] = gender;
    data['dob'] = Dob;
    data['latitude'] = latitute;
    data['longitude'] = longitute;
    data['password'] = password;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['zipcode'] = zipcode;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    data['area'] = area;
    data['latitude'] = lat;
    data['longitude'] = long;
    data['friend_code'] = friend_code;
    data['social_id'] = socialId;
    data['login_medium'] = loginMedium;
    data['device_token'] = deviceToken;
    return data;
  }
}
