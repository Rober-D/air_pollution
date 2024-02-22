class GasesModel {
  double co_2;
  double temperature;
  double humidity;

  GasesModel(
      {required this.co_2, required this.temperature, required this.humidity});

  factory GasesModel.fromJson(Map<String, dynamic> json) => GasesModel(
      co_2: json["Co2"],
      temperature: json["Temperature"],
      humidity: json["Humidity"]);

  Map<String,dynamic> toJson()=>{
  "Co2" : co_2,
  "Temperature": temperature,
  "Humidity": humidity
  };
}
