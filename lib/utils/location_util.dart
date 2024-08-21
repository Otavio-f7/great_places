import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'as http;

const googleApiKey = 'AIzaSyDJhI_LkisN7Lvcd8S9Tjgy6ZDMZcRINlE';

class LocationUtil{
  static String generateLocationPreviewImage({
    double? latitude,
    double? longitude,
  }){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=400x400&markers=color:blue%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }

  static Future<String> getAddressFrom(LatLng position) async{
  final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey';
  final response = await http.get(Uri.parse(url));
  return json.decode(response.body)['results'][0]['formatted_address'];
 }
}

