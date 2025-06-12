import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/plans_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/plan_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'ContinueToPayScreen.dart';

class PlansScreen extends StatefulWidget {
  final type;
  PlansScreen({Key? key, this.type}) : super(key: key);

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class Plan {
  final String name;
  final String description;
  final String price;
  bool? selected;

  Plan(this.name, this.description, this.price, this.selected);
}

class _PlansScreenState extends State<PlansScreen> {
  Razorpay? _razorpay;
  int? pricerazorpayy;
  int seleted = -1;

  String planid = "";
  String amount = "";

  final List<Plan> plans = [
    Plan("Basic Plan", "Description of Basic Plan", "\$10/month", false),
    Plan("Standard Plan", "Description of Standard Plan", "\$20/month", false),
    Plan("Premium Plan", "Description of Premium Plan", "\$30/month", false),
    // Add more plans as needed
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PlanProvider>(context, listen: false).initOrderList(context);
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout(amount) async {
    double res = double.parse(amount.toString());
    pricerazorpayy = int.parse(res.toStringAsFixed(0)) * 100;
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "$pricerazorpayy",
      'name': 'Townway',
      'image': 'assets/images/Group 165.png',
      'description': 'Townway',
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Fluttertoast.showToast(msg: "Payment successfully");
    // addWallet();
    List<PlansData>? planList =
        Provider.of<PlanProvider>(context, listen: false).isPlanList();
    purchasePlan(Provider.of<AuthProvider>(context, listen: false).getAuthID(),
        planid, response.paymentId, amount, "success");
    // Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(msg: "Payment cancelled by user");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}
  // Shivani Verma, Today at 11:45 AM

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: CustomAppBar(
            title: getTranslated('plans', context),
            isBackButtonExist: widget.type == 1 ? false : true,
            isSkip: widget.type == 1 ? true : false,
          )),
      body: Consumer<PlanProvider>(
          builder: (context, orderProvider, child) =>
              Provider.of<PlanProvider>(context).isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 60.0),
                      child: ListView.builder(
                        itemCount: orderProvider.planList!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                seleted = index;

                                orderProvider.planList!.forEach((element) {
                                  element.selected = false;
                                });
                                orderProvider.planList![index].selected = true;
                                planid = orderProvider.planList![index].id
                                    .toString();
                                amount = orderProvider.planList![index].amount
                                    .toString();
                                setState(() {});
                              },
                              child: PlanItem(
                                  plan: orderProvider.planList![index],
                                  selected: seleted));
                        },
                      ),
                    )),
      floatingActionButton:
          Consumer<ProfileProvider>(builder: (context, profile, child) {
        return Consumer<PlanProvider>(builder: (context, orderProvider, child) {
          return Provider.of<PlanProvider>(context).isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 15, right: 20, left: 20),
                  width: double.infinity,
                  child: FloatingActionButton.extended(
                    isExtended: true,
                    backgroundColor: seleted == -1
                        ? ColorResources.getLightSkyBlue(context)
                        : Theme.of(context).primaryColor,
                    splashColor: seleted == -1
                        ? ColorResources.getLightSkyBlue(context)
                        : Theme.of(context).primaryColor,
                    onPressed: () {
                      DateTime dateTime = DateTime.now();

                      try {
                        dateTime = DateFormat('yyyy-MM-dd')
                            .parse(profile.userInfoModel!.plan_expire_date!);
                      } catch (e) {
                        print(e);
                      }
                      print("objectPlanValid ${dateTime}");
                      print(
                          "objectPlanValid ${dateTime.isBefore(DateTime.now())}");
                      if (seleted == -1) {
                        showCustomSnackBar("Please select Plan", context,
                            isToaster: true);
                      } else if (profile.userInfoModel!.plan_id
                                  .toString()
                                  .trim() ==
                              orderProvider.planList![seleted].id
                                  .toString()
                                  .trim() &&
                          !dateTime.isBefore(DateTime.now())) {
                        showCustomSnackBar(
                            "Please select Plan Other than this", context,
                            isToaster: true);
                        return;
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContinueToPayScreen(
                                    amount: orderProvider
                                        .planList![seleted].amount
                                        .toString(),
                                    id: orderProvider.planList![seleted].id
                                        .toString())));
                        // openCheckout(orderProvider.planList![seleted].amount);
                      }
                    },
                    icon: Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Continue to Pay",
                      style: titleHeaderwhite,
                    ),
                  ),
                );
        });
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> purchasePlan(
      userid, planId, transactionId, amount, remark) async {
    // await Provider.of<AuthProvider>(context, listen: false).registration(register, route);
    await Provider.of<PlanProvider>(context, listen: false).purchasePlan(
        userid, planId, transactionId, amount, remark, widget.type, route);
  }

  route(
    bool isRoute,
    String? token,
    String? tempToken,
    String? errorMessage,
  ) async {
    Fluttertoast.showToast(msg: "Plan Buy Successfully");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const DashBoardScreen()),
        (route) => false);
  }
}

class PlanItem extends StatefulWidget {
  final PlansData plan;
  final int selected;

  PlanItem({required this.plan, required this.selected});

  @override
  State<PlanItem> createState() => _PlanItemState();
}

class _PlanItemState extends State<PlanItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        // color: ColorResources.getImageBg(context),
        borderRadius: BorderRadius.circular(10),

        border: Border.all(
            color: widget.plan.selected == true
                ? ColorResources.getPrimary(context)
                : ColorResources.getSellerTxt(context),
            width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.plan.title.toString().toUpperCase(),
            style: robotoBold,
          ),
          Html(data: "Description: " + widget.plan.description.toString()),
          Text(
            "Price: ${widget.plan.amount}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "No of Days: ${widget.plan.days}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Levels : ${widget.plan.levels!.length} levels",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      45), // Adjust the border radius as needed
                  color: ColorResources.getLightSkyBlue(context), // Blush color
                ),
                child: IconButton(
                    // color: ColorResources.getLightSkyBlue(context),
                    onPressed: () {
                      setState(() {
                        widget.plan.isExpanded = !widget.plan.isExpanded;
                      });
                    },
                    icon: Icon(widget.plan.isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down)),
              )
            ],
          ),
          widget.plan.isExpanded
              ? Divider(
                  height: 0.5,
                )
              : SizedBox.shrink(),
          for (var level in widget.plan.levels!) ...[
            Visibility(
              visible: widget.plan.isExpanded,
              child: ListTile(
                tileColor: ColorResources.getImageBg(context), // Se
                title: Text("Level: " + level.level.toString()),
                subtitle: Text("Amount: " + level.amount.toString()),
              ),
            ),
          ]
        ],
        // trailing: Icon(
        //   _isExpanded! ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        // ),

        // Ensure the entire tile has a clickable area

        // Add any actions or additional information here
      ),
    );
  }
}
