import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/LightIconButton.dart';

class ImageInput extends StatefulWidget {

  final Function selectImage;
  final String imageUrl;

  ImageInput(this.selectImage, {this.imageUrl});
  
  @override
  _ImageInputState createState() => _ImageInputState();

}


class _ImageInputState extends State<ImageInput> {

  File _storedImage;

  Future _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null)
      return;
    setState(() {
      _storedImage = imageFile;
    });

    widget.selectImage(_storedImage);
  }

  Future _uploadPicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null)
      return;
    setState(() {
      _storedImage = imageFile;
    });

    widget.selectImage(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            "Add an Image",
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 18,
              color: Colors.black.withOpacity(0.6)
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 10,
                ),
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  )
                ),
                child: (widget.imageUrl.isNotEmpty && _storedImage == null) ? Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ) : _storedImage == null ?
                  Text("No Image") :
                  Image.file(
                    _storedImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                alignment: Alignment.center,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  LightIconButton(
                    icon: Icons.camera_alt,
                    text: "Camera",
                    function: _takePicture,
                  ),
                  LightIconButton(
                    icon: Icons.filter,
                    text: "Gallery",
                    function:  _uploadPicture,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}