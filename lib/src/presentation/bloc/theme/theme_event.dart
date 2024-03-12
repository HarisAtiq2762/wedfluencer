part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class UpdateTheme extends ThemeEvent {
  final ColorScheme colorScheme;
  UpdateTheme({required this.colorScheme});
}

class SetInitialTheme extends ThemeEvent {
  final ThemeData themeData;
  SetInitialTheme({required this.themeData});
}
