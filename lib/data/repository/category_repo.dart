import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

import '../model/select_category.dart';

class CategoryRepo {
  final DioClient? dioClient;
  CategoryRepo({required this.dioClient});

  Future<ApiResponse> getCategoryList() async {
    try {
      final response = await dioClient!.get(
        AppConstants.categoriesUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> fetchCategories() async {
    try {
      final response = await dioClient!.get(
        'https://glow-drop.developmentalphawizz.com/api/v1/seller/category',
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
  Future<ApiResponse> getServiceCategoryList() async {
    try {
      final response = await dioClient!.get(
        AppConstants.serviceCategoriesUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}