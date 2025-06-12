import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/response/product_model.dart';
import '../../../../data/model/response/today_special_model.dart';
import '../../../../helper/price_converter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../basewidget/rating_bar.dart';
import '../../product/product_details_screen.dart';
class TodaysSpecicalWidget extends StatelessWidget {
 Product  product;
   TodaysSpecicalWidget({Key? key,required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String ratting = product.rating != null && product.rating!.isNotEmpty? product.rating![0].average! : "0";

    return      InkWell(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (context, anim1, anim2) => ProductDetails(productId: product!.id, slug: product!.slug,),
        )
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).highlightColor,
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
          ),
          child: Column(
            children: [
              // const SizedBox(height: Dimensions.paddingSizeSmall),
              // Text(getTranslated('recommended_product', context)!,
              //   style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge,
              //       fontWeight: FontWeight.w600),),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 260,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width-35,
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(Dimensions.paddingSizeExtraSmall),
                              bottomRight: Radius.circular(Dimensions.paddingSizeExtraSmall)),
                          color: Theme.of(context).primaryColor
                      ),
                    ),
                  ),



                  Positioned(
                    left: 15,
                    top: 15,
                    child: Column(
                      children: [
                        Container(width: MediaQuery.of(context).size.width/2.5,
                          height: MediaQuery.of(context).size.width/2.5,
                          decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor,
                              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.20),width: .5),
                              borderRadius: const BorderRadius.all(Radius.circular(5))),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            child: FadeInImage.assetNetwork(
                              placeholder: Images.placeholder, fit: BoxFit.cover,
                              image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productThumbnailUrl}'
                                  '/${product.thumbnail}',
                              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
                            ),
                          ),
                        ),


                        Container(width: MediaQuery.of(context).size.width/2.5,
                            padding: const EdgeInsets.only(left: 2,top: 10),
                            child: Center(
                              child: Text(product.name??'',maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: titilliumRegular.copyWith(color: Theme.of(context).cardColor,
                                      fontSize: Dimensions.fontSizeDefault)),
                            )),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                      left: 30,
                      child:Text(".",style: TextStyle(color:product?.productindicator?.toLowerCase()=="veg" ? Colors.green :Colors.red,fontSize: 50),)
                  ),

                  Positioned(right: 20,top: 0,
                    child: SizedBox(width: MediaQuery.of(context).size.width/2.5,
                      height: MediaQuery.of(context).size.width/2.5,
                      child:
                      Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            // Text(product.name ?? '', textAlign: TextAlign.center,
                            //     style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                            //         fontWeight: FontWeight.w400), maxLines: 2,
                            //     overflow: TextOverflow.ellipsis),


                            // Text('${double.parse(product.reviewCount.toString()).toStringAsFixed(1)} ${getTranslated('out_of_5', context)}',
                            //     style: titilliumBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                            // Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     RatingBar(rating: double.parse(product.reviewCount.toString()), size: 18,),
                            //     Text('(${product.reviewCount.toString()})')
                            //   ],
                            // ),

        const SizedBox(height: Dimensions.paddingSizeExtraExtraSmall),


                            // product.discount!= null && product.discount! > 0 ?
                            // Text(PriceConverter.convertPrice(context, product.unitPrice),
                            //   style: titleRegular.copyWith(
                            //     color: ColorResources.getRed(context),
                            //     decoration: TextDecoration.lineThrough,
                            //
                            //     fontSize: Dimensions.fontSizeExtraSmall,
                            //   ),
                            // ) : const SizedBox.shrink(),
                            // const SizedBox(height: 2,),

                            product != null && product.unitPrice != null?
                            Text(
                              PriceConverter.convertPrice(context, product.unitPrice,
                                  discountType: product.discountType,
                                  discount: product.discount),
                              style: titilliumSemiBold.copyWith(
                                color: ColorResources.getPrimary(context),
                                fontSize: Dimensions.fontSizeExtraLarge,
                              ),
                            ):const SizedBox(),
                            const SizedBox(height: Dimensions.paddingSizeExtraExtraSmall),

                            product!=null && product!.discount!= null && product.discount! > 0  ? Text(
                              PriceConverter.convertPrice(context, product.unitPrice),
                              style: robotoBold.copyWith(
                                color: ColorResources.getRed(context),
                                decoration: TextDecoration.lineThrough,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ) : const SizedBox.shrink(),


                          ],),
                      ),),
                  ),


                  Positioned(
                    right: 40,bottom: 70,
                    child: Container(width: 110,height: 35,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall)),
                        color: Theme.of(context).cardColor.withOpacity(.25),
                      ),
                      child: Center(child: Text(getTranslated('buy_now', context)!,
                        style: TextStyle(color: Theme.of(context).cardColor),)),),
                  ),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
