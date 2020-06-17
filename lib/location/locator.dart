import 'package:geolocator/geolocator.dart';

// Future<Position>  getCurrentLocation() async{
//   Position position;
   
//     try{
//    position=await 
        
//        return position;

   
//     } catch(e){
//       print(e);
//     }
//   }
 Future <List<Placemark>> place ()async{
   print("inside place");
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position pos=await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  print(pos.latitude);
List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(pos.latitude, pos.longitude);
print(placemark[0].country);
print(placemark[0].position);
print(placemark[0].locality);
print(placemark[0].administrativeArea);
print(placemark[0].postalCode);
print(placemark[0].name);
print(placemark[0].subAdministrativeArea);
print(placemark[0].isoCountryCode);
print(placemark[0].subLocality);

print(placemark[0].subThoroughfare);
print(placemark[0].thoroughfare);
  }