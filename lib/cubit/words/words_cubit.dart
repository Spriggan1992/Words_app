import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';



class WordsCubit extends Cubit<bool> {
  WordsCubit() : super(false);

void toggleEditMode() => emit(!state);
}