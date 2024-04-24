import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dropdown.dart';
import '../../../../../app.dart';
import '../../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../templates/dividers.dart';
import '../../../templates/khairyat_appbar.dart';
import '../../../templates/textfields.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late TextEditingController _dateController, _cityController, _guestController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateController = TextEditingController();
    _cityController = TextEditingController();
    _guestController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _dateController.dispose();
    _cityController.dispose();
    _guestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: true,
        context: context,
        title: 'Settings',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 WedfluencerDividers.transparentDivider(),
                WedfluencerTextFields.iconTextField(
                    controller: _dateController,
                    onTap: () async {
                      final pickedDate = await showDialog(
                          context: context,
                          builder: (context) => Theme(
                                data: ThemeData(
                                  dialogBackgroundColor: Colors.white,
                                  colorScheme:const ColorScheme.light(primary:  themeColor)
                                ),
                                child: Dialog(
                                  child: SingleChildScrollView(
                                    child: DatePickerDialog(
                                      helpText: 'Select your wedding date',
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2050),
                                    ),
                                  ),
                                ),
                              ));
                      if (pickedDate != null) {
                        _dateController.text =
                            DateFormat('dd/MM/yyyy').format(pickedDate!);
                      }
                    },
                    hint: 'Wedding Date',
                    keyboardType: TextInputType.datetime,
                    enabled: false,
                    iconData: Icons.date_range),
                WedfluencerDividers.transparentDivider(),
                WedfluencerTextFields.iconTextField(
                    hint: 'Enter Wedding City',
                    controller: _cityController,
                    iconData: Icons.location_city_outlined,
                    isGooglePlaces: true),
                WedfluencerDividers.transparentDivider(),
                WedfluencerDropdown(
                    hint: 'Select wedding type',
                    isExpanded: true,
                    width: 1.0.sw,
                    data: const ['Tradional', 'Destination', 'Small']),
                WedfluencerDividers.transparentDivider(),
                WedfluencerTextFields.iconTextField(
                    hint: 'No. of guests',
                    controller: _guestController,
                    keyboardType: TextInputType.number,
                    iconData: Icons.numbers),
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
