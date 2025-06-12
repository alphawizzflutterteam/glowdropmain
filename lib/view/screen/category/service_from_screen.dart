import 'dart:convert';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/response/service_model.dart';
import '../../../data/model/response/time_slot_model.dart';
import '../../../provider/theme_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../home/home_screens.dart';

class ServiceFromScreen extends StatefulWidget {
  String? serviceId;
  String? sellerId;
  String? amount;
  ServiceFromScreen({
    Key? key,
    this.serviceId,
    this.sellerId,
    this.amount,
  }) : super(key: key);

  @override
  State<ServiceFromScreen> createState() => _ServiceFromScreenState();
}

class _ServiceFromScreenState extends State<ServiceFromScreen> {
  TimeSlotData? timeSlot;
  double? lat;
  double? long;
  String? state;
  String? city;
  String? area;
  String? pincode;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  DateTime? alternateSelectedDate;
  TimeOfDay? alternateSelectedTime;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(), // Earliest date user can select
      lastDate: DateTime(2100), // Latest date user can select
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      getSlots();
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  String _formatDate() {
    if (selectedDate == null) return 'Select Date';
    return DateFormat('yyyy-MM-dd').format(selectedDate!);
  }

  String _formatTime() {
    if (selectedTime == null) return 'Select Time';
    final now = DateTime.now();
    final dt = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
    return DateFormat('HH:mm:ss').format(dt); // 24-hour format with seconds
  }

