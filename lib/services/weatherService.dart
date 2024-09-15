import 'dart:async';

import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Weatherservice {
  //Konum Belirlemek için Fonksiyon
  Future<String?> get_Location() async {
    //Konum Servisi Açık Mı?
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //Konum açık değilse kullanıcıya konumu açması için mesaj göster
    if (!serviceEnabled) {
      Future.error("Lütfen Konum Servisi Kapalı");
    }
    //Konumu açmış mı tekrar kontrol et
    LocationPermission permission = await Geolocator.checkPermission();
    //Konum Açık Değilse Mesaj göster.
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Future.error("Devam Edebilmek İçin Lütfen Konum izni verin.");
      }
    }

    final Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(accuracy: LocationAccuracy.high));

    final List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    return placemark[0].administrativeArea;
  }
}

Future<void> getWeatherData() async {
  final String? city = await Weatherservice().get_Location();
  final url =
      "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city";

  const Map<String, dynamic> headers = {
    "authorization": "apikey 6uYlVDvjDp9vBvVCAepwis:2iZF0rhxRFQCYSUpvXAFAL",
    "content-type": "application/json"
  };
  final dio = Dio();
  final response = await dio.get(url, options: Options(headers: headers));

  if (response.statusCode != 200) {
    Future.error("api tarafında bir sorun oluştu");
  }

  print(response.data);
}
