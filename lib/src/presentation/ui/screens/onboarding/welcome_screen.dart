import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../../models/carousel.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import 'onboarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const routeName = '/Welcome-screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late final Animation<double> _animation;
  CarouselController carouselController = CarouselController();
  Tween<double> _tween = Tween(begin: 0.90, end: 1.0);
  bool showButtonIcon = true;
  final carouselDataList = [
    CarouselSliderData(
      title: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: ScreenConfig.theme.textTheme.headlineSmall
              ?.copyWith(color: Colors.white),
          children: <TextSpan>[
            TextSpan(
              text: 'Innovative ',
              style: ScreenConfig.theme.textTheme.headlineSmall
                  ?.copyWith(color: ScreenConfig.theme.primaryColor),
            ),
            TextSpan(
              text: 'wedding planning experience with ',
              style: ScreenConfig.theme.textTheme.headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            TextSpan(
              text: 'AI driven ',
              style: ScreenConfig.theme.textTheme.headlineSmall
                  ?.copyWith(color: ScreenConfig.theme.primaryColor),
            ),
            TextSpan(
              text: 'collaboration',
              style: ScreenConfig.theme.textTheme.headlineSmall
                  ?.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
      imagePath: 'assets/images/bride2.jpg',
    ),
    CarouselSliderData(
      title: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: ScreenConfig.theme.textTheme.headlineSmall
              ?.copyWith(color: Colors.white),
          children: <TextSpan>[
            TextSpan(
              text: 'A ',
              style: ScreenConfig.theme.textTheme.headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            TextSpan(
              text: 'Community ',
              style: ScreenConfig.theme.textTheme.headlineSmall
                  ?.copyWith(color: ScreenConfig.theme.primaryColor),
            ),
            TextSpan(
              text: 'where brides and wedding pros thrive as ',
              style: ScreenConfig.theme.textTheme.headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            TextSpan(
              text: 'Content Creators',
              style: ScreenConfig.theme.textTheme.headlineSmall
                  ?.copyWith(color: ScreenConfig.theme.primaryColor),
            ),
          ],
        ),
      ),
      imagePath: 'assets/images/bride.jpg',
    ),
    CarouselSliderData(
      title: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: ScreenConfig.theme.textTheme.headlineSmall
              ?.copyWith(color: Colors.white),
          children: <TextSpan>[
            TextSpan(
              text: 'Share your wedding deeds and let ',
              style: ScreenConfig.theme.textTheme.headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            TextSpan(
              text: 'AI ',
              style: ScreenConfig.theme.textTheme.headlineSmall
                  ?.copyWith(color: ScreenConfig.theme.primaryColor),
            ),
            TextSpan(
              text: 'play matchmaker with your ',
              style: ScreenConfig.theme.textTheme.headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            TextSpan(
              text: 'Dream Vendors',
              style: ScreenConfig.theme.textTheme.headlineSmall
                  ?.copyWith(color: ScreenConfig.theme.primaryColor),
            ),
          ],
        ),
      ),
      imagePath: 'assets/images/selection.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
          height: ScreenConfig.screenSizeHeight * 1.2,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 10),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          onPageChanged: (val, index) {},
          scrollDirection: Axis.horizontal,
        ),
        items: carouselDataList.map((data) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    WedfluencerDecorations.scaffoldDecoration().copyWith(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(data.imagePath),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logos/logo.png',
                        width: ScreenConfig.screenSizeWidth * 0.4,
                      ),
                      WedfluencerDividers.transparentDividerForHeadings(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withOpacity(0.4)),
                          child: data.title,
                          // child: Text(
                          //   data.title,
                          //   style: ScreenConfig.theme.textTheme.headlineSmall
                          //       ?.copyWith(color: Colors.white),
                          //   textAlign: TextAlign.center,
                          // ),
                        ),
                      ),
                      WedfluencerDividers.transparentDividerForHeadings(),
                      WedfluencerDividers.transparentDividerForHeadings(),
                      GestureDetector(
                        onTap: () {
                          animationController.reset();
                          setState(() {
                            showButtonIcon = false;
                            _tween = Tween(begin: 1, end: 36);
                          });
                          animationController.forward().whenComplete(() {
                            Navigator.pushNamed(
                                context, OnboardingScreen.routeName);
                            setState(() {
                              showButtonIcon = true;
                              _tween = Tween(begin: 0.90, end: 1.0);
                            });
                            animationController.reset();
                            animationController.repeat(reverse: true);
                          });
                        },
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ScaleTransition(
                            scale: _tween.animate(_animation),
                            child: WedfluencerButtons.fullWidthButton(
                              text: 'Get Started',
                              func: () {
                                Navigator.pushNamed(
                                    context, OnboardingScreen.routeName);
                              },
                              hasIcon: false,
                              buttonColor: ScreenConfig.theme.primaryColor,
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
