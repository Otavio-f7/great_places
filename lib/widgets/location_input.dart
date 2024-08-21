import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greate_places/screens/map_screen.dart';
import 'package:greate_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectPosition;
  const LocationInput(this.onSelectPosition, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng){
      final staticMapimageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImageUrl = staticMapimageUrl;
    });

  }

  Future<void> _getCurrentUserLocation() async{

    try{

    final locData = await Location().getLocation();
    


    _showPreview(locData.latitude!, locData.longitude!);
    widget.onSelectPosition(LatLng(
      locData.latitude!, 
      locData.longitude!
    ));
    } catch(e){
      return;
    }

  }

  Future<void> _selectOnMap() async{
    final LatLng? selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const MapScreen(),
      ),
    );

    if(selectedPosition == null ) return;

    _showPreview(selectedPosition.latitude, selectedPosition.longitude);
    // print(selectedPosition.latitude);

    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey
            ),
          ),
          // ignore: unnecessary_null_comparison
          child: _previewImageUrl == null
            ? const Text('Localização Não Informada!')
            : Image.network(
              _previewImageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Localização Atual'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Selecione no Mapa'),
            ),
          ],
        )
      ],
    );
  }
}