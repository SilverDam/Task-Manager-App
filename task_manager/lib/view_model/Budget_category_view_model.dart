import 'package:budget_app/config/colors.dart';
import 'package:budget_app/model/budget_category_model.dart';
import 'package:budget_app/view/Taskscreen.dart';
import 'package:budget_app/view/addtask.dart';

import 'package:budget_app/view/addtaskscreen.dart';
import 'package:budget_app/view/chartscreen.dart';
import 'package:budget_app/view/homescreen.dart';
import 'package:budget_app/view/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetCategoryModel with ChangeNotifier {

// bool _isLoading = false;

List <BudgetCategory> budgetCategory = [
  BudgetCategory("Electricity", const Icon(Icons.electrical_services)),
    BudgetCategory("Electricity", const Icon(Icons.electrical_services)),
      BudgetCategory("Electricity", const Icon(Icons.electrical_services)),
        BudgetCategory("Electricity", const Icon(Icons.electrical_services)),
          BudgetCategory("Electricity", const Icon(Icons.electrical_services)),
];


// selected date 

var selectedDate = DateFormat.yMMMMd().format(DateTime.now());


// change selected date function
changeDate(date) {
  selectedDate = DateFormat.yMMMMd().format(date);
  notifyListeners();
    
}


// page navigation
  int pageIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const TaskScreen(),
    
  ];


// page navigation function
selectedTab(int index) {
    pageIndex = index;
    notifyListeners();
    
}


//All navigation functiom



//AddTask screen Navigation

AddTaskScreenNav(context) {
    
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTask()));
}



// navigate to addTaskdurationScreen


     





// bool get isLoading => _isLoading;
// List <BudgetCategory> get budgetCategory => _budgetCategory;


// setLoading(bool isLoading) async {
//   _isLoading = isLoading;
//    notifyListeners();


//show date picker function


String hintDate = DateFormat.yMd().format(DateTime.now());

 pickDate(context) async {

  DateTime?  taskDate = await showDatePicker(
    context: context,
     initialDate: DateTime.now(), 
     firstDate: DateTime(2015), 
     lastDate: DateTime(2025)

     builder:  (context, child ) {
       return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: primColor, // header background color
              onPrimary: lightColor, // header text color
              onSurface: unselected, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: blackColor, // button text color
              ),
            ),
          ),
          child: child!,

       )
     }
  );
  
     if (taskDate !=  null ) {
           
          hintDate = DateFormat.yMd().format(taskDate);
              
     } else {
       print('something went wrong');
     }

 notifyListeners();

}








 // show time picker function


 String hintStartTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

String hintEndTime = '4:30  AM';



pickTime (context, bool isStartTime )async {

    TimeOfDay? pickedTime = await  showTimePicker(

       initialEntryMode:  TimePickerEntryMode.input,
       
       context: context,
       initialTime:  TimeOfDay(
         
         hour: int.parse(hintStartTime.split(":")[0]), 
         
         minute: int.parse(hintStartTime.split(":")[1].split(" ")[0]),),
      
       );

    var formattedTime = pickedTime?.format(context);

    if(pickedTime == null) {

      print('Date not found');

    }else if (isStartTime == true){
          
      hintStartTime = formattedTime!;
         
    }else if (isStartTime == false){
           

           hintEndTime = formattedTime!;
        


    }

    notifyListeners();

}




// DropDown arrows logic 

//status logic
String selectedItem = "Urgent";

List StatusList = [
   
  "Urgent", "Ongoing",  "Running",

];


// reminder logic

int reminderVal = 5;

List Reminder= [
   
  5, 10, 20, 25, 30

];


// repeat logic
String repeatVal = "Daily";

List Repeat= [
   
  "Daily", "Weekly",  "Monthly",

];


// drop down function
changeSelectedItem (newItem, String checkDrop) {

  if(checkDrop == "Status") {
         selectedItem = newItem;
  } else if (checkDrop == "Remind") {
          
          reminderVal = newItem; 

  } else if (checkDrop == "Repeat") {
          
        repeatVal = newItem;

  }  else {
     print("No selected value");
  }
  
  notifyListeners();
   
}


}
 










// setBudgetCategory(){

//   _budgetCategory.add(value)
// }

// outputBudgetCategory(){
//   setLoading(true);
//   setBudgetCategory();
//   setLoading(false);
// }

//}

// List <BudgetCategory> budgetCategories =  [
//   BudgetCategory("Food", const Icon(Icons.food_bank_outlined)),
//    BudgetCategory("Electricity", const Icon(Icons.electrical_services)),
// ];  