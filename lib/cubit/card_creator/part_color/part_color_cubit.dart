import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'part_color_state.dart';

class PartColorCubit extends Cubit<PartColorState> {
  PartColorCubit() : super(PartColorState());

  void changeColor(Color color) => emit(PartColorState(color));
}
