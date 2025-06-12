import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_details_model.dart'
    as pd;
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_details_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/widget/cart_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ProductTitleView extends StatelessWidget {
  final pd.ProductDetailsModel? productModel;
  final String? averageRatting;
  const ProductTitleView(
      {Key? key, required this.productModel, this.averageRatting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? startingPrice = 0;
    double? endingPrice;
    if (productModel!.variation != null &&
        productModel!.variation!.isNotEmpty) {
      List<double?> priceList = [];
      for (var variation in productModel!.variation!) {
        priceList.add(variation.price);
      }
      priceList.sort((a, b) => a!.compareTo(b!));
      startingPrice = priceList[0];
      if (priceList[0]! < priceList[priceList.length - 1]!) {
        endingPrice = priceList[priceList.length - 1];
      }
    } else {
      startingPrice = productModel!.unitPrice;
    }
    int? stock = productModel!.currentStock;
    return productModel != null
        ? Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Consumer<ProductDetailsProvider>(
              builder: (context, details, child) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(productModel!.name ?? '',
                                style: titleRegular.copyWith(
                                    fontSize: Dimensions.fontSizeLarge),
                                maxLines: 2),
                          ),

                          productModel!.currentStock == 0
                              ? SizedBox()
                              : Row(children: [
                                  // Text(getTranslated('quantity', context)!, style: robotoBold),
                                  QuantityButton(
                                      isIncrement: false,
                                      quantity: details.quantity,
                                      stock: stock,
                                      minimumOrderQuantity:
                                          productModel!.minimumOrderQty,
                                      digitalProduct:
                                          productModel!.productType ==
                                              "digital"),
                                  Text(details.quantity.toString(),
                                      style: titilliumSemiBold),
                                  QuantityButton(
                                      isIncrement: true,
                                      quantity: details.quantity,
                                      stock: stock,
                                      minimumOrderQuantity:
                                          productModel!.minimumOrderQty,
                                      digitalProduct:
                                          productModel!.productType ==
                                              "digital"),
                                ]),

                          //  const SizedBox.shrink(),
                        ],
                      ),
                      // const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                '${startingPrice != null ? PriceConverter.convertPrice(context, startingPrice, discount: productModel!.discount, discountType: productModel!.discountType) : ''}'
                                '${endingPrice != null ? ' - ${PriceConverter.convertPrice(context, endingPrice, discount: productModel!.discount, discountType: productModel!.discountType)}' : ''}',
                                style: titilliumBold.copyWith(
                                    color: ColorResources.getPrimary(context),
                                    fontSize: Dimensions.fontSizeLarge),
                              ),
                              const SizedBox(
                                  height:
                                      Dimensions.paddingSizeExtraExtraSmall),
                              productModel!.discount != null &&
                                      productModel!.discount! > 0
                                  ? Text(
                                      '${PriceConverter.convertPrice(context, startingPrice)}'
                                      '${endingPrice != null ? ' - ${PriceConverter.convertPrice(context, endingPrice)}' : ''}',
                                      style: titilliumRegular.copyWith(
                                          color: Theme.of(context).hintColor,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // productModel!.unitPrice !=null && productModel!.discount != 0 ?
                          // Positioned(
                          //   left: 0,top: 0,
                          //   child: Column(
                          //     children: [
                          //       Container(
                          //         padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                          //         alignment: Alignment.center,
                          //         decoration: BoxDecoration(
                          //             color: Theme.of(context).primaryColor,
                          //             borderRadius: const BorderRadius.only(bottomRight: Radius.circular(Dimensions.paddingSizeSmall))
                          //         ),
                          //         child: Text(PriceConverter.percentageCalculation(context, productModel!.unitPrice,
                          //             productModel!.discount, productModel!.discountType),
                          //           style: titilliumRegular.copyWith(color: Theme.of(context).cardColor, fontSize:10),
                          //         ),
                          //       ),
                          //
                          //     ],
                          //   ),
                          // ) : const SizedBox.shrink(),
                        ],
                      ),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      Row(),
                      //
                      // Row(children: [
                      //   Text('${details.reviewList != null ? details.reviewList!.length : 0} reviews | ',
                      //       style: titilliumRegular.copyWith(color: Theme.of(context).hintColor,
                      //         fontSize: Dimensions.fontSizeDefault,)),
                      //
                      //   Text('${details.orderCount} orders | ', style: titilliumRegular.copyWith(
                      //     color: Theme.of(context).hintColor,
                      //     fontSize: Dimensions.fontSizeDefault,
                      //   )),
                      //
                      //   Text('${details.wishCount} wish', style: titilliumRegular.copyWith(
                      //     color: Theme.of(context).hintColor,
                      //     fontSize: Dimensions.fontSizeDefault,
                      //   )),
                      //
                      //   const Expanded(child: SizedBox.shrink()),
                      //   const SizedBox(width: 5),
                      //
                      //
                      //   Row(children: [
                      //     const Icon(Icons.star, color: Colors.orange,),
                      //     Text('${productModel!.reviews != null ? productModel!.reviews!.isNotEmpty ?
                      //     double.parse(averageRatting!) : 0.0 : 0.0}')
                      //   ],),
                      //
                      // ]),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      productModel!.colors != null &&
                              productModel!.colors!.isNotEmpty
                          ? Row(children: [
                              Text(
                                  '${getTranslated('select_variant', context)} : ',
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.fontSizeLarge)),
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    itemCount: productModel!.colors!.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      String colorString =
                                          '0xff${productModel!.colors![index].code!.substring(1, 7)}';
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.paddingSizeExtraSmall),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              Dimensions.paddingSizeExtraSmall),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            padding: const EdgeInsets.all(
                                                Dimensions
                                                    .paddingSizeExtraSmall),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color:
                                                  Color(int.parse(colorString)),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ])
                          : const SizedBox(),
                      productModel!.colors != null &&
                              productModel!.colors!.isNotEmpty
                          ? const SizedBox(height: Dimensions.paddingSizeSmall)
                          : const SizedBox(),

                      productModel!.choiceOptions != null &&
                              productModel!.choiceOptions!.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: productModel!.choiceOptions!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          '${getTranslated('available', context)} ${productModel!.choiceOptions![index].title} :',
                                          style: titilliumRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge)),
                                      const SizedBox(
                                          width:
                                              Dimensions.paddingSizeExtraSmall),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 6,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5,
                                              childAspectRatio: (1 / .7),
                                            ),
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: productModel!
                                                .choiceOptions![index]
                                                .options!
                                                .length,
                                            itemBuilder: (context, i) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: .3,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                      productModel!
                                                          .choiceOptions![index]
                                                          .options![i]
                                                          .trim(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: titilliumRegular
                                                          .copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeDefault,
                                                      )),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ]);
                              },
                            )
                          : const SizedBox(),
                    ]);
              },
            ),
          )
        : const SizedBox();
  }
}
