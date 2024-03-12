import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../infrastructure/localization/global_translation.dart';
import '../../../infrastructure/localization/preferences.dart';
import '../../ui/templates/debug_helper.dart';
part 'translation_event.dart';
part 'translation_state.dart';

class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  TranslationBloc(TranslationState initialState) : super(initialState);

  TranslationState get initialState => TranslationState(
        locale: translations.locale,
      );

  Stream<TranslationState> mapEventToState(
    TranslationEvent event,
  ) async* {
    if (event is SwitchLanguage) {
      DebugHelper.printAll(event.language);
      await preferences.setPreferredLanguage(event.language);
      // Notification the translations module about the new language
      await translations.setNewLanguage(event.language);
      yield TranslationState(
        locale: translations.locale,
      );
    }
  }
}
