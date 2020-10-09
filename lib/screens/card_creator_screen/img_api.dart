import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/card_creator/card_creator_bloc.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/models/image_data.dart';
import 'package:words_app/utils/size_config.dart';
import 'package:words_app/widgets/widgets.dart';

class ImageApi extends StatefulWidget {
  static const id = 'img_api';
  final String targetLang;

  const ImageApi({Key key, this.targetLang}) : super(key: key);

  @override
  _ImageApiState createState() => _ImageApiState();
}

class _ImageApiState extends State<ImageApi> {
  TextEditingController _controller;
  bool _keyboardVisible = false;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.targetLang ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return SafeArea(
      child: Scaffold(
        appBar: BaseAppBar(title: Text('Image Picker'), appBar: AppBar()),
        body: BlocBuilder<CardCreatorBloc, CardCreatorState>(
          builder: (context, state) {
            if (state is CardCreatorLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CardCreatorSuccess) {
              return InputField(
                imageData: state.imageData,
                textController: _controller,
                keyboardVisible: _keyboardVisible,
              );
            }
            if (state is CardCreatorFailure) {
              return Center(
                child: Text(
                  "${state.message}",
                  style: TextStyle(fontSize: 50),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final List<ImgData> imageData;
  final TextEditingController textController;
  final bool keyboardVisible;
  const InputField({this.imageData, this.textController, this.keyboardVisible});

  List<Widget> buildimageList(BuildContext context) {
    List<Widget> list = [];
    imageData?.forEach((item) {
      list.add(
        GestureDetector(
          onTap: () {
            context.bloc<CardCreatorBloc>().add(
                  CardCreatorUpdateImagesFromAPI(url: item.url),
                );
            Navigator.pop(context);
          },
          child: Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                // child: Container(),
                child: Image.network(
                  item.url,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 100,
                height: 100,
                color: item.isSelected
                    ? Colors.blue.withOpacity(0.4)
                    : Colors.transparent,
              )
            ],
          ),
        ),
      );
    });
    return list;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Center(
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: keyboardVisible
                  ? SizeConfig.blockSizeVertical * 100
                  : SizeConfig.blockSizeVertical * 88.5,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Container(child: Text(id, style: TextStyle(fontSize: 30))),
                SizedBox(height: 20),
                Container(
                  decoration: innerShadow,
                  width: 300,
                  child: TextField(
                    controller: textController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      contentPadding: EdgeInsets.only(
                        left: 50.0,
                        top: 15.0,
                        bottom: 15.0,
                      ),
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (value) {
                      submitImgName(context, value);
                    },
                  ),
                ),
                // Container(child: Text(tagName)),
                SizedBox(height: 25),
                Expanded(
                  child: Container(
                    // padding: const EdgeInsets.all(8.0),

                    child: SingleChildScrollView(
                      child: Wrap(
                        runSpacing: 2,
                        spacing: 2,
                        children: buildimageList(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitImgName(BuildContext context, String imgName) {
    context
        .bloc<CardCreatorBloc>()
        .add(CardCreatorDownloadImagesFromAPI(name: imgName));
  }
}
