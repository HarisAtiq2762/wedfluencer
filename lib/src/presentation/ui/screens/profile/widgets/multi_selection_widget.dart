import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wedfluencer/src/app.dart';
import 'package:wedfluencer/src/presentation/ui/screens/profile/widgets/profile_image_widget.dart';

import '../../../../../infrastructure/screen_size_config/screen_size_config.dart';

class SelectionModel extends Equatable {
  final String id;
  final String label, imageUrl;

  @override
  String toString() {
    return label;
  }

  const SelectionModel(
      {required this.id, required this.label, required this.imageUrl});

  @override
  List<Object?> get props => [id];
}

class MultiSelectionWidget<Selection> extends StatefulWidget {
  final List<Selection> selectedValues;
  final List<Selection> values;
  final void Function(Selection, bool) onChange;
  const MultiSelectionWidget(
      {super.key,
      required this.values,
      required this.selectedValues,
      required this.onChange});

  @override
  State<MultiSelectionWidget> createState() => _MultiSelectionWidgetState();
}

class _MultiSelectionWidgetState extends State<MultiSelectionWidget> {
  List<SelectionModel> selectedValues = <SelectionModel>[];

  @override
  void initState() {
    super.initState();
    selectedValues.addAll(widget.selectedValues as List<SelectionModel>);
    
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 6,
        runSpacing: 6,
        children: List.generate(widget.values.length, (index) {
          final value = widget.values[index];
          bool selected = selectedValues.contains(value);

          return InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                setState(() {
                  if (selected) {
                    selectedValues.remove(value);
                  } else {
                    selectedValues.add(value);
                  }
                });
              },
              child: CustomChip(
                value: value,
                isSelected: selected,
              ));
        }));
  }
}

class CustomChip extends StatelessWidget {
  final SelectionModel value;
  final bool isSelected;

  const CustomChip({super.key, required this.value, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      avatar: ProfileImageWidget(
        imageUrl: value.imageUrl,
        radius: 50,
      ),
      backgroundColor: isSelected ? themeColor.withOpacity(0.4) : Colors.white,
      label: Text(
        value.toString(),
        style: ScreenConfig.theme.textTheme.bodySmall
            ?.copyWith(color: isSelected ? Colors.red : Colors.black),
      ),
    );
  }
}
