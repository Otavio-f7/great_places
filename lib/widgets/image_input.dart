import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {

  final Function onSelectImage;

  const ImageInput(this.onSelectImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  File? _storedImage;
  _takePicture() async{
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
      source: ImageSource.camera, 
      maxWidth: 600,
    ) as XFile;

    setState(() {
      _storedImage = File(imageFile.path);
    });

      final appDir = await syspaths.getApplicationDocumentsDirectory();
      String fileName = path.basename(_storedImage!.path);
      final saveImage = await _storedImage!.copy(
        '${appDir.path}/$fileName',
      );
      widget.onSelectImage(saveImage);
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
          ),
          alignment: Alignment.center,
          child: _storedImage != null 
            ?  Image.file(
              _storedImage!,
              width: double.infinity,
              fit: BoxFit.cover,
            )
            : const Text('Nenhuma imagen!'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera),
            onPressed: _takePicture, 
            label: const Text('Tirar Foto')),
        )
      ],
    );
  }
}