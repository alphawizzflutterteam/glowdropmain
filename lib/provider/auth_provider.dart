import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/login_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/register_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/error_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/response_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/social_login_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/auth_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';

import '../data/model/body/rgistermodel.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo? authRepo;
  AuthProvider({required this.authRepo});

  bool _isLoading = false;
  bool? _isRemember = false;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool? get isRemember => _isRemember;

  void updateRemember(bool? value) {
    _isRemember = value;
    notifyListeners();
  }

  Future socialLogin(SocialLoginModel socialLogin, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.socialLogin(socialLogin);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      String? message = '';
      String? token = '';
      String? temporaryToken = '';
      try {
        message = map['error_message'];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      try {
        token = map['token'];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      try {
        temporaryToken = map['temporary_token'];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }

      if (token != null) {
        authRepo!.saveUserToken(token);
        await authRepo!.updateToken();
      }
      callback(true, token, temporaryToken, message);
      notifyListeners();
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        if (kDebugMode) {
          print(apiResponse.error.toString());
        }
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        if (kDebugMode) {
          print(errorResponse.errors![0].message);
        }
        errorMessage = errorResponse.errors![0].message;
      }
      callback(false, '', '', errorMessage);
      notifyListeners();
    }
  }

  Future registration(RegisterModel register, Function callback) async {
    _isLoading = true;
    notifyListeners();
    print("RegisterRequest ${register.toJson()}");

    String? deviceToken = await _getDeviceToken();
    register.deviceToken = deviceToken;
    ApiResponse apiResponse = await authRepo!.registration(register);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      String? temporaryToken = '';
      String? token = '';
      String? message = '';
      var user;
      var userId;
      print("resgister----------");
      try {
        message = map["message"];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      try {
        token = map["token"];
        user = map["user"];
        userId = user["id"];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      try {
        temporaryToken = map["temporary_token"];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      if (token != null && token.isNotEmpty) {
        authRepo!.saveUserToken(token);
        authRepo!.saveUserId(userId.toString());
        // authRepo!.sd(token);
        await authRepo!.updateToken();
      }
      callback(true, token, temporaryToken, message);
      notifyListeners();
    }
    notifyListeners();
  }
  bool _isLoadingr = false;
  bool get isLoadingr => _isLoading;

  // Future<void> submitDetails(UserDetailsModel model, Function callback) async {
  //   _isLoadingr = true;
  //   notifyListeners();
  //
  //   ApiResponse response = await authRepo.submitUserDetails(model);
  //
  //   _isLoadingr = false;
  //
  //   if (response.response != null && response.response!.statusCode == 200) {
  //     callback(true, "Details submitted successfully");
  //   } else {
  //     callback(false, "Failed to submit details");
  //   }
  //
  //   notifyListeners();
  // }
  Future<String?> _getDeviceToken() async {
    String? deviceToken;
    if (Platform.isIOS) {
      deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      deviceToken = await FirebaseMessaging.instance.getToken();
    }

    if (deviceToken != null) {
      if (kDebugMode) {
        print('--------Device Token---------- $deviceToken');
      }
    }
    return deviceToken;
  }

  Future authToken(String authToken) async {
    authRepo!.saveAuthToken(authToken);
    notifyListeners();
  }

  Future login(LoginModel loginBody, Function callback) async {
    _isLoading = true;
    notifyListeners();
    String? deviceToken = await _getDeviceToken();
    loginBody.deviceToken = deviceToken;
    print("Login Request ${loginBody.toJson()}");
    ApiResponse apiResponse = await authRepo!.login(loginBody);
    _isLoading = false;
    if (kDebugMode) {
      // print("SucessResult ${apiResponse.response}");
      // print("SucessResult ${apiResponse.response!.data}");
    }
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      var user;
      var userId;
      String? temporaryToken = '';
      String? token = '';
      String? plan_status = '';
      String? message = '';

      bool? isPurchase = false;
      // String token = map["token"];

      try {
        message = map["message"];
        user = map["user"];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      try {
        token = map["token"];
        userId = user["id"];
        plan_status = map["plan_status"].toString();
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      try {
        temporaryToken = map["temporary_token"];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }

      if (token != null && token.isNotEmpty
          // && plan_status == "1"
          ) {
        authRepo!.saveUserToken(token);
        authRepo!.saveUserId(userId.toString());
        await authRepo!.updateToken();
        isPurchase = true;
      }

      callback(true, token, temporaryToken, message, isPurchase);
      notifyListeners();
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        if (kDebugMode) {
          print(apiResponse.error.toString());
        }
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        if (kDebugMode) {
          print(errorResponse.errors![0].message);
        }
        errorMessage = errorResponse.errors![0].message;
      }
      callback(false, '', '', errorMessage, false);
      notifyListeners();
    }
  }

  Future loginWithOtp(LoginWithOtpModel loginBody, Function callback) async {
    _isLoading = true;
    notifyListeners();
    String? deviceToken = await _getDeviceToken();
    loginBody.deviceToken = deviceToken;
    print("Login Request ${loginBody.toJson()}");
    ApiResponse apiResponse = await authRepo!.loginWithOtp(loginBody);
    _isLoading = false;
    if (kDebugMode) {
      // print("SucessResult ${apiResponse.response}");
      // print("SucessResult ${apiResponse.response!.data}");
    }
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      var user;
      var userId;
      String? temporaryToken = '';
      String? token = '';
      String? plan_status = '';
      String? message = '';

      bool? isPurchase = false;

      // String token = map["token"];

      try {
        message = map["message"];
        user = map["user"];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      try {
        token = map["token"];
        userId = user["id"];
        plan_status = map["plan_status"].toString();
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      try {
        temporaryToken = map["temporary_token"];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }

      if (token != null && token.isNotEmpty
          // && plan_status == "1"
          ) {
        authRepo!.saveUserToken(token);
        authRepo!.saveUserId(userId.toString());
        await authRepo!.updateToken();
        isPurchase = true;
      }

      callback(true, token, temporaryToken, message, isPurchase);
      notifyListeners();
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        if (kDebugMode) {
          print(apiResponse.error.toString());
        }
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        if (kDebugMode) {
          print(errorResponse.errors![0].message);
        }
        errorMessage = errorResponse.errors![0].message;
      }
      callback(false, '', '', errorMessage, false);
      notifyListeners();
    }
  }

  Future<void> updateToken(BuildContext context) async {
    ApiResponse apiResponse = await authRepo!.updateToken();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }

  //email
  Future<ResponseModel> checkEmail(String email, String temporaryToken,
      {bool resendOtp = false}) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse;
    if (resendOtp) {
      apiResponse = await authRepo!.resendEmailOtp(email, temporaryToken);
    } else {
      apiResponse = await authRepo!.checkEmail(email, temporaryToken);
    }
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response!.data['token'], true);
      resendTime = (apiResponse.response!.data["resend_time"]);
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        if (kDebugMode) {
          print(apiResponse.error.toString());
        }
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        if (kDebugMode) {
          print(errorResponse.errors![0].message);
        }
        errorMessage = errorResponse.errors![0].message;
      }
      responseModel = ResponseModel(errorMessage, false);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> verifyEmail(String email, String token) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse =
        await authRepo!.verifyEmail(email, _verificationCode, token);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      authRepo!.saveUserToken(apiResponse.response!.data['token']);
      await authRepo!.updateToken();
      responseModel = ResponseModel('Successful', true);
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        if (kDebugMode) {
          print(apiResponse.error.toString());
        }
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        if (kDebugMode) {
          print(errorResponse.errors![0].message);
        }
        errorMessage = errorResponse.errors![0].message;
      }
      responseModel = ResponseModel(errorMessage, false);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  //phone

  int resendTime = 0;

  Future<ResponseModel> checkPhone(String phone, String temporaryToken,
      {bool fromResend = false}) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse
        apiResponse; //= await authRepo!.checkPhone(phone, temporaryToken);
    if (fromResend) {
      apiResponse = await authRepo!.resendPhoneOtp(phone, temporaryToken);
    } else {
      apiResponse = await authRepo!.checkPhone(phone, temporaryToken);
    }
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response!.data["token"], true,
          otp: apiResponse.response!.data["otp"]);
      resendTime = (apiResponse.response!.data["resend_time"]) ?? 0;
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        if (kDebugMode) {
          print(apiResponse.error.toString());
        }
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        if (kDebugMode) {
          print('=error==${errorResponse.errors![0].message}');
        }
        errorMessage = errorResponse.errors![0].message;
      }
      responseModel = ResponseModel(errorMessage, false);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> verifyPhone(String phone, String token) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse =
        await authRepo!.verifyPhone(phone, token, _verificationCode);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      responseModel =
          ResponseModel(apiResponse.response!.data["message"], true);
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message;
      }
      responseModel = ResponseModel(errorMessage, false);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> verifyOtp(String phone) async {
    print('---Forget----> $phone & $_verificationCode');
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();

    ApiResponse apiResponse =
        await authRepo!.verifyOtp(phone, _verificationCode);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      responseModel =
          ResponseModel(apiResponse.response!.data["message"], true);
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message;
      }
      responseModel = ResponseModel(errorMessage, false);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> resetPassword(String identity, String otp,
      String password, String confirmPassword) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse =
        await authRepo!.resetPassword(identity, otp, password, confirmPassword);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      responseModel =
          ResponseModel(apiResponse.response!.data["message"], true);
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message;
      }
      responseModel = ResponseModel(errorMessage, false);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  // for phone verification
  bool _isPhoneNumberVerificationButtonLoading = false;

  bool get isPhoneNumberVerificationButtonLoading =>
      _isPhoneNumberVerificationButtonLoading;
  String? _verificationMsg = '';

  String? get verificationMessage => _verificationMsg;
  String _email = '';
  String _phone = '';

  String get email => _email;
  String get phone => _phone;

  updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  updatePhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void clearVerificationMessage() {
    _verificationMsg = '';
  }

  // for verification Code
  String _verificationCode = '';

  String get verificationCode => _verificationCode;
  bool _isEnableVerificationCode = false;

  bool get isEnableVerificationCode => _isEnableVerificationCode;

  updateVerificationCode(String query) {
    if (query.length == 4) {
      _isEnableVerificationCode = true;
    } else {
      _isEnableVerificationCode = false;
    }
    _verificationCode = query;
    notifyListeners();
  }

  // for user Section
  String getUserToken() {
    return authRepo!.getUserToken();
  }

  //get auth token
  // for user Section
  String getAuthToken() {
    return authRepo!.getAuthToken();
  }

  String getAuthID() {
    return authRepo!.getUserId();
  }

  String getSaveIndex() {
    return authRepo!.getSaveIndex();
  }

  bool isLoggedIn() {
    return authRepo!.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo!.clearSharedData();
  }

  // for  Remember Email
  void saveUserEmail(String email, String password) {
    authRepo!.saveUserEmailAndPassword(email, password);
  }

  String getUserEmail() {
    return authRepo!.getUserEmail();
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo!.clearUserEmailAndPassword();
  }

  String getUserPassword() {
    return authRepo!.getUserPassword();
  }

  Future<ResponseModel> forgetPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.forgetPassword(email);
    _isLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      print(("forget password"));
      responseModel =
          ResponseModel(apiResponse.response!.data["message"], true);
      //  resendTime = (apiResponse.response!.data["resend_time"] );
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message;
      }
      responseModel = ResponseModel(errorMessage, false);
    }
    return responseModel;
  }

  Future saveIndex(String authToken) async {
    authRepo!.saveIndex(authToken);
    notifyListeners();
  }

  // Future<void> getPlans(bool reload) async {
  //   if (_mainBannerList == null || reload) {
  //     ApiResponse apiResponse = await bannerRepo!.getBannerList();
  //     if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
  //       _mainBannerList = [];
  //       apiResponse.response!.data.forEach((bannerModel) => _mainBannerList!.add(BannerModel.fromJson(bannerModel)));
  //
  //       _currentIndex = 0;
  //       notifyListeners();
  //     } else {
  //       ApiChecker.checkApi( apiResponse);
  //     }
  //   }
  // }
}

class ErrorModel {
  String? code;
  String? message;

  ErrorModel({this.code, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }
}
