import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/widget/categoryscreen.dart';


class UserDetails extends StatefulWidget {
  // const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String gender = 'Male';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox.expand(
            child: Image.asset("assets/images/background.png", fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  Image.asset(
                    "assets/images/userdetails.png",
                    width: MediaQuery.of(context).size.width * 0.8,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "Full Name",
                    style: TextStyle(
                      color: ColorResources.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: "Enter your full name",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Gender",
                    style: TextStyle(
                      color: ColorResources.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildGenderOption("Female"),
                      const SizedBox(width: 16),
                      _buildGenderOption("Male"),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "Date of Birth",
                    style: TextStyle(
                      color: ColorResources.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: dobController,
                      readOnly: true,
                      onTap: _selectDate,
                      decoration: InputDecoration(
                        hintText: "07 May 2025",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.calendar_today,
                            color: ColorResources.primary,
                          ),
                          onPressed: _selectDate,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Address",
                    style: TextStyle(
                      color: ColorResources.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: dobController,
                      readOnly: true,
                      onTap: _selectDate,
                      decoration: InputDecoration(
                        hintText: "VijayNagar, Indore,Madhya Pradesh",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: ColorResources.primary,
                          ),
                          onPressed: _selectDate,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    // Fixed width
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorResources.white,
                        side: BorderSide(
                          width: 2.0,
                          color: ColorResources.primary,
                        ),

                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Skip",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: ColorResources.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    // Fixed width
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorResources.primary,

                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoriesScreen(),
                          ), // Replace with your screen
                        );
                      },
                      child: Text(
                        "Get Started",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String label) {
    bool isSelected = gender == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          gender = label;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 40 / 100,
        height: MediaQuery.of(context).size.height * 5 / 100,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? ColorResources.primary : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorResources.primary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : ColorResources.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(Icons.check, color: Colors.white, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}
