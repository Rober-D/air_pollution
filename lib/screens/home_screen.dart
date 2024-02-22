import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:work/colors.dart';
import 'package:work/screens/feedback_screen.dart';
import 'package:work/state%20management/gases_provider.dart';

import '../database/mongodb_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    GasesProvider airData = Provider.of<GasesProvider>(context);

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedItem,
          onTap: (index) {
            setState(() {
              _selectedItem = index;
            });
          },
          backgroundColor: Colors.grey[200],
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: ConstColors.iconColor),
            BottomNavigationBarItem(
              icon: Icon(Icons.feedback),
              label: "Feedback",
              backgroundColor: ConstColors.iconColor,
            )
          ],
        ),
        body: FutureBuilder(
          future: MongoDB.get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var dataLength = snapshot.data.length;
                airData.readGases(snapshot.data);
                return _selectedItem == 0
                    ? SafeArea(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35.0),
                              child: Column(
                                children: [
                                  Row(children: const [
                                    Text(
                                      "Overview",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: PieChart(
                                          chartType: ChartType.ring,
                                          ringStrokeWidth: 25,
                                          chartRadius: 175,
                                          dataMap: {
                                            "Co2": snapshot.data[dataLength-1]["Co2"],
                                            "Temperature": snapshot.data[dataLength-1]["Temperature"],
                                            "Humidity": snapshot.data[dataLength-1]["Humidity"],
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: const [
                                  Text(
                                    "Gases Overview",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: Row(
                                          //Future Builder
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Co2",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "${snapshot.data[index]["Co2"]}",
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                  itemCount: 3,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                            height: 40,
                                            color: Colors.grey,
                                            thickness: 2,
                                            indent: 30,
                                            endIndent: 30,
                                          )),
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 2,
                              indent: 30,
                              endIndent: 30,
                            ),
                          ],
                        ),
                      )
                    : const FeedbackScreen();
              } else {
                return Center(
                  child: Text("No Data Available"),
                );
              }
            }
          },
        ));
  }
}
