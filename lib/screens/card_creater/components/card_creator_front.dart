import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'custom_radio.dart';

class CardCreatorFront extends StatefulWidget {
  final Function turnBack;

  CardCreatorFront(this.turnBack);

  @override
  _CardCreatorFrontState createState() => _CardCreatorFrontState();
}

class _CardCreatorFrontState extends State<CardCreatorFront> {
  File _image;
  final picker = ImagePicker();

  getImageFile(ImageSource source) async {
    final imageFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 600);
    //This check is needed if we didn't take a picture  and used back button in camera;
    if (imageFile == null) {
      return;
    }
    //Crop image
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      maxWidth: 2500,
      maxHeight: 2500,
    );

//    Compress the image

//    var result = await FlutterImageCompress.compressAndGetFile(
//      croppedFile.absolute.path,
//      "${croppedFile.path}1",
//      quality: 88,
//    );
    setState(() {
      _image = croppedFile;
      print(_image.lengthSync());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                WordCard(
                  size: size,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 36),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'main word in your language',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: size.width * 0.7,
                          height: 40,
                          child: CustomRadio(),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          width: size.width * 0.45,
                          height: size.width * 0.45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black87),
                              borderRadius: BorderRadius.circular(15)),
                          child: _image == null
                              ? IconButton(
                                  onPressed: () =>
                                      getImageFile(ImageSource.camera),
                                  icon: Icon(
                                    Icons.photo_camera,
                                    size: 48,
                                  ),
                                  color: Theme.of(context).primaryColor,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
                      icon: Icon(
                        Icons.repeat,
                        size: 32,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: widget.turnBack,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 24.0,
            ),
            TextField(
              style: TextStyle(color: Colors.black87),
              maxLines: 5,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                labelText: 'add comments to example',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ButtonGroup extends StatelessWidget {
  const ButtonGroup({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      top: 5,
      child: Row(
        children: <Widget>[
          InkWell(
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onTap: () {},
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            child: Icon(
              Icons.cancel,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class WordCard extends StatelessWidget {
  const WordCard({
    Key key,
    @required this.size,
    this.child,
  }) : super(key: key);

  final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.85,
      height: size.height * 0.60,
      decoration: BoxDecoration(
        color: Color(0xFF720d5d).withOpacity(0.40),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: child,
    );
  }
}
