part of 'image_cubit.dart';

class ImageState extends Equatable {
  ImageState({this.image});

  final File image;

  @override
  List<Object> get props => [image];
}

// part of 'image_cubit.dart';

// abstract class ImageState extends Equatable {
//   const ImageState();

//   @override
//   List<Object> get props => [];
// }

// class ImageInitial extends ImageState {}

// class ImageSucces extends ImageState {
//   ImageSucces({this.image});

//   final File image;

//   @override
//   List<Object> get props => [];
// }
