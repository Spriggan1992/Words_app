import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/card_creator/card_creator_bloc.dart';
import 'package:words_app/bloc/image_api/image_api_bloc.dart';
import 'package:words_app/bloc/words/words_bloc.dart';
import 'package:words_app/config/screenDefiner.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/repositories/image_repository.dart';
import 'package:words_app/widgets/custom_round_btn.dart';
import 'package:words_app/config/constants.dart';

import 'package:words_app/cubit/card_creator/part_color/part_color_cubit.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'package:words_app/widgets/base_appbar.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/config/size_config.dart';
import '../image_api_screen/img_api.dart';
import 'widgets/InnerShadowTextField.dart';
import 'widgets/custom_radio.dart';

import 'widgets/reusable_card.dart';

class CardCreator extends StatelessWidget {
  final Word word;

  static const id = 'card_creator';

  CardCreator({Key key, this.word});
  bool get _isEditingMode {
    return word != null;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    return BlocConsumer<CardCreatorBloc, CardCreatorState>(
      listener: (context, state) {
        print(state.word);
        if (state.isFailure) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(state.errorMessage),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  )
                ],
              );
            },
          );
        } else if (state.isSubmiting) {
          return CircularProgressIndicator();
        }
      },
      builder: (context, state) {
        return buildBody(
          context,
          _isEditingMode,
          id,
          state.collectionId,
          word,
          state,
          defaultSize,
          // collectionLang,
        );
      },
    );
  }

  Scaffold buildBody(
    BuildContext context,
    bool isEditingMode,
    String id,
    String collectionId,
    Word word,
    CardCreatorState state,
    double defaultSize,
    // String collectionLang,
  ) {
    return Scaffold(
      appBar: buildBaseAppBar(
          context, isEditingMode, id, collectionId, word, state),
      body: FlipCard(
        //Card key  is used to pass the toggle card method into card

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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: defaultSize * 4,
                              child: SingleChildScrollView(
                                child: CustomRadio(
                                  getPart: (value) =>
                                      context.bloc<CardCreatorBloc>().add(
                                            CardCreatorPartUpdate(part: value),
                                          ),
                                  defaultSize: defaultSize,
                                ),
                              ),
                            ),
                            InnerShadowTextField(
                              title: isEditingMode ? word.targetLang : '',
                              hintText: 'word',
                              onChanged: (value) => context
                                  .bloc<CardCreatorBloc>()
                                  .add(CardCreatorTargetLanguageUpdate(
                                      targetLanguage: value)),
                              fontSizeMultiplyer: 3.2,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: defaultSize * 23,
                                  height: defaultSize * 23,
                                  decoration: innerShadow,
                                ),
                                state.word?.image == null
                                    ? Positioned.fill(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                context.bloc<CardCreatorBloc>().add(
                                                    CardCreatorUpdateImgFromCamera());
                                              },
                                              icon: Icon(
                                                Icons.photo_camera,
                                                size: 32,
                                              ),
                                              color: Color(0xFFDA627D),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                var image =
                                                    await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider<
                                                            ImageApiBloc>(
                                                      create: (context) =>
                                                          ImageApiBloc(
                                                              ImageRepository(),
                                                              state,
                                                              state.word
                                                                  ?.targetLang)
                                                            ..add(
                                                                ImageApiLoaded()),
                                                      child: ImageApi(
                                                        targetLang: state
                                                            .word?.targetLang,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                                context.bloc<CardCreatorBloc>().add(
                                                    CardCreatorUpdateImgFromApi(
                                                        url: image));
                                              },
                                              icon: Icon(
                                                Icons.web_asset,
                                                size: 32,
                                              ),
                                              color: Color(0xFFDA627D),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: defaultSize * 23,
                                        height: defaultSize * 23,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          child: state.word.image.path == ''
                                              ? Container()
                                              : Image.file(
                                                  state.word.image,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),

                                /// FIXME: refactor to use less code
                                isEditingMode
                                    ? Positioned.fill(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                context.bloc<CardCreatorBloc>().add(
                                                    CardCreatorUpdateImgFromCamera());
                                              },
                                              icon: Icon(
                                                Icons.photo_camera,
                                                size: 32,
                                              ),
                                              color: Color(0xFFDA627D),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                var image =
                                                    await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider<
                                                            ImageApiBloc>(
                                                      create: (context) =>
                                                          ImageApiBloc(
                                                              ImageRepository(),
                                                              state,
                                                              state.word
                                                                  ?.targetLang)
                                                            ..add(
                                                                ImageApiLoaded()),
                                                      child: ImageApi(
                                                        targetLang: state
                                                            .word?.targetLang,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                                context.bloc<CardCreatorBloc>().add(
                                                    CardCreatorUpdateImgFromApi(
                                                        url: image));
                                              },
                                              icon: Icon(
                                                Icons.web_asset,
                                                size: 32,
                                              ),
                                              color: Color(0xFFDA627D),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Positioned.fill(
                                        child: Container(),
                                      ),
                              ],
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
                  title: isEditingMode ? word.example : '',
                  hintText: 'example',
                  fontSizeMultiplyer: 2.4,
                  onChanged: (value) => context
                      .bloc<CardCreatorBloc>()
                      .add(CardCreatorExampleUpdate(example: value)),
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
                    ReusableCard(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            /// [ownLang] text field
                            InnerShadowTextField(
                              title: isEditingMode ? word.ownLang : '',
                              hintText: 'translation',
                              onChanged: (value) => context
                                  .bloc<CardCreatorBloc>()
                                  .add(CardCreatorOwnLanguageUpdate(
                                      ownLanguage: value)),
                              fontSizeMultiplyer: 3.2,
                            ),
                            InnerShadowTextField(
                              title: isEditingMode ? word.secondLang : '',
                              hintText: '2nd language',
                              onChanged: (value) => context
                                  .bloc<CardCreatorBloc>()
                                  .add(CardCreatorSecondLanguageUpdate(
                                      secondLanguage: value)),
                              fontSizeMultiplyer: 3.2,
                            ),
                            InnerShadowTextField(
                              title: isEditingMode ? word.thirdLang : '',
                              hintText: '3rd language',
                              onChanged: (value) => context
                                  .bloc<CardCreatorBloc>()
                                  .add(CardCreatorThirdLanguageUpdate(
                                      thirdLanguage: value)),
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
                  onChanged: (value) => context.bloc<CardCreatorBloc>().add(
                      CardCreatorOwnExapleUpdate(exampleTranslation: value)),
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
    BuildContext context,
    bool isEditingMode,
    String id,
    String collectionId,
    Word word,
    CardCreatorState state,
  ) {
    return BaseAppBar(
      screenDefiner: ScreenDefiner.cardCreator,
      title: Text('Create your word card'),
      appBar: AppBar(),
      actions: [
        CustomRoundBtn(
          icon: Icons.check,
          fillColor: Theme.of(context).accentColor,
          onPressed: () {
            context.bloc<CardCreatorBloc>().add(CardCreatorAdded());

            // isEditingMode
            //     ? context
            //         .bloc<WordsBloc>()
            //         .add(WordsUpdatedWord(word: state.word))
            //     : context.bloc<WordsBloc>().add(WordsAdded(
            //         word: state.word ??
            //             Word(
            //                 collectionId: state.collectionId,
            //                 part: Part.empty())));
            context.bloc<WordsBloc>().add(WordsLoaded(id: state.collectionId));
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
