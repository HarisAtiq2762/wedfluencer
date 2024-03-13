import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class WedfluencerButtons {
  static Widget fullWidthButton(
          {required String text,
          required Function() func,
          String? iconPath,
          double? height,
          bool hasIcon = true,
          Color? textColor,
          Color? buttonColor,
          Color borderColor = Colors.grey,
          TextStyle? style}) =>
      GestureDetector(
        onTap: func,
        child: Container(
          width: ScreenConfig.screenSizeWidth * 0.9,
          height: height ?? 60,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: ShapeDecoration(
            color: buttonColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.50, color: borderColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              hasIcon
                  ? Container(
                      width: 29,
                      height: 29,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(iconPath!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(width: 8),
              Text(
                text,
                textAlign: TextAlign.center,
                style: style ??
                    ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600, color: textColor),
              ),
            ],
          ),
        ),
      );

  static Widget backButton({required Function() func}) => GestureDetector(
        onTap: func,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
          child: Container(
            color: Colors.transparent,
            height: ScreenConfig.screenSizeHeight * 0.1,
            width: ScreenConfig.screenSizeWidth * 0.1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/icons/Vector (Stroke).png',
              ),
            ),
          ),
        ),
      );

  static Widget selectionBox(
          {required String text,
          bool isSelected = false,
          bool male = true,
          required IconData iconData,
          required Animation<double> opacity}) =>
      Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: ScreenConfig.screenSizeWidth * 0.34,
            height: ScreenConfig.screenSizeHeight * 0.16,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? ScreenConfig.theme.colorScheme.primary
                    : Colors.transparent,
                width: 2,
              ),
              color: const Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(seconds: 0),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: opacity, child: child);
                  },
                  child: isSelected
                      ? Lottie.asset(
                          male
                              ? 'assets/animations/man waving.json'
                              : 'assets/animations/waving women.json',
                          height: ScreenConfig.screenSizeHeight * 0.12,
                        )
                      : CircleAvatar(
                          radius: 28,
                          backgroundColor: isSelected
                              ? ScreenConfig.theme.colorScheme.primary
                              : const Color(0xff9E9E9E),
                          child: Icon(iconData, size: 34, color: Colors.white),
                        ),
                ),
                Text(text, style: ScreenConfig.theme.textTheme.bodySmall)
              ],
            ),
          ),
          isSelected
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.check_circle,
                    color: ScreenConfig.theme.colorScheme.primary,
                    size: 20,
                  ),
                )
              : const SizedBox(),
        ],
      );

  static Widget tabButton({
    required String text,
    bool isSelected = false,
    required Function() func,
  }) =>
      GestureDetector(
        onTap: func,
        child: SizedBox(
          width: ScreenConfig.screenSizeWidth * 0.28,
          height: ScreenConfig.screenSizeHeight * 0.06,
          child: Center(
            child: Text(
              text,
              style: ScreenConfig.theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
          ),
        ),
      );

  static Widget transparentButton(
          {required IconData iconData,
          required String text,
          bool showIcon = true,
          Color borderColor = const Color(0xFFEFEFEF),
          required Function() func}) =>
      GestureDetector(
        onTap: func,
        child: Container(
          width: ScreenConfig.screenSizeWidth * 0.9,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1, color: ScreenConfig.theme.colorScheme.primary),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showIcon
                  ? SizedBox(
                      width: 21.50,
                      height: 21.50,
                      child: Icon(iconData,
                          color: ScreenConfig.theme.primaryColor),
                    )
                  : const SizedBox(),
              showIcon ? const SizedBox(width: 8) : const SizedBox(),
              Text(
                text,
                textAlign: TextAlign.center,
                style: ScreenConfig.theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );

  static Widget circleButtonSmall(
          {required IconData icon, required Function() func}) =>
      GestureDetector(
        onTap: func,
        child: Container(
          width: 52,
          height: 52,
          decoration: ShapeDecoration(
            color: ScreenConfig.theme.colorScheme.primary,
            shape: const OvalBorder(),
            shadows: const [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 25,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      );

  static Widget circleButton({
    required Function() func,
    required Color backgroundColor,
    required bool animatedButton,
    Animation<double>? turns,
    IconData? icon,
  }) =>
      GestureDetector(
        onTap: func,
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 25,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ]),
          child: CircleAvatar(
            radius: 38,
            backgroundColor: backgroundColor,
            child: animatedButton
                ? RotationTransition(
                    turns: turns!,
                    child: Image.asset(
                      'assets/icons/phone.png',
                      height: 34,
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    icon!,
                    color: Colors.white,
                  ),
          ),
        ),
      );

  static Widget floatingButton({required void Function()? onPressed}) =>
      FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: ScreenConfig.theme.primaryColor,
        child: const Icon(Icons.add),
      );
}
