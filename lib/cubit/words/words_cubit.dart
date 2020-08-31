import 'package:bloc/bloc.dart';

class WordsCubit extends Cubit<bool> {
  WordsCubit() : super(false);

  void toggleEditMode() => emit(!state);

  void toggleEditModeToFalse() => emit(false);
}
