import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dropdown.dart';

import '../../../infrastructure/resources/user/user_provider.dart';
import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../templates/custom_date_picker.dart';
import '../templates/dividers.dart';
import '../templates/khairyat_appbar.dart';
import '../templates/textfields.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late TextEditingController _dateController, _cityController, _guestController;
  String? weddingType;
  DateTime? pickedDate;

  @override
  void initState() {
    super.initState();
    final weddingDetails = DI.i<AuthRepository>().user!.weddingDetails;
    _dateController = TextEditingController();
    _cityController = TextEditingController();
    _guestController = TextEditingController();
    _guestController.text = weddingDetails?.noOfGuests != null
        ? weddingDetails!.noOfGuests.toString()
        : '0';
    _cityController.text =
        weddingDetails?.city != null ? weddingDetails!.city.toString() : '';
    _dateController.text =
        weddingDetails?.date != null ? weddingDetails!.date.toString() : '';
    // DateFormat('dd/MM/yyyy').format(weddingDetails!.date);
    pickedDate = weddingDetails?.date;
    weddingType = weddingDetails?.type;
  }

  @override
  void dispose() {
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
                      pickedDate = await showDialog(
                        context: context,
                        builder: (context) => const CustomDatePickerDialog(
                          title: "Add your wedding date",
                        ),
                      );
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
                WedfluencerDropdown.wedfluencerDropdown(
                    isExpanded: true,
                    data: const [
                      'Wedding Weekends',
                      'Traditional Weddings',
                      'Destination Weddings',
                      'Small Weddings',
                      'Elopements',
                      'Courthouse Weddings',
                      'Themed Weddings',
                      'Others',
                    ],
                    hint: 'Select wedding type',
                    dropdownValue: weddingType,
                    onChanged: (value) {
                      setState(() {
                        weddingType = value;
                      });
                    }),
                WedfluencerDividers.transparentDivider(),
                WedfluencerTextFields.iconTextField(
                    hint: 'No. of guests',
                    controller: _guestController,
                    keyboardType: TextInputType.number,
                    iconData: Icons.numbers),
                WedfluencerDividers.transparentDividerForHeadings(),
                WedfluencerButtons.fullWidthButton(
                  buttonColor: ScreenConfig.theme.colorScheme.primary,
                  hasIcon: false,
                  text: 'Save Changes',
                  textColor: Colors.white,
                  widthMultiplier: 1,
                  func: () {
                    UserProvider().updateWeddingDetails(
                        city: _cityController.text,
                        date: pickedDate!.toIso8601String(),
                        type: weddingType!,
                        guestsCount: _guestController.text);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
