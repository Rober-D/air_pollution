class SensorsModel {
  double? dht11Humidity;
  double? dht11Temperature;
  double? dhtHumidity;
  double? dhtTemperature;
  double? mq135Gas;
  double? mq7Co2;

  SensorsModel({required this.dht11Humidity,
    required this.dht11Temperature,
    required this.dhtHumidity,
    required this.dhtTemperature,
    required this.mq135Gas,
    required this.mq7Co2});

  factory SensorsModel.fromJson(Map<String, dynamic> json) =>
      SensorsModel(
          dht11Humidity: json[""],
          dht11Temperature: json[""],
          dhtHumidity: json[""],
          dhtTemperature: json[""],
          mq135Gas: json[""],
          mq7Co2: json[""]);

  Map<String, dynamic> toJson() =>
      {
        "":dht11Humidity,
        "":dht11Temperature,
        "":dhtHumidity,
        "":dhtTemperature,
        "":mq135Gas,
        "":mq7Co2,
      };
}