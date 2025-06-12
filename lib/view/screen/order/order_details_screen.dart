import 'dart:convert';
import 'dart:developer';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/my_dialog.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/shimmer_loading.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/cal_chat_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/cancel_and_support_center.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/ordered_product_list.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/payment_info.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/seller_section.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/shipping_info.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/amount_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/title_row.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/payment/payment_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utill/app_constants.dart';

class OrderDetailsScreen extends StatefulWidget {
  final bool isNotification;
  final int? orderId;
  final String? orderType;
  final double? extraDiscount;
  final String? extraDiscountType;
  const OrderDetailsScreen(
      {Key? key,
      required this.orderId,
      required this.orderType,
      this.extraDiscount,
      this.extraDiscountType,
      this.isNotification = false})
      : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late Razorpay _razorpay;
  bool paymentSucess = false;

  void _loadData(BuildContext context) async {
    await Provider.of<OrderProvider>(Get.context!, listen: false)
        .initTrackingInfo(widget.orderId.toString());
    await Provider.of<OrderProvider>(Get.context!, listen: false)
        .getOrderFromOrderId(widget.orderId.toString());
    await Provider.of<OrderProvider>(Get.context!, listen: false)
        .getOrderDetails(
      widget.orderId.toString(),
      Provider.of<LocalizationProvider>(Get.context!, listen: false)
          .locale
          .countryCode,
    );
  }

  String? pId;

  @override
  void initState() {
    super.initState();
    _loadData(context);
    Provider.of<OrderProvider>(context, listen: false).digitalOnly(true);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log('Success Response:  $response');
    await updateOrderPaymentDetails(
      widget.orderId.toString(),
      response.paymentId ?? '',
    );
    Fluttertoast.showToast(
        msg: "SUCCESS: ${response.paymentId}", toastLength: Toast.LENGTH_SHORT);
    paymentSucess = true;
    _loadData(context);
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (_) => const DashBoardScreen()),
    //     (route) => false);

