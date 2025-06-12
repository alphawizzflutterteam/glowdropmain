import 'package:flutter/material.dart';
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
import 'package:flutter_sixvalley_ecommerce/view/screen/category/service_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../data/datasource/remote/dio/dio_client.dart';
import '../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../data/model/response/base/api_response.dart';
import '../../../utill/app_constants.dart';
import '../home/home_screens.dart';

class ServiceCardView extends StatelessWidget {
  final bool isBrand;
  final String id;
  final String? name;
  final String? image;
  final TextEditingController _searchController = TextEditingController();
  ServiceCardView(
      {Key? key,
      required this.isBrand,
      required this.id,
      required this.name,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false)
        .initServiceList(isBrand, id, context);
    return Scaffold(
      // backgroundColor: ColorResources.getIconBg(context),
      backgroundColor: ColorResources.getIconBg(context),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAppBar(title: name),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 12.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                    onChanged: (value) {
                      Provider.of<ProductProvider>(context, listen: false)
                          .initServiceList(isBrand, id, context,
                              text: _searchController.text);
                      print('Search query: $value');
                    },
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
                productProvider.serviceList.isNotEmpty
                    ? Expanded(
                        child: StaggeredGridView.countBuilder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall),
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          itemCount: productProvider.serviceList.length,
                          shrinkWrap: true,
                          staggeredTileBuilder: (int index) =>
                              const StaggeredTile.fit(1),
                          itemBuilder: (BuildContext context, int index) {
                            return ServiceWidget(
                                productModel:
                                    productProvider.serviceList[index]);
                          },
                        ),
                      )
                    : Expanded(
                        child: Center(
                        child: productProvider.hasServiceData ?? true
                            ? ProductShimmer(
                                isHomePage: false,
                                isEnabled: Provider.of<ProductProvider>(context)
                                    .serviceList
                                    .isEmpty)
                            : const NoInternetOrDataScreen(isNoInternet: false),
                      )),
              ]);
        },
      ),
    );
  }
}
