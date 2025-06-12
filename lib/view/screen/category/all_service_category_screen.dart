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
import 'package:flutter_sixvalley_ecommerce/view/screen/category/service_card_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/brand_and_category_product_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class AllServiceCategoryScreen extends StatelessWidget {
  final bool fromWhere;
  AllServiceCategoryScreen({Key? key, required this.fromWhere})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          CustomAppBar(
              title: getTranslated('CATEGORY', context),
              isBackButtonExist: fromWhere),

          Expanded(child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              return categoryProvider.serviceCategoryList.isNotEmpty
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
                            itemCount:
                                categoryProvider.serviceCategoryList.length,
                            crossAxisCount: 3,

                            padding: const EdgeInsets.all(0),
                            // physics: const NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            staggeredTileBuilder: (int index) =>
                                const StaggeredTile.fit(1),
                            itemBuilder: (BuildContext context, int index) {
                              Category category =
                                  categoryProvider.serviceCategoryList[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ServiceCardView(
                                                isBrand: false,
                                                id: categoryProvider
                                                    .serviceCategoryList[index]
                                                    .id
                                                    .toString(),
                                                name: categoryProvider
                                                    .serviceCategoryList[index]
                                                    .name,
                                              )));
                                },
                                //  onTap: () => Provider.of<CategoryProvider>(context, listen: false).changeSelectedIndex(index),
                                child: CategoryItem(
                                  title: category.name,
                                  icon: category.icon,
                                  isSelected: categoryProvider
                                          .serviceCategorySelectedIndex ==
                                      index,
                                ),
                              );
                            },
                          )),
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
                  builder: (_) => ServiceCardView(
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
                    builder: (_) => ServiceCardView(
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
