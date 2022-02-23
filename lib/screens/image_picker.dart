import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final ImagePicker _picker = ImagePicker();
  late XFile? _pickedImage = null;
  late File? _takenPicture = null;

  Future<void> pickPhoto() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = image;
    });
  }

  Future<void> takePicture() async {
    // final pickedImage = await (_picker.pickImage(source: ImageSource.camera));
    //
    // if (pickedImage == null) return;
    //
    // File tmpFile = File(pickedImage.path);
    // tmpFile = await tmpFile.copy(tmpFile.path);
    //
    // setState(() {
    //   _takenPicture = tmpFile;
    // });
    //
    // GallerySaver.saveImage(pickedImage.path).then((String path) {
    //   setState(() {});
    // });
    final picture = await _picker.pickImage(source: ImageSource.camera);
    File pictureFile = File(picture!.path);
    setState(() {
      _takenPicture = pictureFile;
    });
    await GallerySaver.saveImage(pictureFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: TextButton(
                  child: const Text('pick photo'),
                  onPressed: pickPhoto,
                ),
              ),
              if (_pickedImage != null)
                Container(
                  width: 600,
                  child: Image.asset(_pickedImage!.path),
                ),
              Center(
                child: TextButton(
                  child: const Text('take picture'),
                  onPressed: takePicture,
                ),
              ),
              if (_takenPicture != null) Image.asset(_takenPicture!.path),
            ],
          ),
        ),
      ),
    );
  }

  _ImagePickerScreenState();
}
