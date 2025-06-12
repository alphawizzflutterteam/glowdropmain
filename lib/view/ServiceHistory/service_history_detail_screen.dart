import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/body/service_history_model.dart';
import '../../provider/splash_provider.dart';
import '../../utill/color_resources.dart';
import '../../utill/custom_themes.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';
import '../basewidget/custom_app_bar.dart';
class ServiceHistoryDetailScreen extends StatefulWidget {
  ServiceHistoryData? serviceHistoryData;
   ServiceHistoryDetailScreen({Key? key,this.serviceHistoryData}) : super(key: key);

  @override
  State<ServiceHistoryDetailScreen> createState() => _ServiceHistoryDetailScreenState();
}

class _ServiceHistoryDetailScreenState extends State<ServiceHistoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> imageList =[];
if(widget.serviceHistoryData?.images != null)
  imageList = List<String>.from(json.decode(widget.serviceHistoryData?.images ?? ''));
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: CustomAppBar(
            title: "Service Details",
            isBackButtonExist: true,
            isSkip: false,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               widget.serviceHistoryData?.service?.name ?? '',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    "Date Time: ${widget.serviceHistoryData?.bookingDatetime ?? ''}",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
              // SizedBox(height: 10),
              // Row(
              //   children: [
              //     Icon(Icons.timer, color: Colors.green),
              //     SizedBox(width: 10),
              //     Text(
              //       "Time Taken: 05:00",
              //       style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              //     ),
              //   ],
              // ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.payment, color: Colors.purple),
                  SizedBox(width: 10),
                  Text(
                    "Payment: ₹${widget.serviceHistoryData?.paidAmount}",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
                       SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.timelapse_rounded, color: Colors.green),
                  SizedBox(width: 10),
                  Text(
                    "Time Slot : ${widget.serviceHistoryData?.bookingTime} to  ${widget.serviceHistoryData?.toTime}",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
              // SizedBox(height: 10),
              // Row(
              //   children: [
              //     Icon(Icons.comment, color: Colors.orange),
              //     SizedBox(width: 10),
              //     Text(
              //       "Feedback: sfsafsfFf",
              //       style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              //     ),
              //   ],
              // ),
              widget.serviceHistoryData?.images ==null ?  SizedBox()   : SizedBox(height: 10,),
              widget.serviceHistoryData?.images ==null ?  SizedBox()   :  SizedBox(
            height: 150,
            child:  ListView.builder(
              scrollDirection: Axis.horizontal, // Horizontal scrolling
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return Card(
                  // elevation: 7,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),

                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
                   width: 100, // Adjust width
                    child: Image.network(
                      '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productImageUrl}/${imageList[index]}',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text('Failed to load image'),
                        );
                      },
                    ),
                  ),
                );
              },
            )
          ),
              SizedBox(height: 20,),
              Text('User Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
        
                      // Section Header
        
                      // Seller Image and Name
                      Row(
                        children: [
                          // Seller Profile Picture
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(50),
                          //   child: FadeInImage.assetNetwork(
                          //     placeholder: Images.placeholder,
                          //     height: Dimensions.chooseReviewImageSize,
                          //     width: Dimensions.chooseReviewImageSize,
                          //     fit: BoxFit.cover,
                          //     image:
                          //     '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.sellerImageUrl}/${widget.serviceHistoryData?.seller?.image ?? ''}',
                          //     imageErrorBuilder: (context, error, stackTrace) =>
                          //         Image.asset(
                          //           Images.placeholder,
                          //           height: Dimensions.chooseReviewImageSize,
                          //           width: Dimensions.chooseReviewImageSize,
                          //           fit: BoxFit.cover,
                          //         ),
                          //   ),
                          // ),
                          Icon(Icons.person),
                          SizedBox(width: 15), // Spacing between image and name
                          // Seller Name
                          Expanded(
                            child: Text(
                              '${widget.serviceHistoryData?.patientName ?? ''}',
                              style: robotoRegular.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15), // Add spacing
        
                      // Seller Phone
                      Row(
                        children: [
                          Icon(Icons.phone,
                              color: ColorResources.primaryMaterial, size: 20),
                          SizedBox(width: 10),
                          Text(
                            '${widget.serviceHistoryData?.patientMobile ?? 'N/A'}',
                            style: robotoRegular.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 10), // Add spacing
        
                      // Seller Email
                      Row(
                        children: [
                          Icon(Icons.email_outlined,
                              color: ColorResources.primaryMaterial, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${widget.serviceHistoryData?.patientEmail ?? 'N/A'}',
                              style: robotoRegular.copyWith(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )   ,
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: ColorResources.primaryMaterial, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${widget.serviceHistoryData?.googleAddress ?? 'N/A'}',
                              style: robotoRegular.copyWith(fontSize: 16),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),  SizedBox(height: 20,),
              Text('Seller Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
        
                      // Section Header
        
                      // Seller Image and Name
                      Row(
                        children: [
                          // Seller Profile Picture
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: FadeInImage.assetNetwork(
                              placeholder: Images.placeholder,
                              height: Dimensions.chooseReviewImageSize,
                              width: Dimensions.chooseReviewImageSize,
                              fit: BoxFit.cover,
                              image:
                              '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.sellerImageUrl}/${widget.serviceHistoryData?.seller?.image ?? ''}',
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    Images.placeholder,
                                    height: Dimensions.chooseReviewImageSize,
                                    width: Dimensions.chooseReviewImageSize,
                                    fit: BoxFit.cover,
                                  ),
                            ),
                          ),
                          SizedBox(width: 15), // Spacing between image and name
                          // Seller Name
                          Expanded(
                            child: Text(
                              '${widget.serviceHistoryData?.seller?.fName ?? ''} ${widget.serviceHistoryData?.seller?.lName ?? ''}',
                              style: robotoRegular.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15), // Add spacing
        
                      // Seller Phone
                      Row(
                        children: [
                          Icon(Icons.phone,
                              color: ColorResources.primaryMaterial, size: 20),
                          SizedBox(width: 10),
                          Text(
                            '${widget.serviceHistoryData?.seller?.phone ?? 'N/A'}',
                            style: robotoRegular.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 10), // Add spacing
        
                      // Seller Email
                      Row(
                        children: [
                          Icon(Icons.email_outlined,
                              color: ColorResources.primaryMaterial, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${widget.serviceHistoryData?.seller?.email ?? 'N/A'}',
                              style: robotoRegular.copyWith(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )   ,
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: ColorResources.primaryMaterial, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${widget.serviceHistoryData?.seller?.address ?? 'N/A'}',
                              style: robotoRegular.copyWith(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey[300]),
              SizedBox(height: 20),
              Text(
                "Notes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "${widget.serviceHistoryData?.complaint}",
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),       SizedBox(height: 20),
              Divider(color: Colors.grey[300]),
              SizedBox(height: 20),
              Text(
                "Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "${widget.serviceHistoryData?.service?.details}",
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
