import 'package:flutter/material.dart';
import 'package:work/colors.dart';
import 'package:fl_chart/fl_chart.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});
  static const String routeName = "detailsScreen";
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  List<FlSpot> points = [
    FlSpot(0, 1),
    FlSpot(1, 3),
    FlSpot(2, 10),
    FlSpot(3, 7),
    FlSpot(4, 12),
    FlSpot(5, 13),
    FlSpot(6, 17),
    FlSpot(7, 15),
    FlSpot(8, 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Co2 level",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        leadingWidth: 80,
        leading: TextButton(
          onPressed: () {},
          child: const Text(
            "Back",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: ConstColors.primeGreen),
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [

            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: 400,
                height: 300,
                child: LineChart(
                  LineChartData(
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(spots: points),
                      ]),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
