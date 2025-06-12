import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/plans_model.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/plan_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/my_plan_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';

class MyPlansScreen extends StatefulWidget {
  // MyPlansScreen({super.key});
  MyPlansScreen({Key? key,}) : super(key: key);
  @override
  State<MyPlansScreen> createState() => _MyPlansScreenState();
}

class _MyPlansScreenState extends State<MyPlansScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PlanProvider>(context, listen: false).initPlansList(context,Provider.of<AuthProvider>(context, listen: false).getAuthID());

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:   PreferredSize(preferredSize: const Size.fromHeight(80.0),
          child: CustomAppBar(title:
          "My Plans", isBackButtonExist: true,isSkip: false,)),
      body: SingleChildScrollView(
        child:  InkWell(
            onTap: (){

            },
            child:Consumer<PlanProvider>(
                builder: (context, orderProvider, child) =>
                Provider.of<PlanProvider>(context).isLoading ?
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor,),),) :
                orderProvider.myplans != null ? PlanItem(plan: orderProvider.myplans,) : Center(
                  child: Container(

                    child: Text("No plans "),
                  ),
                ))),
      ),
    );
  }
}


class PlanItem extends StatefulWidget {
  final MyPlansModel? plan;


  PlanItem({required this.plan});

  @override
  State<PlanItem> createState() => _PlanItemState();
}

class _PlanItemState extends State<PlanItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return
      Container(

        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        margin: const EdgeInsets.all( Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          // color: ColorResources.getImageBg(context),
          borderRadius: BorderRadius.circular(10),

          border: Border.all(color:  true ?
          ColorResources.getPrimary(context)
              : ColorResources.getSellerTxt(context), width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.plan?.data?.planData!.title?.toString().toUpperCase()}",style: robotoBold,),
            Html(data : "Description: " +"${widget.plan!.data?.planData!.description?.toString().toUpperCase()}"),
            Text(
              "Price: ${widget.plan?.data?.planData!.amount?.toString().toUpperCase()}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Text(
              "No of Days: ${widget.plan?.data?.planData!.days?.toString().toUpperCase()}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Levels :  ${widget.plan?.data?.planData!.levels!.length?.toString().toUpperCase()} levels",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45), // Adjust the border radius as needed
                    color: ColorResources.getLightSkyBlue(context), // Blush color
                  ),
                  child: IconButton(
                    // color: ColorResources.getLightSkyBlue(context),
                      onPressed: (){
                        setState(() {
                          // widget.plan.isExpanded = !widget.plan.isExpanded;
                        });
                      }, icon: Icon( true? Icons.keyboard_arrow_up:Icons.keyboard_arrow_down)),
                )
              ],
            ),
            true ? Divider(height: 0.5,) :SizedBox.shrink(),
            for (var level in  widget.plan!.data!.planData!.levels!)...[
              Visibility(
                visible: true,
                child: ListTile(
                  tileColor: ColorResources.getImageBg(context), // Se
                  title: Text("Level: "+level.level.toString()),
                  subtitle: Text("Amount: "+level.amount.toString()),
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