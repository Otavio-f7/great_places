import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greate_places/models/place.dart';

class MapScreen extends StatefulWidget {

  final PlaceLocation inicialLocation;
  final bool isReadonly;
  const MapScreen({
    this.inicialLocation = const PlaceLocation(
      latitude: -18.928612,
      longitude: -48.2932517,
    ),
    this.isReadonly = false,
    super.key
  });



  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  LatLng? _pickedPosition;

void _selectPosition(LatLng position){
  setState(() {
    _pickedPosition = position;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione...'),
        actions: [
          if(!widget.isReadonly)
            IconButton(
              onPressed: _pickedPosition == null 
                ? null 
                : (){
                  Navigator.of(context).pop(_pickedPosition);
                }, 
              icon: const Icon(Icons.check)
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.inicialLocation.latitude, 
            widget.inicialLocation.longitude
          ),
          zoom: 13
        ),
        onTap: widget.isReadonly
          ? null
          : _selectPosition,
        markers: (_pickedPosition == null && !widget.isReadonly)
          ? {}
          : {
            Marker(
              markerId: const MarkerId('p1'),
              position: _pickedPosition ?? widget.inicialLocation.toLatLng(),
            ),
          },
      ),
    );
  }
}