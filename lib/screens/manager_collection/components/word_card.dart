import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/manager_collection/components/dialog_window.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';

class WordCard extends StatelessWidget {
  const WordCard({this.index});
  final index;
  @override
  Widget build(BuildContext context) {
    final words = Provider.of<Words>(context, listen: false).wordsData[index];
    final showImg = Provider.of<Words>(context);
    return GestureDetector(
      onTap: () {
        // When we prees on WordCard, we pass an id of this WordCard to provider_data,
        // in provider_data Function choosePictureInProvider takes that id and send it to words_data throught
        // Function choosePicture, in that Function check wich id match to WordCard and stored image in wordCardPicture.
        words.selectImages(words.id);
        showDialogWindow(context, index);
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [kBoxShadow],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Checkbox(
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: false,
                          onChanged: null,
                        ),
                      ),
                      //Main word container
                      Container(
                        height: 30,
                        width: 100,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(words.word1, //Main word
                              style: TextStyle(
                                  fontSize: 25.0, color: Color(0xFFF8b6b6))),
                        ),
                      ),
                    ],
                  ),
                  // Translation word container
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      alignment: Alignment.center,
                      child: Text(
                        words.translation, //  Translation
                      ),
                    ),
                  ),
                  // Image
                  GestureDetector(
                    // When we press IconBotton is DialogTextHolderContainer, we pass an id of this WordCard to provider_data,
                    // in provider_data Function choosePictureInProvider takes that id and send it to words_data throught
                    // Function choosePicture, in that Function check wich id match to WordCard and stored image in wordCardPicture.
                    onTap: () {
                      words.selectImages(words.id);
                      showImg.toggleShowImgInWordsProvider(words);

                      // words
                      //     .toggleShowImgInWordsProvider(words);
                    },
                    child: !words.isEditingShowImg
                        ? Icon(Icons.image)
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(
                                    words.image,
                                  ),
                                  fit: BoxFit.cover),
                            ),
                            // padding: EdgeInsets.all(0),
                            width: 48,
                            height: 48,
                          ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future showDialogWindow(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: StatefulBuilder(builder: (context, setState) {
            return DialogWindow(index: index);
          }),
        );
      },
    );
  }
}
