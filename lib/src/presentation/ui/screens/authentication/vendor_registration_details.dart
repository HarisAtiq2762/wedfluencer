import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:wedfluencer/src/presentation/bloc/createVendor/create_vendor_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/createVendor/create_vendor_event.dart';
import 'package:wedfluencer/src/presentation/bloc/createVendor/create_vendor_state.dart';
import 'package:wedfluencer/src/presentation/ui/templates/multiDropdown.dart';
import '../../../../domain/create_vendor/vendor_dto.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';
import '../../templates/dropdown.dart';
import '../../templates/headings.dart';
import '../../templates/textfields.dart';

class VendorRegistrationDetails extends StatefulWidget {
  const VendorRegistrationDetails({super.key});

  @override
  State<VendorRegistrationDetails> createState() =>
      _VendorRegistrationDetailsState();
}

class _VendorRegistrationDetailsState extends State<VendorRegistrationDetails> {
  late TextEditingController companyName,
      tradeMark,
      firstName,
      lastName,
      userName,
      websiteUrl,
      phoneNumber,
      secondaryEmail,
      tollFree,
      comments;
  late ValueNotifier<String?> offeringProduct, offeringServices;
  final List<ValueItem> selectedCategory = [], selectedSubCategory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyName = TextEditingController();
    tradeMark = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();
    userName = TextEditingController();
    websiteUrl = TextEditingController();
    phoneNumber = TextEditingController();
    secondaryEmail = TextEditingController();
    tollFree = TextEditingController();
    comments = TextEditingController();
    offeringProduct = ValueNotifier(null);
    offeringServices = ValueNotifier(null);
  }

  @override
  void dispose() {
    companyName.dispose();
    tradeMark.dispose();
    firstName.dispose();
    lastName.dispose();
    userName.dispose();
    websiteUrl.dispose();
    phoneNumber.dispose();
    secondaryEmail.dispose();
    tollFree.dispose();
    comments.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateVendorBloc>(
      create: (context) => CreateVendorBloc(CreateVendorState.initial()),
      child: WedfluencerDecorations.mainContainer(
        context: context,
        heading: 'Enter Your Details',
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: WedfluencerTextFields.iconTextField(
              controller: companyName,
              showIcon: false,
              hint: 'Company Name',
            ),
          ),
          WedfluencerDividers.transparentDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: WedfluencerTextFields.iconTextField(
              controller: tradeMark,
              showIcon: false,
              hint: 'Trademark Name',
            ),
          ),
          WedfluencerDividers.transparentDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: WedfluencerTextFields.iconTextField(
              controller: firstName,
              showIcon: false,
              hint: 'First Name',
            ),
          ),
          WedfluencerDividers.transparentDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: WedfluencerTextFields.iconTextField(
              controller: lastName,
              showIcon: false,
              hint: 'Last Name',
            ),
          ),
          WedfluencerDividers.transparentDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: WedfluencerTextFields.iconTextField(
              controller: userName,
              iconData: Icons.alternate_email,
              showIcon: true,
              hint: 'User Name',
            ),
          ),
          WedfluencerDividers.transparentDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: WedfluencerTextFields.iconTextField(
              controller: websiteUrl,
              showIcon: true,
              iconData: Icons.web,
              hint: 'Website url',
            ),
          ),
          WedfluencerDividers.transparentDivider(),
          WedfluencerTextFields.phoneNumberField(
            controller: phoneNumber,
            onInputChanged: (PhoneNumber number) {
              print(number.dialCode);
              print(number.isoCode);
              print(number.phoneNumber);
            },
          ),
          WedfluencerDividers.transparentDividerForHeadings(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WedfluencerHeadings.generalHeading(
                    heading: 'Select Main Category'),
                WedfluencerDividers.transparentDivider(),
                WedfluencerMultiDropdown.vendorServiceDropdown(
                  onOptionSelected: (List<ValueItem> selectedOptions) {
                    selectedCategory.addAll(selectedOptions);
                  },
                ),
                WedfluencerDividers.transparentDividerForHeadings(),
                WedfluencerHeadings.generalHeading(
                    heading: 'Select Secondary Category'),
                WedfluencerDividers.transparentDivider(),
                WedfluencerMultiDropdown.vendorCategoryDropdown(
                  onOptionSelected: (List<ValueItem> selectedOptions) {
                    selectedSubCategory.addAll(selectedOptions);
                  },
                ),
              ],
            ),
          ),
          WedfluencerDividers.transparentDividerForHeadings(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: WedfluencerTextFields.iconTextField(
                controller: secondaryEmail,
                showIcon: false,
                hint: 'Enter Address',
                isGooglePlaces: true),
          ),
          WedfluencerDividers.transparentDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: WedfluencerTextFields.iconTextField(
              controller: tollFree,
              showIcon: false,
              hint: 'Toll Free',
            ),
          ),
          WedfluencerDividers.transparentDividerForHeadings(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WedfluencerHeadings.generalHeading(
                    heading: 'Are you offering products ?'),
                WedfluencerDividers.transparentDivider(),
                ValueListenableBuilder<String?>(
                    valueListenable: offeringProduct,
                    builder: (context, selectedValue, _) {
                      return WedfluencerDropdown.wedfluencerDropdown(
                        hint: 'Select option',
                        onChanged: (value) {
                          offeringProduct.value = value;
                        },
                        dropdownValue: selectedValue,
                        isExpanded: true,
                        data: ['Yes', 'No'],
                      );
                    }),
              ],
            ),
          ),
          WedfluencerDividers.transparentDividerForHeadings(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WedfluencerHeadings.generalHeading(
                    heading: 'Are you offering services ?'),
                WedfluencerDividers.transparentDivider(),
                ValueListenableBuilder<String?>(
                    valueListenable: offeringServices,
                    builder: (context, selectedValue, _) {
                      return WedfluencerDropdown.wedfluencerDropdown(
                        hint: 'Select option',
                        onChanged: (value) {
                          offeringServices.value = value;
                        },
                        dropdownValue: selectedValue,
                        isExpanded: true,
                        data: ['Yes', 'No'],
                      );
                    }),
              ],
            ),
          ),
          WedfluencerDividers.transparentDividerForHeadings(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WedfluencerHeadings.generalHeading(heading: 'Comments'),
                WedfluencerDividers.transparentDivider(),
                WedfluencerTextFields.multilineTextField(
                  controller: comments,
                  hint: 'Enter About Yourself',
                ),
              ],
            ),
          ),
          WedfluencerDividers.transparentDividerForHeadings(),
          BlocBuilder<CreateVendorBloc, CreateVendorState>(
            buildWhen: (prev, curr) =>
                prev != curr &&
                curr.vendorRegistrationLoading !=
                    prev.vendorRegistrationLoading,
            builder: (context, state) {
              return state.vendorRegistrationLoading
                  ? const CircularProgressIndicator()
                  : WedfluencerButtons.fullWidthButton(
                      text: 'Sign up',
                      textColor: Colors.white,
                      func: () {
                        final vendorDto = VendorDTO(
                          company: companyName.text.trim(),
                          tradeMark: tradeMark.text.trim(),
                          firstName: firstName.text.trim(),
                          lastName: lastName.text.trim(),
                          userName: userName.text.trim(),
                          websiteUrl: websiteUrl.text.trim(),
                          phoneNumber: phoneNumber.text.trim(),
                          secondaryAddress: secondaryEmail.text.trim(),
                          tolFree: tollFree.text.trim(),
                          comments: comments.text.trim(),
                          keywords: [],
                          offeringProduct:
                              offeringProduct.value == 'Yes' ? true : false,
                          offeringService:
                              offeringServices.value == 'Yes' ? true : false,
                          category: List.generate(selectedCategory.length,
                              (index) => selectedCategory[index].value),
                          subCategory: List.generate(selectedSubCategory.length,
                              (index) => selectedSubCategory[index].value),
                        );

                        context.read<CreateVendorBloc>().add(
                            VendorCreationEvent(
                                dto: vendorDto, context: context));
                      },
                      buttonColor: ScreenConfig.theme.colorScheme.primary,
                      hasIcon: false,
                    );
            },
          ),
          WedfluencerDividers.transparentDividerForHeadings(),
        ],
      ),
    );
  }
}
