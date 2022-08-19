import 'package:budget_app/config/colors.dart';
import 'package:budget_app/config/text.dart';
import 'package:budget_app/model/user_model.dart';
import 'package:budget_app/resources/post_auth_method.dart';
import 'package:budget_app/view/UI%20widgets/addtask_form.dart';
import 'package:budget_app/view/UI%20widgets/buttons.dart';
import 'package:budget_app/view/addtask_time_screen.dart';
import 'package:budget_app/view_model/Budget_category_view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/user_view_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();



      @override
  void dispose() {
    super.dispose();
   _titleController;
     _descriptionController ;
  }


  @override
  Widget build(BuildContext context) {

   

    BudgetCategoryModel budgetCategoryModel =
        context.watch<BudgetCategoryModel>();
    return Scaffold(
      backgroundColor: bkgrColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: blackColor,
      ),
      body: getBody(budgetCategoryModel, context),
    );
  }



  Widget getBody(BudgetCategoryModel budgetCat, context) {
  return SingleChildScrollView(
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            AddTaskForm(
              'Task title',
              null,
              false,
              null, _titleController, false
           ),
            const SizedBox(
              height: 40,
            ),
            AddTaskForm('Task description', null, true, null, _descriptionController, false),
            const SizedBox(
              height: 40,
            ),
          
                GestureDetector(
                    onTap: () {
                    
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const TaskDuration(), 
                         settings: RouteSettings(

                           arguments: {


                            "title":  _titleController.text,
                            "description": _descriptionController.text

                          }
                         )
                     ));
                 
                    },
                    child: Button( Text('Next', style: lightlatobody,), const Icon(Icons.keyboard_arrow_right, color: lightColor,) )
             
                )],
        )),
  );
}







}


