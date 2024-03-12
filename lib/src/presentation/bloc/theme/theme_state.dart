part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {
  final ThemeData theme;
  ThemeInitial({required this.theme});
}
