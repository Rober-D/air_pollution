import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:work/database/mongodb_helper.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  static const String routeName = "TestScreen";

  @override
  Widget build(BuildContext context) {
    Query mqGas = FirebaseDatabase.instance.ref().child('MQ135_Gas').limitToLast(1);
    return Scaffold(
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: mqGas,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            int dht = snapshot.value as int;
            //dht['key'] = snapshot.key;
            return Column(
              children: [
                Text("DHT : ${dht}"),
                SizedBox(height: 20,),
                Text("DHT : ${dht}"),
                SizedBox(height: 20,),
              ],
            );
          },
        ),
      ),
    );
  }
}
