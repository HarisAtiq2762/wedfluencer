import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wedfluencer/src/infrastructure/constants/icon_constant.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import '../../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../templates/dividers.dart';
import '../../../templates/textfields.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  late TextEditingController _fbController,
      _igController,
      _xController,
      _ytController,
      _ttController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fbController = TextEditingController();
    _igController = TextEditingController();
    _xController = TextEditingController();
    _ytController = TextEditingController();
    _ttController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fbController.dispose();
    _igController.dispose();
    _xController.dispose();
    _ytController.dispose();
    _ttController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Social Links'),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    'We may still send you important notifications about your account and content outside of you preferred notivications settings'),
                SocialTextfieldWithIcon(
                  controller: _fbController,
                  hintText: 'Enter facebook profile url',
                  iconBgColor: Colors.blue[50]!,
                  iconPath: IconConstant.facebookIcon,
                ),WedfluencerDividers.transparentDivider(),
                 SocialTextfieldWithIcon(
                  hintText: 'Enter instagram profile url',
                  controller: _igController,
                  iconBgColor: Colors.purple[50]!,
                  iconPath: IconConstant.instagramIcon,
                ),WedfluencerDividers.transparentDivider(),
                SocialTextfieldWithIcon(hintText: 'Enter twitter profile url',
                  controller: _xController,iconBgColor: Colors.black12,
                  iconPath: IconConstant.xIcon,),
                  WedfluencerDividers.transparentDivider(),
                SocialTextfieldWithIcon(
                  hintText: 'Enter Youtube profile url',
                  controller: _ytController,
                  iconBgColor: Colors.red[100]!,
                  iconPath: IconConstant.youtubeIcon,
                ),
                WedfluencerDividers.transparentDivider(),
                SocialTextfieldWithIcon(
                  hintText: 'Enter tiktok profile url',
                  controller: _ttController,
                  iconBgColor: Colors.grey[100]!,
                  iconPath: IconConstant.tiktokIcon,
                  
                ),
               
             
                WedfluencerDividers.transparentDivider(),
                        WedfluencerButtons.fullWidthButton(
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
              text: 'Save Changes',
              textColor: Colors.white,
              widthMultiplier: 1,
              func: () {}),
                
              ],
            ),
          
           
          ],
        ),
      ),
    );
  }
}

class SocialTextfieldWithIcon extends StatelessWidget {
  const SocialTextfieldWithIcon(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.iconPath,
      required this.iconBgColor});

  final TextEditingController controller;
  final String hintText;
  final String iconPath;
  final Color iconBgColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: iconBgColor,
          child: Center(
            child: SvgPicture.asset(iconPath,height:30,width:30,),
          ),
        ),const SizedBox(width: 8,),
        Flexible(
          child: WedfluencerTextFields.iconTextField(
            hint: hintText,
            controller: controller,
            showIcon: false,
            keyboardType: TextInputType.url
          ),
        ),
      ],
    );
  }
}
