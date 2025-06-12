import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';

import '../../../basewidget/button/custom_button.dart';
import 'bookinf_details.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({Key? key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<String> images = [
    'assets/images/image 154.png',
    'assets/images/Green and White Modern Beauty Spa Center Banner (1) 1.png',
    'assets/images/Green and White Modern Beauty Spa Center Banner (1) 1.png',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: ColorResources.backGroundcolor,

        // ✅ Move custom AppBar here
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
        // and rest of content
        body: SingleChildScrollView(
          child: Container(
            // color:Colors.green,
            child: Column(
              children: [
                // const SizedBox(height: 100), // Pushes content below the image
                Container(
                  color: Colors.red,
                  width: screenWidth,
                  height: 300,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return ClipPath(
                        clipper: InvertedTopCurveClipper(),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 300,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: _currentPage == index ? 12 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? ColorResources.primary
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),

                ServiceCard(),
                // const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/images/location1.png",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                BeautySensePage(),
                ReviewCard(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CustomButton(
                      buttonText: "Book Service",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingDetails(),
                          ), // Replace with your screen
                        );
                        // Add your navigation or logic here
                      },
                    ),
                  ),
                ),
                SizedBox(height: 12),

                ServiceScreen(),
                SizedBox(height: 15),

                ServiceScreen1(),
              ],
            ),
          ),
        ));
  }
}

class InvertedTopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    // Inward top curve
    path.quadraticBezierTo(
      size.width / 2,
      60, // Control point
      0,
      0, // End at top left
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ServiceCard extends StatefulWidget {
  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 92 / 100,
      // height: MediaQuery.of(context).size.height*90/100,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Service',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Text(
                'Fast Track Booking',
                style: TextStyle(fontSize: 14, color: Colors.redAccent),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Facial Clean - Up',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 18),
                  Text(' 4.5', style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '₹ 600 Only',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Service Duration: 30–40 minutes',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Service Type: ',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(

            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex =
                          0; // Set selected index to 0 for 'At Salon'
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedIndex == 0
                        ? ColorResources.primary
                        : Colors.grey, // Background color
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'At Salon',
                    style: TextStyle(
                      color: selectedIndex == 0
                          ? Colors.white
                          : Colors.black, // Text color
                    ),
                  ),
                ),
                SizedBox(width: 4),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex =
                          1; // Set selected index to 1 for 'At Home'
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedIndex == 1
                        ? ColorResources.primary
                        : Colors.white, // Background color
                    padding: EdgeInsets.symmetric(horizontal: 52, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'At Home',
                    style: TextStyle(
                      color: selectedIndex == 1
                          ? Colors.white
                          : Colors.black, // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BeautySensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Top Container
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Seller", style: TextStyle(color: Colors.grey[600])),
                SizedBox(height: 6),
                Text(
                  "BEAUTY & SENSE",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Beauty and Sense offers expert facial care with personalized treatments for healthy, glowing skin—right at your doorstep.",
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Bottom Container
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Includes
                Row(
                  children: [
                    Text(
                      "✅ Includes:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                buildBulletPoint("Deep cleansing with gentle face wash"),
                buildBulletPoint(
                  "Mild exfoliation using skin-type-specific scrub",
                ),
                buildBulletPoint("Blackhead & whitehead removal"),
                buildBulletPoint("Steaming for pore opening"),
                buildBulletPoint("Soothing face massage"),
                buildBulletPoint("Refreshing face pack & toner application"),
                SizedBox(height: 16),

                // Benefits
                Row(
                  children: [
                    Text(
                      "🌿 Benefits:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                buildBulletPoint("Removes dirt, oil, and impurities"),
                buildBulletPoint("Unclogs pores and reduces blackheads"),
                buildBulletPoint("Refreshes dull and tired skin"),
                buildBulletPoint("Ideal for weekly skin maintenance"),
                SizedBox(height: 16),

                // Recommended For
                Row(
                  children: [
                    Text(
                      "📌 Recommended for:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                buildBulletPoint(
                  "All skin types, especially normal to oily skin",
                ),
                SizedBox(height: 16),

                // Booking
                Row(
                  children: [
                    Text(
                      "📅 Booking Available:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                buildBulletPoint("Daily | Morning to Evening Slots"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 90 / 100,
      // padding: EdgeInsets.all(4),
      // Background color matching your image
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Title + Arrow
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rating & Reviews",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
          SizedBox(height: 16),
          // Reviewer Row
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(
                  'assets/images/veronika.png',
                ), // Replace with your image asset
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Veronika",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          size: 16,
                          color:
                              index < 4 ? Colors.orange : Colors.grey.shade300,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Text("2d ago", style: TextStyle(color: Colors.grey)),
            ],
          ),
          SizedBox(height: 12),
          // Review Text
          Text(
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed ...",
            style: TextStyle(color: Colors.black87),
          ),
          SizedBox(height: 12),
          // Link
          GestureDetector(
            onTap: () {
              // Navigate to full reviews page
            },
            child: Text(
              "See all reviews",
              style: TextStyle(
                color: Color(0xFF116B61),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceScreen extends StatelessWidget {
  final List<Map<String, dynamic>> otherSalons = [
    {
      "name": "Olivia",
      "service": "Facial Clean-Up",
      "price": "₹500",
      "rating": 4.5,
      "tagColor": Color(0xFFD3E8E0),
    },
    {
      "name": "Five Seasons",
      "service": "Facial Clean-Up",
      "price": "₹3000",
      "rating": 4.5,
      "tagColor": Color(0xFFB5E1E9),
    },
  ];

  final List<Map<String, dynamic>> beautyAndSenseServices = [
    {"service": "Face Treatment", "price": "₹500", "rating": 4.5},
    {"service": "Spa", "price": "₹3000", "rating": 4.5},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 90 / 100,
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 12),
          Text(
            "Other Salons",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: otherSalons
                .map(
                  (salon) => Expanded(child: _buildSalonContainer(salon)),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSalonContainer(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    'assets/images/image 155.png',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: data["tagColor"],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      data["name"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data["service"]),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data["price"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          SizedBox(width: 4),
                          Text(data["rating"].toString()),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Book",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorResources.primary,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceScreen1 extends StatelessWidget {
  final List<Map<String, dynamic>> otherSalons = [
    {
      "name": "Olivia",
      "service": "Facial Clean-Up",
      "price": "₹500",
      "rating": 4.5,
      "tagColor": Color(0xFFD3E8E0),
    },
    {
      "name": "Five Seasons",
      "service": "Facial Clean-Up",
      "price": "₹3000",
      "rating": 4.5,
      "tagColor": Color(0xFFB5E1E9),
    },
  ];

  final List<Map<String, dynamic>> beautyAndSenseServices = [
    {"service": "Face Treatment", "price": "₹500", "rating": 4.5},
    {"service": "Spa", "price": "₹3000", "rating": 4.5},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 90 / 100,
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Other Services by ",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "BEAUTY & SENSE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: beautyAndSenseServices
                      .map(
                        (service) => Expanded(
                          child: _buildServiceContainer(service),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceContainer(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                'assets/images/image 155.png',
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data["service"]),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data["price"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          SizedBox(width: 4),
                          Text(data["rating"].toString()),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Book",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorResources.primary,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
