class GasesModel {
  double co_2;
  double co;
  double h2so4;

  GasesModel(
      {required this.co_2, required this.co, required this.h2so4});

  factory GasesModel.fromJson(Map<String, dynamic> json) => GasesModel(
      co_2: json["Co2"],
      co: json["Temperature"],
      h2so4: json["Humidity"]);

  Map<String,dynamic> toJson()=>{
  "Co2" : co_2,
  "Temperature": co,
  "Humidity": h2so4
  };
}
