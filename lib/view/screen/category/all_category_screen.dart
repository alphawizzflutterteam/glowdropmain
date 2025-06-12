import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/category.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/category_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/brand_and_category_product_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class AllCategoryScreen extends StatelessWidget {
  final bool fromWhere;
  AllCategoryScreen({Key? key, required this.fromWhere}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).highlightColor,
      body: Column(
        children: [
          CustomAppBar(
              title: getTranslated('CATEGORY', context),
              isBackButtonExist: fromWhere),

          Expanded(child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              return categoryProvider.categoryList.isNotEmpty
                  ? Row(children: [
                      Container(
                          width: MediaQuery.maybeOf(context)?.size.width,
                          margin: const EdgeInsets.only(top: 3),
                          height: double.infinity,
                          // decoration: BoxDecoration(
                          //   color: Theme.of(context).highlightColor,
                          //   boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 200]!,
                          //       spreadRadius: 1, blurRadius: 1)],
                          // ),
                          child: StaggeredGridView.countBuilder(
                            itemCount: categoryProvider.categoryList.length,
                            crossAxisCount: 3,

                            padding: const EdgeInsets.all(0),
                            // physics: const NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            staggeredTileBuilder: (int index) =>
                                const StaggeredTile.fit(1),
                            itemBuilder: (BuildContext context, int index) {
                              Category category =
                                  categoryProvider.categoryList[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              BrandAndCategoryProductScreen(
                                                isBrand: false,
                                                id: categoryProvider
                                                    .categoryList[index].id
                                                    .toString(),
                                                name: categoryProvider
                                                    .categoryList[index].name,
                                              )));
                                },
                                //  onTap: () => Provider.of<CategoryProvider>(context, listen: false).changeSelectedIndex(index),
                                child: CategoryItem(
                                  title: category.name,
                                  icon: category.icon,
                                  isSelected:
                                      categoryProvider.categorySelectedIndex ==
                                          index,
                                ),
                              );
                            },
                          )
                          // ListView.builder(
                          //   physics: const BouncingScrollPhysics(),
                          //   itemCount: categoryProvider.categoryList.length,
                          //   padding: const EdgeInsets.all(0),
                          //   itemBuilder: (context, index) {
                          //     Category category = categoryProvider.categoryList[index];
                          //     return InkWell(
                          //       onTap: () => Provider.of<CategoryProvider>(context, listen: false).changeSelectedIndex(index),
                          //       child: CategoryItem(
                          //         title: category.name,
                          //         icon: category.icon,
                          //         isSelected: categoryProvider.categorySelectedIndex == index,
                          //       ),
                          //     );
                          //
                          //   },
                          // ),
                          ),

                      //      StaggeredGridView.countBuilder(
                      //       itemCount: categoryProvider.categoryList.length,
                      //       crossAxisCount: 3,
                      //
                      //       padding: const EdgeInsets.all(0),
                      //       physics: const NeverScrollableScrollPhysics(),
                      //       shrinkWrap: true,
                      //       staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
                      //       itemBuilder: (BuildContext context, int index) {
                      // Category category = categoryProvider.categoryList[index];
                      // return InkWell(
                      // onTap: () => Provider.of<CategoryProvider>(context, listen: false).changeSelectedIndex(index),
                      // child: CategoryItem(
                      // title: category.name,
                      // icon: category.icon,
                      // isSelected: categoryProvider.categorySelectedIndex == index,
                      // ),
                      // );
                      //       },
                      //     ) : const NoInternetOrDataScreen(isNoInternet: false): ProductShimmer(isHomePage: isHomePage ,isEnabled: prodProvider.firstLoading),
                      //
                      //     prodProvider.filterIsLoading ? Center(child: Padding(
                      //       padding: const EdgeInsets.all(Dimensions.iconSizeExtraSmall),
                      //       child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                      //     ))

                      // Expanded(child: ListView.builder(
                      //   padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      //   itemCount: categoryProvider.categoryList[categoryProvider.categorySelectedIndex!].subCategories!.length+1,
                      //   itemBuilder: (context, index) {
                      //
                      //     late SubCategory subCategory;
                      //     if(index != 0) {
                      //       subCategory = categoryProvider.categoryList[categoryProvider.categorySelectedIndex!].subCategories![index-1];
                      //     }
                      //     if(index == 0) {
                      //       return Ink(
                      //         color: Theme.of(context).highlightColor,
                      //         child: ListTile(
                      //           title: Text(getTranslated('all', context)!, style: titilliumSemiBold, maxLines: 2, overflow: TextOverflow.ellipsis),
                      //           trailing: const Icon(Icons.navigate_next),
                      //           onTap: () {
                      //             Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                      //               isBrand: false,
                      //               id: categoryProvider.categoryList[categoryProvider.categorySelectedIndex!].id.toString(),
                      //               name: categoryProvider.categoryList[categoryProvider.categorySelectedIndex!].name,
                      //             )));
                      //           },
                      //         ),
                      //       );
                      //     }else if (subCategory.subSubCategories!.isNotEmpty) {
                      //       return Ink(
                      //         color: Theme.of(context).highlightColor,
                      //         child: Theme(
                      //           data: Provider.of<ThemeProvider>(context).darkTheme ? ThemeData.dark() : ThemeData.light(),
                      //           child: ExpansionTile(
                      //             key: Key('${Provider.of<CategoryProvider>(context).categorySelectedIndex}$index'),
                      //             title: Text(subCategory.name!, style: titilliumSemiBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color), maxLines: 2, overflow: TextOverflow.ellipsis),
                      //             children: _getSubSubCategories(context, subCategory),
                      //           ),
                      //         ),
                      //       );
                      //     } else {
                      //       return Ink(
                      //         color: Theme.of(context).highlightColor,
                      //         child: ListTile(
                      //           title: Text(subCategory.name!, style: titilliumSemiBold, maxLines: 2, overflow: TextOverflow.ellipsis),
                      //           trailing: Icon(Icons.navigate_next, color: Theme.of(context).textTheme.bodyLarge!.color),
                      //           onTap: () {
                      //             Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                      //               isBrand: false,
                      //               id: subCategory.id.toString(),
                      //               name: subCategory.name,
                      //             )));
                      //           },
                      //         ),
                      //       );
                      //     }
                      //
                      //   },
                      // )),
                    ])
                  : Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor)));
            },
          )),
          SizedBox(
            height: 20,
          )
          // SizedBox(height: 20,)
        ],
      ),
    );
  }

  List<Widget> _getSubSubCategories(
      BuildContext context, SubCategory subCategory) {
    List<Widget> subSubCategories = [];
    subSubCategories.add(Container(
      color: ColorResources.getIconBg(context),
      margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraSmall),
      child: ListTile(
        title: Row(
          children: [
            Container(
              height: 7,
              width: 7,
              decoration: BoxDecoration(
                  color: ColorResources.getPrimary(context),
                  shape: BoxShape.circle),
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Flexible(
                child: Text(
              getTranslated('all', context)!,
              style: titilliumSemiBold.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BrandAndCategoryProductScreen(
                        isBrand: false,
                        id: subCategory.id.toString(),
                        name: subCategory.name,
                      )));
        },
      ),
    ));
    for (int index = 0; index < subCategory.subSubCategories!.length; index++) {
      subSubCategories.add(Container(
        color: ColorResources.getIconBg(context),
        margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeExtraSmall),
        child: ListTile(
          title: Row(
            children: [
              Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                    color: ColorResources.getPrimary(context),
                    shape: BoxShape.circle),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Flexible(
                  child: Text(
                subCategory.subSubCategories![index].name!,
                style: titilliumSemiBold.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BrandAndCategoryProductScreen(
                          isBrand: false,
                          id: subCategory.subSubCategories![index].id
                              .toString(),
                          name: subCategory.subSubCategories![index].name,
                        )));
          },
        ),
      ));
    }
    return subSubCategories;
  }
}

class CategoryItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool isSelected;
  const CategoryItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 90,
            width: 90,
            // decoration: BoxDecoration(
            //   border: Border.all(width: 2, color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor),
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                fit: BoxFit.cover,
                image:
                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.categoryImageUrl}/$icon',
                imageErrorBuilder: (c, o, s) =>
                    Image.asset(Images.placeholder, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeExtraSmall),
          child: Text(title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: titilliumSemiBold.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall, color: Colors.black
                  //  color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor,
                  )),
        ),
      ]),
    );
  }
}
