import 'package:flutter/material.dart';
import 'package:wedfluencer/src/app.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? title, bodyText, cancelButtonText, filledButtonText;
  final VoidCallback? onConfirmation, onCancel;
  final Color filledBtnColor;

  const ConfirmationDialog(
      {super.key,
      this.onConfirmation,
      this.onCancel,
      this.title,
      this.bodyText,
      this.cancelButtonText,
      this.filledButtonText,
      this.filledBtnColor = themeColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title ?? 'TEST SUBMISSION',
                    maxLines: 5,
                    style: ScreenConfig.theme.textTheme.labelLarge?.copyWith(
                        color: const Color(0xFF121212), fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    bodyText ?? "Do you want to end the test?",
                    style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF121212),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            if (onCancel != null) onCancel!();
                            Navigator.pop(context, false);
                          },
                          child: Text(
                            cancelButtonText ?? 'Cancel',
                            //style: context.textTheme.titleSmall,
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      WedfluencerButtons.smallButton(
                        text: filledButtonText ?? 'Submit',
                        buttonColor: filledBtnColor,
                        hasIcon: false,
                        textColor: Colors.white,
                        func: () {
                          if (onConfirmation != null) onConfirmation!();
                          Navigator.pop(context, true);
                        },
                      )
                    ],
                  )
                ],
              ),
            )),
      ],
    );
  }
}
