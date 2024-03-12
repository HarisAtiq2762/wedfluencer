import 'package:flutter/material.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';

class ImprintScreen extends StatelessWidget {
  const ImprintScreen({super.key});

  static const routeName = '/imprint-screen';

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
          'Imprint',
          style: ScreenConfig.theme.textTheme.headlineSmall
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: SizedBox(
        width: ScreenConfig.screenSizeWidth * 0.9,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Information according to §5 TMG',
                textAlign: TextAlign.start,
                style: ScreenConfig.theme.textTheme.titleLarge
                    ?.copyWith(color: Colors.black),
              ),
              Center(
                child: SizedBox(
                  width: ScreenConfig.screenSizeWidth * 0.84,
                  child: const Text(
                    'Askrella Software Agency UG (haftungsbeschränkt) \nSenefelderstr. 3 \n71638 Ludwigsburg \n \nEmail: contact@askrella.de \nPhone: +49 177 2686292 \n \nManaging Director:\nStanislav Hetzel\n\nCourt of Registry Stuttgart\nRegistration number: HRB 782555\nVAT ID No.: DE349197234',
                    style: TextStyle(
                      color: Color(0xFF626B71),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
