import 'package:budget_app/config/colors.dart';
import 'package:budget_app/config/text.dart';
import 'package:budget_app/model/user_model.dart';
import 'package:budget_app/resources/post_auth_method.dart';
import 'package:budget_app/view/Taskscreen.dart';
import 'package:budget_app/view/UI%20widgets/addtask_form.dart';
import 'package:budget_app/view/UI%20widgets/buttons.dart';
import 'package:budget_app/view/approot.dart';
import 'package:budget_app/view_model/Budget_category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../view_model/user_view_model.dart';

class TaskDuration extends StatefulWidget {
  const TaskDuration({Key? key}) : super(key: key);

  @override
  State<TaskDuration> createState() => _TaskDurationState();
}

class _TaskDurationState extends State<TaskDuration> {
  @override
  Widget build(BuildContext context) {
    BudgetCategoryModel budgetCategoryModel =
        context.watch<BudgetCategoryModel>();
    return Scaffold(
      backgroundColor: bkgrColor,
      appBar: AppBar(
        foregroundColor: blackColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: getBody(budgetCategoryModel, context),
    );
  }

  Widget getBody(
    BudgetCategoryModel budgetCat,
    context,
  ) {
    Users? user = Provider.of<UserProvider>(context).getUser;

    Map arguments = {};

    arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          AddTaskForm(
              budgetCat.hintDate,
              IconButton(
                  onPressed: () {
                    budgetCat.pickDate(context);
                  },
                  icon: const Icon(Icons.calendar_month, color: unselected)),
              false,
              null,
              null, false),
          const SizedBox(
            height: 40,
          ),
          AddTaskForm(
              budgetCat.selectedItem,
              DropdownButton(
                  dropdownColor: lightColor,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  elevation: 1,
                  items:
                      budgetCat.StatusList.map<DropdownMenuItem<String>>((val) {
                    return DropdownMenuItem<String>(
                        value: val,
                        child: Center(
                            child: Text(
                          val,
                          style: GoogleFonts.lato(fontSize: 12),
                        )));
                  }).toList(),

                  // underline: const Divider(color: bkgrColor,),
                  onChanged: (String? newVal) {
                    budgetCat.changeSelectedItem(newVal!, "Status");
                  }),
              false,
              budgetCat.selectedItem,
              null, false),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: AddTaskForm(
                    budgetCat.hintStartTime,
                    IconButton(
                        onPressed: () {
                          budgetCat.pickTime(context, true);
                        },
                        icon: const Icon(
                          Icons.schedule,
                          color: unselected,
                        )),
                    false,
                    null,
                    null, false),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: AddTaskForm(
                    budgetCat.hintEndTime,
                    IconButton(
                        onPressed: () {
                          budgetCat.pickTime(context, false);
                        },
                        icon: const Icon(Icons.schedule, color: unselected)),
                    false,
                    null,
                    null, false),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: AddTaskForm(
                    '${budgetCat.reminderVal} mins earlier',
                    DropdownButton(
                        dropdownColor: lightColor,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        elevation: 1,
                        items: budgetCat.Reminder.map<DropdownMenuItem<String>>(
                            (val) {
                          return DropdownMenuItem<String>(
                            value: val.toString(),
                            child: Text(val.toString(),
                                style: GoogleFonts.lato(fontSize: 12)),
                          );
                        }).toList(),

                        // underline: const Divider(color: bkgrColor,),
                        onChanged: (String? newVal) {
                          budgetCat.changeSelectedItem(
                              int.parse(newVal!), "Remind");
                        }),
                    false,
                    null,
                    null, false),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: AddTaskForm(
                    budgetCat.repeatVal,
                    DropdownButton(
                        dropdownColor: lightColor,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        elevation: 1,
                        items: budgetCat.Repeat.map<DropdownMenuItem<String>>(
                            (val) {
                          return DropdownMenuItem<String>(
                              value: val,
                              child: Center(
                                  child: Text(
                                val,
                                style: GoogleFonts.lato(fontSize: 12),
                              )));
                        }).toList(),

                        // underline: const Divider(color: bkgrColor,),
                        onChanged: (String? newVal) {
                          budgetCat.changeSelectedItem(newVal!, "Repeat");
                        }),
                    false,
                    null,
                    null, false),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              uploadTask(
                  name: user!.name,
                  uid: user.uid,
                  title: arguments["title"],
                  description: arguments["description"],
                  date: budgetCat.hintDate,
                  status: budgetCat.selectedItem,
                  startTime: budgetCat.hintStartTime,
                  endTime: budgetCat.hintEndTime,
                  reminder: budgetCat.reminderVal.toString(),
                  repeat: budgetCat.repeatVal

                  
                  );

                  
              print(arguments["title"]);
            },
            child: Button(
                Text(
                  'Add task',
                  style: lightlatobody,
                ),
                const Icon(
                  Icons.add,
                  color: lightColor,
                )),
          )
        ],
      ),
    ));
  }

//drop doen Button

  void uploadTask(
      {required String name,
      required String uid,
      required String title,
      required String description,
      required String date,
      required String status,
      required String startTime,
      required String endTime,
      required String reminder,
      required String repeat,
      
      }) async {
    String postAuth = await PostAuth().storePost(
        name: name,
        uid: uid,
        title: title,
        description: description,
        date: date,
        status: status,
        startTime: startTime,
        endTime: endTime,
        reminder: reminder,
        repeat:  repeat,
        
        
        );

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
   const  AppRoot()), (Route<dynamic> route) => false);
  }
}

