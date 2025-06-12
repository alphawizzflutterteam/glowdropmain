import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/model/response/MyTeamModel.dart';
import '../basewidget/custom_app_bar.dart';

class TeamDetails extends StatefulWidget {
  final Level? model;
  final String? LevalName;
  TeamDetails({Key? key, this.model, this.LevalName}) : super(key: key);

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: CustomAppBar(
            title: "${widget.LevalName} Team Details",
            isBackButtonExist: true,
            // level: true,
            // levelText: widget.LevalName,
          )),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: widget.model?.userData.length == null ||
                  widget.model?.userData.length == "" ||
                  widget.model?.userData.length == 0
              ? const Center(
                  child: Text(
                    "No Data Found",
                    style: TextStyle(fontSize: 14),
                  ),
                )
              : ListView.builder(
                  itemCount: widget.model?.userData.length ?? 0,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (c, i) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "${widget.model!.userData[i].firstName}",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${widget.model?.userData[i].lastName}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Registration Date'),
                                Text(
                                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.model?.userData[i].registeredDate ?? ''))}'),
                                // Text(
                                //     '${widget.model?.userData[i].registeredDate}')
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.model?.userData[i].phone}',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Daily Bonus',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    widget.model?.userData[i].status == 0
                                        ? Text(
                                            "Active",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: widget.model?.userData[i]
                                                          .status ==
                                                      0
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          )
                                        : Text(
                                            "InActive",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: widget.model?.userData[i]
                                                          .status ==
                                                      0
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
    );
  }
}
