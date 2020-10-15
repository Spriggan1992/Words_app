import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/image_api/image_api_bloc.dart';
import 'package:words_app/models/image_data.dart';

class ImageApi extends StatefulWidget {
  static const id = 'img_api';
  // final String targetLanguage;

  // const ImageApi({this.targetLanguage});

  @override
  _ImageApiState createState() => _ImageApiState();
}

class _ImageApiState extends State<ImageApi> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> buildimageList(
      BuildContext context, List<ImgData> imageData, ImageApiState state) {
    List<Widget> list = [];
    imageData?.forEach((item) {
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
  Widget build(BuildContext context) {
    TextEditingController controller;
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ImageApiBloc, ImageApiState>(
          listener: (context, state) {
            controller = TextEditingController(text: state.search ?? "");
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length));
          },
          builder: (context, state) {
            return Center(
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // Container(child: Text(id, style: TextStyle(fontSize: 30))),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: controller,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            context
                                .bloc<ImageApiBloc>()
                                .add(ImageApiSearchUpdated(search: value));
                          },
                          onSubmitted: (value) {
                            context
                                .bloc<ImageApiBloc>()
                                .add(ImageApiDownloadImagesFromAPI());
                          },
                        ),
                      ),
                      // Container(child: Text(tagName)),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 500,
                        child: SingleChildScrollView(
                          child: Wrap(
                            runSpacing: 2,
                            spacing: 2,
                            children:
                                buildimageList(context, state.imageData, state),
                          ),
                        ),
                      ),

                      FlatButton(
                        child: Text('add image'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
