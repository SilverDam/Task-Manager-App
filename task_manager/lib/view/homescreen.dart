import 'package:budget_app/config/colors.dart';
import 'package:budget_app/config/text.dart';
import 'package:budget_app/model/user_model.dart';
import 'package:budget_app/view_model/Budget_category_view_model.dart';
import 'package:budget_app/view_model/user_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
     BudgetCategoryModel budgetCat =
        context.watch<BudgetCategoryModel>();
    Users? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        backgroundColor: bkgrColor,
        body: Scaffold(
            backgroundColor: bkgrColor,
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Column(
                children: [
                  Expanded(child: getBody(context, user, budgetCat)),
                ],
              ),
            ))));
  }




Widget getBody(context, Users? user, BudgetCategoryModel budget) {
  var size = MediaQuery.of(context).size;
  

  return Column(
    children: [
      Center(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          height: 100,
          width: size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: blackColor,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: lightColor,
                  radius: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Hi, ${user?.name}",
                  style: lightlatoheading2,
                )
              ],
            ),
          ),
        ),
      ),

      const SizedBox(height: 40),

      Expanded(child: postWidget(context, size, budget))
    ],
  );
}




// output all task




  Widget postWidget(context, size, BudgetCategoryModel budgetCat) {
    Users? user = Provider.of<UserProvider>(context).getUser;

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Posts").orderBy("date").snapshots(),
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

