import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/card_creator/card_creator_bloc.dart';
import 'package:words_app/models/image_data.dart';

class ImageApi extends StatefulWidget {
  static const id = 'img_api';
  @override
  _ImageApiState createState() => _ImageApiState();
}

class _ImageApiState extends State<ImageApi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          },
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final List<ImgData> imageData;

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

  const InputField({this.imageData});
  @override
  Widget build(BuildContext context) {
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
                  textAlign: TextAlign.center,
                  onSubmitted: (value) {
                    submitImgName(context, value);
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
                    children: buildimageList(context),
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
  }

  void submitImgName(BuildContext context, String imgName) {
    context
        .bloc<CardCreatorBloc>()
        .add(CardCreatorDownloadImagesFromAPI(name: imgName));
  }
}
