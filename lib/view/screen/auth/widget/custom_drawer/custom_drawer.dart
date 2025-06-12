import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset("assets/images/categorybg.png", fit: BoxFit.cover),
          ),

          Positioned.fill(
            child: Column(
              children: [
                SizedBox(height: 50),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Header
                        Container(
                          width: 500,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Text(
                                  "••• ", // Using three bold dots spaced manually
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text("More", style: TextStyle(fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 100),

                        // Drawer items (you can refactor this list for brevity)
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  "Loyalty Points",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    fontFamily: "Bricolage Grotesque",
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/Vector (1).png",
                                  fit: BoxFit.cover,
                                  width: 10,
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  "Enquiry",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    fontFamily: "Bricolage Grotesque",
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/Vector (1).png",
                                  fit: BoxFit.cover,
                                  width: 10,
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  "Refer and Earn",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    fontFamily: "Bricolage Grotesque",
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/Vector (1).png",
                                  fit: BoxFit.cover,
                                  width: 10,
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    fontFamily: "Bricolage Grotesque",
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/Vector (1).png",
                                  fit: BoxFit.cover,
                                  width: 10,
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  "Terms and Conditions",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    fontFamily: "Bricolage Grotesque",
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/Vector (1).png",
                                  fit: BoxFit.cover,
                                  width: 10,
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  "FAQ’s",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    fontFamily: "Bricolage Grotesque",
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/Vector (1).png",
                                  fit: BoxFit.cover,
                                  width: 10,
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  "Customer Support",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    fontFamily: "Bricolage Grotesque",
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/Vector (1).png",
                                  fit: BoxFit.cover,
                                  width: 10,
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),


                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 80),
                // Positioned.fill(child: Text("Logout")),

                // Logout image pinned to the bottom
                Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(),
                        child: Image.asset(
                          "assets/images/logout.png",
                          fit: BoxFit.cover,
                          width: 310, // Adjust size as needed
                        ),
                      ),
                      SizedBox(height: 20, width: 50,),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 10),
                        child: Positioned.fill(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.power_settings_new,
                                  color: Colors.white, size: 24),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  _showLogoutDialog(context);
                                },
                                child: Text(
                                  "Log Out",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      )
                    ]
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Cancel button color
                foregroundColor: Colors.white, // Text color
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:Theme.of(context).primaryColor, // Primary color
                foregroundColor: Colors.white, // Text color
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Add your logout logic here
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

}
