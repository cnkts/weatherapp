import 'dart:async';

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
