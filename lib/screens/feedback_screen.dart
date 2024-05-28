import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work/colors.dart';
import '../shared/widgets/air_quality.dart';
import '../state management/gases_provider.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  static const String routeName = "feedbackScreen";

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  @override
  void initState() {
    var sensorsProvider = context.read<GasesProvider>();

    super.initState();

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
          sensorsProvider.addTemperatureAndHumidity(value);
        });
      } catch (e) {
        print('Error processing DHT11 Temperature data: $e');
      }
    });

    dhtHumidity.onValue.listen((DatabaseEvent event) {
      try {
        Map data = event.snapshot.value as Map;
        data.forEach((key, value) {
          sensorsProvider.addTemperatureAndHumidity(value);
        });
      } catch (e) {
        print('Error processing DHT11 Humidity data: $e');
      }
    });
  }


  Image co2 = const Image(
    image: AssetImage("assets/co2.png"),
  );
  Image temperature = const Image(
    image: AssetImage("assets/temp.png"),
  );
  Image humidity = const Image(
    image: AssetImage("assets/humidity.png"),
  );

  List<String> quality = ["Poor", "Fair", "Good"];
  List<Image> qualityImg = [
    const Image(
      image: AssetImage("assets/bad.png"),
    ),
    const Image(
      image: AssetImage("assets/fair.png"),
    ),
    const Image(
      image: AssetImage("assets/good.png"),
    )
  ];
  List<String> feedback = [
    "Ensure all windows all fully open, leaving the room and re-check after 5 mins",
    "Please Fully open windows",
    "Mechanical ventilation in operation Fan speed low"
  ];
  List<Color> colors = [
    ConstColors.poorColor,
    ConstColors.fairColor,
    ConstColors.goodColor
  ];

  @override
  Widget build(BuildContext context) {
    GasesProvider airData = Provider.of<GasesProvider>(context);
    int check = airData.checkQuality();

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            check == 0 ? colors[0] : (check == 1 ? colors[1] : colors[2]),
        elevation: 0,
        title: const Center(
            child: Text(
          "Room",
          style: TextStyle(fontSize: 30),
        )),
      ),
      body: airData.temperatureAndHumidity.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.28,
                  decoration: BoxDecoration(
                    color: check == 0
                        ? colors[0]
                        : (check == 1 ? colors[1] : colors[2]),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: check == 0
                            ? qualityImg[0]
                            : (check == 1 ? qualityImg[1] : qualityImg[2]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      check == 0
                          ? Text(
                              quality[0],
                              style: const TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          : (check == 1
                              ? Text(
                                  quality[1],
                                  style: const TextStyle(
                                      fontSize: 35,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  quality[2],
                                  style: const TextStyle(
                                      fontSize: 35,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: check == 0
                            ? Text(
                                feedback[0],
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200]),
                                textAlign: TextAlign.center,
                              )
                            : (check == 1
                                ? Text(feedback[1],
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                    textAlign: TextAlign.center)
                                : Text(feedback[2],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                    textAlign: TextAlign.center)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 15),
                        child: Row(
                          children: const [
                            Text(
                              "Indoor Air Quality",
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      AirQuality(
                        image: co2,
                        gas: "Co2 level",
                        num: airData.gasesFromSensors[1],
                        x: "ppm",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        thickness: 2,
                        indent: 25,
                        endIndent: 25,
                        height: 2,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AirQuality(
                          image: temperature,
                          gas: "Temperature",
                          num: airData.temperatureAndHumidity.length < 2 ? 0 : airData.temperatureAndHumidity[0],
                          x: "ppm"),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        thickness: 2,
                        indent: 25,
                        endIndent: 25,
                        height: 2,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AirQuality(
                          image: humidity,
                          gas: "Humidity",
                          num: airData.temperatureAndHumidity.length < 2 ? 0 : airData.temperatureAndHumidity[1],
                          x: "ppm"),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        thickness: 2,
                        indent: 25,
                        endIndent: 25,
                        height: 2,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
