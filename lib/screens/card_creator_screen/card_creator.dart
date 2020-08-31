import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/card_creator/card_creator_bloc.dart';
import 'package:words_app/bloc/words/words_bloc.dart';
import 'package:words_app/components/custom_round_btn.dart';
import 'package:words_app/constants/constants.dart';

import 'package:words_app/cubit/card_creator/part_color/part_color_cubit.dart';
import 'package:words_app/models/part.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/words_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:words_app/utils/size_config.dart';
import 'components/InnerShadowTextField.dart';
import 'components/custom_radio.dart';

import 'components/reusable_card.dart';

class CardCreator extends StatelessWidget {
  static const id = 'card_creator';

  //Global key for Flip card
  // GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  //variables to work with card
  String targetLang;
  String ownLang;
  String secondLang;
  String thirdLang;
  String example = 'tämä on tarkea sano';
  String exampleTranslations = 'Это важное слово. It is important word';

  File image;
  // this variable will be created when state initiate
  File defaultImage;

  String dropdownValue = 'One';
  Part part = Part(
    'n',
    Colors.white,
  );
  FocusNode targetLangFocusNode = FocusNode();
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;

    /// Pass [Word] from path[words_screen] for passing it to the controllers for text
    final Word word = args['word'] ?? Word();

    /// To allow card_creator to be used on add word and on edit word event
    final bool isEditingMode = args['isEditingMode'];
    final String id = word.id;
    final String collectionId = args['collectionId'];
    SizeConfig().init(context);

    double defaultSize = SizeConfig.defaultSize;
    final providerData = Provider.of<WordsRepository>(context, listen: false);
    return BlocBuilder<CardCreatorBloc, CardCreatorState>(
      builder: (context, state) {
        if (state is CardCreatorLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CardCreatorSuccess) {
          return Scaffold(
            appBar: buildBaseAppBar(providerData, context, isEditingMode, id,
                collectionId, word, state),
            body: FlipCard(
              //Card key  is used to pass the toggle card method into card
              // key: cardKey,
              direction: FlipDirection.HORIZONTAL,
              speed: 500,

              front: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultSize * 2, vertical: defaultSize * 1.6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      BlocBuilder<PartColorCubit, PartColorState>(
                        builder: (context, partColorState) {
                          return ReusableCard(
                            //receive data
                            color: partColorState.color,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: defaultSize * 2.4,
                                  right: defaultSize * 2.4,
                                  top: defaultSize * 2,
                                  bottom: defaultSize * 2),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: defaultSize * 4,
                                    child: SingleChildScrollView(
                                      child: CustomRadio(
                                        getPart: (value) =>
                                            part.partName = value,
                                        getColor: (color) {
                                          part.partColor = color;
                                          context
                                              .bloc<PartColorCubit>()
                                              .changeColor(part.partColor);
                                        },
                                        defaultSize: defaultSize,
                                      ),
                                    ),
                                  ),
                                  InnerShadowTextField(
                                    title: isEditingMode ? word.targetLang : '',
                                    hintText: 'word',
                                    onChanged: (value) => targetLang = value,
                                    defaultSize: defaultSize,
                                    fontSizeMultiplyer: 3.2,
                                  ),
                                  Container(
                                    width: defaultSize * 23,
                                    height: defaultSize * 23,
                                    decoration: innerShadow,
                                    child: state.image == null
                                        ? IconButton(
                                            onPressed: () {
                                              context
                                                  .bloc<CardCreatorBloc>()
                                                  .add(
                                                      CardCreatorUpdateImage());
                                            },
                                            icon: Icon(
                                              Icons.photo_camera,
                                              size: 48,
                                            ),
                                            color: Color(0xFFDA627D),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            child: state.image.path == ''
                                                ? IconButton(
                                                    onPressed: () {
                                                      context
                                                          .bloc<
                                                              CardCreatorBloc>()
                                                          .add(
                                                              CardCreatorUpdateImage());
                                                    },
                                                    icon: Icon(
                                                      Icons.photo_camera,
                                                      size: 48,
                                                    ),
                                                    color: Color(0xFFDA627D),
                                                  )
                                                : Image.file(
                                                    state.image,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: SizeConfig.blockSizeVertical * 5,
                        ),
                      ),
                      InnerShadowTextField(
                        maxLines: SizeConfig.blockSizeVertical > 7 ? 6 : 5,
                        defaultSize: defaultSize,
                        title: isEditingMode ? word.example : '',
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          ReusableCard(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  /// [ownLang] text field
                                  InnerShadowTextField(
                                    title: isEditingMode ? word.ownLang : '',
                                    hintText: 'translation',
                                    onChanged: (value) => ownLang = value,
                                    defaultSize: defaultSize,
                                    fontSizeMultiplyer: 3.2,
                                  ),
                                  InnerShadowTextField(
                                    title: isEditingMode ? word.secondLang : '',
                                    hintText: '2nd language',
                                    onChanged: (value) => secondLang = value,
                                    defaultSize: defaultSize,
                                    fontSizeMultiplyer: 3.2,
                                  ),
                                  InnerShadowTextField(
                                    title: isEditingMode ? word.thirdLang : '',
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

                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 5,
                      ),
                      //Text area with Five line to enter the comments or examples
                      InnerShadowTextField(
                        maxLines: SizeConfig.blockSizeVertical > 7.5 ? 6 : 5,
                        title: isEditingMode ? word.exampleTranslations : ' ',
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
        if (state is CardCreatorFailure) {
          return Text('Somthing went wrong....');
        }
      },
    );
  }

  BaseAppBar buildBaseAppBar(
    WordsRepository providerData,
    BuildContext context,
    bool isEditingMode,
    String id,
    String collectionId,
    Word word,
    CardCreatorSuccess state,
  ) {
    return BaseAppBar(
      title: Text('Create your word card'),
      appBar: AppBar(),
      actions: [
        CustomRoundBtn(
          icon: Icons.check,
          fillColor: Color(0xffDA627D),
          onPressed: () {
            var newWord = Word(
              collectionId: collectionId,
              id: isEditingMode ? id : Uuid().v4(),
              targetLang: targetLang ?? word.targetLang,
              ownLang: ownLang ?? word.ownLang,
              secondLang: secondLang ?? word.secondLang,
              thirdLang: thirdLang ?? word.thirdLang,
              image: state.image ?? defaultImage,
              part: part ?? word.part,
              example: example ?? word.example,
              exampleTranslations:
                  exampleTranslations ?? word.exampleTranslations,
              isSelected: isSelected,
            );
            isEditingMode
                ? context.bloc<WordsBloc>().add(WordsUpdatedWord(word: newWord))
                : context.bloc<WordsBloc>().add(WordsAdded(word: newWord));

            Navigator.pop(context);
          },
        ),
        CustomRoundBtn(
          icon: Icons.close,
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
