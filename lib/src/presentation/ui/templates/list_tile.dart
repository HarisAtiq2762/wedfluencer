import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../models/doctors.dart';
import 'buttons.dart';
import 'dividers.dart';

class KhairyatListTile {
  static Widget generalTile({
    required Doctor doctor,
    required Color color,
    bool isRemoveAble = false,
  }) =>
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.title,
                      style: ScreenConfig.theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      doctor.subTitle,
                      style: ScreenConfig.theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/${doctor.imagePath}',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
          isRemoveAble
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 4.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close_outlined,
                      color: ScreenConfig.theme.colorScheme.error,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      );

  static Widget bluetoothListTile({
    required String title,
    required String subTitle,
    required Color color,
    required Function()? onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: ScreenConfig.theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subTitle,
                    style: ScreenConfig.theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  static Widget notificationListTile({
    required String title,
    required String subTitle,
    required Color color,
  }) =>
      Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.notifications_active_outlined,
              color: ScreenConfig.theme.primaryColor,
            ),
            SizedBox(width: ScreenConfig.screenSizeWidth * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ScreenConfig.theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  subTitle,
                  style: ScreenConfig.theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      );

  static Widget settingsListTile(
      {required String text,
      required IconData icon,
      Color? color,
      required void Function()? onTap}) {
    final colors = [
      Colors.pink.shade50,
      Colors.blue.shade50,
      Colors.purple.shade50,
      Colors.green.shade50,
    ];
    return Material(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors[Random().nextInt(colors.length)],
                ),
                child: Icon(
                  icon,
                  color: ScreenConfig.theme.primaryColor,
                ),
              ),
              SizedBox(width: ScreenConfig.screenSizeWidth * 0.04),
              Text(
                text,
                style: ScreenConfig.theme.textTheme.labelLarge,
              ),
              const Spacer(),
              Image.asset(
                'assets/icons/arrow_right.png',
                height: 16,
                width: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget simpleTile({
    required String name,
    required String description,
    required String reminder,
    required String dateRange,
    bool isEditable = true,
  }) =>
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: ScreenConfig.theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: ScreenConfig.theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.notifications_active_outlined,
                      color: ScreenConfig.theme.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Reminders',
                      style: ScreenConfig.theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  reminder,
                  style: ScreenConfig.theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  dateRange,
                  style: ScreenConfig.theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          isEditable
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 4.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.edit_outlined,
                      color: ScreenConfig.theme.primaryColor,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      );

  static Widget earningsTile({
    required String title,
    required String subTitle,
    required String earning,
    required String imageName,
  }) =>
      Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 4,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/$imageName',
              width: 36,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ScreenConfig.theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  subTitle,
                  style: ScreenConfig.theme.textTheme.labelMedium,
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.shade50,
              ),
              child: Icon(
                Icons.arrow_downward,
                color: ScreenConfig.theme.primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 40,
              child: Text(
                earning,
                style: ScreenConfig.theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      );

  static Widget displayExpansionTile(
          {required Color color,
          required String name,
          required String status,
          required String description}) =>
      ExpansionTile(
        maintainState: true,
        backgroundColor: ScreenConfig.theme.primaryColor.withOpacity(0.1),
        collapsedBackgroundColor: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: ScreenConfig.theme.textTheme.bodyLarge,
            ),
            Text(
              status,
              style: ScreenConfig.theme.textTheme.labelMedium,
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              description,
              style: ScreenConfig.theme.textTheme.bodySmall,
            ),
          ),
          WedfluencerDividers.transparentDivider(),
          WedfluencerTextFields.multilineTextField(
            controller: TextEditingController(),
            hint: 'Type Your Reply',
          ),
          WedfluencerDividers.transparentDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: WedfluencerButtons.fullWidthButton(
              text: 'Submit',
              func: () {},
              hasIcon: false,
              borderColor: ScreenConfig.theme.primaryColor,
              textColor: ScreenConfig.theme.primaryColor,
            ),
          ),
          WedfluencerDividers.transparentDivider(),
        ],
      );
}
