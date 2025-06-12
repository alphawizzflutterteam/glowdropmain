import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/order_details.dart';
import 'package:flutter_sixvalley_ecommerce/downloads_path_provider_28.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_details_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/cart/cart_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/refunded_status_bottom_sheet.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/review_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/widget/refund_request_bottom_sheet.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utill/app_constants.dart';

class OrderDetailsWidget extends StatefulWidget {
  final OrderDetailsModel orderDetailsModel;
  final String orderType;
  final String paymentStatus;
  final Function callback;
  const OrderDetailsWidget(
      {Key? key,
      required this.orderDetailsModel,
      required this.callback,
      required this.orderType,
      required this.paymentStatus})
      : super(key: key);

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // setState((){ });
    });
    // FlutterDownloader.registerCallback(downloadCallback as DownloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          const SizedBox(height: Dimensions.paddingSizeLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  fit: BoxFit.scaleDown,
                  width: 60,
                  height: 60,
                  image:
                      '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productThumbnailUrl}/${widget.orderDetailsModel.productDetails?.thumbnail}',
                  imageErrorBuilder: (c, o, s) => Image.asset(
                      Images.placeholder,
                      fit: BoxFit.scaleDown,
                      width: 50,
                      height: 50),
                ),
              ),
              const SizedBox(width: Dimensions.marginSizeDefault),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.orderDetailsModel.productDetails?.name ?? '',
                            style: titilliumSemiBold.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).hintColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Provider.of<OrderProvider>(context).orderTypeIndex ==
                                    1 &&
                                widget.orderType != "POS"
                            ? InkWell(
                                onTap: () {
                                  if (Provider.of<OrderProvider>(context,
                                              listen: false)
                                          .orderTypeIndex ==
                                      1) {
                                    Provider.of<ProductDetailsProvider>(context,
                                            listen: false)
                                        .removeData();
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => ReviewBottomSheet(
                                            productID: widget.orderDetailsModel
                                                .productDetails!.id
                                                .toString(),
                                            callback: widget.callback));
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: Dimensions.paddingSizeSmall),
                                  padding: const EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.paddingSizeExtraSmall,
                                      horizontal: Dimensions.paddingSizeSmall),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.paddingSizeDefault),
                                    border: Border.all(
                                        width: 1,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  child: Text(getTranslated('review', context)!,
                                      style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.fontSizeExtraSmall,
                                        color: ColorResources.getTextTitle(
                                            context),
                                      )),
                                ),
                              )
                            : const SizedBox.shrink(),
                        Consumer<OrderProvider>(builder: (context, refund, _) {
                          return refund.orderTypeIndex == 1 &&
                                  widget.orderDetailsModel.refundReq == 0 &&
                                  widget.orderType != "POS"
                              ? InkWell(
                                  onTap: () {
                                    Provider.of<ProductDetailsProvider>(context,
                                            listen: false)
                                        .removeData();
                                    refund
                                        .getRefundReqInfo(
                                            widget.orderDetailsModel.id)
                                        .then((value) {
                                      if (value.response!.statusCode == 200) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    RefundBottomSheet(
                                                        product: widget
                                                            .orderDetailsModel
                                                            .productDetails,
                                                        orderDetailsId: widget
                                                            .orderDetailsModel
                                                            .id)));
                                      }
                                    });
                                  },
                                  child: refund.isRefund
                                      ? Center(
                                          child: CircularProgressIndicator(
                                              color: Theme.of(context)
                                                  .primaryColor))
                                      : Container(
                                          margin: const EdgeInsets.only(
                                              left:
                                                  Dimensions.paddingSizeSmall),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: Dimensions
                                                  .paddingSizeExtraSmall,
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          decoration: BoxDecoration(
                                            color: ColorResources.getPrimary(
                                                context),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.paddingSizeDefault),
                                          ),
                                          child: Text(
                                              getTranslated(
                                                  'refund_request', context)!,
                                              style: titilliumRegular.copyWith(
                                                fontSize: Dimensions
                                                    .fontSizeExtraSmall,
                                                color: Theme.of(context)
                                                    .highlightColor,
                                              )),
                                        ),
                                )
                              : const SizedBox();
                        }),
                        Consumer<OrderProvider>(builder: (context, refund, _) {
                          return (Provider.of<OrderProvider>(context)
                                          .orderTypeIndex ==
                                      1 &&
                                  widget.orderDetailsModel.refundReq != 0 &&
                                  widget.orderType != "POS")
                              ? InkWell(
                                  onTap: () {
                                    Provider.of<ProductDetailsProvider>(context,
                                            listen: false)
                                        .removeData();
                                    refund
                                        .getRefundReqInfo(
                                            widget.orderDetailsModel.id)
                                        .then((value) {
                                      if (value.response!.statusCode == 200) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    RefundResultBottomSheet(
                                                        product:
                                                            widget
                                                                .orderDetailsModel
                                                                .productDetails,
                                                        orderDetailsId: widget
                                                            .orderDetailsModel
                                                            .id,
                                                        orderDetailsModel: widget
                                                            .orderDetailsModel)));
                                      }
                                    });
                                  },
                                  child: refund.isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(
                                              color: Theme.of(context)
                                                  .primaryColor))
                                      : Container(
                                          margin: const EdgeInsets.only(
                                              left:
                                                  Dimensions.paddingSizeSmall),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: Dimensions
                                                  .paddingSizeExtraSmall,
                                              horizontal:
                                                  Dimensions.paddingSizeSmall),
                                          decoration: BoxDecoration(
                                            color: ColorResources.getPrimary(
                                                context),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.paddingSizeDefault),
                                          ),
                                          child: Text(
                                              getTranslated('refund_status_btn',
                                                  context)!,
                                              style: titilliumRegular.copyWith(
                                                fontSize: Dimensions
                                                    .fontSizeExtraSmall,
                                                color: Theme.of(context)
                                                    .highlightColor,
                                              )),
                                        ),
                                )
                              : const SizedBox();
                        }),
                      ],
                    ),
                    const SizedBox(height: Dimensions.marginSizeExtraSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          PriceConverter.convertPrice(
                              context, widget.orderDetailsModel.price),
                          style: titilliumSemiBold.copyWith(
                              color: ColorResources.getPrimary(context)),
                        ),
                        Text('x${widget.orderDetailsModel.qty}',
                            style: titilliumSemiBold.copyWith(
                                color: ColorResources.getPrimary(context))),
                        widget.orderDetailsModel.discount! > 0
                            ? Container(
                                height: 20,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.paddingSizeExtraSmall),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: ColorResources.getPrimary(
                                            context))),
                                child: Text(
                                  PriceConverter.percentageCalculation(
                                      context,
                                      (widget.orderDetailsModel.price! *
                                          widget.orderDetailsModel.qty!),
                                      widget.orderDetailsModel.discount,
                                      'amount'),
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.fontSizeExtraSmall,
                                      color:
                                          ColorResources.getPrimary(context)),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          (widget.orderDetailsModel.variant != null &&
                  widget.orderDetailsModel.variant!.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.paddingSizeSmall,
                      top: Dimensions.paddingSizeExtraSmall),
                  child: Row(children: [
                    const SizedBox(width: 65),
                    Text('${getTranslated('variations', context)}: ',
                        style: titilliumSemiBold.copyWith(
                            fontSize: Dimensions.fontSizeSmall)),
                    Flexible(
                        child: Text(widget.orderDetailsModel.variant!,
                            style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor,
                            ))),
                  ]),
                )
              : const SizedBox(),

          SizedBox(
            height: 50,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.orderDetailsModel.deliveryStatus == 'delivered')
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      String downloadUrl =
                          "${AppConstants.baseUrl}/api/v1/auth/generate_invoice/${widget.orderDetailsModel.orderId}";
                      if (await canLaunch(downloadUrl)) {
                        await launch(downloadUrl);
                      } else {
                        throw 'Could not launch $downloadUrl';
                      }
                    },
                    // onTap: () async {
                    //   String apiUrl =
                    //       'https://townway.alphawizzserver.com/api/v1/customer/order/generate-invoice/${widget.orderDetailsModel.orderId}';
                    //   String fileName =
                    //       'invoice_${widget.orderDetailsModel.orderId}';
                    //   await savePdfFromApi(apiUrl, fileName);
                    // },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Download Invoice",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              SizedBox(width: 10), // Space between buttons

              Expanded(
                child: InkWell(
                  onTap: () async {
                    _reorder();
                  },
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Re Order",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ),

              SizedBox(width: 10), // Space between buttons

              // Expanded(
              //   child: InkWell(
              //     onTap: () {
              //       // Implement Pay Now logic
              //     },
              //     child: Container(
              //       padding: EdgeInsets.symmetric(vertical: 12),
              //       alignment: Alignment.center,
              //       decoration: BoxDecoration(
              //         color: Colors.blue,
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       child: Text(
              //         "Pay Now",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 16,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     widget.orderDetailsModel.deliveryStatus == 'delivered'
          //         ? InkWell(
          //             onTap: () async {
          //               String apiUrl =
          //                   'https://townway.alphawizzserver.com/api/v1/customer/order/generate-invoice/${widget.orderDetailsModel.orderId}';
          //               String fileName =
          //                   'invoice_${widget.orderDetailsModel.orderId}';
          //
          //               await savePdfFromApi(apiUrl, fileName);
          //             },
          //             child: Container(
          //               padding:
          //                   EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          //               decoration: BoxDecoration(
          //                 color: Colors.blue,
          //                 borderRadius: BorderRadius.circular(8),
          //               ),
          //               child: Text(
          //                 "Download Invoice",
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ),
          //           )
          //         : SizedBox(),
          //     InkWell(
          //       onTap: () async {
          //         _reorder();
          //         //
          //         // String apiUrl =
          //         //     'https://townway.alphawizzserver.com/api/v1/customer/order/generate-invoice/${widget.orderDetailsModel.orderId}';
          //         // String fileName =
          //         //     'invoice_${widget.orderDetailsModel.orderId}';
          //         //
          //         // await savePdfFromApi(apiUrl, fileName);
          //         //
          //       },
          //       child: _isLoading == true
          //           ? CircularProgressIndicator()
          //           : Container(
          //               padding:
          //                   EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          //               decoration: BoxDecoration(
          //                 color: Colors.blue,
          //                 borderRadius: BorderRadius.circular(8),
          //               ),
          //               child: Text(
          //                 "Re Order",
          //                 style: TextStyle(
          //                   color: Colors.white, // Text color
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ),
          //     )
          //   ],
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 75, right: 75, top: 5),
          //   child: Row(
          //     children: [
          //       Text(
          //           '${getTranslated('tax', context)} ${widget.orderDetailsModel.productDetails!.taxModel}(${widget.orderDetailsModel.tax})'),
          //     ],
          //   ),
          // ),
          SizedBox(
              height: (widget.orderDetailsModel.productDetails != null &&
                      widget.orderDetailsModel.productDetails?.productType ==
                          'digital' &&
                      widget.paymentStatus == 'paid')
                  ? Dimensions.paddingSizeExtraLarge
                  : 0),
          widget.orderDetailsModel.productDetails?.productType == 'digital' &&
                  widget.paymentStatus == 'paid'
              ? Consumer<OrderProvider>(builder: (context, orderProvider, _) {
                  return InkWell(
                    onTap: () async {
                      if (widget.orderDetailsModel.productDetails!
                                  .digitalProductType ==
                              'ready_after_sell' &&
                          widget.orderDetailsModel.digitalFileAfterSell ==
                              null) {
                        Fluttertoast.showToast(
                            msg: getTranslated(
                                'product_not_uploaded_yet', context)!,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: Dimensions.fontSizeDefault);
                      } else {
                        if (kDebugMode) {
                          print(
                              'ios url click=====>${'${Provider.of<SplashProvider>(context, listen: false).baseUrls!.digitalProductUrl}/${widget.orderDetailsModel.digitalFileAfterSell}'}');
                        }
                        final status = await Permission.storage.request();
                        if (status.isGranted) {
                          Directory? directory =
                              Directory('/storage/emulated/0/Download');
                          if (!await directory.exists()) {
                            directory = Platform.isAndroid
                                ? await getExternalStorageDirectory()
                                : await getApplicationSupportDirectory();
                          }
                          orderProvider.downloadFile(
                              widget.orderDetailsModel.productDetails!
                                          .digitalProductType ==
                                      'ready_after_sell'
                                  ? '${Provider.of<SplashProvider>(Get.context!, listen: false).baseUrls!.digitalProductUrl}/${widget.orderDetailsModel.digitalFileAfterSell}'
                                  : '${Provider.of<SplashProvider>(Get.context!, listen: false).baseUrls!.digitalProductUrl}/${widget.orderDetailsModel.productDetails!.digitalFileReady}',
                              directory!.path);
                        } else {
                          if (kDebugMode) {
                            print('=====permission denied=====');
                          }
                        }
                      }
                    },
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.only(left: 5),
                      height: 38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.fontSizeExtraSmall),
                          color: Theme.of(context).primaryColor),
                      alignment: Alignment.center,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${getTranslated('download', context)}',
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).cardColor),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeSmall),
                          SizedBox(
                              width: Dimensions.iconSizeDefault,
                              child: Image.asset(
                                Images.fileDownload,
                                color: Theme.of(context).cardColor,
                              ))
                        ],
                      )),
                    ),
                  );
                })
              : const SizedBox(),
          const SizedBox(height: Dimensions.paddingSizeLarge),
        ],
      ),
    );
  }

  // Future getDownloadInvoiceLink() async {
  //   try {
  //     var token =
  //         Provider.of<AuthProvider>(context, listen: false).getUserToken();
  //     Response response = await get(
  //         Uri.parse(
  //             "https://townway.alphawizzserver.com/api/v1/customer/order/generate-invoice/100028"),
  //         headers: {'Authorization': 'Bearer $token'}).timeout(
  //       Duration(seconds: 10),
  //     );
  //     print(response.body);
  //     var getdata = json.decode(response.body);
  //     bool? error = getdata["error"];
  //     String? msg = getdata["message"];

  //     print(getdata);

  //     // if(widget.checkForgot == "false"){

  //     if (msg!.contains('Successfully')) {
  //       String otp = getdata['otp'].toString();
  //       // setSnackbar(otp.toString());
  //       // Fluttertoast.showToast(msg: otp.toString(),
  //       //     backgroundColor: colors.primary
  //       // );
  //       print("OTP : " + otp);

  //       showCustomSnackBar(msg!, context);
  //       // settingsProvider.setPrefrence(MOBILE, mobile!);
  //       // settingsProvider.setPrefrence(COUNTRY_CODE, countrycode!);
  //     } else {
  //       showCustomSnackBar(msg!, context);
  //     }
  //   } on TimeoutException catch (_) {
  //     showCustomSnackBar("Something went wrong", context);
  //   }
  // }

  Future<void> savePdfFromApi(String apiUrl, String fileName) async {
    try {
      var token =
          Provider.of<AuthProvider>(context, listen: false).getUserToken();
      print(token);
      final plugin = DeviceInfoPlugin();
      final android = await plugin.androidInfo;
      final storageStatus = await Permission.manageExternalStorage.request();

      if (storageStatus == PermissionStatus.granted) {
        print("granted");
      }
      if (storageStatus == PermissionStatus.denied) {
        print("denied");
      }
      if (storageStatus == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
      if (Platform.isAndroid) {
        if (!storageStatus.isGranted) {
          throw Exception('Storage permission is required to save the file.');
        }
      }
      Dio dio = Dio();
      final response = await dio.get(
        apiUrl,
        options: Options(
          responseType: ResponseType.bytes, // Ensure the response is in binary
          headers: {
            'Authorization': 'Bearer $token', // Add Authorization header
          },
        ),
      );

      // Get the application directory for saving the file
      //final directory = await DownloadsPathProvider.downloadsDirectory;
      // final filePath = '${downloadsDir?.path}/$fileName.pdf';

      final Directory? downloadsDir = await getDownloadsDirectory();
      final filePath = '${downloadsDir?.path}/$fileName.pdf';

      // final filePath = '/storage/emulated/0/Download/$fileName.pdf';

      // Write the file to the specified path
      final file = File(filePath);
      await file.writeAsBytes(response.data);

      print(file);
      showCustomSnackBar('File downloaded Successfully', context);
    } catch (e) {
      print('Error saving PDF: $e');
      showCustomSnackBar('$e', context);
    }
  }

  bool _isLoading = false;
  final Dio _dio = Dio();

  Future<void> _reorder() async {
    setState(() {
      _isLoading = true;
    });

    var token =
        Provider.of<AuthProvider>(context, listen: false).getUserToken();

    String url =
        "https://townway.alphawizzserver.com/api/v1/customer/order/re-order/${widget.orderDetailsModel.orderId}";

    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Add Authorization header
          },
        ),
      );

      if (response.statusCode == 200) {
        // Assuming success response

        String? message = response.data['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message ?? "")),
        );

        if (!message.toString().toLowerCase().contains("out of stock")) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CartScreen(
                        fromWhere: true,
                        fromCheckout: false,
                      )));
        }
      } else {
        // Handle unexpected server responses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to reorder: ${response.statusMessage}')),
        );
      }
    } catch (e) {
      // Handle network or other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
