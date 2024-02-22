import 'package:flutter/material.dart';
import 'package:work/screens/home_screen.dart';

import '../colors.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  static const String routeName = "startScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.primeGreen,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Container(
            //color: Colors.white,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Center(
                  child: Text("Welcome !",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 120,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ConstColors.startButtonColor),
                      minimumSize: MaterialStateProperty.all<Size>(Size(200, 50))
                  ),
                  child: const Text(
                    "S t a r t",
                    style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
