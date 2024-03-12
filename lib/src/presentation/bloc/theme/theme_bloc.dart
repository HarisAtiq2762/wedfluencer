import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ui/config/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(theme: wedfluencerTheme));

  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is UpdateTheme) {
      final newTheme =
          wedfluencerTheme.copyWith(colorScheme: event.colorScheme);
      yield ThemeInitial(theme: newTheme);
    }
  }
}
