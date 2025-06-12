import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/withdrawmodel.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/plan_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../helper/price_converter.dart';
import '../../../provider/splash_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../basewidget/custom_app_bar.dart';
import '../../basewidget/textfield/custom_textfield.dart';

class WithDrawRequest extends StatefulWidget {
  const WithDrawRequest();

  @override
  State<WithDrawRequest> createState() => _WithDrawRequestState();
}

class _WithDrawRequestState extends State<WithDrawRequest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PlanProvider>(context, listen: false).initWithDrawList(
        context, Provider.of<AuthProvider>(context, listen: false).getAuthID());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: CustomAppBar(
            title: "WithDraw Request",
            isBackButtonExist: true,
            isSkip: false,
          )),
      body: SingleChildScrollView(
        child: InkWell(
            onTap: () {},
            child: Consumer<PlanProvider>(
                builder: (context, orderProvider, child) =>
                    Provider.of<PlanProvider>(context).isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                orderProvider.withdrawModel!.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return WithDrawItem(
                                plan: orderProvider.withdrawModel!.data![index],
                              );
                            },
                          ))),
      ),

      // floatingActionButton:
      //   InkWell(
      //     onTap: () => showModalBottomSheet(
      //         backgroundColor: Colors.transparent,
      //         isScrollControlled: true,
      //         context: context, builder: (_) =>  CustomEditDialog()),
      //     child: Container(height: 40,width: 250,
      //       decoration: BoxDecoration(color: const Color(0xFFEEF6FF),
      //           borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      //       child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      //         InkWell(onTap: () => showModalBottomSheet(
      //             backgroundColor: Colors.transparent,
      //             isScrollControlled: true,
      //             context: context, builder: (_) => const CustomEditDialog()),
      //           child: Text(getTranslated('send_withdraw_request', context)!,
      //               style:titilliumRegular.copyWith(color: Theme.of(context).primaryColor,
      //                   fontSize: Dimensions.fontSizeLarge)),
      //         ),
      //
      //       ],),
      //     ),
      //   ),
    );
  }
}

class WithDrawItem extends StatefulWidget {
  final WithdrawData? plan;

  WithDrawItem({required this.plan});

  @override
  State<WithDrawItem> createState() => _WithDrawItemState();
}

