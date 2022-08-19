import 'package:budget_app/config/colors.dart';
import 'package:budget_app/config/icons.dart';
import 'package:budget_app/config/text.dart';
import 'package:budget_app/model/user_model.dart';
import 'package:budget_app/view_model/Budget_category_view_model.dart';
import 'package:budget_app/view_model/user_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    BudgetCategoryModel budgetCategoryModel =
        context.watch<BudgetCategoryModel>();
    return Scaffold(
        backgroundColor: bkgrColor,
        body: SafeArea(child: getBody(context, budgetCategoryModel)));
  }

  Widget getBody(
    context,
    BudgetCategoryModel budgetCat,
  ) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      budgetCat.selectedDate,
                      style: latoheading2,
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                datePicker(budgetCat.selectedDate, budgetCat.changeDate),
                const SizedBox(
                  height: 40,
                ),

                // Listview body for outputing the differentclc cataegories
                Expanded(child: postWidget(context, size, budgetCat)),
              ],
            ),
          ),
        ],
      ),
    );
  }

//Date Picker widget

  Widget datePicker(selecteddate, Function changeDate) {
    return DatePicker(
      DateTime.now(),
      height: 100,
      width: 60,
      initialSelectedDate: DateTime.now(),
      selectionColor: primColor,
      dateTextStyle: GoogleFonts.lato(
          fontSize: 16, fontWeight: FontWeight.bold, color: unselected),
      dayTextStyle: GoogleFonts.lato(fontSize: 12, color: unselected),
      monthTextStyle: GoogleFonts.lato(fontSize: 12, color: unselected),
      onDateChange: (date) {
        changeDate(date);
      },
    );
  }

//post widget

  Widget postWidget(context, size, BudgetCategoryModel budgetCat) {
    Users? user = Provider.of<UserProvider>(context).getUser;

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Posts").snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: lightColor),
            );
          } else {
            return ListView.builder(
                itemCount: snapShot.data!.docs.length,
                itemBuilder: (context, index) {
                  var snap = snapShot.data!.docs[index].data();

                  if (user?.uid == snap["uid"]) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.25,
                        decoration: BoxDecoration(
                          color: lightColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    snap["status"] == "Urgent"
                                        ? Text(
                                            snap["status"],
                                            style: GoogleFonts.lato(
                                                color: urgent, fontSize: 20),
                                          )
                                        : snap["status"] == "Ongoing"
                                            ? Text(snap["status"],
                                                style: GoogleFonts.lato(
                                                    color: ongoing,
                                                    fontSize: 20))
                                            : snap["status"] == "Running"
                                                ? Text(snap["status"],
                                                    style: GoogleFonts.lato(
                                                        color: running,
                                                        fontSize: 20))
                                                : Container(),
                                    const Icon(
                                      Icons.more_vert_outlined,
                                      color: unselected,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: unselected,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 70,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      snap["status"] == "Urgent"
                                          ? Container(
                                              height: 65,
                                              width: 5,
                                              color: urgent,
                                            )
                                          : snap["status"] == "Ongoing"
                                              ? Container(
                                                  height: 65,
                                                  width: 5,
                                                  color: ongoing,
                                                )
                                              : snap["status"] == "Running"
                                                  ? Container(
                                                      height: 65,
                                                      width: 5,
                                                      color: running,
                                                    )
                                                  : Container(),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: size.width * 0.7,
                                            child: Text(
                                              snap["title"],
                                              style: latoheading3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.schedule,
                                                    color: unselected,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      "${snap['startTime']} - ${snap['endTime']}",
                                                      style: latobody2),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                   return Container();
                  }
                });
          }
        });
  }
}
