import 'package:flutter/material.dart';
import 'package:work/colors.dart';
import '../shared/widgets/air_quality.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  static const String routeName = "feedbackScreen";

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int check = 0;

  Image co2 = const Image(
    image: AssetImage("assets/temp.png"),
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
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.28,
            decoration: BoxDecoration(
              color:
                  check == 0 ? colors[0] : (check == 1 ? colors[1] : colors[2]),
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
                                  fontSize: 19,
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
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
                  num: 900,
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
                    image: temperature, gas: "Temperature", num: 22.5, x: "C"),
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
                AirQuality(image: humidity, gas: "Humidity", num: 30, x: "%"),
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