class _WithDrawItemState extends State<WithDrawItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        // color: ColorResources.getImageBg(context),
        borderRadius: BorderRadius.circular(10),

        border: Border.all(
            color: true
                ? ColorResources.getPrimary(context)
                : ColorResources.getSellerTxt(context),
            width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.plan?.walletType?.toString().toUpperCase()}",
            style: robotoBold,
          ),
          // Html(data : "Description: " +"${widget.plan!.status?.toString().toUpperCase()}"),
          Text(
            "Total Amount : ${splashProvider.myCurrency!.symbol}${widget.plan?.amount?.toString().toUpperCase()}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),

          Text(
            "Admin Commission: ${splashProvider.myCurrency!.symbol}${widget.plan?.adminCommission}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Tds:${splashProvider.myCurrency!.symbol} ${widget.plan?.tds}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Repurchase Income: ${splashProvider.myCurrency!.symbol}${widget.plan?.repurchaseIncome?.toString().toUpperCase()}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Receive Amount: ${splashProvider.myCurrency!.symbol}${widget.plan?.remaningAmount}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          Text(
            "Created at: ${widget.plan?.createdAt?.toString().toUpperCase()}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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

class CustomEditDialog extends StatefulWidget {
  final wallet_type;
  final amount;
  CustomEditDialog(
    this.wallet_type,
    this.amount,
  );

  @override
  CustomEditDialogState createState() => CustomEditDialogState();
}

class CustomEditDialogState extends State<CustomEditDialog> {
  final TextEditingController _balanceController = TextEditingController();
  GlobalKey<FormState>? _formKey;
  @override
  void initState() {
    // Provider.of<ProfileProvider>(context, listen: false).setMethodTypeIndex(0, notify: false);
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  TextEditingController userName = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController accountType = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Provider.of<ThemeProvider>(context).darkTheme
              ? const Color(0xFF25282B)
              : const Color(0xFFFCFCFC),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.keyboard_arrow_down)),
              const SizedBox(
                height: Dimensions.paddingSizeExtraSmall,
              ),
              Consumer<ProfileProvider>(builder: (context, withdraw, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeDefault,
                    horizontal: Dimensions.paddingSizeSmall,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: Dimensions.paddingSizeSmall),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                prefixIcon: const Icon(Icons.person),
                                textInputType: TextInputType.text,
                                // border: true,
                                controller: userName,
                                hintText: "Account Holder name",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: Dimensions.paddingSizeSmall),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                prefixIcon:
                                    const Icon(Icons.account_balance_outlined),
                                textInputType: TextInputType.text,
                                // border: true,
                                controller: bankName,
                                hintText: "Bank Name",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: Dimensions.paddingSizeSmall),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                prefixIcon:
                                    const Icon(Icons.account_balance_outlined),
                                textInputType: TextInputType.number,
                                isZipCode: true,
                                length: 16,
                                // border: true,
                                controller: accountNumber,
                                hintText: "Account Number",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: Dimensions.paddingSizeSmall),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                prefixIcon: const Icon(Icons.code),
                                textInputType: TextInputType.text,
                                textAlign: TextAlign.start,
                                isZipCode: true,
                                length: 11,
                                // border: true,
                                controller: ifscCode,
                                hintText: "Ifsc Code",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: Dimensions.paddingSizeSmall),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                prefixIcon:
                                    const Icon(Icons.account_balance_outlined),
                                textInputType: TextInputType.text,
                                // border: true,
                                controller: accountType,
                                hintText: "Account Type",
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeSmall),
                        //   decoration: BoxDecoration(color: Theme.of(context).cardColor,
                        //       border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),
                        //       borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                        //   child: DropdownButton<int>(
                        //     value: withdraw.methodSelectedIndex,
                        //     items: withdraw.methodsIds.map((int? value) {
                        //       return DropdownMenuItem<int>(
                        //         value: withdraw.methodsIds.indexOf(value),
                        //         child: Text(withdraw.methodList[(withdraw.methodsIds.indexOf(value))].methodName!),);}).toList(),
                        //     onChanged: (int? value) {
                        //       withdraw.setMethodTypeIndex(value);
                        //     },
                        //     isExpanded: true, underline: const SizedBox(),),),

                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        // Padding(
                        //   padding:  const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                        //   child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       CustomTextField(
                        //         textInputType:  TextInputType.number,
                        //         // border: true,
                        //         controller: inputFieldControllerList,
                        //         hintText: "withdraw amount",
                        //
                        //       ),
                        //     ],
                        //   ),
                        // )
                        // if(withdraw.methodList.isNotEmpty &&
                        //     withdraw.methodList[withdraw.methodSelectedIndex!].methodFields != null &&
                        //     withdraw.inputFieldControllerList.isNotEmpty &&
                        //     withdraw.methodList[withdraw.methodSelectedIndex!].methodFields!.isNotEmpty)
                        //   ListView.builder(
                        //       physics: const NeverScrollableScrollPhysics(),
                        //       shrinkWrap: true,
                        //       itemCount: withdraw.methodList[withdraw.methodSelectedIndex!].methodFields!.length,
                        //       itemBuilder: (context, index){
                        //
                        //         String? type = withdraw.methodList[withdraw.methodSelectedIndex!].methodFields![index].inputType;
                        //
                        //         return
                        //         Padding(
                        //           padding:  const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                        //           child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               CustomTextField(
                        //                 textInputType: (type == 'number' || type == "phone") ? TextInputType.number:
                        //                 TextInputType.text,
                        //                 // border: true,
                        //                 controller: withdraw.inputFieldControllerList[index],
                        //                 hintText: withdraw.methodList[withdraw.methodSelectedIndex!].methodFields![index].placeholder,
                        //
                        //               ),
                        //             ],
                        //           ),
                        //         );
                        //       })
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Enter Amount",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.fontSizeDefault),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      Provider.of<SplashProvider>(context, listen: false)
                          .myCurrency!
                          .symbol!,
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.paddingSizeSmall)),
                  IntrinsicWidth(
                    child: TextField(
                      controller: _balanceController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: 'Ex: 500',
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset(Images.inputLine),
              const SizedBox(
                height: 35,
              ),
              !Provider.of<ProfileProvider>(context).isLoading
                  ? Consumer<ProfileProvider>(builder: (context, withdraw, _) {
                      return InkWell(
                        onTap: () {
                          bool haveBlankTitle = false;
                          if (_balanceController.text.isEmpty) {
                            haveBlankTitle = true;
                          }
                          print("object AAAAA ");
                          if (Provider.of<ProfileProvider>(context,
                                      listen: false)
                                  .kycInfoModel ==
                              null) {
                            print("object AAAAA ");
                            Fluttertoast.showToast(
                                msg: "Please verify kyc is approved",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);

                            return;
                          } else if (Provider.of<ProfileProvider>(context,
                                      listen: false)
                                  .kycInfoModel!
                                  .status ==
                              0) {
                            Fluttertoast.showToast(
                                msg: "Please verify kyc is approved",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);

                            return;
                          }

                          // if (_formKey!.currentState!.validate()) {
                          //   print("object AAAA ");
                          // } else
                          if (!_formKey!.currentState!.validate() &&
                              _balanceController.text.toString().isEmpty) {
                            showCustomSnackBarTop(
                                "Please Enter Amount grater than ${AppConstants.balance}",
                                context,
                                isToaster: true);
                            Fluttertoast.showToast(
                                msg:
                                    "Please Enter Amount grater than ${AppConstants.balance}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (0.0 >=
                              double.parse(
                                  _balanceController.text.toString())) {
                            Fluttertoast.showToast(
                                msg:
                                    "Please Enter Amount grater than ${AppConstants.balance}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (AppConstants.balance >
                              double.parse(
                                  _balanceController.text.toString())) {
                            Fluttertoast.showToast(
                                msg:
                                    "Please Enter Amount grater than ${AppConstants.balance}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (widget.amount <
                              double.parse(
                                  _balanceController.text.toString())) {
                            Fluttertoast.showToast(
                                msg:
                                    "Please Enter Amount less than your balance",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (widget.amount < AppConstants.balance) {
                            Fluttertoast.showToast(
                                msg:
                                    "Please maintain ${AppConstants.balance} balance",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (widget.amount < AppConstants.balance) {
                            Fluttertoast.showToast(
                                msg:
                                    "Please maintain ${AppConstants.balance} balance",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (haveBlankTitle) {
                            Fluttertoast.showToast(
                                msg: "Please Enter Amount",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            withdrawBalance();
                          }
                        },
                        child: Card(
                          color: Theme.of(context).primaryColor,
                          child: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text("Withdraw",
                                  style: const TextStyle(
                                      fontSize: Dimensions.fontSizeLarge,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      );
                    })
                  : Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor))),
            ],
          ),
        ),
      ),
    );
  }

  void withdrawBalance() async {
    String balance = '0';
    double bal = 0;
    balance = _balanceController.text.trim();
    if (balance.isNotEmpty) {
      bal = double.parse(balance);
    }
    if (balance.isEmpty) {
      showCustomSnackBar("Enter balance", context, isToaster: true);
    } else {
      await Provider.of<PlanProvider>(context, listen: false)
          .initwithDrawMyRequestList(
              context,
              Provider.of<AuthProvider>(context, listen: false).getAuthID(),
              widget.wallet_type,
              balance,
              userName.text.toString(),
              bankName.text.toString(),
              accountNumber.text.toString(),
              ifscCode.text.toString(),
              accountType.text.toString());
      // TextEditingController bankName = TextEditingController();
      // TextEditingController accountNumber = TextEditingController();
      // TextEditingController ifscCode = TextEditingController();
      // TextEditingController accountType = TextEditingController();
    }
  }
}
