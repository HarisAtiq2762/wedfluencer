import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/resources/helper_services/dialog_box_service.dart';

import '../../../presentation/ui/templates/custom_widgets/circle_rounded_loader.dart';
import '../../dependency_injection.dart';
import '../../navigation_service.dart';

class LoaderStatus {
  LoaderStatus._();
  static bool _isLoading = false;
  //ignore: prefer_final_fields
  static List<String> _keysForBlocs = [];

  static void setLoaderToLoading(
    BuildContext context, {
    String? keyForBloc,
  }) {
    if (keyForBloc != null && !_keysForBlocs.contains(keyForBloc)) {
      _keysForBlocs.add(keyForBloc);
    }

    if (!_isLoading) {
      _isLoading = true;
      DialogBoxService().wedfluencerDialogBoxWithWidgets(
        context: context,
        widgets: [
          const CircleRoundedLoader(),
        ],
      );
    }
  }

  static void dismissLoader(
    BuildContext context, {
    String? keyForBloc,
  }) {
    if (keyForBloc != null && _keysForBlocs.contains(keyForBloc)) {
      _keysForBlocs.remove(
        keyForBloc,
      );
    }
    if (_isLoading && _keysForBlocs.isEmpty) {
      _isLoading = false;
      Navigator.pop(context);
    }
  }
}

class LoaderService {
  LoaderService._();
  static void setContextSafeLoader({
    required bool startLoader,
    required String loaderKeyForBloc,
  }) {
    if (startLoader) {
      LoaderStatus.setLoaderToLoading(
        DI.i<NavigationService>().getContext(),
        keyForBloc: loaderKeyForBloc,
      );
    } else {
      LoaderStatus.dismissLoader(
        DI.i<NavigationService>().getContext(),
        keyForBloc: loaderKeyForBloc,
      );
    }
  }
}
