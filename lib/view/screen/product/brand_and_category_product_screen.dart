import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../search/widget/search_filter_bottom_sheet.dart';

class BrandAndCategoryProductScreen extends StatelessWidget {
  final bool isBrand;
  final String id;
  final String? name;
  final String? image;

  const BrandAndCategoryProductScreen(
      {Key? key,
      required this.isBrand,
      required this.id,
      required this.name,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).updateMaxValue(null);
    Provider.of<ProductProvider>(context, listen: false).updateMinValue(null);
    Provider.of<ProductProvider>(context, listen: false).setFilterIndex(0);

    Provider.of<ProductProvider>(context, listen: false)
        .initBrandOrCategoryProductList(isBrand, id, context);
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAppBar(
                  title: name,
                  filterIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          double minPrice = 0;
                          double maxPrice = 0;
                          // if (Provider.of<ProductProvider>(context,
                          //             listen: false)
                          //         .maxPrice ==
                          //     null) {
                          for (var i = 0;
                              i <
                                  productProvider
                                      .brandOrCategoryProductList.length;
                              i++) {
                            double price = double.parse(
                                PriceConverter.convertPrice(
                                        context,
                                        productProvider
                                            .brandOrCategoryProductList[i]
                                            .unitPrice,
                                        discountType:
                                            productProvider
                                                .brandOrCategoryProductList[i]
                                                .discountType,
                                        discount: productProvider
                                            .brandOrCategoryProductList[i]
                                            .discount)
                                    .replaceAll('₹', '')
                                    .replaceAll(',', ''));
                            if (i == 0) {
                              minPrice = price;
                            }
                            if (price > maxPrice) {
                              maxPrice = price;
                            }
                            if (price < minPrice) {
                              minPrice = price;
                            }
                          }
                          // } else {
                          //   minPrice = Provider.of<ProductProvider>(context,
                          //           listen: false)
                          //       .minPrice!;
                          //   maxPrice = Provider.of<ProductProvider>(context,
                          //           listen: false)
                          //       .maxPrice!;
                          // }
                          await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (c) => SearchFilterBottomSheet(
                                    maxPrice: 500000,
                                    minPrice: 0,
                                  ));
                          print('test');
                          Provider.of<ProductProvider>(context, listen: false)
                              .initBrandOrCategoryProductList(
                                  isBrand, id, context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeExtraSmall,
                              horizontal: Dimensions.paddingSizeSmall),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Image.asset(Images.dropdown, scale: 3),
                        ),
                      ),
                    ],
                  ),
                ),
                isBrand
                    ? Container(
                        height: 100,
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeLarge),
                        margin: const EdgeInsets.only(
                            top: Dimensions.paddingSizeSmall),
                        color: Theme.of(context).highlightColor,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FadeInImage.assetNetwork(
                                placeholder: Images.placeholder,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                image:
                                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.brandImageUrl}/$image',
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                    Images.placeholder,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover),
                              ),
                              const SizedBox(
                                  width: Dimensions.paddingSizeSmall),
                              Text(name!,
                                  style: titilliumSemiBold.copyWith(
                                      fontSize: Dimensions.fontSizeLarge)),
                            ]),
                      )
                    : const SizedBox.shrink(),

                const SizedBox(height: Dimensions.paddingSizeSmall),

                // Products
                productProvider.brandOrCategoryProductList.isNotEmpty
                    ? Expanded(
                        child: StaggeredGridView.countBuilder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall),
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          itemCount:
                              productProvider.brandOrCategoryProductList.length,
                          shrinkWrap: true,
                          staggeredTileBuilder: (int index) =>
                              const StaggeredTile.fit(1),
                          itemBuilder: (BuildContext context, int index) {
                            return ProductWidget(
                                productModel: productProvider
                                    .brandOrCategoryProductList[index]);
                          },
                        ),
                      )
                    : Expanded(
                        child: Center(
                        child: productProvider.hasData!
                            ? ProductShimmer(
                                isHomePage: false,
                                isEnabled: Provider.of<ProductProvider>(context)
                                    .brandOrCategoryProductList
                                    .isEmpty)
                            : const NoInternetOrDataScreen(isNoInternet: false),
                      )),
              ]);
        },
      ),
    );
  }
}
