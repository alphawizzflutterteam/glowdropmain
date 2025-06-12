import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/rating_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/category/service_detail_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/service_model.dart';

class ServiceWidget extends StatelessWidget {
  final ServiceData productModel;
  const ServiceWidget({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String ratting =
        productModel.rating != null && productModel.rating!.isNotEmpty
            ? productModel.rating![0].average!
            : "0";
print('safgfg gdgsdg${AppConstants.baseUrl}/storage/app/public/product/${productModel.thumbnail}',);
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ServiceDetailScreen(productModel: productModel,)));
        // Navigator.push(context, PageRouteBuilder(
        //   transitionDuration: const Duration(milliseconds: 1000),
        //   pageBuilder: (context, anim1, anim2) => ProductDetails(productId: productModel.id,slug: productModel.slug),
        // ));
      },
      child: Container(
        //height: MediaQuery.of(context).size.width/5,
        width: MediaQuery.of(context).size.width / 2.4,
        height: Dimensions.cardHeight1,
        margin: const EdgeInsets.only(left: 9, right: 9, top: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5)
          ],
        ),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // Product Image
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: ColorResources.getIconBg(context),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width / 2.45,
                  image:
                      '${AppConstants.baseUrl}/storage/app/public/product/${productModel.thumbnail}',
                  imageErrorBuilder: (c, o, s) => Image.asset(
                      Images.placeholder_1x1,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.width / 2.45),
                ),
              ),
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.only(
                  top: Dimensions.paddingSizeSmall,
                  bottom: 5,
                  left: 5,
                  right: 5),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(productModel.name ?? '',
                              textAlign: TextAlign.center,
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  fontWeight: FontWeight.w400),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      RatingBar(
                        rating: double.parse(ratting),
                        size: 18,
                      ),
                      Text('${(productModel.rating?.isNotEmpty ?? false) ? (productModel.rating?[0].average) : '0' }',
                          style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                          )),
                    ]),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        productModel.discount != null &&
                                productModel.discount! > 0
                            ? Text(
                                PriceConverter.convertPrice(
                                    context, double.parse(productModel.unitPrice.toString())),
                                style: titleRegular.copyWith(
                                  color: ColorResources.getRed(context),
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                ),
                              )
                            : const SizedBox.shrink(),
                        productModel.discount != null &&
                                productModel.discount! > 0
                            ? SizedBox(
                                width: 10,
                              )
                            : SizedBox(),
                        Text(
                          PriceConverter.convertPrice(
                              context,  double.parse(productModel.unitPrice.toString()),
                              discountType: productModel.discountType,
                              discount: double.parse(productModel.discount.toString()),),
                          style: titilliumSemiBold.copyWith(
                              color: ColorResources.getPrimary(context),
                              fontSize: 18),
                        ),
                      ],
                    ),
                    // SizedBox(height: 5,),
                    // Container(
                    //   width: double.infinity, // or any specific width
                    //
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start
                    //     ,
                    //     children: [
                    //       Icon(
                    //         Icons.location_on_outlined,
                    //         size: 20,
                    //       ),
                    //       Expanded(
                    //         child: Text(
                    //           productModel.seller?.address ?? '',
                    //
                    //           maxLines: 2,
                    //           style: TextStyle(overflow: TextOverflow.ellipsis),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(
                      height: 5,
                    ),
                    // Container(
                    //   height: 30,
                    //   width: 200,
                    //   decoration: BoxDecoration(
                    //     color: ColorResources.primaryMaterial.withOpacity(.4),
                    //       borderRadius: BorderRadius.circular(10),
                    //       border: Border.all(
                    //           color: ColorResources.primaryMaterial)),
                    //   child: Center(child: const Text('Book Now',style: TextStyle(color: ColorResources.white,fontWeight: FontWeight.bold),)),
                    // )
                  ],
                ),
              ),
            ),
          ]),

          // Off

          productModel.discount! > 0
              ? Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraSmall),
                    decoration: BoxDecoration(
                      color: ColorResources.getPrimary(context),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        PriceConverter.percentageCalculation(
                            context,
                            double.parse(productModel.unitPrice.toString()),
                            double.parse(productModel.discount.toString()),
                            productModel.discountType),
                        style: robotoRegular.copyWith(
                            color: Theme.of(context).highlightColor,
                            fontSize: Dimensions.fontSizeSmall),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          // Positioned(
          //     bottom: 110,
          //     left: 20,
          //     child: Text(
          //       ".",
          //       style: TextStyle(
          //           color:
          //               productModel?.productindicator?.toLowerCase() == "veg"
          //                   ? Colors.green
          //                   : Colors.red,
          //           fontSize: 50),
          //     )),
        ]),
      ),
    );
  }
}
