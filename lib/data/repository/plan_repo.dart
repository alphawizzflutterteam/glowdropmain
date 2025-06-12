import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

// PlanRepo


class PlanRepo {
  final DioClient? dioClient;

  PlanRepo({required this.dioClient});


  Future<ApiResponse> getPlanList() async {
    try {
      final response = await dioClient!.get(AppConstants.getPlans);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




  Future<ApiResponse> planSList(var userid,var planId,
      var transactionId, var amount,var remark,var type) async {

    Map data ={
      "user_id" : "$userid",
      "plan_id" : "$planId",
      "transaction_id" : "$transactionId",
      "amount" : "$amount",
      "remark" : "$remark",
      "type" : "$type",
    };

    print("Request $data");
    try {
      Response response = await dioClient!.post(
        AppConstants.purchasePlan,
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> Myplan(var userid) async {

    Map data ={
      "user_id" : "$userid",

    };

    print("Request $data");
    try {
      Response response = await dioClient!.post(
        AppConstants.MyPlans,
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> MyServices() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.myServicesApi,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> withDrawRequest(var userid) async {

    Map data ={
      "user_id" : "$userid",

    };

    print("Request $data");
    try {
      Response response = await dioClient!.post(
        AppConstants.withDrawRequest,
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> withDrawMyRequest(var userid,var wallet_type,var amount) async {

    Map data ={
      "user_id" : "$userid",
      "wallet_type" : "$wallet_type",
      "amount" : "$amount",

    };

    print("Request $data");
    print("Request url ${AppConstants.withDrawMyRequest}");
    try {
      Response response = await dioClient!.post(
        AppConstants.withDrawMyRequest,
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



}