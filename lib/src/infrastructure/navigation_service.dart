import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigatorKey;
  BuildContext? get _context => _navigatorKey.currentContext!;

  navigateTo(Function(BuildContext context) navigationFunc) {
    navigationFunc(_navigatorKey.currentContext!);
  }

  Future<dynamic> showCustomDialog(Widget dialog) async {
    return await showDialog(
      context: _navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  void showToast({required String message, bool error = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showSnackBar(
      {required String message,
      bool error = false,
      Color color = Colors.black}) {
    ScaffoldMessenger.of(_context!).clearSnackBars();
    final snackBar = SnackBar(
      backgroundColor: error ? Colors.red : color,
      content: Text(
        message,
        style: ScreenConfig.theme.textTheme.bodySmall
            ?.copyWith(color: Colors.white),
        textAlign: TextAlign.start,
      ),
      duration: const Duration(milliseconds: 5000),
      behavior: SnackBarBehavior.fixed,
    );
    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(_context!).showSnackBar(snackBar);
  }
}
