import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/category.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/category_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';

import '../data/model/select_category.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepo? categoryRepo;

  CategoryProvider({required this.categoryRepo});

  final List<Category> _categoryList = [];
  int? _categorySelectedIndex;

  List<Category> get categoryList => _categoryList;
  int? get categorySelectedIndex => _categorySelectedIndex;
  List<SlectCategory> _categories = [];
  bool _isLoading = false;

  List<SlectCategory> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      ApiResponse apiResponse = await categoryRepo!.fetchCategories();
      apiResponse.response!.data.forEach(
          (category) => _categories.add(SlectCategory.fromJson(category)));
    } catch (e) {
      print(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getCategoryList(bool reload) async {
    if (_categoryList.isEmpty || reload) {
      ApiResponse apiResponse = await categoryRepo!.getCategoryList();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        _categoryList.clear();
        apiResponse.response!.data.forEach(
            (category) => _categoryList.add(Category.fromJson(category)));
        _categorySelectedIndex = 0;
      } else {
        ApiChecker.checkApi(apiResponse);
      }
      notifyListeners();
    }
  }

  void changeSelectedIndex(int selectedIndex) {
    _categorySelectedIndex = selectedIndex;
    notifyListeners();
  }

  final List<Category> _serviceCategoryList = [];
  int? _serviceCategorySelectedIndex;

  List<Category> get serviceCategoryList => _serviceCategoryList;
  int? get serviceCategorySelectedIndex => _serviceCategorySelectedIndex;

  Future<void> getServiceCategoryList(bool reload) async {
    if (_serviceCategoryList.isEmpty || reload) {
      ApiResponse apiResponse = await categoryRepo!.getServiceCategoryList();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        _serviceCategoryList.clear();
        apiResponse.response!.data.forEach((category) =>
            _serviceCategoryList.add(Category.fromJson(category)));
        _categorySelectedIndex = 0;
      } else {
        ApiChecker.checkApi(apiResponse);
      }
      notifyListeners();
    }
  }

  void changeServiceSelectedIndex(int selectedIndex) {
    _categorySelectedIndex = selectedIndex;
    notifyListeners();
  }
}
