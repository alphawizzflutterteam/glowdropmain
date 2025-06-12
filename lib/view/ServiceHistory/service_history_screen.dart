import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/service_history_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/plans_model.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/plan_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/view/ServiceHistory/service_history_detail_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class ServiceHistoryScreen extends StatefulWidget {
  bool? isBackButton;
  // MyPlansScreen({super.key});
  ServiceHistoryScreen({Key? key, this.isBackButton}) : super(key: key);
  @override
  State<ServiceHistoryScreen> createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends State<ServiceHistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PlanProvider>(context, listen: false).initServiceHistoryList(
      context,
    );
  }

  // String _formatDate(String date) {
  //   if (date == null) return 'Select Date';
  //   return DateFormat('dd/MM/yyyy').format(date!);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: CustomAppBar(
            title: "My Services",
            isBackButtonExist: widget.isBackButton ?? true,
            isSkip: false,
          )),
      body: SingleChildScrollView(
        child: InkWell(
            onTap: () {},
            child: Consumer<PlanProvider>(
                builder: (context, orderProvider, child) {
              for (var i = 0; i < orderProvider.serviceList.length; i++) {
                if (orderProvider.serviceList[i].reScheduleUserStatus == '1') {
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    await showDialog(
                      context: context,
                      barrierDismissible:
                          false, // Disable dismissing the popup without action
                      builder: (context) => RescheduleServicePopup(
                        serviceHistoryData: orderProvider.serviceList[i],
                      ),
                    );
                  });
                }
              }
              return Provider.of<PlanProvider>(context).isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : orderProvider.serviceList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(16),
                          itemCount: orderProvider.serviceList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ServiceHistoryDetailScreen(
                                              serviceHistoryData: orderProvider
                                                  .serviceList[index],
                                            )));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              orderProvider.serviceList[index]
                                                      .service?.name ??
                                                  '',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.date_range,
                                                  color: Colors.purple,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  orderProvider
                                                          .serviceList[index]
                                                          .bookingDatetime
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Divider(color: Colors.grey[300]),
                                        // SizedBox(height: 8),
                                        // Row(
                                        //   children: [
                                        //     Icon(Icons.timer,
                                        //         size: 16, color: Colors.blue),
                                        //     SizedBox(width: 8),
                                        //     Text(
                                        //       'Completed in 45 minutes',
                                        //       style: TextStyle(
                                        //         fontSize: 14,
                                        //         color: Colors.grey[700],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.payment,
                                                    size: 20,
                                                    color: Colors.green),
                                                SizedBox(width: 8),
                                                Text(
                                                  "₹${orderProvider.serviceList[index].paidAmount.toString() ?? ''}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.timelapse_rounded,
                                                  color: Colors.red,
                                                ),
                                                // Text('Seller : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                                Text(
                                                    ' ${orderProvider.serviceList[index].bookingTime} to ${orderProvider.serviceList[index].toTime}'),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              orderProvider.serviceList[index]
                                                          .status ==
                                                      0
                                                  ? 'Pending'
                                                  : orderProvider
                                                              .serviceList[
                                                                  index]
                                                              .status ==
                                                          1
                                                      ? 'Assign'
                                                      : orderProvider
                                                                  .serviceList[
                                                                      index]
                                                                  .status ==
                                                              2
                                                          ? 'Completed'
                                                          : orderProvider
                                                                      .serviceList[
                                                                          index]
                                                                      .status ==
                                                                  3
                                                              ? 'Rescheduled'
                                                              : orderProvider
                                                                          .serviceList[
                                                                              index]
                                                                          .status ==
                                                                      4
                                                                  ? 'Canceled '
                                                                  : orderProvider
                                                                              .serviceList[index]
                                                                              .status ==
                                                                          5
                                                                      ? 'Start'
                                                                      : '',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: orderProvider
                                                            .serviceList[index]
                                                            .status ==
                                                        0
                                                    ? Colors.orange
                                                    : orderProvider
                                                                .serviceList[
                                                                    index]
                                                                .status ==
                                                            1
                                                        ? Colors.lightBlue
                                                        : orderProvider
                                                                    .serviceList[
                                                                        index]
                                                                    .status ==
                                                                2
                                                            ? Colors.green
                                                            : orderProvider
                                                                        .serviceList[
                                                                            index]
                                                                        .status ==
                                                                    3
                                                                ? Colors.purple
                                                                : orderProvider
                                                                            .serviceList[
                                                                                index]
                                                                            .status ==
                                                                        4
                                                                    ? Colors.red
                                                                    : orderProvider.serviceList[index].status ==
                                                                            5
                                                                        ? Colors
                                                                            .yellow
                                                                        : Colors
                                                                            .black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 8),
                                        // Row(
                                        //   children: [
                                        //     Icon(Icons.comment,
                                        //         size: 16, color: Colors.orange),
                                        //     SizedBox(width: 8),
                                        //     Expanded(
                                        //       child: Text(
                                        //         'Feedback: Excellent service, highly satisfied!',
                                        //         style: TextStyle(
                                        //           fontSize: 14,
                                        //           color: Colors.grey[700],
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Container(
                            child: Text("No plans "),
                          ),
                        );
            })),
      ),
    );
  }
}

class RescheduleServicePopup extends StatefulWidget {
  ServiceHistoryData serviceHistoryData;
  RescheduleServicePopup({required this.serviceHistoryData});

  @override
  _RescheduleServicePopupState createState() => _RescheduleServicePopupState();
}

class _RescheduleServicePopupState extends State<RescheduleServicePopup> {
  bool _isLoading = false;

  Future<void> rescheduleService(
      {required String bookingId, required String status}) async {
    setState(() {
      _isLoading = true;
    });

    final sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstants.token);

    // // Replace with your actual API endpoint
    // const String apiUrl = "https://yourapi.com/reschedule";

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://townway.alphawizzserver.com/api/v1/customer/booking/reschedule_booking',
        ),
      );

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Add text fields
      request.fields.addAll({
        'booking_id': bookingId,
        'seller_id': status,
      });

      // Send the request
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);

        if (responseJson['status'] == true) {
          Fluttertoast.showToast(msg: responseJson['message']);
        } else {
          Fluttertoast.showToast(msg: responseJson['message']);
        }
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Reschedule Service'),
      content: _isLoading
          ? SizedBox(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Text(
              'Do you want to reschedule the service "${widget.serviceHistoryData.service?.name ?? ''} "'),
      actions: _isLoading
          ? []
          : [
              TextButton(
                onPressed: () async {
                  await rescheduleService(
                      bookingId: widget.serviceHistoryData.bookingId ?? '',
                      status: '0');
                  Navigator.of(context).pop(); // Close the popup
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  await rescheduleService(
                      bookingId: widget.serviceHistoryData.bookingId ?? '',
                      status: '1');
                  Navigator.of(context).pop(); // Close the popup
                },
                child: Text('Yes'),
              ),
            ],
    );
  }
}
