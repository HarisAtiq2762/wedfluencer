import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../config/globals.dart';

class WedfluencerTextFields {
  static Widget formPasswordTextField({
    String? hint,
    double? width,
    String? iconImage,
    required bool hidePassword,
    void Function(String)? onChanged,
    required Widget icon,
    required TextEditingController controller,
    bool validateStructure = true,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width ?? ScreenConfig.screenSizeWidth,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: ScreenConfig.screenSizeWidth * 0.025,
                  ),
                  Image.asset(
                    iconImage != null
                        ? 'assets/icons/$iconImage'
                        : 'assets/icons/Location Map Marker 4.png',
                    height: 20,
                    width: 16,
                  ),
                  SizedBox(width: ScreenConfig.screenSizeWidth * 0.025),
                  Expanded(
                    child: TextField(
                      obscureText: hidePassword,
                      controller: controller,
                      onChanged: onChanged,
                      style: ScreenConfig.theme.textTheme.bodySmall,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hint ?? 'Home address',
                          hintStyle: ScreenConfig.theme.textTheme.bodySmall
                              ?.copyWith(color: const Color(0xFF9E9E9E))),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  icon,
                  const SizedBox(width: 12.0),
                ],
              ),
            ),
            controller.text.isEmpty || validateStructure
                ? const SizedBox()
                : Column(
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        'Enter a strong password',
                        style:
                            ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                          color: ScreenConfig.theme.colorScheme.error,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      );
  static Widget phoneNumberField(
          {required TextEditingController controller,
          required void Function(PhoneNumber)? onInputChanged}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InternationalPhoneNumberInput(
            searchBoxDecoration: InputDecoration(
              hintText: 'Search by country code or name',
              hintStyle: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                color: ScreenConfig.theme.hintColor,
              ),
            ),
            spaceBetweenSelectorAndTextField: 0,
            autoFocusSearch: true,
            textStyle: ScreenConfig.theme.textTheme.bodySmall,
            onInputChanged: onInputChanged,
            onInputValidated: (bool value) {
              print(value);
            },
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              setSelectorButtonAsPrefixIcon: true,
              useEmoji: true,
              showFlags: true,
              useBottomSheetSafeArea: true,
            ),
            ignoreBlank: false,
            initialValue: PhoneNumber(dialCode: '+1', isoCode: 'US'),
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: ScreenConfig.theme.textTheme.bodySmall,
            textFieldController: controller,
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            inputBorder: InputBorder.none,
            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
              controller.text = number.phoneNumber.toString();
            },
          ),
        ),
      );

  static Widget iconTextField({
    String? hint,
    double? width,
    String? iconImage,
    IconData? iconData,
    void Function()? onComplete,
    void Function(PointerDownEvent)? onTapOutside,
    void Function()? onTap,
    void Function(String)? onChanged,
    bool showSuffix = false,
    bool? enabled,
    bool showIcon = true,
    Color color = const Color(0xFFF4F4F4),
    required TextEditingController controller,
    TextInputType? keyboardType,
    bool isGooglePlaces = false,
    IconData? suffixIcon,
    void Function()? onTapSuffix,
    int? maxlines,
  }) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: width ?? ScreenConfig.screenSizeWidth,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: ScreenConfig.screenSizeWidth * 0.025),
              if (showIcon) ...[
                iconImage == null
                    ? Icon(
                        iconData,
                        color: ScreenConfig.theme.hintColor,
                        size: 22,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Image.asset(
                          'assets/icons/$iconImage',
                          height: 20,
                          width: 16,
                        ),
                      ),
                SizedBox(width: ScreenConfig.screenSizeWidth * 0.025)
              ],
              Expanded(
                child: isGooglePlaces
                    ? GooglePlaceAutoCompleteTextField(
                        textEditingController: controller,
                        itemClick: (p) {
                          controller.text = p.description!;
                        },
                        containerHorizontalPadding: 0,
                        textStyle: ScreenConfig.theme.textTheme.bodySmall!,
                        isCrossBtnShown: true,
                        googleAPIKey: googleApiKey,
                        isLatLngRequired: true,
                        boxDecoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                        ),
                        inputDecoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hint ?? 'Wedding Location',
                          hintStyle:
                              ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                            color: ScreenConfig.theme.hintColor,
                          ),
                        ),
                      )
                    : TextField(
                        controller: controller,
                        onEditingComplete: onComplete,
                        keyboardType: keyboardType,
                        // onTap: onTap,
                        onChanged: onChanged,
                        enabled: enabled,
                        maxLines: maxlines,
                        style: ScreenConfig.theme.textTheme.bodySmall,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hint ?? 'Home address',
                          hintStyle:
                              ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                            color: ScreenConfig.theme.hintColor,
                          ),
                        ),
                      ),
              ),
              showSuffix
                  ? InkWell(
                      onTap: onTapSuffix,
                      child:
                          Icon(suffixIcon, color: ScreenConfig.theme.hintColor))
                  : const SizedBox(),
              showSuffix
                  ? SizedBox(width: ScreenConfig.screenSizeWidth * 0.025)
                  : const SizedBox(),
            ],
          ),
    GlobalKey? formKey,
    String? Function(String?)? validator,
    void Function(String)? onFieldSubmitted,
    void Function(String?)? onSaved,
    FocusNode? focusNode,
    bool validateStructure = true,
    String? errorMessage = '',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width ?? ScreenConfig.screenSizeWidth,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: ScreenConfig.screenSizeWidth * 0.025),
              showIcon
                  ? iconImage == null
                      ? Icon(
                          iconData,
                          color: ScreenConfig.theme.hintColor,
                          size: 22,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Image.asset(
                            'assets/icons/$iconImage',
                            height: 20,
                            width: 16,
                          ),
                        )
                  : const SizedBox(),
              showIcon
                  ? SizedBox(width: ScreenConfig.screenSizeWidth * 0.025)
                  : const SizedBox(),
              Expanded(
                  child: isGooglePlaces
                      ? GooglePlaceAutoCompleteTextField(
                          textEditingController: controller,
                          itemClick: (p) {
                            controller.text = p.description!;
                          },
                          containerHorizontalPadding: 0,
                          textStyle: ScreenConfig.theme.textTheme.bodySmall!,
                          isCrossBtnShown: true,
                          googleAPIKey: googleApiKey,
                          isLatLngRequired: true,
                          boxDecoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                          ),
                          inputDecoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Wedding Location',
                            hintStyle: ScreenConfig.theme.textTheme.bodySmall
                                ?.copyWith(
                              color: ScreenConfig.theme.hintColor,
                            ),
                          ),
                        )
                      : TextField(
                          // validator: validator,
                          // onSaved: onSaved,
                          // onFieldSubmitted: onFieldSubmitted,
                          focusNode: focusNode,
                          onSubmitted: onFieldSubmitted,
                          controller: controller,
                          onEditingComplete: onComplete,
                          onTapOutside: onTapOutside,
                          keyboardType: keyboardType,
                          onTap: onTap,
                          onChanged: onChanged,
                          enabled: enabled,
                          style: ScreenConfig.theme.textTheme.bodySmall,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: hint ?? 'Home address',
                            hintStyle: ScreenConfig.theme.textTheme.bodySmall
                                ?.copyWith(
                              color: ScreenConfig.theme.hintColor,
                            ),
                          ),
                        )),
              showSuffix
                  ? InkWell(
                      onTap: onTapSuffix,
                      child:
                          Icon(suffixIcon, color: ScreenConfig.theme.hintColor))
                  : const SizedBox(),
              showSuffix
                  ? SizedBox(width: ScreenConfig.screenSizeWidth * 0.025)
                  : const SizedBox(),
            ],
          ),
        ),
        controller.text.isEmpty || validateStructure
            ? const SizedBox()
            : Column(
                children: [
                  const SizedBox(height: 6),
                  Text(
                    errorMessage!,
                    style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                      color: ScreenConfig.theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  static Widget multilineTextField(
          {String? hint,
          double? width,
          required TextEditingController controller}) =>
      Column(
        children: [
          Container(
            width: width ?? ScreenConfig.screenSizeWidth,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: TextField(
                maxLines: 3,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint ?? 'Type Instructions',
                  hintStyle: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF9E9E9E),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
