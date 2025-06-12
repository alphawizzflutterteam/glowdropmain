import '../../utill/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class TopRestaurantsRepo {
  final DioClient? dioClient;
  TopRestaurantsRepo({required this.dioClient});

  Future<ApiResponse> getTopRestaurants() async {
    print("top restaurents ---------");
    try {
      final response = await dioClient!.post(AppConstants.topRestaurantsUri);
      print("allsellerapi_${response}");
      print("top restaurents success---------");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print("top restaurents error---------");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getTodaysSpecial() async {
    print("top restaurents ---------");
    try {
      final response = await dioClient!.get(AppConstants.todaySpecialUri);
      print("todays special success---------");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print("todays special error---------");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