    // showAnimatedDialog(
    //     context,
    //     MyDialog(
    //       icon: Icons.done,
    //       title: getTranslated('payment_done', context),
    //       description: getTranslated('your_payment_successfully_done', context),
    //     ),
    //     dismissible: false,
    //     isFlip: true);
    print("anjali plan id__________${pId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log('Error Response: ${response.code} - ${response.message}');
    paymentSucess = false;
    Fluttertoast.showToast(
      msg: "ERROR: ${response.code} - ${response.message}",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log('External SDK Response:  $response');
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName}",
        toastLength: Toast.LENGTH_SHORT);
  }

  Future<void> openRazorpay(String? amount) async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': double.parse(amount ?? '0.0').toInt() * 100,
      'description': 'Townway',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error--------: ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.isNotification
            ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const DashBoardScreen()))
            : Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorResources.getIconBg(context),
        appBar: AppBar(
            iconTheme:
                IconThemeData(color: ColorResources.getTextTitle(context)),
            backgroundColor: Theme.of(context).cardColor,
            leading: InkWell(
                onTap: () {
                  widget.isNotification
                      ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const DashBoardScreen()))
                      : Navigator.pop(context);
                },
                child: const Icon(Icons.keyboard_backspace)),
            title: Text(
              getTranslated('ORDER_DETAILS', context)!,
              style: robotoRegular.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: Dimensions.fontSizeLarge),
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer<OrderProvider>(
                builder: (context, orderProvider, child) {
                  double order = 0;
                  double discount = 0;
                  double? eeDiscount = 0;
                  double tax = 0;

                  if (orderProvider.orderDetails != null) {
                    for (var orderDetails in orderProvider.orderDetails!) {
                      if (orderDetails.productDetails?.productType != null &&
                          orderDetails.productDetails!.productType !=
                              "physical") {
                        orderProvider.digitalOnly(false, isUpdate: false);
                      }
                    }

                    for (var orderDetails in orderProvider.orderDetails!) {
                      if (kDebugMode) {
                        print('---> ${orderDetails.taxModel}');
                      }
                      order = order + (orderDetails.price! * orderDetails.qty!);
                      discount = discount + orderDetails.discount!;
                      tax = tax + orderDetails.tax!;
                    }

                    if (widget.orderType == 'POS') {
                      if (widget.extraDiscountType == 'percent') {
                        eeDiscount = order * (widget.extraDiscount! / 100);
                      } else {
                        eeDiscount = widget.extraDiscount;
                      }
                    }
                  }

                  return orderProvider.orderDetails != null
                      ? ListView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          children: [
                            const SizedBox(
                              height: Dimensions.paddingSizeDefault,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: Dimensions.paddingSizeDefault,
                                  horizontal: Dimensions.paddingSizeSmall),
                              child: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: getTranslated(
                                                'ORDER_ID', context),
                                            style: titilliumRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .color,
                                            )),
                                        TextSpan(
                                            text: orderProvider
                                                .trackingModel!.id
                                                .toString(),
                                            style: titilliumRegular.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge,
                                                color:
                                                    ColorResources.getPrimary(
                                                        context))),
                                      ],
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                      DateConverter.localDateToIsoStringAMPM(
                                          DateTime.parse(orderProvider
                                              .trackingModel!.createdAt!)),
                                      style: titilliumRegular.copyWith(
                                          color:
                                              ColorResources.getHint(context),
                                          fontSize: Dimensions.fontSizeSmall)),
                                ],
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.all(
                                  Dimensions.marginSizeSmall),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).highlightColor),
                              child: Column(
                                children: [
                                  widget.orderType == 'POS'
                                      ? Text(
                                          getTranslated('pos_order', context)!)
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                              orderProvider.onlyDigital
                                                  ? Text(
                                                      '${getTranslated('SHIPPING_TO', context)} : ',
                                                      style: titilliumRegular
                                                          .copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeDefault))
                                                  : const SizedBox(),
                                              orderProvider.onlyDigital
                                                  ? Expanded(
                                                      child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 1),
                                                      child: Text(
                                                          ' ${orderProvider.orderModel != null && orderProvider.orderModel!.shippingAddressData != null ? orderProvider.orderModel!.shippingAddressData!.address : ''} , ${orderProvider.orderModel != null && orderProvider.orderModel!.shippingAddressData != null ? orderProvider.orderModel!.shippingAddressData!.city : ''}, ${orderProvider.orderModel != null && orderProvider.orderModel!.shippingAddressData != null && orderProvider.orderModel!.shippingAddressData!.country == 'IN' ? 'India' : ''}',
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: titilliumRegular
                                                              .copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeSmall)),
                                                    ))
                                                  : const SizedBox(),
                                            ]),
                                  // SizedBox(
                                  //     height: orderProvider.onlyDigital
                                  //         ? Dimensions.paddingSizeLarge
                                  //         : 0),
                                  // orderProvider.orderModel != null &&
                                  //         orderProvider.orderModel!
                                  //                 .billingAddressData !=
                                  //             null
                                  //     ? Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.start,
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           Text(
                                  //               '${getTranslated('billing_address', context)} :',
                                  //               style:
                                  //                   titilliumRegular.copyWith(
                                  //                       fontSize: Dimensions
                                  //                           .fontSizeDefault)),
                                  //           Expanded(
                                  //               child: Padding(
                                  //             padding:
                                  //                 const EdgeInsets.symmetric(
                                  //                     vertical: 1),
                                  //             child: Text(
                                  //                 ' ${orderProvider.orderModel!.billingAddressData != null ? orderProvider.orderModel!.billingAddressData!.address : ''}',
                                  //                 maxLines: 3,
                                  //                 overflow:
                                  //                     TextOverflow.ellipsis,
                                  //                 style:
                                  //                     titilliumRegular.copyWith(
                                  //                         fontSize: Dimensions
                                  //                             .fontSizeSmall)),
                                  //           )),
                                  //         ],
                                  //       )
                                  //     : const SizedBox(),
                                ],
                              ),
                            ),

                            orderProvider.orderModel != null &&
                                    orderProvider.orderModel!.orderNote != null
                                ? Padding(
                                    padding: const EdgeInsets.all(
                                        Dimensions.marginSizeSmall),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text:
                                                  '${getTranslated('order_note', context)} : ',
                                              style: robotoBold.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                  color: ColorResources
                                                      .getReviewRattingColor(
                                                          context))),
                                          TextSpan(
                                              text: orderProvider.orderModel!
                                                          .orderNote !=
                                                      null
                                                  ? orderProvider.orderModel!
                                                          .orderNote ??
                                                      ''
                                                  : "",
                                              style: titilliumRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeSmall)),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(height: Dimensions.paddingSizeSmall),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault,
                                  vertical: Dimensions.paddingSizeDefault),
                              child: Text(
                                  getTranslated('ORDERED_PRODUCT', context)!,
                                  style: titilliumSemiBold.copyWith()),
                            ),

                            SellerSection(order: orderProvider),

                            OrderProductList(
                                order: orderProvider,
                                orderType: widget.orderType),

                            const SizedBox(
                                height: Dimensions.marginSizeDefault),

                            // Amounts
                            Container(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeSmall),
                              color: Theme.of(context).highlightColor,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical:
                                              Dimensions.paddingSizeSmall),
                                      child: TitleRow(
                                          title:
                                              getTranslated('TOTAL', context)),
                                    ),
                                    AmountWidget(
                                        title: getTranslated('ORDER', context),
                                        amount: PriceConverter.convertPrice(
                                            context, order)),
                                    widget.orderType == "POS"
                                        ? const SizedBox()
                                        : AmountWidget(
                                            title: getTranslated(
                                                'SHIPPING_FEE', context),
                                            amount: PriceConverter.convertPrice(
                                                context,
                                                orderProvider.trackingModel!
                                                    .shippingCost)),
                                    AmountWidget(
                                        title:
                                            getTranslated('DISCOUNT', context),
                                        amount: PriceConverter.convertPrice(
                                            context, discount)),
                                    widget.orderType == "POS"
                                        ? AmountWidget(
                                            title: getTranslated(
                                                'EXTRA_DISCOUNT', context),
                                            amount: PriceConverter.convertPrice(
                                                context, eeDiscount))
                                        : const SizedBox(),
                                    AmountWidget(
                                      title: getTranslated(
                                          'coupon_voucher', context),
                                      amount: PriceConverter.convertPrice(
                                          context,
                                          orderProvider
                                              .trackingModel!.discountAmount),
                                    ),
                                    AmountWidget(
                                        title: getTranslated('TAX', context),
                                        amount: PriceConverter.convertPrice(
                                            context, tax)),
                                    AmountWidget(
                                        title: "Other City Shipping:",
                                        amount: PriceConverter.convertPrice(
                                            context,
                                            orderProvider.trackingModel!
                                                    .otherCityShippingCost ??
                                                0)),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              Dimensions.paddingSizeExtraSmall),
                                      child: Divider(
                                          height: 2,
                                          color: ColorResources.hintTextColor),
                                    ),
                                    AmountWidget(
                                      title: getTranslated(
                                          'TOTAL_PAYABLE', context),
                                      amount: PriceConverter.convertPrice(
                                          context,
                                          (order +
                                              orderProvider.trackingModel!
                                                  .shippingCost! -
                                              eeDiscount! -
                                              orderProvider.trackingModel!
                                                  .discountAmount! -
                                              discount +
                                              tax +
                                              (orderProvider.trackingModel!
                                                      .otherCityShippingCost ??
                                                  0))),
                                    ),
                                  ]),
                            ),

                            const SizedBox(
                              height: Dimensions.paddingSizeSmall,
                            ),

                            orderProvider.trackingModel!.deliveryMan != null
                                ? Container(
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeDefault),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).highlightColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context)
                                                .hintColor
                                                .withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 10)
                                      ],
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${getTranslated('shipping_info', context)}',
                                              style: robotoBold),
                                          const SizedBox(
                                              height: Dimensions
                                                  .marginSizeExtraSmall),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    '${getTranslated('delivery_man', context)} : ',
                                                    style: titilliumRegular
                                                        .copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeSmall)),
                                                Text(
                                                  (orderProvider.trackingModel!
                                                              .deliveryMan !=
                                                          null)
                                                      ? '${orderProvider.trackingModel!.deliveryMan!.fName} ${orderProvider.trackingModel!.deliveryMan!.lName}'
                                                      : '',
                                                  style:
                                                      titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeSmall),
                                                ),
                                              ]),
                                          const SizedBox(
                                              height: Dimensions
                                                  .paddingSizeDefault),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CallAndChatWidget(
                                                  orderProvider: orderProvider,
                                                  orderModel: orderProvider
                                                      .trackingModel),
                                            ],
                                          )
                                        ]),
                                  )
                                :
                                //third party
                                orderProvider.trackingModel!
                                            .thirdPartyServiceName !=
                                        null
                                    ? ShippingInfo(order: orderProvider)
                                    : const SizedBox(),

                            const SizedBox(
                                height: Dimensions.paddingSizeDefault),

                            // Payment
                            PaymentInfo(order: orderProvider),

                            const SizedBox(height: Dimensions.paddingSizeSmall),

                            orderProvider.trackingModel!.paymentStatus ==
                                    'unpaid'
                                ? Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 20),
                                    child: CustomButton(
                                      buttonText:
                                          getTranslated('pay_now', context),
                                      onTap: () {
                                        openRazorpay(orderProvider
                                            .trackingModel?.orderAmount
                                            .toString());
                                      },
                                    ),
                                    // child: CustomButton(
                                    //     buttonText:
                                    //         getTranslated('pay_now', context),
                                    //     onTap: () async {
                                    //       String userID = await Provider.of<
                                    //                   ProfileProvider>(context,
                                    //               listen: false)
                                    //           .getUserInfo(context);
                                    //       Navigator.pushReplacement(
                                    //           Get.context!,
                                    //           MaterialPageRoute(
                                    //               builder: (_) => PaymentScreen(
                                    //                     customerID: userID,
                                    //                     addressID: orderProvider
                                    //                         .orderModel!
                                    //                         .shippingAddressData!
                                    //                         .id
                                    //                         .toString(),
                                    //
                                    //                     //  Provider.of<
                                    //                     //             ProfileProvider>(
                                    //                     //         context,
                                    //                     //         listen: false)
                                    //                     //     .addressList[Provider.of<
                                    //                     //                 OrderProvider>(
                                    //                     //             context,
                                    //                     //             listen:
                                    //                     //                 false)
                                    //                     //         .addressIndex!]
                                    //                     //     .id
                                    //                     //     .toString(),
                                    //                     couponCode: "",
                                    //                     couponCodeAmount: "0",
                                    //                     billingId: orderProvider
                                    //                         .orderModel!
                                    //                         .billingAddressData!
                                    //                         .id
                                    //                         .toString(),
                                    //                     // _billingAddress
                                    //                     //     ? Provider.of<
                                    //                     //                 ProfileProvider>(
                                    //                     //             context,
                                    //                     //             listen:
                                    //                     //                 false)
                                    //                     //         .billingAddressList[Provider.of<OrderProvider>(
                                    //                     //                 context,
                                    //                     //                 listen:
                                    //                     //                     false)
                                    //                     //             .billingAddressIndex!]
                                    //                     //         .id
                                    //                     //         .toString()
                                    //                     //     : widget
                                    //                     //             .onlyDigital
                                    //                     //         ? ''
                                    //                     //         :
                                    //                     orderNote: "",
                                    //                     paymentMethod:
                                    //                         "razor_pay",
                                    //                   )));
                                    //     }
                                    //
                                    //     // => Provider.of<OrderProvider>(
                                    //     //             context,
                                    //     //             listen: false)
                                    //     //         .cancelOrder(
                                    //     //             context, orderModel!.id)
                                    //     //         .then((value) {
                                    //     //       if (value.response!.statusCode ==
                                    //     //           200) {
                                    //     //         Provider.of<OrderProvider>(context,
                                    //     //                 listen: false)
                                    //     //             .initOrderList(context);
                                    //     //         Navigator.pop(context);
                                    //     //         ScaffoldMessenger.of(context)
                                    //     //             .showSnackBar(SnackBar(
                                    //     //           content: Text(getTranslated(
                                    //     //               'order_cancelled_successfully',
                                    //     //               context)!),
                                    //     //           backgroundColor: Colors.green,
                                    //     //         ));
                                    //     //       }
                                    //     //     })
                                    //
                                    //     ),
                                  )
                                : Container(),

                            CancelAndSupport(
                                orderModel: orderProvider.orderModel),
                          ],
                        )
                      : const LoadingPage();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> updateOrderPaymentDetails(
      String orderId, String transactionRef) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstants.token);
    http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${AppConstants.baseUrl}/api/v1/customer/order/payment-option'));
    request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});

    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'payment_method': 'razor_pay',
      'transaction_ref': transactionRef.toString(),
      'order_id': orderId
    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);

      return true;
    } else {
      return false;
    }
  }
}
