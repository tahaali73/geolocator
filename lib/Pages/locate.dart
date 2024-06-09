import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class locations extends StatefulWidget {
  const locations({super.key});

  @override
  State<locations> createState() => _locationsState();
}

class _locationsState extends State<locations> {
  Position? position;

  fetchposition ()async{
    bool ServiceEnabled;
    LocationPermission permission;

    ServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!ServiceEnabled){
      Fluttertoast.showToast(msg: 'Location service is disabled');
    }
    permission = await Geolocator.checkPermission();
     if(permission == LocationPermission.denied){
       permission = await Geolocator.requestPermission();
       if(permission == LocationPermission.denied){
         Fluttertoast.showToast(msg: 'you denied the permission');
       }
     }
     if(permission==LocationPermission.deniedForever){
       Fluttertoast.showToast(msg: 'you denied the permission forevver');
     }
     Position currentposition = await Geolocator.getCurrentPosition();
     setState(() {
       position = currentposition;
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(position==null? 'Location' : position.toString(),style: TextStyle(fontSize: 20),),
        ElevatedButton(onPressed: (){
          fetchposition();
        }, child: Text('Get Location' , style: TextStyle(fontSize: 20),))
      ],),),
    );
  }
}
