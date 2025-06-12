import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/notification_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/referal_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/referal_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../data/model/response/repurchasemodel.dart';
import '../data/repository/referal_repo.dart';
import '../view/screen/repurchase/repurchasehistory.dart';

class ReferalProvider extends ChangeNotifier {
  final ReferalRepo? referalRepo;

  ReferalProvider({required this.referalRepo});

  List<ReferalData>? _notificationList;
  List<RepurchaseData>? _selfRepurchaseList;
  List<RepurchaseData>? _bonusRepurchaseList;
  List<RepurchaseData>? _rebonusRepurchaseList;
  List<RepurchaseData>? _frenchRepurchaseList;
  List<ReferalData>? _bonusList;
  List<ReferalData>? _earningsList;
  List<ReferalData>? get notificationList => _notificationList;
  List<RepurchaseData>? get selfRepurchaseList => _selfRepurchaseList;
  List<RepurchaseData>? get bonusRepurchaseList => _bonusRepurchaseList;
  List<RepurchaseData>? get rebonusRepurchaseList => _rebonusRepurchaseList;
  List<RepurchaseData>? get frenchRepurchaseList => _frenchRepurchaseList;
  List<ReferalData>? get bonusList => _bonusList;
  List<ReferalData>? get earningsList => _earningsList;

  Future<void> initReferalList(BuildContext context) async {
    ApiResponse apiResponse = await referalRepo!.getRegferalList(
        Provider.of<AuthProvider>(context, listen: false).getAuthID());
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _notificationList = [];
      ReferalModel referalModel =
          ReferalModel.fromJson(apiResponse.response!.data);
      _notificationList!.addAll(referalModel.data!);
      // apiResponse.response!.data.forEach((notification) => _notificationList!.add(ReferalModel.fromJson(notification)));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> initBonusList(BuildContext context) async {
    ApiResponse apiResponse = await referalRepo!.getBonusList(
        Provider.of<AuthProvider>(context, listen: false).getAuthID());
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _bonusList = [];

      ReferalModel referalModel =
          ReferalModel.fromJson(apiResponse.response!.data);
      print("ReferalModel ${referalModel.data}");
      _bonusList!.addAll(referalModel.data!);
      // apiResponse.response!.data.forEach((notification) => _notificationList!.add(ReferalModel.fromJson(notification)));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> initEarningsList(BuildContext context) async {
    ApiResponse apiResponse = await referalRepo!.getEarningList(
        Provider.of<AuthProvider>(context, listen: false).getAuthID());
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _earningsList = [];
      ReferalModel referalModel =
          ReferalModel.fromJson(apiResponse.response!.data);
      _earningsList!.addAll(referalModel.data!);
      // apiResponse.response!.data.forEach((notification) => _notificationList!.add(ReferalModel.fromJson(notification)));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  /// Repurchase
  Future<void> initRepurchaseReferalList(BuildContext context) async {
    ApiResponse apiResponse = await referalRepo!.getPSelfList(
        Provider.of<AuthProvider>(context, listen: false).getAuthID());
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _selfRepurchaseList = [];
      RepurchaseHistoryModel referalModel =
          RepurchaseHistoryModel.fromJson(apiResponse.response!.data);
      _selfRepurchaseList!.addAll(referalModel.data!);
      // apiResponse.response!.data.forEach((notification) => _notificationList!.add(ReferalModel.fromJson(notification)));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> initRepurchaseBonusList(BuildContext context) async {
    ApiResponse apiResponse = await referalRepo!.getPBonusSelfList(
        Provider.of<AuthProvider>(context, listen: false).getAuthID());
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _bonusRepurchaseList = [];
      RepurchaseHistoryModel referalModel =
          RepurchaseHistoryModel.fromJson(apiResponse.response!.data);
      _bonusRepurchaseList!.addAll(referalModel.data!);
      // apiResponse.response!.data.forEach((notification) => _notificationList!.add(ReferalModel.fromJson(notification)));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> initRepurchaseREBonusList(BuildContext context) async {
    ApiResponse apiResponse = await referalRepo!.getPrepurchaseBonusList(
        Provider.of<AuthProvider>(context, listen: false).getAuthID());
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _rebonusRepurchaseList = [];
      RepurchaseHistoryModel referalModel =
          RepurchaseHistoryModel.fromJson(apiResponse.response!.data);
      _rebonusRepurchaseList!.addAll(referalModel.data!);
      // apiResponse.response!.data.forEach((notification) => _notificationList!.add(ReferalModel.fromJson(notification)));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> initRepurchaseFrechEarningsList(BuildContext context) async {
    ApiResponse apiResponse = await referalRepo!.getPFrenchiseList(
        Provider.of<AuthProvider>(context, listen: false).getAuthID());
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _frenchRepurchaseList = [];
      RepurchaseHistoryModel referalModel =
          RepurchaseHistoryModel.fromJson(apiResponse.response!.data);
      _frenchRepurchaseList!.addAll(referalModel.data!);
      // apiResponse.response!.data.forEach((notification) => _notificationList!.add(ReferalModel.fromJson(notification)));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }
}
