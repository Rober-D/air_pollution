import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work/routes.dart';
import 'package:work/screens/details_screen.dart';
import 'package:work/screens/feedback_screen.dart';
import 'package:work/screens/home_screen.dart';
import 'package:work/screens/start_screen.dart';
import 'package:work/state%20management/gases_provider.dart';
import 'database/mongodb_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDB.connect();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GasesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Routes.generateRoute,
      home: StartScreen(),
    );
  }
}
