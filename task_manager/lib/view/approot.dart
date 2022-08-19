import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:budget_app/view_model/Budget_category_view_model.dart';
import 'package:budget_app/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';
import '../config/icons.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {



  @override
  void initState() {
  
    super.initState();
    addUser();
  }
 
  addUser()async {
    
     
     UserProvider _userProvider = Provider.of(context, listen: false);
     await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {


      Map arguments = {};

      arguments = ModalRoute.of(context)!.settings.arguments as Map ;

     BudgetCategoryModel budgetCategoryModel = context.watch<BudgetCategoryModel>();
    return Scaffold(


                 
                 body: getBody(budgetCategoryModel.pageIndex, budgetCategoryModel.pages,),

                 bottomNavigationBar: bottomNavigation(budgetCategoryModel.selectedTab, budgetCategoryModel.pageIndex) ,

               floatingActionButton: FloatingActionButton(
    
            onPressed: () {
              budgetCategoryModel.AddTaskScreenNav(context);
            },
            child: const Icon(
              Icons.add,
              size: 25,
            ),
            backgroundColor: primColor
            //params
            ),
               floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
    );
  }
}

  Widget getBody(int pageval, List<Widget> pages) {
    return IndexedStack(
      index:pageval,
      children: pages ,
    );
  }

// Bottom Navigation Widget

Widget bottomNavigation (Function selectedTab, int pageIndex) {

      return AnimatedBottomNavigationBar(
      backgroundColor: bkgrColor,
      activeColor: primColor,
      splashColor: primColor,
      inactiveColor: unselected ,
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        selectedTab(index);
       // print(index);
            
      },
    
    );
}