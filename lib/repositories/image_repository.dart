import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:words_app/models/image_data.dart';

class ImageRepository {
  Future getNetworkImg({String word, String collectionLang}) async {
    List<ImgData> imageData = [];
    String requestUrl =
        'https://pixabay.com/api/?key=17723422-77b02c597c0935e4cc98e0e5f&q=$word&image_type=photo&lang=$collectionLang';

    http.Response response = await http.get(requestUrl);

    if (response.statusCode == 200 &&
        jsonDecode(response.body)['hits'].length > 0) {
      String data = response.body;
      var images = jsonDecode(data);

      List<dynamic> imagesList = images['hits'];

      imagesList?.forEach(
        (item) {
          imageData.add(
            ImgData(
              id: item['id'].toString(),
              url: item['previewURL'].toString(),
              tag: item['tags'].toString(),
            ),
          );
        },
      );
      return imageData;
    } else {
      throw NetworkException();
    }
  }

  /// /// This method is responsible for returning picter [File].
  Future<dynamic> getImageFile() async {
    final picker = ImagePicker();
    PickedFile imageFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 600);
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    String name = p.basename(imageFile.path);

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

    File file = await croppedFile.copy("$path/$name");
    try {
      croppedFile.delete();
    } on FileSystemDeleteEvent {}
    // print('name: $name path: $path file size: ${file.length()}');
    return file;
  }

  Future<File> getImageFileFromUrl(String url) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    String name = p.basename(url);
    File file = File("$path/$name");
    // print(
    //   "path: $path name $name",
    // );
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      await file.writeAsBytes(response.bodyBytes);
    } else {
      throw NetworkException();
    }

    //Call imageCropper module and crop the image. I has different looks on Android and IOS
    // File croppedFile = await ImageCropper.cropImage(
    //   sourcePath: imageFile.path,
    //   maxWidth: 600,
    //   maxHeight: 600,
    // );
    // return croppedFile;
    return file;
  }
}

class NetworkException implements Exception {}
