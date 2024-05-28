import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work/screens/details_screen.dart';
import 'package:work/screens/feedback_screen.dart';
import 'package:work/screens/home_screen.dart';
import 'package:work/screens/start_screen.dart';
import 'package:work/screens/test_model_screen.dart';

class Routes{

  static Route<dynamic> generateRoute (RouteSettings settings){
    switch (settings.name){
      case StartScreen.routeName:
        return MaterialPageRoute(builder: (context)=> StartScreen(), settings: settings);
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context)=> const HomeScreen(), settings: settings);
      case FeedbackScreen.routeName:
        return MaterialPageRoute(builder: (context)=> const FeedbackScreen(), settings: settings);
      case DetailsScreen.routeName:
        return MaterialPageRoute(builder: (context)=> const DetailsScreen(), settings: settings);
      case TestScreen.routeName:
        return MaterialPageRoute(builder: (context)=> const TestScreen(), settings: settings);
      default:
        return MaterialPageRoute(builder: (context)=>  const StartScreen(), settings: settings);
    }
  }
}