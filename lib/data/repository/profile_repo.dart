import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/address_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/kyc_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/user_info_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  ProfileRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getAddressTypeList() async {
    try {
      List<String> addressTypeList = [
        'Select Address type',
        'Permanent',
        'Home',
        'Office',
      ];
      Response response = Response(
          requestOptions: RequestOptions(path: ''),
          data: addressTypeList,
          statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getUserInfo() async {
    try {
      final response = await dioClient!.get(AppConstants.customerUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getKYC(String userId) async {
    try {
      Map data = {"user_id": "$userId", "type": "user"};
      final response = await dioClient!.post(AppConstants.getKYC, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deleteUserAccount(int? customerId) async {
    try {
      final response = await dioClient!
          .get('${AppConstants.deleteCustomerAccount}/$customerId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getAllAddress() async {
    try {
      final response = await dioClient!.get(AppConstants.addressListUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> removeAddressByID(int? id) async {
    try {
      final response =
          await dioClient!.delete('${AppConstants.removeAddressUri}$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> KYCID(int? id) async {
    try {
      final response =
          await dioClient!.delete('${AppConstants.removeAddressUri}$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addAddress(AddressModel addressModel) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.addAddressUri,
        data: addressModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.StreamedResponse> updateProfile(UserInfoModel userInfoModel,
      String pass, File? file, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse('${AppConstants.baseUrl}${AppConstants.updateProfileUri}'));
    request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});
    if (file != null) {
      request.files.add(http.MultipartFile(
          'image', file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path.split('/').last));
    }
    Map<String, String> fields = {};
    if (pass.isEmpty) {
      fields.addAll(<String, String>{
        '_method': 'put',
        'f_name': userInfoModel.fName!,
        'l_name': userInfoModel.lName!,
        'phone': userInfoModel.phone!,
        'zipcode': userInfoModel.zipcode!,
        'city': userInfoModel.city!,
        'state': userInfoModel.state!,
        'area': userInfoModel.area!,
        'address': userInfoModel.address!,
        'latitude': userInfoModel.lat!,
        'longitude': userInfoModel.long!,
      });
    } else {
      fields.addAll(<String, String>{
        '_method': 'put',
        'f_name': userInfoModel.fName!,
        'l_name': userInfoModel.lName!,
        'phone': userInfoModel.phone!,
        'password': pass,
        'zipcode': userInfoModel.zipcode!,
        'city': userInfoModel.city!,
        'state': userInfoModel.state!,
        'area': userInfoModel.area!,
        'address': userInfoModel.address!,
        'latitude': userInfoModel.lat!,
        'longitude': userInfoModel.long!,
      });
    }
    request.fields.addAll(fields);
    if (kDebugMode) {
      print('========>${fields.toString()}');
    }
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> updateKYCR(KYCModel userInfoModel, File? pan,
      File? addharf, File? addharb, File? passBook, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse('${AppConstants.baseUrl}${AppConstants.addKYCProfileUri}'));
    // request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});
    if (pan != null) {
      request.files.add(http.MultipartFile(
          'pan_image', pan.readAsBytes().asStream(), pan.lengthSync(),
          filename: pan.path.split('/').last));
    }
    if (addharf != null) {
      request.files.add(http.MultipartFile(
          'adhar_front', addharf.readAsBytes().asStream(), addharf.lengthSync(),
          filename: addharf.path.split('/').last));
    }
    if (addharb != null) {
      request.files.add(http.MultipartFile(
          'adhar_back', addharb.readAsBytes().asStream(), addharb.lengthSync(),
          filename: addharb.path.split('/').last));
    }
    if (passBook != null) {
      request.files.add(http.MultipartFile('passbook_image',
          passBook.readAsBytes().asStream(), passBook.lengthSync(),
          filename: passBook.path.split('/').last));
    }
    Map<String, String> fields = {};

    fields.addAll(<String, String>{
      '_method': 'post',
      'user_id': userInfoModel.user_id.toString()!,
      'type': "user",
      'pan_number': userInfoModel.pan_number!,
      'adhar_number': userInfoModel.adhar_number!,
      'nomini_name': userInfoModel.nomini_name!,
      'nomini_relation': userInfoModel.nomini_relation!,
      'account_number': userInfoModel.account_number!,
      'holder_name': userInfoModel.holder_name!,
      'ifsc': userInfoModel.ifsc!,
      'bank_name': userInfoModel.bank_name!,
    });

    request.fields.addAll(fields);
    if (kDebugMode) {
      print('========>${fields.toString()}');
    }
    if (kDebugMode) {
      print('========>${request.files.toString()}');
    }
    http.StreamedResponse response = await request.send();

    return response;
  }

  // for save home address
  Future<void> saveHomeAddress(String homeAddress) async {
    try {
      await sharedPreferences!.setString(AppConstants.homeAddress, homeAddress);
    } catch (e) {
      rethrow;
    }
  }

  String getHomeAddress() {
    return sharedPreferences!.getString(AppConstants.homeAddress) ?? "";
  }

  Future<bool> clearHomeAddress() async {
    return sharedPreferences!.remove(AppConstants.homeAddress);
  }

  // for save office address
  Future<void> saveOfficeAddress(String officeAddress) async {
    try {
      await sharedPreferences!
          .setString(AppConstants.officeAddress, officeAddress);
    } catch (e) {
      rethrow;
    }
  }

  String getOfficeAddress() {
    return sharedPreferences!.getString(AppConstants.officeAddress) ?? "";
  }

  Future<bool> clearOfficeAddress() async {
    return sharedPreferences!.remove(AppConstants.officeAddress);
  }
}
