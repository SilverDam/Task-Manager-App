import 'package:budget_app/config/colors.dart';
import 'package:budget_app/view/Onboarding%20screens/onboard_screen.dart';
import 'package:budget_app/view/approot.dart';
import 'package:budget_app/view/login_screen.dart';
import 'package:budget_app/view/splashscreen.dart';
import 'package:budget_app/view_model/Budget_category_view_model.dart';
import 'package:budget_app/view_model/user_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyA4Cy6uTGQv5aeaD_5TDb_xWSZODjyM134",
      appId: "1:835906809231:web:3f344668f3fe5970d0effa",
      messagingSenderId: "835906809231",
      projectId: "task-management-app-99c32",
      storageBucket: "task-management-app-99c32.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BudgetCategoryModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'BuddiePlan',
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const AppRoot();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: lighText,
                ),
              );
            }
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
