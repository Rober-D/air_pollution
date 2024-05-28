import 'package:flutter/widgets.dart';
import 'package:work/database/models/gases_model.dart';

class GasesProvider extends ChangeNotifier{

  GasesModel gases = GasesModel(co_2: 0.0, co: 0.0, h2so4: 0.0);
  // index 0 : MQ135_Gas
  // index 1 : MQ7_CO2
  List<int> gasesFromSensors = [];
  // index 0 : Temperature
  // index 1 : Humidity
  List<int> temperatureAndHumidity = [];
  bool check = false;

  void getChecked(){
    check = true;
    notifyListeners();
  }

  void addTemperatureAndHumidity(int read){
    if(temperatureAndHumidity.length >= 2){
      temperatureAndHumidity.clear();
    }
    temperatureAndHumidity.add(read);
    notifyListeners();
  }

  void addGas(int read){
    if(gasesFromSensors.length >= 2){
      gasesFromSensors.clear();
    }
    gasesFromSensors.add(read);
    notifyListeners();
  }

  int checkQuality(){
    if(gasesFromSensors[1] > 1000){
      return 0;
    }else if(gasesFromSensors[1] > 400 && gasesFromSensors[1] < 1000){
      return 1;
    }else{
      return 2;
    }
  }
}