import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/card_creator/card_creator_bloc.dart';
import 'package:words_app/bloc/image_api/image_api_bloc.dart';
import 'package:words_app/config/constants.dart';
import 'package:words_app/config/size_config.dart';
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
        body: BlocConsumer<ImageApiBloc, ImageApiState>(
          listener: (context, state) {
            if (state.isSuccess) {
              // Navigator.of(context).pop(state.image);
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
            } else if (state.isSubmiting) {
              return CircularProgressIndicator();
            }
          },
          builder: (context, state) {
            return InputField(
              state: state,
              textController: _controller,
              keyboardVisible: _keyboardVisible,
            );
          },
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final ImageApiState state;
  final TextEditingController textController;
  final bool keyboardVisible;
  const InputField({this.state, this.textController, this.keyboardVisible});

  List<Widget> buildimageList(BuildContext context) {
    List<Widget> list = [];
    state.imageData?.forEach((item) {
      list.add(
        GestureDetector(
          onTap: () {
            Navigator.pop(context, item.url);
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
                    onChanged: (value) {
                      context
                          .bloc<ImageApiBloc>()
                          .add(ImageApiSearchUpdated(search: value));
                    },
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
    context.bloc<ImageApiBloc>().add(ImageApiDownloadImagesFromAPI());
  }
}
