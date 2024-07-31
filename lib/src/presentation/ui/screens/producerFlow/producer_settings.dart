import 'package:flutter/material.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dropdown.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../templates/dividers.dart';
import '../../templates/khairyat_appbar.dart';
import '../../templates/multiDropdown.dart';
import '../../templates/textfields.dart';

class ProducerSettingScreen extends StatefulWidget {
  const ProducerSettingScreen({super.key});

  @override
  State<ProducerSettingScreen> createState() => _ProducerSettingScreenState();
}

class _ProducerSettingScreenState extends State<ProducerSettingScreen> {
  // late TextEditingController _dateController, _cityController, _guestController;
  // String? weddingType;
  // DateTime? pickedDate;

  final companyName = TextEditingController();
  final trademarkName = TextEditingController();
  final website = TextEditingController();
  final address = TextEditingController();
  final tollFree = TextEditingController();
  final keyword = TextEditingController();
  final mainCategory = TextEditingController();
  final comment = TextEditingController();
  // final isOfferingServicesController = TextEditingController();
  // final isOfferingProductsController = TextEditingController();
  // final isOfferingProducts = false;
  // final isOfferingServices = false;
  late ValueNotifier<String?> offeringProduct, offeringServices;
  final List<ValueItem> selectedCategory = [];

  @override
  void initState() {
    super.initState();
    offeringProduct = ValueNotifier(null);
    offeringServices = ValueNotifier(null);
    // offeringProduct.value == 'Yes' ? true : false, ese use hoga
    // final weddingDetails = DI.i<AuthRepository>().user!.weddingDetails;
    // _dateController = TextEditingController();
    // _guestController.text = weddingDetails?.noOfGuests != null
    //     ? weddingDetails!.noOfGuests.toString()
    //     : '0';
    // _cityController.text =
    //     weddingDetails?.city != null ? weddingDetails!.city.toString() : '';
    // _dateController.text =
    //     weddingDetails?.date != null ? weddingDetails!.date.toString() : '';
    // // DateFormat('dd/MM/yyyy').format(weddingDetails!.date);
    // pickedDate = weddingDetails?.date;
    // weddingType = weddingDetails?.type;
  }

  @override
  void dispose() {
    // _dateController.dispose();
    // _cityController.dispose();
    // _guestController.dispose();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WedfluencerDividers.transparentDivider(),
            WedfluencerTextFields.iconTextField(
              hint: 'Company Name',
              controller: companyName,
              iconData: Icons.location_city_outlined,
              isGooglePlaces: false,
            ),
            WedfluencerDividers.transparentDivider(),
            WedfluencerTextFields.iconTextField(
              hint: 'Trademark Name',
              controller: trademarkName,
              iconData: Icons.mark_as_unread_outlined,
              isGooglePlaces: false,
            ),
            WedfluencerDividers.transparentDivider(),
            WedfluencerTextFields.iconTextField(
              hint: 'Website',
              controller: website,
              iconData: Icons.webhook_sharp,
              isGooglePlaces: false,
            ),
            WedfluencerDividers.transparentDivider(),
            WedfluencerTextFields.iconTextField(
              hint: 'Enter Address',
              controller: address,
              iconData: Icons.location_on_outlined,
              isGooglePlaces: true,
            ),
            WedfluencerDividers.transparentDivider(),
            ValueListenableBuilder<String?>(
                valueListenable: offeringProduct,
                builder: (context, selectedValue, _) {
                  return WedfluencerDropdown.wedfluencerDropdown(
                    hint: 'Are you offering products',
                    onChanged: (value) {
                      offeringProduct.value = value;
                    },
                    dropdownValue: selectedValue,
                    isExpanded: true,
                    data: ['Yes', 'No'],
                  );
                }),
            WedfluencerDividers.transparentDivider(),
            ValueListenableBuilder<String?>(
                valueListenable: offeringServices,
                builder: (context, selectedValue, _) {
                  return WedfluencerDropdown.wedfluencerDropdown(
                    hint: 'Are you offering services',
                    onChanged: (value) {
                      offeringServices.value = value;
                    },
                    dropdownValue: selectedValue,
                    isExpanded: true,
                    data: ['Yes', 'No'],
                  );
                }),
            WedfluencerDividers.transparentDivider(),
            WedfluencerTextFields.iconTextField(
              hint: 'Toll Free',
              controller: tollFree,
              iconData: Icons.toll_outlined,
              isGooglePlaces: false,
            ),
            WedfluencerDividers.transparentDivider(),
            WedfluencerTextFields.iconTextField(
              hint: 'Keywords',
              controller: keyword,
              iconData: Icons.tag,
              isGooglePlaces: false,
            ),
            WedfluencerDividers.transparentDivider(),
            WedfluencerMultiDropdown.vendorServiceDropdown(
              hint: 'Select main category',
              onOptionSelected: (List<ValueItem> selectedOptions) {
                selectedCategory.addAll(selectedOptions);
              },
            ),
            WedfluencerDividers.transparentDivider(),
            WedfluencerTextFields.iconTextField(
              hint: 'Comment',
              controller: comment,
              iconData: Icons.comment_outlined,
              isGooglePlaces: false,
            ),
            WedfluencerDividers.transparentDividerForHeadings(),
            WedfluencerButtons.fullWidthButton(
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
              text: 'Save Changes',
              textColor: Colors.white,
              widthMultiplier: 1,
              func: () {
                // UserProvider().updateWeddingDetails(
                //     city: _cityController.text,
                //     date: pickedDate!.toIso8601String(),
                //     type: weddingType!,
                //     guestsCount: _guestController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
