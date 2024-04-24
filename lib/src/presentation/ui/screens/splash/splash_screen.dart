import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../infrastructure/local_storage/local_storage.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/helper.dart';
import '../onboarding/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController logoAnimationController;
  late final Animation<double> _animation;
  final Tween<double> _tween = Tween(begin: 0.70, end: 1.0);
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
    logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    navigate();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  initialize() async {
    await Storage.initialize();
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        PageTransition(
          alignment: Alignment.center,
          type: PageTransitionType.fade,
          child: Container(),
        ),
      );
      Navigator.of(context).push(WedfluencerHelper.createRoute(
        page: const WelcomeScreen(),
      ));
      // Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        // image: DecorationImage(
        //  image: AssetImage('assets/images/splashScreen.png'),
        //   fit: BoxFit.cover,
        // ),
      ),
      // child: Scaffold(
      //   body: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       ScaleTransition(
      //         scale: _tween.animate(_animation),
      //         child: Image.asset(
      //           'assets/logos/logo.png',
      //           fit: BoxFit.contain,
      //           height: ScreenConfig.screenSizeHeight * 0.24,
      //           width: ScreenConfig.screenSizeWidth,
      //         ),
      //       ),
      //       WedfluencerDividers.transparentDivider(),
      //       Text(
      //         'Says You',
      //         style: ScreenConfig.theme.textTheme.bodySmall,
      //       ),
      //       WedfluencerDividers.transparentDivider(),
      //       Lottie.asset(
      //         'assets/animations/hello.json',
      //         width: ScreenConfig.screenSizeWidth,
      //         height: ScreenConfig.screenSizeHeight * 0.1,
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