  List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _selectImages() async {
    try {
      final List<XFile>? selectedImages = await _picker.pickMultiImage(
          maxWidth: 400, maxHeight: 400, imageQuality: 100);
      if (selectedImages != null) {
        setState(() {
          _images.addAll(selectedImages);
        });
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  TextEditingController noteController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController alternateMobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.home,
                  color: Theme.of(context).cardColor, size: 20),
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Text('Book Service',
              style: robotoRegular.copyWith(
                  fontSize: 18, color: Theme.of(context).cardColor)),
        ]),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
            ? Colors.black
            : Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // SizedBox(
                //   height: 20,
                // ),
                // Name Field
                TextFormField(
                  controller: nameController,
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorResources.lightSkyBlue.withOpacity(.3),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 25,
                    ),
                    isDense: true,
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Email Field
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorResources.lightSkyBlue.withOpacity(.3),
                    prefixIcon: Icon(
                      Icons.email,
                      size: 25,
                    ),
                    isDense: true,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Mobile Field
                TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: mobileController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (value.length != 10) {
                      return 'Mobile number must be 10 digits';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: ColorResources.lightSkyBlue.withOpacity(.3),
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      size: 25,
                    ),
                    isDense: true,
                    hintText: 'Mobile',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Alternate Mobile Field
                TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: alternateMobileController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (value.length != 10) {
                      return 'Mobile number must be 10 digits';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: ColorResources.lightSkyBlue.withOpacity(.3),
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      size: 25,
                    ),
                    isDense: true,
                    hintText: 'Alternate Mobile No.',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Address Field
                TextFormField(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PlacePicker(
                    //       apiKey: Platform.isAndroid
                    //           ? "AIzaSyDp5WRm4NU2C0C6NeNkBY1uOUnpGl6ChKY"
                    //           : "AIzaSyDp5WRm4NU2C0C6NeNkBY1uOUnpGl6ChKY",
                    //       onPlacePicked: (result) {
                    //         print('assaafsdf${result.formattedAddress}');
                    //         setState(() {
                    //           addressController.text =
                    //               result.formattedAddress.toString();
                    //               lat         = result.geometry!.location.lat;
                    //               long    = result.geometry!.location.lng;
                    //         });
                    //         Navigator.of(context).pop();
                    //       },
                    //       initialPosition: LatLng(
                    //           22.719568,75.857727),
                    //       useCurrentLocation: true,
                    //     ),
                    //   ),
                    // );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlacePicker(
                          apiKey: Platform.isAndroid
                              ? "AIzaSyDp5WRm4NU2C0C6NeNkBY1uOUnpGl6ChKY"
                              : "AIzaSyDp5WRm4NU2C0C6NeNkBY1uOUnpGl6ChKY",
                          onPlacePicked: (result) {
                            print('Full Address: ${result.formattedAddress}');

                            // Extract components from address
                            for (var component in result.addressComponents!) {
                              if (component.types
                                  .contains('administrative_area_level_1')) {
                                state = component.longName; // State
                              } else if (component.types.contains('locality')) {
                                city = component.longName; // City
                              } else if (component.types
                                      .contains('sublocality_level_1') ||
                                  component.types.contains('neighborhood')) {
                                area = component.longName; // Area
                              } else if (component.types
                                  .contains('postal_code')) {
                                pincode = component.longName; // Pincode
                              }
                            }

                            print('State: $state');
                            print('City: $city');
                            print('Area: $area');
                            print('Pincode: $pincode');

                            setState(() {
                              addressController.text =
                                  result.formattedAddress.toString();
                              lat = result.geometry!.location.lat;
                              long = result.geometry!.location.lng;
                            });
                            Navigator.of(context).pop();
                          },
                          initialPosition: const LatLng(22.719568, 75.857727),
                          useCurrentLocation: true,
                        ),
                      ),
                    );
                  },
                  controller: addressController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorResources.lightSkyBlue.withOpacity(.3),
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      size: 25,
                    ),
                    isDense: true,
                    hintText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Select Time Slot',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: ColorResources.lightSkyBlue.withOpacity(.3),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorResources.black)),
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.calendar_month),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                            selectedDate == null
                                ? 'Select Date'
                                : _formatDate(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                timeSlotList.isEmpty
                    ? const Center(
                        child: Text(
                        'No Slot',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                    : SizedBox(
                        height: 70,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: timeSlotList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (timeSlotList?[index].isBooked.toString() ==
                                    '1') {
                                  Fluttertoast.showToast(
                                      msg: 'Slot Already Booked');
                                } else {
                                  timeSlot = timeSlotList?[index];
                                  setState(() {});
                                }
                              },
                              child: Card(
                                elevation: 7,
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: timeSlotList?[index]
                                                  .isBooked
                                                  .toString() ==
                                              '1'
                                          ? Colors.grey
                                          : timeSlot?.slotId.toString() ==
                                                  timeSlotList?[index]
                                                      .slotId
                                                      .toString()
                                              ? Colors.lightBlueAccent
                                              : Colors.white),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Text(
                                          '${timeSlotList?[index].fromTime ?? ' '}'),
                                      Text('To'),
                                      Text(
                                          '${timeSlotList?[index].toTime ?? ' '}'),
                                    ],
                                  )),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                // const SizedBox(
                //   height: 20,
                // ),
                // InkWell(
                //   onTap: () {
                //     _selectTime(context);
                //   },
                //   child: Container(
                //     height: 50,
                //     decoration: BoxDecoration(
                //         color: ColorResources.lightSkyBlue.withOpacity(.3),
                //         borderRadius: BorderRadius.circular(10),
                //         border: Border.all(color: ColorResources.black)),
                //     width: MediaQuery.sizeOf(context).width,
                //     child: Row(
                //       children: [
                //         const SizedBox(
                //           width: 10,
                //         ),
                //         Icon(Icons.access_time_outlined),
                //         const SizedBox(
                //           width: 10,
                //         ),
                //         Text(
                //           selectedTime == null ? 'Select Time' : _formatTime(),
                //           style: TextStyle(
                //               color: Colors.grey, fontWeight: FontWeight.bold),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: noteController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorResources.lightSkyBlue.withOpacity(.3),
                      hintText: 'Enter Note',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black))),
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        _selectImages();
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        child: Center(
                            child: Text(
                          'Add Images',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: Image.file(
                              File(_images[index].path),
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                            onPressed: () => _removeImage(index),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (selectedDate == null) {
                        Fluttertoast.showToast(msg: 'Please Select Date');
                      } else if (timeSlot == null) {
                        Fluttertoast.showToast(msg: 'Please Select TimeSlot');
                      } else if (noteController.text == '') {
                        Fluttertoast.showToast(msg: 'Please Select Note');
                      } else {
                        bookServiceApi();
                      }
                    }
                  },
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                                child: Text(
                              'Book Now',
                              style: TextStyle(
                                  color: ColorResources.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;
  Future<void> bookServiceApi() async {
    isLoading = true;
    setState(() {});

    final sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstants.token);

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://townway.alphawizzserver.com/api/v1/customer/booking/services-booking',
        ),
      );

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Add text fields
      request.fields.addAll({
        'service_id': widget.serviceId ?? '',
        'seller_id': widget.sellerId ?? '',
        'booking_name': nameController.text,
        'booking_email': emailController.text,
        'booking_mobile': mobileController.text,
        'alternate_mobile': alternateMobileController.text,
        'booking_address': addressController.text,
        'pincode': pincode.toString(),
        'area': area.toString(),
        'city': city.toString(),
        'state': state.toString(),
        'comment': noteController.text,
        'booking_datetime': _formatDate().toString(),
        // 'alternate_datetime': '${_formatDate()} ${_formatTime()}',
        'paid_amount': widget.amount.toString(),
        'latitude': lat.toString(),
        'longitude': long.toString(),
        'is_paid': '0',
        'slot_id': timeSlot?.slotId.toString() ?? '',
      });

      // Add image files
      for (int i = 0; i < _images.length; i++) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'images[]', // Make sure this matches the server's expected parameter name
            _images[i].path,
          ),
        );
      }

      // Send the request
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);

        if (responseJson['status'] == true) {
          Fluttertoast.showToast(msg: responseJson['message']);
          Navigator.pop(context); // Outputs: Service Booking Successfully
        } else {
          Fluttertoast.showToast(msg: responseJson['message']);
        }
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  List<TimeSlotData> timeSlotList = [];
  Future<void> getSlots() async {
    timeSlot = null;
    isLoading = true;
    setState(() {});

    final sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstants.token);

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://townway.alphawizzserver.com/api/v1/customer/booking/get_timeslots',
        ),
      );

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Add text fields
      request.fields.addAll({
        'service_id': widget.serviceId ?? '',
        'date': _formatDate().toString()
      });

      // Send the request
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);

        if (responseJson['status'] == true) {
          timeSlotList = (responseJson['data'] as List)
              .map((e) => TimeSlotData.fromJson(e))
              .toList();
          setState(() {});
          // Fluttertoast.showToast(msg: responseJson['message']);
          // Navigator.pop(context); // Outputs: Service Booking Successfully
        } else {
          Fluttertoast.showToast(msg: responseJson['message']);
        }
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading = false;
      setState(() {});
    }
  }
}
