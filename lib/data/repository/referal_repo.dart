import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class ReferalRepo {
  final DioClient? dioClient;
  ReferalRepo({required this.dioClient});

  Future<ApiResponse> getRegferalList(var userId) async {
    try {
      Response response = await dioClient!.post(AppConstants.getReferalHistory,
          data: {"user_id": userId.trim(), "type": "refer_bonus"});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getBonusList(var userId) async {
    try {
      Response response = await dioClient!.post(AppConstants.getReferalHistory,
          data: {"user_id": userId.trim(), "type": "frenchise_refer_bonus"});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getEarningList(var userId) async {
    try {
      Response response = await dioClient!.post(AppConstants.getReferalHistory,
          data: {"user_id": userId.trim(), "type": "daily_bonus"});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///self_purchase_bonus
  Future<ApiResponse> getPSelfList(var userId) async {
    try {
      Response response = await dioClient!.post(AppConstants.repurchaseHistory,
          data: {"user_id": userId.trim(), "type": "self_purchase_bonus"});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///Bonus
  Future<ApiResponse> getPBonusSelfList(var userId) async {
    try {
      Response response = await dioClient!.post(AppConstants.repurchaseHistory,
          data: {"user_id": userId.trim(), "type": "bonus"});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///repurchase_bonus
  Future<ApiResponse> getPrepurchaseBonusList(var userId) async {
    try {
      Response response = await dioClient!.post(AppConstants.repurchaseHistory,
          data: {"user_id": userId.trim(), "type": "repurchase_bonus"});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///frenchise_withdrawal_income
  Future<ApiResponse> getPFrenchiseList(var userId) async {
    try {
      Response response = await dioClient!.post(AppConstants.repurchaseHistory,
          data: {
            "user_id": userId.trim(),
            "type": "frenchise_withdrawal_income"
          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
