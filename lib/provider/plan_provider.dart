import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/my_plan_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/plans_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/withdrawmodel.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/plan_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/wallet_transaction_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';

import '../data/model/body/service_history_model.dart';

class PlanProvider with ChangeNotifier {
  final PlanRepo? planRepo;
  PlanProvider({required this.planRepo});

  MyPlansModel? _myplans;
  WithdrawModel? _withdrawModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  MyPlansModel? get myplans => _myplans;
  WithdrawModel? get withdrawModel => _withdrawModel;

  List<PlansData>? _planList;
  List<PlansData>? get planList =>
      _planList != null ? _planList!.reversed.toList() : _planList;

  Future<void> initOrderList(BuildContext context) async {
    _isLoading = true;
    ApiResponse apiResponse = await planRepo!.getPlanList();
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _planList = [];
      print("_planList ${apiResponse.response!.data}");
      PlansModel orderModel = PlansModel.fromJson(apiResponse.response!.data);

      _planList!.addAll(orderModel.data!);
      print("_planList sieze ${_planList!.length}");
      // apiResponse.response!.data.forEach((order) {
      //
      //
      // });
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> initPlansList(BuildContext context, var userid) async {
    _isLoading = true;
    _myplans = null;
    ApiResponse apiResponse = await planRepo!.Myplan(userid);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      print("_planList ${apiResponse.response!.data}");
      MyPlansModel orderModel =
          MyPlansModel.fromJson(apiResponse.response!.data);

      _myplans = orderModel;
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }
  List<ServiceHistoryData> serviceList = [];
  Future<void> initServiceHistoryList(BuildContext context,) async {
    _isLoading = true;
    ApiResponse apiResponse = await planRepo!. MyServices();
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      print('safasfafaffa${apiResponse.response!.data}');
      var data = apiResponse.response!.data;
      serviceList =
          (data['data'] as List).map((e) => ServiceHistoryData.fromJson(e)).toList();
      print("_planList ${apiResponse.response!.data}");

      notifyListeners();
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> initWithDrawList(BuildContext context, var userid) async {
    _isLoading = true;
    ApiResponse apiResponse = await planRepo!.withDrawRequest(userid);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      print("_planList ${apiResponse.response!.data}");
      WithdrawModel orderModel =
          WithdrawModel.fromJson(apiResponse.response!.data);

      _withdrawModel = orderModel;
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> initwithDrawMyRequestList(
      BuildContext context,
      var userid,
      var wallet_type,
      var amount,
      var username,
      var bankname,
      var accountnumber,
      var ifscCode,
      var accountType) async {
    _isLoading = true;
    ApiResponse apiResponse =
        await planRepo!.withDrawMyRequest(userid, wallet_type, amount);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      print("_planList ${apiResponse.response!.data}");
      Map<String, dynamic> jsondata = apiResponse.response!.data;
      bool iscomplete = jsondata['status'];
      if (iscomplete == true) {
        Provider.of<ProfileProvider>(context, listen: false)
            .getUserInfo(context);
        Provider.of<WalletTransactionProvider>(context, listen: false)
            .getTransactionList(context, 1);

        showCustomSnackBar(jsondata['message'], context);
      } else {
        showCustomSnackBar(jsondata['message'], context);
      }

      Navigator.pop(context);
      // WithdrawModel orderModel = WithdrawModel.fromJson(apiResponse.response!.data);
      //
      // _withdrawModel = orderModel;
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  List<PlansData>? isPlanList() {
    return _planList;
  }

  Future purchasePlan(var userid, var planId, var transactionId, var amount,
      var remark, var type, Function callback) async {
    _isLoading = true;
    notifyListeners();

    ApiResponse apiResponse = await planRepo!
        .planSList(userid, planId, transactionId, amount, remark, type);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      String? temporaryToken = '';
      String? token = '';
      String? message = '';
      print("resgister----------");
      try {
        message = map["message"];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      try {
        token = map["message"];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      try {
        temporaryToken = map["message"];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      if (token != null && token.isNotEmpty) {
        // authRepo!.saveUserToken(token);
        // await authRepo!.updateToken();
      }
      callback(true, token, temporaryToken, message);
      notifyListeners();
    }
    notifyListeners();
  }
}
