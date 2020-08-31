import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:words_app/repositories/words_repository.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit(this.wordsRepository) : super(ImageState());

  WordsRepository wordsRepository;

  void getImageFile() async {
    final picker = ImagePicker();
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
    emit(ImageState(image: croppedFile));
  }

  void rebuild(File image) {
    emit(ImageState(image: image));
  }
}
// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// part 'image_state.dart';

// class ImageCubit extends Cubit<ImageState> {
//   ImageCubit() : super(ImageInitial());

//   void getImageFile() async {
//     final picker = ImagePicker();
//     PickedFile imageFile =
//         await picker.getImage(source: ImageSource.camera, maxWidth: 600);
// //    final imageFile2 = await assetToFile('images/noimages.png');
// //    print(imageFile2.path);
//     //This check is needed if we didn't take a picture  and used back button in camera;

//     if (imageFile == null) {
//       return;
//     }

//     //Call imageCropper module and crop the image. I has different looks on Android and IOS
//     File croppedFile = await ImageCropper.cropImage(
//       sourcePath: imageFile.path,
//       maxWidth: 600,
//       maxHeight: 600,
//     );
//     emit(ImageSucces(image: croppedFile));
//   }
// }
