class LoginModel {
  String? email;
  String? password;
  String? deviceToken;


  LoginModel({this.email, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['device_token'] = deviceToken;

    return data;
  }
}

class LoginWithOtpModel {
  String? phone;
  String? otp;
  String? deviceToken;
  LoginWithOtpModel({this.phone, this.otp});

  LoginWithOtpModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    otp = json['otp'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['phone'] = phone;
    data['otp'] = otp;
    data['device_token'] = deviceToken;
    return data;
  }
}
