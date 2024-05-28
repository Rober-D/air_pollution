import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:work/colors.dart';
import 'package:work/screens/feedback_screen.dart';
import 'package:work/state%20management/gases_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedItem = 0;

  @override
  @override
  void initState() {
    var gases = context.read<GasesProvider>();

    super.initState();

    Query mqGas = FirebaseDatabase.instance.ref().child('MQ135_Gas').limitToLast(1);
    Query mqCo2 = FirebaseDatabase.instance.ref().child('MQ7_CO2').limitToLast(1);

    mqGas.onValue.listen((DatabaseEvent event) {
      try {
        Map data = event.snapshot.value as Map;
        data.forEach((key, value) {
          gases.addGas(value);
        });
      } catch (e) {
        print('Error processing MQ135_Gas data: $e');
      }
    });

    mqCo2.onValue.listen((DatabaseEvent event) {
      try {
        Map data = event.snapshot.value as Map;
        data.forEach((key, value) {
          gases.addGas(value);
        });
      } catch (e) {
        print('Error processing MQ7_CO2 data: $e');
      }
    });

    Query dhtTemperature = FirebaseDatabase.instance
        .ref()
        .child('DHT11')
        .child('Temperature')
        .limitToLast(1);
    Query dhtHumidity = FirebaseDatabase.instance
        .ref()
        .child('DHT11')
        .child('Humidity')
        .limitToLast(1);

    dhtTemperature.onValue.listen((DatabaseEvent event) {
      try {
        Map data = event.snapshot.value as Map;
        data.forEach((key, value) {
          gases.addTemperatureAndHumidity(value);
        });
      } catch (e) {
        print('Error processing DHT11 Temperature data: $e');
      }
    });

    dhtHumidity.onValue.listen((DatabaseEvent event) {
      try {
        Map data = event.snapshot.value as Map;
        data.forEach((key, value) {
          gases.addTemperatureAndHumidity(value);
        });
      } catch (e) {
        print('Error processing DHT11 Humidity data: $e');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    List<String> gasesList = ["MQ135_Gas", "MQ7_CO2"];
    GasesProvider gasesProvider = Provider.of<GasesProvider>(context);

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
        body: gasesProvider.gasesFromSensors.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : _selectedItem == 0
                ? Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Column(
                          children: [
                            Row(children: const [
                              Text(
                                "Overview",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ]),
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: PieChart(
                                    chartType: ChartType.ring,
                                    ringStrokeWidth: 25,
                                    chartRadius: 175,
                                    dataMap: {
                                      gasesList[0]: double.parse(gasesProvider.gasesFromSensors[0].toString()),
                                      gasesList[1]: double.parse(gasesProvider.gasesFromSensors[1].toString())
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
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: const [
                            Text(
                              "Gases Overview",
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
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
                                      Text(
                                        gasesList[index],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "${gasesProvider.gasesFromSensors[index]}",
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                            itemCount: gasesList.length,
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
                  )
                : const FeedbackScreen());
  }
}
