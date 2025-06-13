import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/order_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/order_details_screen.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel? orderModel;
  const OrderWidget({Key? key, this.orderModel}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => OrderDetailsScreen(
  //               orderId: orderModel!.id,
  //               orderType: orderModel!.orderType,
  //               extraDiscount: orderModel!.extraDiscount,
  //               extraDiscountType: orderModel!.extraDiscountType)));
  //     },
  //     child: Container(
  //       margin: const EdgeInsets.only(
  //           bottom: Dimensions.paddingSizeSmall,
  //           left: Dimensions.paddingSizeSmall,
  //           right: Dimensions.paddingSizeSmall),
  //       padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
  //       decoration: BoxDecoration(
  //           color: Theme.of(context).cardColor,
  //           borderRadius: BorderRadius.circular(6),
  //           border: Border.all(color: ColorResources.primary)),
  //       child: Padding(
  //         padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
  //         child: Row(children: [
  //           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //             Row(children: [
  //               Text(getTranslated('ORDER_ID', context)!,
  //                   style: titilliumRegular.copyWith(
  //                       fontSize: Dimensions.fontSizeSmall)),
  //               const SizedBox(width: Dimensions.paddingSizeSmall),
  //               Text(orderModel!.id.toString(), style: titilliumSemiBold),
  //             ]),
  //             const SizedBox(height: Dimensions.paddingSizeSmall),
  //             Row(children: [
  //               Text(
  //                   DateConverter.localDateToIsoStringAMPM(
  //                       DateTime.parse(orderModel!.createdAt!)),
  //                   style: titilliumRegular.copyWith(
  //                     fontSize: Dimensions.fontSizeSmall,
  //                     color: Theme.of(context).hintColor,
  //                   )),
  //             ]),
  //           ]),
  //           const SizedBox(width: Dimensions.paddingSizeLarge),
  //           Expanded(
  //             child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(getTranslated('total_price', context)!,
  //                       style: titilliumRegular.copyWith(
  //                           fontSize: Dimensions.fontSizeSmall)),
  //                   const SizedBox(height: Dimensions.paddingSizeSmall),
  //                   Text(
  //                       PriceConverter.convertPrice(
  //                           context, orderModel!.orderAmount),
  //                       style: titilliumSemiBold),
  //                 ]),
  //           ),
  //           Container(
  //             alignment: Alignment.center,
  //             padding: const EdgeInsets.symmetric(
  //                 horizontal: Dimensions.paddingSizeSmall,
  //                 vertical: Dimensions.paddingSizeSmall),
  //             decoration: BoxDecoration(
  //               color: ColorResources.getLowGreen(context),
  //               borderRadius: BorderRadius.circular(5),
  //             ),
  //             child: Text(getTranslated('${orderModel!.orderStatus}', context)!,
  //                 style: titilliumSemiBold),
  //           ),
  //         ]),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          bottom: Dimensions.paddingSizeSmall,
          left: Dimensions.paddingSizeSmall,
          right: Dimensions.paddingSizeSmall),
      padding: const EdgeInsets.only(
          left: Dimensions.paddingSizeSmall,
          top: Dimensions.paddingSizeSmall,
          bottom: Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: ColorResources.primary)),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    DateConverter.isoStringToLocalTimeOnly(
                        DateConverter.localDateToIsoString(
                            DateTime.parse(orderModel!.createdAt!))),
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
                Text(
                    DateConverter.localDateToIsoStringAMPM(
                        DateTime.parse(orderModel!.createdAt!)),
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault, vertical: 4),
              decoration: const BoxDecoration(
                  color: Color(0xFFD6E9E9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                  border: Border(
                    top: BorderSide(color: ColorResources.primary, width: 1),
                    left: BorderSide(color: ColorResources.primary, width: 1),
                    bottom: BorderSide(color: ColorResources.primary, width: 1),
                    right: BorderSide(color: ColorResources.primary, width: 0),
                  )
                  // border: Border.all(color: ColorResources.primary, width: 1)
                  ),
              child: Text(
                  PriceConverter.convertPrice(context, orderModel!.orderAmount),
                  style: titilliumSemiBold),
            )
          ],
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${orderModel!.shippingAddressData!.address}",
                  style: titilliumRegular.copyWith(
                      fontSize: Dimensions.fontSizeDefault),
                ),
                const SizedBox(height: 6),
                Text(
                  "05:00pm - 06:00pm",
                  style: titilliumRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Color(0xFF595959)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${orderModel!.orderStatus} Booking".toUpperCase(),
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: ColorResources.primary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "After Service Pay",
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Color(0xFF595959)),
                  ),
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}
