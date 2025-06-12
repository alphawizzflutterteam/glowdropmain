import 'package:flutter/foundation.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/today_special_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/top_restaurants_repo.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/top_restaurants_model.dart';
import '../helper/api_checker.dart';

class TopRestaurantsProvider extends ChangeNotifier{

  final TopRestaurantsRepo? topRestaurantsRepo;
  TopRestaurantsProvider({this.topRestaurantsRepo} );
   // List<>
  List<TopRestaurantsmodel> _topRestaurantsList=[];
  List<TopRestaurantsmodel> get topRestaurantsList => _topRestaurantsList;
  List<Product> _todaysSpecialList=[];
  List<Product> get todaysSpecialList => _todaysSpecialList;


  int? _currentIndex;
  int? _currentIndex1;
 int? get currentIndex => _currentIndex;


  Future<void> getTopRestaurantsList(bool reload) async {
    debugPrint("method called");
    if (_topRestaurantsList.isEmpty || reload) {
      ApiResponse apiResponse = await topRestaurantsRepo!.getTopRestaurants();
      // debugPrint("method called"+apiResponse.response!.statusCode.toString());
   if (apiResponse.response != null && apiResponse.response!.statusCode   == 200) {
     _topRestaurantsList.clear();
      _topRestaurantsList.add(TopRestaurantsmodel.fromJson(apiResponse.response!.data));
   debugPrint('top Restaurants counts--------${topRestaurantsList.length}');
    _currentIndex = 0;

      }
      else
        {debugPrint("top restaurants response----------");
          ApiChecker.checkApi( apiResponse);
        }
      notifyListeners();
    }




  }
    Future<void> getTodaysSpecialList(bool reload) async {
      debugPrint("method called todays special");
      if (_todaysSpecialList.isEmpty || reload) {
        ApiResponse apiResponse = await topRestaurantsRepo!.getTodaysSpecial() ;
        debugPrint("method called todays special"+apiResponse.response!.statusCode.toString());
     if (apiResponse.response != null && apiResponse.response!.statusCode   == 200) {
       _todaysSpecialList.clear();
       print("aaaabbcc${apiResponse.response?.data}");
       // for(int i=  0;i<apiResponse.response.)
       _todaysSpecialList.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
    //   _todaysSpecialList.add(Product.fromJson(apiResponse.response?.data));
     debugPrint('todays special counts--------${todaysSpecialList.length}');
      _currentIndex1 = 0;

        }
        else
          {
            debugPrint("top restaurants response----------");
            ApiChecker.checkApi( apiResponse);
          }
        notifyListeners();
      }
    }

    void setCurrentIndex(int index) {
    _currentIndex = index;
    _currentIndex1 = index;
    notifyListeners();
  }


// final List<Seller> _ = [];
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter_sixvalley_ecommerce/data/repository/top_restaurants_repo.dart';
//
// import '../data/model/response/base/api_response.dart';
// import '../data/model/response/top_restaurants_model.dart';
// import '../helper/api_checker.dart';
//
// class TopRestaurantsProvider extends ChangeNotifier {
//    final TopRestaurantsRepo topRestaurantsRepo;
//
//   CategoryProvider({this.topRestaurantsRepo});
//
//
//   final List<Seller> _categoryList = [];
//   int? _categorySelectedIndex;
//
//   List<Seller> get categoryList => _categoryList;
//   int? get categorySelectedIndex => _categorySelectedIndex;
//
//   Future<void> getCategoryList(bool reload) async {
//     if (_categoryList.isEmpty || reload) {
//       ApiResponse apiResponse = await topRestaurantsRepo!.getTopRestaurants();
//       if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
//         _categoryList.clear();
//         apiResponse.response!.data.forEach((category) => _categoryList.add(Seller.fromJson()));
//         _categorySelectedIndex = 0;
//       } else {
//         ApiChecker.checkApi( apiResponse);
//       }
//       notifyListeners();
//     }
//   }
//
//   void changeSelectedIndex(int selectedIndex) {
//     _categorySelectedIndex = selectedIndex;
//     notifyListeners();
//   }
// }