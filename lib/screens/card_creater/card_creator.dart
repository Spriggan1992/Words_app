import 'dart:io';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/screens/card_creater/components/text_field_area.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:uuid/uuid.dart';
import 'components/custom_radio.dart';
import 'components/folding_btn_field.dart';
import 'components/reusable_card.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class CardCreator extends StatefulWidget {
  static const id = 'card_creator';
  @override
  _CardCreatorState createState() => _CardCreatorState();
}

class _CardCreatorState extends State<CardCreator> {
  static var uuid = Uuid();
  //to store image locally
  //get access to camera or gallery
  final picker = ImagePicker();
  bool _secondLangSelect = false;
  bool _thirdLangSelect = false;

  //variables to work with card
  String mainWord = 'one';
  String secondWord = 'two';
  String translation = 'three';
  String id = uuid.v4();
  File image;
  String dropdownValue = 'One';
  String part = '';

  //method to work with camera
  getImageFile(ImageSource source) async {
    final imageFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 600);
    //This check is needed if we didn't take a picture  and used back button in camera;

    if (imageFile == null) {
      return;
    }
    //Call imageCropper module and crop the image. I has different looks on Android and IOS
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      maxWidth: 600,
      maxHeight: 600,
    );

//    Compress the image, not working currently

//    var result = await FlutterImageCompress.compressAndGetFile(
//      croppedFile.absolute.path,
//      "${croppedFile.path}1",
//      quality: 88,
//    );

    setState(() {
      image = croppedFile;
    });

    //to get current app folder path.
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // to obtain the name of the created file;
    final fileName = path.basename(croppedFile.path);

    final savedImage =
        await File(croppedFile.path).copy('${appDir.path}/$fileName');
    print("saved image: ${savedImage}");
  }

  //Global key for Flip card
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<Words>(
      builder: (context, providerData, child) {
        return Scaffold(
          appBar: BaseAppBar(
            title: Text('Create your word card'),
            appBar: AppBar(),
            actions: [
              InkWell(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onTap: () {
                  providerData.addNewWordCard(
                      mainWord, secondWord, translation, id, image, part);

                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 10,
              ),
//   dismiss button pop the context back to list of words
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              )
            ],
          ),
          body: FlipCard(
            //Card key  is used to pass the toggle card method into card
            key: cardKey,
            flipOnTouch: false,
            direction: FlipDirection.HORIZONTAL,
            speed: 500,
//            onFlipDone: (status) {
//              print(status);
//            },
//        front: CardCreatorFront(() => cardKey.currentState.toggleCard()),
            front: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
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
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.black),
                                    ),
                                  ),
                                  onChanged: (value) => mainWord = value,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: size.width * 0.7,
                                  height: 40,
                                  child: CustomRadio(
                                    getPart: (value) => part = value,
                                  ),
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
                                  child: image == null
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
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          child: Image.file(
                                            image,
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
                              onPressed: () =>
                                  cardKey.currentState.toggleCard(),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    TextFieldArea(),
                  ],
                ),
              ),
            ),
            back: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // main word text field
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'main word in your language',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.black),
                                      ),
                                    ),
                                    onChanged: (value) => translation = value,
                                  ),
                                  FoldingBtnField(
                                    selected: _secondLangSelect,
                                    title: 'Enter a language',
                                    onPress: () {
                                      setState(
                                        () {
                                          _secondLangSelect =
                                              !_secondLangSelect;
                                        },
                                      );
                                    },
                                    onChanged: (value) => secondWord = value,
                                  ),
                                  FoldingBtnField(
                                    selected: _thirdLangSelect,
                                    title: 'Enter a language',
                                    onPress: () {
                                      setState(
                                        () {
                                          _thirdLangSelect = !_thirdLangSelect;
                                        },
                                      );
                                    },
                                  ),
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
                                onPressed: () =>
                                    cardKey.currentState.toggleCard(),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      //Text area with Five line to enter the comments or examples
                      TextFieldArea()
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
