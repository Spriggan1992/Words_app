import 'dart:io';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/part_data.dart';
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
  String example = 'test example';
  String exampleTranslations = 'test example';
  String id = uuid.v4();
  File image;
  String dropdownValue = 'One';
  Part part = Part('', Colors.white);

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

    setState(() {
      image = croppedFile;
    });

    //   //to get current app folder path.
    //   final appDir = await syspaths.getApplicationDocumentsDirectory();
    //   // to obtain the name of the created file;
    //   final fileName = path.basename(croppedFile.path);

    //   final savedImage =
    //       await File(croppedFile.path).copy('${appDir.path}/$fileName');
    //   print("saved image: ${savedImage}");

    //   //    Compress the image, not working currently

    //  var result = await FlutterImageCompress.compressAndGetFile(
    //    croppedFile.absolute.path,
    //    "${croppedFile.path}1",
    //    quality: 88,
    //  );
  }

  _getColor(Color color) {
    setState(() {
      part.color = color;
    });
  }

  //Global key for Flip card
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];
    Size size = MediaQuery.of(context).size;

    return Consumer<Words>(
      builder: (context, providerData, child) {
        return Scaffold(
          appBar: BaseAppBar(
            title: Text('Create your word card'),
            appBar: AppBar(),
            actions: [
              CustomRoundBtn(
                icon: Icons.check,
                fillColor: Color(0xffDA627D),
                onPressed: () {
                  providerData.addNewWordCard(
                    collectionId,
                    mainWord,
                    secondWord,
                    translation,
                    id,
                    image,
                    part,
                    example,
                    exampleTranslations,
                  );
                  Navigator.pop(context);
                },
              ),

              CustomRoundBtn(
                icon: Icons.close,
                onPressed: () => Navigator.of(context).pop(),
                color: Theme.of(context).primaryColor,
              ),

//   dismiss button pop the context back to list of words
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
            front: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      WordCard(
                        color: part.color,
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
                                  labelText: 'Enter a word',
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
                                  //TODO: create setter for part
                                  getPart: (value) => part.part = value,
                                  getColor: _getColor,
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
                                        borderRadius: BorderRadius.circular(14),
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
                            onPressed: () => cardKey.currentState.toggleCard(),
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
                    onChanged: (value) => example = value,
                  ),
                ],
              ),
            ),
            back: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // main word text field
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Enter translation',
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
                                      _secondLangSelect = !_secondLangSelect;
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

                      //you can position widget inside stack with alignment proprerty
                      //fill property is responsible formfilling all available size
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: IconButton(
                            icon: Icon(
                              Icons.repeat,
                              size: 32,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () => cardKey.currentState.toggleCard(),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  //Text area with Five line to enter the comments or examples
                  TextField(
                    onChanged: (value) => exampleTranslations = value,
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomRoundBtn extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final Color fillColor;
  final Color color;

  const CustomRoundBtn(
      {Key key, this.onPressed, this.icon, this.fillColor, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: CircleBorder(),
      constraints: BoxConstraints(
        minHeight: 35,
        minWidth: 35,
      ),
      fillColor: fillColor,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
