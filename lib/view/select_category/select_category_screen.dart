import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/home_screens.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../provider/category_provider.dart';
import '../../data/model/select_category.dart';
import '../../main.dart';
import '../../utill/color_resources.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int? selectedCategoryIndex;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CategoryProvider>(context, listen: false).loadCategories());
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final categories = categoryProvider.categories;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child:
                Image.asset("assets/images/categorybg.png", fit: BoxFit.cover),
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
                Expanded(
                  child: categoryProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                          // Add bottom padding to avoid being hidden by the bottom nav bar
                          padding: EdgeInsets.only(
                            top: 70,
                            left: 5,
                            right: 5,
                            bottom:
                                kBottomNavigationBarHeight + 16, // key fix here
                          ),
                          child: GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                            children: categories.map((category) {
                              int index = categories.indexOf(category);
                              return GestureDetector(
                                onTap: () async {
                                  if (selectedCategoryIndex != index) {
                                    setState(() {
                                      selectedCategoryIndex = index;
                                    });
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    await prefs.setString('master_category_id', category.id.toString());
                                    await prefs.setString('sub_master_category_id', category.childes!.first.id.toString());

                                    // Navigate after short delay to allow UI to update
                                    Future.delayed(Duration(milliseconds: 100), () {
                                      final selectedCategory = categories[index];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SubCategoryScreen(
                                            selectedCategory: selectedCategory,
                                          ),
                                        ),
                                      );
                                    });
                                  }
                                },

                                child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                          'https://glow-drop.developmentalphawizz.com/storage/app/public/sellercategory/${category.image}',
                                        ),
                                      ),
                                      if (selectedCategoryIndex == index)
                                        const Positioned(
                                          right: 0,
                                          top: 0,
                                          child: Icon(
                                            Icons.check_circle,
                                            color: ColorResources.primary,
                                            size: 24,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    category.name ?? '',
                                    style: const TextStyle(fontSize: 14, color: Colors.black),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),

                              );
                            }).toList(),
                          ),
                        ),
                ),

                // Keep minimal height
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubCategoryScreen extends StatefulWidget {
  final SlectCategory selectedCategory;

  const SubCategoryScreen({Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  int? selectedSubcategoryIndex;
  @override
  Widget build(BuildContext context) {
    final List<Childes> subcategories = widget.selectedCategory.childes ?? [];

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child:
                Image.asset("assets/images/categorybg.png", fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "${widget.selectedCategory.name}",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Bricolage Grotesque",
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                subcategories.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text(
                            "No subcategories found",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          padding:
                              const EdgeInsets.only(top: 70, left: 5, right: 5),
                          child: GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                            children:
                                subcategories.asMap().entries.map((entry) {
                              final int index = entry.key;
                              final sub = entry.value;

                              return GestureDetector(
                                onTap: () {
                                  if (selectedSubcategoryIndex != index) {
                                    setState(() {
                                      selectedSubcategoryIndex = index;
                                    });

                                    // Navigate after short delay to allow UI to update
                                    // Future.delayed(Duration(milliseconds: 100), () {
                                    //   final selectedCategory = categories[index];
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => SubCategoryScreen(
                                    //         selectedCategory: selectedCategory,
                                    //       ),
                                    //     ),
                                    //   );
                                    // });
                                  }
                                },

                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(
                                            'https://glow-drop.developmentalphawizz.com/storage/app/public/sellersubcategory/${sub.image}',
                                          ),
                                        ),
                                        const SizedBox(height: 6),

                                        Text(
                                          sub.name ?? '',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    if (selectedSubcategoryIndex == index)
                                      const Positioned(
                                        top: 0,
                                        right: 0,

                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: ColorResources.primary,
                                          child: Icon(Icons.check,
                                              color: Colors.white, size: 16),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CustomButton(
                    buttonText: "Next",
                    onTap: () {
                      Navigator.of(Get.context!).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const HomePage()),
                              (route) => false);
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class CategoriesScreen extends StatefulWidget {
//   const CategoriesScreen({Key ?key});
//
//   @override
//   State<CategoriesScreen> createState() => _CategoriesScreenState();
// }
//
// class _CategoriesScreenState extends State<CategoriesScreen> {
//
//   final List<Map<String, String>> categories = [
//     {'name': 'Health & Wellness', 'image':     'assets/Green and White Modern Beauty Spa Center Banner (1) 1.png',
//     },
//     {'name': 'Beauty & Aesthetics', 'image': 'assets/Green and White Modern Beauty Spa Center Banner (1) 1.png'},
//     {'name': 'Fitness Freelancers','image': 'assets/image 166.png'},
//     {'name': 'Insurance & Mediclaim Providers', 'image': 'assets/image 166.png'},
//     {'name': 'Music', 'image': 'assets/image 166.png'},
//     {'name': 'Art', 'image': 'assets/image 166.png'},
//     {'name': 'Nature', 'image': 'assets/image 166.png'},
//     {'name': 'Design', 'image': 'assets/image 166.png'},
//     {'name': 'Travel', 'image': 'assets/image 166.png'},
//     {'name': 'Travel', 'image': 'assets/image 166.png'},
//     {'name': 'Travel', 'image': 'assets/image 166.png'},
//     {'name': 'Travel', 'image': 'assets/image 166.png'},
//     {'name': 'Travel', 'image': 'assets/image 166.png'},
//     {'name': 'Travel', 'image': 'assets/image 166.png'},
//     {'name': 'Travel', 'image': 'assets/image 166.png'},
//   ];
//
//   int? selectedCategoryIndex; // Track selected category
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() =>
//         Provider.of<CategoryProvider>(context, listen: false).loadCategories());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           SizedBox.expand(
//             child: Image.asset("assets/categorybg.png", fit: BoxFit.cover),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 const Text(
//                   "Choose Category",
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontFamily: "Bricolage Grotesque",
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 // 👉 Make the GridView scrollable and show all items
//                 Expanded(
//                   child: Container(
//                     padding: const EdgeInsets.only(top: 70, left: 5,right: 5),
//                     child: GridView.count(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 20,
//                       children: categories.map((category) {
//                         int index = categories.indexOf(category); // Get the index of the current category
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               // Toggle selection
//                               if (selectedCategoryIndex == index) {
//                                 selectedCategoryIndex = null; // Deselect if tapped again
//                               } else {
//                                 selectedCategoryIndex = index;
//                               }
//                             });
//                           },
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 50,
//                                     backgroundImage: AssetImage(category['image']!)
//
//
//                                     ,
//                                   ),
//                                   const SizedBox(height: 6),
//                                   Text(
//                                     category['name']!,
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.black,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               ),
//                               // Display right icon when this item is selected
//                               if (selectedCategoryIndex == index)
//                                 Positioned(
//                                   right: 3,
//
//                                   top: 5,
//                                   child: Icon(
//                                     Icons.check_circle,
//                                     color: ColorResources.primary,
//                                     size: 30,
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 Container(
//                   padding: EdgeInsets.only(bottom: 10),
//                   child: CustomButton(
//                     buttonText: "Next",
//                     onTap: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => DashBoardScreen()),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
