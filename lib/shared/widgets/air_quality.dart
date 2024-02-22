import 'package:flutter/material.dart';

class AirQuality extends StatelessWidget {

  AirQuality({super.key,required this.image,required this.gas,required this.num,required this.x});
  Image? image;
  String? gas;
  double? num;
  String x;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //const SizedBox(width: 20,),
            Container(decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.grey[200],
            ),
            child: image),
            const SizedBox(width: 50,),
            Column(
              children:[
                Text("${gas}",style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                const SizedBox(),
                Text("${num} ${x}",style:TextStyle(fontSize: 16),),
              ],
            ),
          ],
        ),
      ),
      onTap: (){print("Bye Bye");},
    );
  }
}
