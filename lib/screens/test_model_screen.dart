import 'package:flutter/material.dart';
import 'package:work/database/mongodb_helper.dart';

class TestModel extends StatelessWidget {
  const TestModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: MongoDB.get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              var dataLength = snapshot.data.length;
              return ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    Text("${snapshot.data[index]["firstName"]}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("${snapshot.data[index]["lastName"]}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("${snapshot.data[index]["address"]}"),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                itemCount: snapshot.data.length,
              );
            } else {
              return Center(
                child: Text("No Data Available"),
              );
            }
          }
        },
      )),
    );
  }
}
