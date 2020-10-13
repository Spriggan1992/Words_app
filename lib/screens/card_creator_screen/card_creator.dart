import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/card_creator/card_creator_bloc.dart';
import 'package:words_app/bloc/words/words_bloc.dart';
import 'package:words_app/config/screenDefiner.dart';
import 'package:words_app/widgets/custom_round_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/cubit/card_creator/part_color/part_color_cubit.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:words_app/widgets/base_appbar.dart';
import 'package:words_app/models/word_model.dart';
import 'package:words_app/utils/size_config.dart';
import 'img_api.dart';
import 'widgets/InnerShadowTextField.dart';
import 'widgets/custom_radio.dart';
import 'widgets/reusable_card.dart';

class CardCreator extends StatefulWidget {
  final Word word;

  const CardCreator({this.word});

  @override
  _CardCreatorState createState() => _CardCreatorState();
}

class _CardCreatorState extends State<CardCreator> {
  bool get _isEditing {
    return widget.word != null;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    return BlocConsumer<CardCreatorBloc, CardCreatorState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.isFailure) {
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
        }
      },
      builder: (context, state) {
        print(state.word);
        return Scaffold(
          appBar: buildBaseAppBar(
            context,
            _isEditing,
            state,
          ),
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
                                      getPart: (value) => context
                                          .bloc<CardCreatorBloc>()
                                          .add(
                                            CardCreatorPartUpdate(part: value),
                                          ),
                                      defaultSize: defaultSize,
                                    ),
                                  ),
                                ),
                                InnerShadowTextField(
                                  title: state.word == null
                                      ? ""
                                      : state.word.targetLang,
                                  // title: 'hopes',
                                  hintText: 'word',
                                  onChanged: (value) {
                                    context.bloc<CardCreatorBloc>().add(
                                          CardCreatorTargetLanguageUpdate(
                                              targetLanguage: value),
                                        );
                                  },
                                  defaultSize: defaultSize,
                                  fontSizeMultiplyer: 3.2,
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      width: defaultSize * 23,
                                      height: defaultSize * 23,
                                      decoration: innerShadow,
                                    ),
                                    // state.image == null
                                    state.word?.image == null
                                        ? Positioned.fill(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    context
                                                        .bloc<CardCreatorBloc>()
                                                        .add(
                                                            CardCreatorUpdateImgFromCamera());
                                                  },
                                                  icon: Icon(
                                                    Icons.photo_camera,
                                                    size: 32,
                                                  ),
                                                  color: Color(0xFFDA627D),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    // context
                                                    //     .bloc<CardCreatorBloc>()
                                                    //     .add(
                                                    //       CardCreatorDownloadImagesFromAPI(
                                                    //           // name: state.word
                                                    //           //     .targetLang,
                                                    //           ),
                                                    //     );
                                                    Navigator.pushNamed(
                                                        context, ImageApi.id);
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
                                    _isEditing
                                        ? Positioned.fill(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    context
                                                        .bloc<CardCreatorBloc>()
                                                        .add(
                                                            CardCreatorUpdateImgFromCamera());
                                                  },
                                                  icon: Icon(
                                                    Icons.photo_camera,
                                                    size: 32,
                                                  ),
                                                  color: Color(0xFFDA627D),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    context
                                                        .bloc<CardCreatorBloc>()
                                                        .add(
                                                          CardCreatorDownloadImagesFromAPI(
                                                              // name: state.word
                                                              //     .targetLang,
                                                              ),
                                                        );
                                                    // Navigator.pushNamed(
                                                    //     context, ImageApi.id);
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
                      defaultSize: defaultSize,
                      title: state.word == null ? "" : state.word.example,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                /// [ownLang] text field
                                InnerShadowTextField(
                                  title: state.word == null
                                      ? ""
                                      : state.word.ownLang,
                                  hintText: 'own language',
                                  onChanged: (value) => context
                                      .bloc<CardCreatorBloc>()
                                      .add(CardCreatorOwnLanguageUpdate(
                                          ownLanguage: value)),
                                  defaultSize: defaultSize,
                                  fontSizeMultiplyer: 3.2,
                                ),
                                InnerShadowTextField(
                                  // title: state.word.secondLang,
                                  title: state.word == null
                                      ? ""
                                      : state.word.secondLang,
                                  hintText: '2nd language',
                                  onChanged: (value) => context
                                      .bloc<CardCreatorBloc>()
                                      .add(CardCreatorSecondLanguageUpdate(
                                          secondLanguage: value)),
                                  defaultSize: defaultSize,
                                  fontSizeMultiplyer: 3.2,
                                ),
                                InnerShadowTextField(
                                  title: state.word == null
                                      ? ""
                                      : state.word.thirdLang,
                                  hintText: '3rd language',
                                  onChanged: (value) => context
                                      .bloc<CardCreatorBloc>()
                                      .add(CardCreatorThirdLanguageUpdate(
                                          thirdLanguage: value)),
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
                      // title: state.word.exampleTranslations,
                      title: state.word == null
                          ? ""
                          : state.word.exampleTranslations,
                      hintText: 'example',
                      onChanged: (value) => context.bloc<CardCreatorBloc>().add(
                          CardCreatorOwnExapleUpdate(
                              exampleTranslation: value)),
                      defaultSize: defaultSize,
                      fontSizeMultiplyer: 2.4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        // return Scaffold(
        //   appBar: buildBaseAppBar(
        //     context,
        //     _isEditing,
        //     state,
        //     // state,
        //   ),
        //   body: FlipCard(
        //     //Card key  is used to pass the toggle card method into card

        //     direction: FlipDirection.HORIZONTAL,
        //     speed: 500,

        //     front: SingleChildScrollView(
        //       child: Padding(
        //         padding: EdgeInsets.symmetric(
        //             horizontal: defaultSize * 2, vertical: defaultSize * 1.6),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: <Widget>[
        //             BlocBuilder<PartColorCubit, PartColorState>(
        //               builder: (context, partColorState) {
        //                 return ReusableCard(
        //                   //receive data
        //                   color: partColorState.color,
        //                   child: Padding(
        //                     padding: EdgeInsets.only(
        //                         left: defaultSize * 2.4,
        //                         right: defaultSize * 2.4,
        //                         top: defaultSize * 2,
        //                         bottom: defaultSize * 2),
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: <Widget>[
        //                         Container(
        //                           height: defaultSize * 4,
        //                           child: SingleChildScrollView(
        //                             child: CustomRadio(
        //                               getPart: (value) => context
        //                                   .bloc<CardCreatorBloc>()
        //                                   .add(
        //                                     CardCreatorPartUpdate(part: value),
        //                                   ),
        //                               defaultSize: defaultSize,
        //                             ),
        //                           ),
        //                         ),
        //                         InnerShadowTextField(
        //                           title: state.word.targetLang,
        //                           hintText: 'word',
        //                           onChanged: (value) => context
        //                               .bloc<CardCreatorBloc>()
        //                               .add(CardCreatorTargetLanguageUpdate(
        //                                   targetLanguage: value)),
        //                           defaultSize: defaultSize,
        //                           fontSizeMultiplyer: 3.2,
        //                         ),
        //                         Stack(
        //                           children: [
        //                             Container(
        //                               width: defaultSize * 23,
        //                               height: defaultSize * 23,
        //                               decoration: innerShadow,
        //                             ),
        //                             // state.image == null
        //                             state.word.image == null
        //                                 ? Positioned.fill(
        //                                     child: Row(
        //                                       mainAxisAlignment:
        //                                           MainAxisAlignment.center,
        //                                       children: [
        //                                         IconButton(
        //                                           onPressed: () {
        //                                             context
        //                                                 .bloc<CardCreatorBloc>()
        //                                                 .add(
        //                                                     CardCreatorUpdateImgFromCamera());
        //                                           },
        //                                           icon: Icon(
        //                                             Icons.photo_camera,
        //                                             size: 32,
        //                                           ),
        //                                           color: Color(0xFFDA627D),
        //                                         ),
        //                                         IconButton(
        //                                           onPressed: () {
        //                                             context
        //                                                 .bloc<CardCreatorBloc>()
        //                                                 .add(
        //                                                   CardCreatorDownloadImagesFromAPI(
        //                                                     name: state.word
        //                                                         .targetLang,
        //                                                   ),
        //                                                 );
        //                                             // Navigator.pushNamed(
        //                                             //     context, ImageApi.id);
        //                                           },
        //                                           icon: Icon(
        //                                             Icons.web_asset,
        //                                             size: 32,
        //                                           ),
        //                                           color: Color(0xFFDA627D),
        //                                         ),
        //                                       ],
        //                                     ),
        //                                   )
        //                                 : Container(
        //                                     width: defaultSize * 23,
        //                                     height: defaultSize * 23,
        //                                     child: ClipRRect(
        //                                       borderRadius:
        //                                           BorderRadius.circular(14),
        //                                       // child: state.image.path == ''
        //                                       //     ? Container()
        //                                       //     : Image.file(
        //                                       //         state.image,
        //                                       //         fit: BoxFit.cover,
        //                                       //       ),
        //                                     ),
        //                                   ),

        //                             /// FIXME: refactor to use less code
        //                             _isEditing
        //                                 ? Positioned.fill(
        //                                     child: Row(
        //                                       mainAxisAlignment:
        //                                           MainAxisAlignment.center,
        //                                       children: [
        //                                         IconButton(
        //                                           onPressed: () {
        //                                             context
        //                                                 .bloc<CardCreatorBloc>()
        //                                                 .add(
        //                                                     CardCreatorUpdateImgFromCamera());
        //                                           },
        //                                           icon: Icon(
        //                                             Icons.photo_camera,
        //                                             size: 32,
        //                                           ),
        //                                           color: Color(0xFFDA627D),
        //                                         ),
        //                                         IconButton(
        //                                           onPressed: () {
        //                                             context
        //                                                 .bloc<CardCreatorBloc>()
        //                                                 .add(
        //                                                   CardCreatorDownloadImagesFromAPI(
        //                                                     name: state.word
        //                                                         .targetLang,
        //                                                   ),
        //                                                 );
        //                                             // Navigator.pushNamed(
        //                                             //     context, ImageApi.id);
        //                                           },
        //                                           icon: Icon(
        //                                             Icons.web_asset,
        //                                             size: 32,
        //                                           ),
        //                                           color: Color(0xFFDA627D),
        //                                         ),
        //                                       ],
        //                                     ),
        //                                   )
        //                                 : Positioned.fill(
        //                                     child: Container(),
        //                                   ),
        //                           ],
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                 );
        //               },
        //             ),
        //             ConstrainedBox(
        //               constraints: BoxConstraints(
        //                 minHeight: SizeConfig.blockSizeVertical * 5,
        //               ),
        //             ),
        //             InnerShadowTextField(
        //               maxLines: SizeConfig.blockSizeVertical > 7 ? 6 : 5,
        //               defaultSize: defaultSize,
        //               title: state.word.example,
        //               hintText: 'example',
        //               fontSizeMultiplyer: 2.4,
        //               onChanged: (value) => context
        //                   .bloc<CardCreatorBloc>()
        //                   .add(CardCreatorOwnExapleUpdate(ownExample: value)),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     back: SingleChildScrollView(
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(
        //             horizontal: 24.0, vertical: 16.0),
        //         child: Column(
        //           children: <Widget>[
        //             Stack(
        //               children: <Widget>[
        //                 ReusableCard(
        //                   child: Padding(
        //                     padding: EdgeInsets.symmetric(
        //                         horizontal: 24, vertical: 10),
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: <Widget>[
        //                         /// [ownLang] text field
        //                         InnerShadowTextField(
        //                           title: state.word.ownLang,
        //                           hintText: 'own language',
        //                           onChanged: (value) => context
        //                               .bloc<CardCreatorBloc>()
        //                               .add(CardCreatorOwnLanguageUpdate(
        //                                   ownLanguage: value)),
        //                           defaultSize: defaultSize,
        //                           fontSizeMultiplyer: 3.2,
        //                         ),
        //                         InnerShadowTextField(
        //                           title: state.word.secondLang,
        //                           hintText: '2nd language',
        //                           onChanged: (value) => context
        //                               .bloc<CardCreatorBloc>()
        //                               .add(CardCreatorSecondLanguageUpdate(
        //                                   secondLanguage: value)),
        //                           defaultSize: defaultSize,
        //                           fontSizeMultiplyer: 3.2,
        //                         ),
        //                         InnerShadowTextField(
        //                           title: state.word.thirdLang,
        //                           hintText: '3rd language',
        //                           onChanged: (value) => context
        //                               .bloc<CardCreatorBloc>()
        //                               .add(CardCreatorThirdLanguageUpdate(
        //                                   thirdLanguage: value)),
        //                           defaultSize: defaultSize,
        //                           fontSizeMultiplyer: 3.2,
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),

        //             SizedBox(
        //               height: SizeConfig.blockSizeVertical * 5,
        //             ),
        //             //Text area with Five line to enter the comments or examples
        //             InnerShadowTextField(
        //               maxLines: SizeConfig.blockSizeVertical > 7.5 ? 6 : 5,
        //               title: state.word.exampleTranslations,
        //               hintText: 'example',
        //               onChanged: (value) => context
        //                   .bloc<CardCreatorBloc>()
        //                   .add(CardCreatorOwnExapleUpdate(ownExample: value)),
        //               defaultSize: defaultSize,
        //               fontSizeMultiplyer: 2.4,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // );
      },
    );
  }

  BaseAppBar buildBaseAppBar(
    BuildContext context,
    bool isEditing,
    CardCreatorState state,
    // CardCreatorSuccess state,
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
            _isEditing
                ? context
                    .bloc<WordsBloc>()
                    .add(WordsUpdatedWord(word: state.word))
                : context.bloc<WordsBloc>().add(WordsAdded(word: state.word));
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
