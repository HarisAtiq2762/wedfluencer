import 'package:flutter/material.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';

class DataPrivacyScreen extends StatelessWidget {
  const DataPrivacyScreen({super.key});
  static const routeName = '/privacy-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          'Data Privacy',
          style: ScreenConfig.theme.textTheme.headlineSmall
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: ScreenConfig.screenSizeWidth * 0.9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This is just a placeholder headline',
                  textAlign: TextAlign.start,
                  style: ScreenConfig.theme.textTheme.titleLarge
                      ?.copyWith(color: Colors.black),
                ),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'This is just placeholder text. Don’t be alarmed, this is just here to fill up space since your finalized copy isn’t ready yet. Once we have your content finalized, we’ll replace this placeholder text with your real content.\n\n',
                        style: TextStyle(
                          color: Color(0xFF626B71),
                          fontSize: 16,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Sometimes it’s nice to put in text just to get an idea of how text will fill in a space on your website',
                        style: TextStyle(
                          color: Color(0xFF121212),
                          fontSize: 16,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.50,
                        ),
                      ),
                      TextSpan(
                        text:
                            '. Traditionally our industry has used Lorem Ipsum, which is placeholder text written in Latin. Unfortunately, not everyone is familiar with Lorem Ipsum and that can lead to confusion. I can’t tell you how many times clients have asked me why their website is in another language!\n\nThere are other placeholder text alternatives like Hipster Ipsum, Zombie Ipsum, Bacon Ipsum, and many more. While often hilarious, these placeholder passages can also lead to much of the same confusion.\n\nIf you’re curious, this is Website Ipsum. It was specifically developed for the use on development websites. Other than being less confusing than other Ipsum’s, Website Ipsum is also formatted in patterns more similar to how real copy is formatted on the web today.',
                        style: TextStyle(
                          color: Color(0xFF626B71),
                          fontSize: 16,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
