// import 'package:chat_app/task/after_click_page.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../data/model/response/MyTeamModel.dart';
import '../../provider/auth_provider.dart';
import '../basewidget/custom_app_bar.dart';
import 'TeamDetails.dart';

class MyTeam extends StatefulWidget {
  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {
  List category = [
    "",
    "Consumer",
    "Vendor",
    "RAC",
    "Promoter",
    "National\nPromoter",
    "CoFounder",
    "RGC",
    "Active Member",
    "Verified Vendor",
    "BizTool basic",
    "BizTool Prime",
  ];

  List header = [
    "L1",
    "L2",
    "L3",
    "L4",
    "L5",
    "L6",
    "L7",
    "L8",
    "L9",
    "L10",
    "L11",
    "L12",
    "L13",
    "L14",
    "L15",
    "L16",
    "L17",
    "L18",
    "L19",
    "L20",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myTeams();
  }

  String? userId;

  MyTeamModel? teamModel;
  myTeams() async {
    userId = Provider.of<AuthProvider>(context, listen: false).getAuthID();
    print("user id in team scren $userId");
    var request = http.MultipartRequest('POST',
        Uri.parse('https://townway.alphawizzserver.com/api/v1/auth/my_team'));
    request.fields.addAll({'user_id': '$userId'});
    print("fieldsfields $request");
    print("fieldsfields $userId");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      teamModel = MyTeamModel.fromJson(finalresult);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: CustomAppBar(title: "My Team", isBackButtonExist: true)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: teamModel?.status == false
            ? const Center(
                child: Text(
                "No Data Found",
              ))
            : Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(teamModel?.levelCount ?? 0,
                            (columnIndex) {
                          return Column(
                            children: List.generate(2 ?? 0, (rowIndex) {
                              print(
                                  "roe indexx ${teamModel?.data?.level1?.userCount} column index is $columnIndex row index $rowIndex");
                              if (rowIndex == 0) {
                                return Container(
                                  width: 80,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff0007a3),
                                    border: Border.all(
                                        color: Colors.white, width: 0.5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      header[columnIndex],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    if (columnIndex == 0) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level1,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 1) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level2,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 2) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level3,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 3) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level4,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 4) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level5,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 5) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level6,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 6) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level7,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 7) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level8,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 8) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level9,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 9) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level10,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 10) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level11,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 11) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level12,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 12) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level13,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 13) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level14,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 14) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level15,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 15) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level16,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 16) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level17,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 17) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level18,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 18) {
                                      print("object Inedex ${columnIndex}");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level19,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 19) {
                                      print("object Inedex ${columnIndex}");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level20,
                                                  LevalName:
                                                      header[columnIndex])));
                                    } else if (columnIndex == 20) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TeamDetails(
                                                  model:
                                                      teamModel?.data?.level20,
                                                  LevalName:
                                                      header[columnIndex])));
                                    }
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 0.5),
                                    ),
                                    child: Center(
                                      child: columnIndex == 0
                                          ? Text(
                                              '${teamModel?.data?.level1?.userCount}')
                                          : columnIndex == 1
                                              ? Text(
                                                  '${teamModel?.data?.level2?.userCount}')
                                              : columnIndex == 2
                                                  ? Text(
                                                      '${teamModel?.data?.level3?.userCount}')
                                                  : columnIndex == 3
                                                      ? Text(
                                                          '${teamModel?.data?.level4?.userCount}')
                                                      : columnIndex == 4
                                                          ? Text(
                                                              '${teamModel?.data?.level5?.userCount}')
                                                          : columnIndex == 5
                                                              ? Text(
                                                                  '${teamModel?.data?.level6?.userCount}')
                                                              : columnIndex == 6
                                                                  ? Text(
                                                                      '${teamModel?.data?.level7?.userCount}')
                                                                  : columnIndex ==
                                                                          7
                                                                      ? Text(
                                                                          '${teamModel?.data?.level8?.userCount}')
                                                                      : columnIndex ==
                                                                              8
                                                                          ? Text(
                                                                              '${teamModel?.data?.level9?.userCount}')
                                                                          : columnIndex == 9
                                                                              ? Text('${teamModel?.data?.level10?.userCount}')
                                                                              : columnIndex == 10
                                                                                  ? Text('${teamModel?.data?.level11?.userCount}')
                                                                                  : columnIndex == 11
                                                                                      ? Text('${teamModel?.data?.level12?.userCount}')
                                                                                      : columnIndex == 12
                                                                                          ? Text('${teamModel?.data?.level13?.userCount}')
                                                                                          : columnIndex == 13
                                                                                              ? Text('${teamModel?.data?.level14?.userCount}')
                                                                                              : columnIndex == 14
                                                                                                  ? Text('${teamModel?.data?.level15?.userCount}')
                                                                                                  : columnIndex == 15
                                                                                                      ? Text('${teamModel?.data?.level16?.userCount}')
                                                                                                      : columnIndex == 16
                                                                                                          ? Text('${teamModel?.data?.level17?.userCount}')
                                                                                                          : columnIndex == 17
                                                                                                              ? Text('${teamModel?.data?.level18?.userCount}')
                                                                                                              : columnIndex == 18
                                                                                                                  ? Text('${teamModel?.data?.level19?.userCount}')
                                                                                                                  : columnIndex == 19
                                                                                                                      ? Text('${teamModel?.data?.level20?.userCount}')
                                                                                                                      : SizedBox(),
                                    ),
                                  ),
                                );
                              }
                            }),
                          );
                        }),
                      ),
                    ),
                  ),
                  // Fixed last column
                  Column(
                    children: List.generate(2, (index) {
                      if (index == 0) {
                        return Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xff0007a3),
                              border:
                                  Border.all(color: Colors.white, width: 0.5)),
                          child: const Center(
                              child: Text(
                            'Total',
                            style: TextStyle(color: Colors.white),
                          )),
                        );
                      } else {
                        return Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.grey, width: 0.5)),
                          child: Center(
                              child: index == 1
                                  ? Text('${teamModel?.totalCount}')
                                  : const Text("0")),
                        );
                      }
                    }),
                  ),
                ],
              ),
      ),
    );
  }
}
