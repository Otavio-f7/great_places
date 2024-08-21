import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greate_places/providers/great_places.dart';
import 'package:greate_places/widgets/image_input.dart';
import 'package:greate_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {

  final _titleController = TextEditingController();
  File? _pikedImage;
  LatLng? _pickedPosition;

  void _selectImage(File pikedImage){
    setState(() {
    _pikedImage = pikedImage;
    });
  }

  void _selecTPosition(LatLng position){
    setState(() {
    _pickedPosition = position;
    });
  }

  bool _isValidForm(){
    return _titleController.text.isNotEmpty &&
    _pikedImage != null &&
    _pickedPosition != null;
  }

  void _submitForm(){
    if(!_isValidForm()) return;
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text, 
      _pikedImage!,
      _pickedPosition!,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Titulo',
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 10),
                    ImageInput(_selectImage),
                    const SizedBox(height: 10),
                    LocationInput(_selecTPosition),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.black,
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: const ContinuousRectangleBorder(),
            ),
            onPressed: _isValidForm() ? _submitForm : null, 
            label: const Text('Adcionar'))
        ],
      ),
    );
  }
}