import 'package:flutter/material.dart';
import 'package:greate_places/providers/great_places.dart';
import 'package:greate_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: [
          IconButton(
            onPressed: () {Navigator.of(context).pushNamed(AppRoutes.placeForm);}, 
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) => snapshot.connectionState == 
            ConnectionState.waiting
          ? const Center(child: CircularProgressIndicator(),)
          : Consumer<GreatPlaces>(
            builder: (ctx, gretPlaces, child)=> gretPlaces.intemsCount == 0 
              ? child! 
              : ListView.builder(
                  itemCount: gretPlaces.intemsCount,
                  itemBuilder: (ctx, i)=> ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        gretPlaces.itemByIndex(i).image
                        ),
                    ),
                    title: Text(gretPlaces.itemByIndex(i).title),
                    subtitle: Text(gretPlaces.itemByIndex(i).location.address!),
                    onTap: (){
                      Navigator.of(context).pushNamed(
                        AppRoutes.placeDetail,
                        arguments: gretPlaces.itemByIndex(i),
                      );
                    },
                  ),
                ),
            child: const Text('Nenhum local cadastrado'),
          )
      )
    );
  }
}