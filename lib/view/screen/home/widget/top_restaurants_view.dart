import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/top_restaurants_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/top_restaurants_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/top_restaurants_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/restaurants_details.dart';
import 'package:provider/provider.dart';

import 'category_shimmer.dart';
class TopRestaurantsView extends StatelessWidget {
  final bool isHomePage;
  const TopRestaurantsView({Key? key, required this.isHomePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TopRestaurantsProvider>(builder: (context, topRestaurantsProvider,child,){
      return  topRestaurantsProvider.topRestaurantsList.isNotEmpty  ? SizedBox(
          height: 170,
          child:
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
             childAspectRatio: 1.8,
            ),
            itemCount:
            isHomePage
                ?  topRestaurantsProvider.topRestaurantsList.first.seller!.length > 4
                ? 4
                :  topRestaurantsProvider.topRestaurantsList.first.seller!.length
                :  topRestaurantsProvider.topRestaurantsList.first.seller!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {

              return TopRestaurantsWidget(seller: topRestaurantsProvider.topRestaurantsList.first.seller![index] ,);

            },
          )

      ) : const TopRestaurentsShimmer();

      //   topRestaurantsProvider.topRestaurantsList.isNotEmpty  ?
      // SizedBox(
      //   height: 100,
      //   child:
      //   GridView.builder(
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 4,
      //       crossAxisSpacing: 15,
      //       mainAxisSpacing: 8,
      //       childAspectRatio: (1/1.4),
      //     ),
      //     itemCount: isHomePage
      //         ?  topRestaurantsProvider.topRestaurantsList.length > 4
      //            ? 4
      //            :  topRestaurantsProvider.topRestaurantsList.length
      //         :  topRestaurantsProvider.topRestaurantsList.length,
      //     shrinkWrap: true,
      //     physics: const NeverScrollableScrollPhysics(),
      //     itemBuilder: (BuildContext context, int index) {
      //
      //       return InkWell(
      //         onTap: () {
      //          // Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
      //          //    isBrand: false,
      //          //    id: categoryProvider.categoryList[index].id.toString(),
      //          //    name: categoryProvider.categoryList[index].name,
      //         //  )));
      //         },
      //         child:TopRestaurantsWidget(seller: topRestaurantsProvider.topRestaurantsList[0].seller![index] ,)
      //           // categoryProvider.categoryList[index]
      //       );
      //
      //     },
      //   )
      //
      // ): const CategoryShimmer();
      //

    });
  }
}
