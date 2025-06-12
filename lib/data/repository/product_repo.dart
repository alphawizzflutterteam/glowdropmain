import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/user_info_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/home_screens.dart';
import 'package:provider/provider.dart';

import '../../provider/profile_provider.dart';

class ProductRepo {
  final DioClient? dioClient;
  ProductRepo({required this.dioClient});

  Future<ApiResponse> getLatestProductList(BuildContext context, String offset,
      ProductType productType, String? title) async {
    late String endUrl;

    if (productType == ProductType.bestSelling) {
      endUrl = AppConstants.bestSellingProductUri;
      title = getTranslated('best_selling', context);
    } else if (productType == ProductType.newArrival) {
      endUrl = AppConstants.newArrivalProductUri;
      title = getTranslated('new_arrival', context);
    } else if (productType == ProductType.topProduct) {
      endUrl = AppConstants.topProductUri;
      title = getTranslated('top_product', context);
    } else if (productType == ProductType.discountedProduct) {
      endUrl = AppConstants.discountedProductUri;
      title = getTranslated('discounted_product', context);
    }

    try {
      final response = await dioClient!.get(endUrl + offset);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //Seller Products
  Future<ApiResponse> getSellerProductList(String sellerId, String offset,
      [String search = '']) async {
    try {
      final response = await dioClient!.get(
          '${AppConstants.sellerProductUri}$sellerId/products?limit=10&&offset=$offset&search=$search');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getBrandOrCategoryProductList(
      bool isBrand, String id, double? max, double? min) async {
    try {
      String uri;
      print("Max Price: $max");
      print("Min Price: $min");
      if (isBrand) {
        uri =
            '${AppConstants.brandProductUri}$id?city=${Provider.of<ProfileProvider>(Get.context!, listen: false).selectedCity ?? ""}';
      } else {
        uri =
            '${AppConstants.categoryProductUri}$id?city=${Provider.of<ProfileProvider>(Get.context!, listen: false).selectedCity ?? ''}';
      }

      if (max != null && min != null) {
        uri += '&max_price=$max&min_price=$min';
      }
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getServiceList(
      bool isBrand, String id, String sellerId) async {
    try {
      String uri;
      uri =
          '${AppConstants.serviceUri}$id?latitude=$lat&longitude=$long&vendor_id=$sellerId';

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getRelatedProductList(String id) async {
    try {
      final response =
          await dioClient!.get(AppConstants.relatedProductUri + id);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getFeaturedProductList(String offset) async {
    try {
      final response = await dioClient!.get(
        AppConstants.featuredProductUri + offset,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getLProductList(String offset) async {
    try {
      final response = await dioClient!.get(
        AppConstants.latestProductUri + offset,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getRecommendedProduct() async {
    try {
      final response = await dioClient!.get(AppConstants.dealOfTheDay);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
