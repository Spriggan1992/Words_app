part of 'part_color_cubit.dart';

class PartColorState extends Equatable {
  const PartColorState([this.color = const Color(0xffF3F3F3)]);
  final Color color;

  @override
  List<Object> get props => [color];
}
