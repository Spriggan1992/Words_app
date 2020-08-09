import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:words_app/components/custom_round_btn.dart';
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
import 'package:words_app/utils/size_config.dart';
import 'package:words_app/utils/utilities.dart';
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
  //to store image locally
  //get access to camera or gallery
  final picker = ImagePicker();
  bool _secondLangSelect = false;
  bool _thirdLangSelect = false;

  //variables to work with card
  String targetLang = 'sano';
  String ownLang = 'слово';
  String secondLang = 'word';
  String thirdLang = '单词';
  String example = 'tämä on tarkea sano';
  String exampleTranslations = 'Это важное слово. It is important word';
  String id = Uuid().v4();
  File image;
  // this variable will be created when state initiatet
  File defaultImage;
  String temp = 'fuck';
  String dropdownValue = 'One';
  Part part = Part(
    'n',
    Colors.white,
  );
  FocusNode targetLangFocusNode = FocusNode();

  setImage() async {
    //image receive File which we ca freely use in our app. Coz word data saves images as File object
    final image = await Utilities.assetToFile('images/noimage.png');
    setState(() {
      defaultImage = image;
    });
  }

  void initState() {
    super.initState();
    targetLangFocusNode.addListener(() {});
    setImage();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
    targetLangFocusNode.dispose();
  }

  //method to work with camera
  getImageFile(ImageSource source) async {
    PickedFile imageFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 600);
//    final imageFile2 = await assetToFile('images/noimages.png');
//    print(imageFile2.path);
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
    //TODO: find compression method for File

    setState(() {
      image = croppedFile;
    });
    //   //    Compress the image, not working currently

    //  var result = await FlutterImageCompress.compressAndGetFile(
    //    croppedFile.absolute.path,
    //    "${croppedFile.path}1",
    //    quality: 88,
    //  );
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(targetLangFocusNode);
    });
  }

  _getColor(Color color) {
    setState(() {
      part.partColor = color;
    });
  }

  //Global key for Flip card
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    return Consumer<Words>(
      builder: (context, providerData, child) {
        return Scaffold(
          appBar: buildBaseAppBar(providerData, collectionId, context),
          body: FlipCard(
            //Card key  is used to pass the toggle card method into card
            key: cardKey,
            direction: FlipDirection.HORIZONTAL,
            speed: 500,
//            onFlipDone: (status) {
//              print(status);
//            },
//        front: CardCreatorFront(() => cardKey.currentState.toggleCard()),
            front: Padqqding(
              padding: EdgeInsets.symmetric(
                horizontal: defaultSize * 2.4,
                vertical: defaultSize * 1.6,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  WordCard(
                    color: part.partColor,
                    size: size,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 36),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: size.width * 0.7,
                            height: 40,
                            child: CustomRadio(
                              getPart: (value) => part.partName = value,
                              getColor: _getColor,
                            ),
                          ),
                          Container(
                            decoration: innerShadow,
                            child: TextFormField(
                              style: GoogleFonts.montserrat(
                                  fontSize: defaultSize * 3.2,
                                  color: Colors.black87),
                              focusNode: targetLangFocusNode,
                              decoration: InputDecoration(
                                hintText: 'word',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10),
                                hintStyle: GoogleFonts.montserrat(
                                  fontSize: defaultSize * 3.2,
                                  letterSpacing: 1.4,
                                  color: Color(0xffDA627D).withOpacity(0.5),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onTap: _requestFocus,
                              onChanged: (value) => targetLang = value,
                              onEditingComplete: () =>
                                  FocusScope.of(context).unfocus(),
                            ),
                          ),
                          Container(
                            width: size.width * 0.45,
                            height: size.width * 0.45,
                            decoration: innerShadow,
                            child: image == null
                                ? IconButton(
                                    onPressed: () => getImageFile(
                                      ImageSource.camera,
                                    ),
                                    icon: Icon(
                                      Icons.photo_camera,
                                      size: 48,
                                    ),
                                    color: Color(0xFFDA627D),
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
                  Container(
                    decoration: innerShadow,
                    child: TextField(
                      style: TextStyle(
                          color: Colors.black87, fontSize: defaultSize * 2.4),
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        hintText: 'EXAMPLE',
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: defaultSize * 2.4,
                          letterSpacing: 1.4,
                          color: Color(0xffDA627D).withOpacity(0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) => example = value,
                    ),
                  ),
                ],
              ),
            ),
            back: SingleChildScrollView(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // main word text field
                                Container(
                                  decoration: innerShadow,
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 32,
                                    ),
//                                      autofocus: true,
//                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Color(0xFFDA627D),
                                      ),
                                      hintText: 'translation',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    onChanged: (value) => ownLang = value,
                                  ),
                                ),
                                Container(
                                  decoration: innerShadow,
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 32,
                                    ),
//                                      autofocus: true,
//                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Color(0xFFDA627D),
                                      ),
                                      hintText: '2nd language',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    onChanged: (value) => secondLang = value,
                                  ),
                                ),
                                Container(
                                  decoration: innerShadow,
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 32,
                                    ),
//                                      autofocus: true,
//                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Color(0xFFDA627D),
                                      ),
                                      hintText: '3rd language',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    onChanged: (value) => thirdLang = value,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    //Text area with Five line to enter the comments or examples
                    Container(
                      decoration: innerShadow,
                      child: TextField(
                        style: TextStyle(color: Colors.black87, fontSize: 24),
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'examples',
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 24,
                            letterSpacing: 1.4,
                            color: Color(0xffDA627D).withOpacity(0.5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) => exampleTranslations = value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  BaseAppBar buildBaseAppBar(
      Words providerData, String collectionId, BuildContext context) {
    return BaseAppBar(
      title: Text('Create your word card'),
      appBar: AppBar(),
      actions: [
        CustomRoundBtn(
          icon: Icons.check,
          fillColor: Color(0xffDA627D),
          onPressed: () {
            providerData.addNewWordCard(
              collectionId,
              id,
              targetLang,
              ownLang,
              secondLang,
              thirdLang,
              image ?? defaultImage,
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
    );
  }
}
