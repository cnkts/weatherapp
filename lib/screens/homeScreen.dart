import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/services/weatherService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getWeatherData();
    //.get_Location()
    //.then((value) => print(value))
    //.catchError((error) => print(error));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("anasayfa"),
          )
        ],
      )),
    );
  }
}
