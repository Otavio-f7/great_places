import 'package:flutter/material.dart';
import 'package:greate_places/providers/great_places.dart';
import 'package:greate_places/screens/place_detail_screen.dart';
import 'package:greate_places/screens/place_form_screen.dart';
import 'package:greate_places/screens/places_list_screen.dart';
import 'package:greate_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            primary: Colors.teal.shade400,
            secondary: Colors.amber,
            seedColor: Colors.white,
            
          )
        ),
        home: const PlacesListScreen(),
        routes: {
          AppRoutes.placeForm : (ctx)=> const PlaceFormScreen(),
          AppRoutes.placeDetail : (ctx)=> const PlaceDetailScreen(),
        },
      ),
    );
  }
}


