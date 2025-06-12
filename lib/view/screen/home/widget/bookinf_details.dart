import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../basewidget/button/custom_button.dart';
import '../../patment_details/payment_details.dart';


class BookingDetails extends StatelessWidget {
  const BookingDetails({Key?key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EA), // Light beige background
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(80),
        child: Stack(
          children: [
            Image.asset(
              "assets/images/topappbar.png",
              height: 380,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: Colors.white, size: 25),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 88),
                  Text(
                    "Facial Clean-Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
          children: [
            // Image.asset(
            //   "assets/images/topappbar.png",
            //   height: 200,
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            // ),

            Positioned(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 16,  right: 16 ,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 150),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text("Selected Service", style: TextStyle(fontSize: 18, color: Colors.black87)),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/image 154.png', // Make sure this image is added to assets
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Facial Clean - Up", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text("Beauty & Sense", style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        const Text("4.5", style: TextStyle(fontWeight: FontWeight.w500))
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Price", style: TextStyle(fontSize: 14)),
                    const Text("₹ 600 only", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text("Service Duration", style: TextStyle(fontSize: 14)),
                    const Text("30–40 minutes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    const Text("Service Type", style: TextStyle(fontSize: 14)),
                    const Text("At Home", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 20),

                    const Text("Location", style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/location1.png', // Replace with your static map or use Google Maps widget
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),

                    const Text("Select Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A5C5C),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat("MMMM yyyy").format(today),
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(3, (index) {
                              final date = today.add(Duration(days: index));
                              final isSelected = index == 0;
                              return Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.white : const Color(0xFF407C7C),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Column(
                                    children: [
                                      Text(
                                        DateFormat('E').format(date),
                                        style: TextStyle(
                                          color: isSelected ? Colors.black : Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      CircleAvatar(
                                        backgroundColor: isSelected ? Colors.black : Colors.transparent,
                                        radius: 14,
                                        child: Text(
                                          '${date.day}',
                                          style: TextStyle(
                                            color: isSelected ? Colors.white : Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                    TimeAndPaymentSelector()
                  ],
                ),
              ),
            ),

          ]
      ),
    );
  }
}

class TimeAndPaymentSelector extends StatefulWidget {
  const TimeAndPaymentSelector({Key?key});

  @override
  State<TimeAndPaymentSelector> createState() => _TimeAndPaymentSelectorState();
}

class _TimeAndPaymentSelectorState extends State<TimeAndPaymentSelector> {
  String selectedTime = "12:00";
  String selectedPayment = "After Service";

  final List<String> timeSlots = [
    "10:00", "11:00", "12:00",
    "01:00", "02:00", "03:00",
    "04:00", "05:00", "06:00"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // Background color of the whole section
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*90/100,
            color: Colors.white,
            child: Column(
              children: [
                const Text("Select Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                const SizedBox(height: 5),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: timeSlots.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    final time = timeSlots[index];
                    final isDisabled = time == "05:00";
                    final isSelected = selectedTime == time;

                    return GestureDetector(
                      onTap: isDisabled
                          ? null
                          : () {
                        setState(() {
                          selectedTime = time;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF2A5C5C)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey.shade300,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          time,
                          style: TextStyle(
                            color: isDisabled
                                ? Colors.grey
                                : isSelected
                                ? Colors.white
                                : Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text("Payment Method", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: ["After Services", "Pay Now"].map((option) {
              final isSelected = selectedPayment == option;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPayment = option;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF2A5C5C) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Colors.transparent
                            : Colors.grey.shade300,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      option,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          CustomButton(
            buttonText: "Book Service",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentDetailsScreen(),
                ), // Replace with your screen
              );
              // Add your navigation or logic here
            },
          ),
          const SizedBox(height: 24),

        ],

      ),
    );
  }
}
