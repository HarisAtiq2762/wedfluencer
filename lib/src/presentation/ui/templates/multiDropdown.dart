import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../bloc/vendorCategory/vendor_category_bloc.dart';
import '../../bloc/vendorService/vendor_service_bloc.dart';

class WedfluencerMultiDropdown {
  static Widget vendorServiceDropdown(
          {required void Function(List<ValueItem<String>>)?
              onOptionSelected}) =>
      BlocBuilder<VendorServiceBloc, VendorServiceState>(
        builder: (context, state) {
          List<ValueItem<String>> services = [];
          if (state is GotVendorService) {
            for (var service in state.vendorServices) {
              services.add(ValueItem(label: service.title, value: service.id));
            }
            return MultiSelectDropDown<String>(
              onOptionSelected: onOptionSelected,
              options: services,
              selectionType: SelectionType.multi,
              chipConfig: const ChipConfig(wrapType: WrapType.scroll),
              dropdownHeight: ScreenConfig.screenSizeHeight * 0.24,
              optionTextStyle: ScreenConfig.theme.textTheme.bodySmall,
              selectedOptionIcon: const Icon(Icons.check_circle),
              inputDecoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(10.0),
              ),
            );
          }
          return Container(
            width: ScreenConfig.screenSizeWidth,
            color: ScreenConfig.theme.hintColor,
          );
        },
      );
  static Widget vendorCategoryDropdown() =>
      BlocBuilder<VendorCategoryBloc, VendorCategoryState>(
        builder: (context, state) {
          List<ValueItem<String>> services = [];
          if (state is GotVendorCategory) {
            for (var service in state.vendorCategory) {
              services.add(ValueItem(label: service.title, value: service.id));
            }
            return MultiSelectDropDown<String>(
              onOptionSelected: (List<ValueItem> selectedOptions) {},
              options: services,
              selectionType: SelectionType.multi,
              chipConfig: const ChipConfig(wrapType: WrapType.scroll),
              dropdownHeight: ScreenConfig.screenSizeHeight * 0.24,
              optionTextStyle: ScreenConfig.theme.textTheme.bodySmall,
              selectedOptionIcon: const Icon(Icons.check_circle),
              inputDecoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(10.0),
              ),
            );
          }
          return Container(
            width: ScreenConfig.screenSizeWidth,
            color: ScreenConfig.theme.hintColor,
          );
        },
      );
}
