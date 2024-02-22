import 'package:flutter/widgets.dart';
import 'package:work/database/models/gases_model.dart';

class GasesProvider extends ChangeNotifier{

  GasesModel gases = GasesModel(co_2: 0.0, temperature: 0.0, humidity: 0.0);

  void readGases(List<Map<String,dynamic>>gasesList){
    gases.co_2 = gasesList[gasesList.length-1]["Co2"];
    gases.temperature = gasesList[gasesList.length-1]["Temperature"];
    gases.humidity = gasesList[gasesList.length-1]["Humidity"];
  }

  int checkQuality(){
    if(gases.co_2 > 1000){
      return 0;
    }else if(gases.co_2 > 400 && gases.co_2 < 1000){
      return 1;
    }else{
      return 2;
    }
  }
}