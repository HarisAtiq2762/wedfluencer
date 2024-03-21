import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
      title: 'Share Your Journey And Make Money',
      imagePath: 'assets/animations/makeVideo.json',
    ),
    CarouselSliderData(
      title: 'Record Your Needs And Have Vendors Compete To Earn Your Biz',
      imagePath: 'assets/animations/won.json',
    ),
    CarouselSliderData(
      title: 'Need Inspiration? WEDFLUENCER Is The Answer!',
      imagePath: 'assets/animations/idea.json',
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
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: WedfluencerDecorations.scaffoldDecoration(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                height: ScreenConfig.screenSizeHeight * 0.7,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 10),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                enlargeFactor: 0.3,
                onPageChanged: (val, index) {},
                scrollDirection: Axis.horizontal,
              ),
              items: carouselDataList.map((data) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.title,
                            style: ScreenConfig.theme.textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          Lottie.asset(
                            data.imagePath,
                            height: ScreenConfig.screenSizeHeight * 0.4,
                            width: ScreenConfig.screenSizeWidth,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            GestureDetector(
              onTap: () {
                animationController.reset();
                setState(() {
                  showButtonIcon = false;
                  _tween = Tween(begin: 1, end: 36);
                });
                animationController.forward().whenComplete(() {
                  Navigator.pushNamed(context, OnboardingScreen.routeName);
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
                      Navigator.pushNamed(context, OnboardingScreen.routeName);
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
  }
}
