import 'package:flutter/material.dart';

import '../../../../utill/color_resources.dart';
import '../../../basewidget/button/custom_button.dart';


class CategoriesScreen extends StatefulWidget {
  // const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  final List<Map<String, String>> categories = [
    {'name': 'Health & Wellness', 'image':     'assets/images/Green and White Modern Beauty Spa Center Banner (1) 1.png',
    },
    {'name': 'Beauty & Aesthetics', 'image': 'assets/images/Green and White Modern Beauty Spa Center Banner (1) 1.png'},
    {'name': 'Fitness Freelancers','image': 'assets/image 166.png'},
    {'name': 'Insurance & Mediclaim Providers', 'image': 'assets/image 166.png'},
    {'name': 'Music', 'image': 'assets/images/image 166.png'},
    {'name': 'Art', 'image': 'assets/images/image 166.png'},
    {'name': 'Nature', 'image': 'assets/images/image 166.png'},
    {'name': 'Design', 'image': 'assets/images/image 166.png'},
    {'name': 'Travel', 'image': 'assets/images/image 166.png'},
    {'name': 'Travel', 'image': 'assets/images/image 166.png'},
    {'name': 'Travel', 'image': 'assets/images/image 166.png'},
    {'name': 'Travel', 'image': 'assets/images/image 166.png'},
    {'name': 'Travel', 'image': 'assets/images/image 166.png'},
    {'name': 'Travel', 'image': 'assets/images/image 166.png'},
    {'name': 'Travel', 'image': 'assets/images/image 166.png'},
  ];

  int? selectedCategoryIndex; // Track selected category

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset("assets/images/categorybg.png", fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Choose Category",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Bricolage Grotesque",
                  ),
                ),
                const SizedBox(height: 20),

                // 👉 Make the GridView scrollable and show all items
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 70, left: 5,right: 5),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      children: categories.map((category) {
                        int index = categories.indexOf(category); // Get the index of the current category
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              // Toggle selection
                              if (selectedCategoryIndex == index) {
                                selectedCategoryIndex = null; // Deselect if tapped again
                              } else {
                                selectedCategoryIndex = index;
                              }
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(category['image']!)


                                    ,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    category['name']!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              // Display right icon when this item is selected
                              if (selectedCategoryIndex == index)
                                Positioned(
                                  right: 3,

                                  top: 5,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: ColorResources.primary,
                                    size: 30,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Container(
                //   padding: EdgeInsets.only(bottom: 10),
                //   child: CustomButton(
                //     text: "Next",
                //     onPressed: () {
                //       Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(builder: (context) => bottomnavbar()),
                //       );
                //     }, buttonText: '',
                //   ),
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
