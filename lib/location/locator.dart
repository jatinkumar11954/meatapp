import 'package:geolocator/geolocator.dart';

Position  getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      print(position);
       return position;

   
    }).catchError((e) {
      print(e);
    });
  }