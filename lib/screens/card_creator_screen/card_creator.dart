import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/card_creator/card_creator_bloc.dart';
import 'package:words_app/bloc/words/words_bloc.dart';
import 'package:words_app/components/custom_round_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/models/part.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/words_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:words_app/utils/size_config.dart';
import 'package:words_app/utils/utilities.dart';
import 'components/InnerShadowTextField.dart';
import 'components/custom_radio.dart';

import 'components/reusable_card.dart';

class CardCreator extends StatefulWidget {
  static const id = 'card_creator';

  CardCreator({
    this.index,
  });
  final int index;

  @override
  _CardCreatorState createState() => _CardCreatorState();
}

class _CardCreatorState extends State<CardCreator> {
  //Global key for Flip card
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  //to store image locally
  //get access to camera or gallery
  final picker = ImagePicker();
  bool _secondLangSelect = false;
  bool _thirdLangSelect = false;

  //variables to work with card
  String targetLang;
  String ownLang = '1';
  String secondLang = '1';
  String thirdLang = '1';
  String example = 'tämä on tarkea sano';
  String exampleTranslations = 'Это важное слово. It is important word';
  String id = '1';
  File image;
  // this variable will be created when state initiate
  File defaultImage;
  String temp = 'fuck';
  String dropdownValue = 'One';
  Part part = Part(
    'n',
    Colors.white,
  );
  FocusNode targetLangFocusNode = FocusNode();
  bool isSelected = false;

  setImage() async {
    //image receive File which we ca freely use in our app. Coz word data saves images as File object
    final image = await Utilities.assetToFile('images/noimage.png');
    setState(() {
      defaultImage = image;
    });
  }

  // void setUpWords() {
  //   if (widget.editMode == true) {
  //     targetLang = widget.targetWord;
  //     secondLang = widget.secondWord;
  //     thirdLang = widget.thirdWord;
  //     ownLang = widget.ownWord;
  //     targetLang == null ? targetLang = ' ' : targetLang = widget.targetWord;
  //     secondLang == null ? secondLang = ' ' : secondLang = widget.secondWord;
  //     thirdLang == null ? thirdLang = ' ' : thirdLang = widget.thirdWord;
  //     ownLang == null ? ownLang = ' ' : ownLang = widget.ownWord;
  //   }
  // }

  void initState() {
    super.initState();
    // setUpWords();
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

  _getColor(Color color) {
    setState(() {
      part.partColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    // String collectionId = args['id'];
    final Word word = args['word'] ?? Word();
    final bool isEditingMode = args['isEditingMode'];
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    final providerData = Provider.of<WordsRepository>(context, listen: false);
    return Scaffold(
      appBar:
          buildBaseAppBar(providerData, context, widget.index, isEditingMode),
      body: FlipCard(
        //Card key  is used to pass the toggle card method into card
        key: cardKey,
        direction: FlipDirection.HORIZONTAL,
        speed: 500,

        front: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultSize * 2, vertical: defaultSize * 1.6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                WordCard(
                  color: part.partColor,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSize * 2.4,
                        right: defaultSize * 2.4,
                        top: defaultSize * 2,
                        bottom: defaultSize * 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: defaultSize * 4,
                          child: SingleChildScrollView(
                            child: CustomRadio(
                              getPart: (value) => part.partName = value,
                              getColor: _getColor,
                              defaultSize: defaultSize,
                            ),
                          ),
                        ),
                        InnerShadowTextField(
                          title: isEditingMode ? word.targetLang : ' ',
                          hintText: 'word',
                          onChanged: (value) {
                            targetLang = value;

                            // final String targetLang2 = value;
                          },
                          defaultSize: defaultSize,
                          fontSizeMultiplyer: 3.2,
                        ),
                        Container(
                          width: defaultSize * 23,
                          height: defaultSize * 23,
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
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: SizeConfig.blockSizeVertical * 5,
                  ),
                ),
                InnerShadowTextField(
                  maxLines: SizeConfig.blockSizeVertical > 7 ? 6 : 5,
                  defaultSize: defaultSize,
                  hintText: 'example',
                  fontSizeMultiplyer: 2.4,
                  onChanged: (value) => example = value,
                ),
              ],
            ),
          ),
        ),
        back: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    WordCard(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            /// [ownLang] text field
                            InnerShadowTextField(
                              title: ' ',
                              hintText: 'translation',
                              onChanged: (value) {
                                ownLang = value;
                              },
                              defaultSize: defaultSize,
                              fontSizeMultiplyer: 3.2,
                            ),
                            InnerShadowTextField(
                              title: '',
                              hintText: '2nd language',
                              onChanged: (value) => secondLang = value,
                              defaultSize: defaultSize,
                              fontSizeMultiplyer: 3.2,
                            ),
                            InnerShadowTextField(
                              title: '',
                              hintText: '3rd language',
                              onChanged: (value) => thirdLang = value,
                              defaultSize: defaultSize,
                              fontSizeMultiplyer: 3.2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: SizeConfig.blockSizeVertical * 5),
                ),
                //Text area with Five line to enter the comments or examples
                InnerShadowTextField(
                  maxLines: SizeConfig.blockSizeVertical > 7.5 ? 6 : 5,
                  hintText: 'example',
                  onChanged: (value) => exampleTranslations = value,
                  defaultSize: defaultSize,
                  fontSizeMultiplyer: 2.4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BaseAppBar buildBaseAppBar(
    WordsRepository providerData,
    BuildContext context,
    int index,
    bool isEditingMode,
  ) {
    return BaseAppBar(
      title: Text('Create your word card'),
      appBar: AppBar(),
      actions: [
        CustomRoundBtn(
          icon: Icons.check,
          fillColor: Color(0xffDA627D),
          onPressed: () {
            print("from costom round button $ownLang");

            var newWord = Word(
              id: isEditingMode ? id : Uuid().v4(),
              targetLang: targetLang,
              ownLang: ownLang,
              secondLang: secondLang,
              thirdLang: thirdLang,
              image: image ?? defaultImage,
              part: part,
              example: example,
              exampleTranslations: exampleTranslations,
              isSelected: isSelected,
            );
            isEditingMode
                ? context.bloc<WordsBloc>().add(WordsUpdatedWord(word: newWord))
                : context.bloc<WordsBloc>().add(WordsAdded(word: newWord));

            // context.bloc<WordsBloc>().add(WordsLoaded());

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
