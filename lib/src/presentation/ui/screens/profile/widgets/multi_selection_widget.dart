import 'package:flutter/material.dart';
import 'package:wedfluencer/src/app.dart';
import 'package:wedfluencer/src/presentation/ui/screens/profile/widgets/profile_image_widget.dart';

import '../../../../../infrastructure/screen_size_config/screen_size_config.dart';

class MultiSelectionWidget<T> extends StatefulWidget {
  final List<T> selectedValues;
  final List<T> values;
  final void Function(T, bool) onChange;
  const MultiSelectionWidget(
      {super.key,
      required this.values,
      required this.selectedValues,
      required this.onChange});

  @override
  State<MultiSelectionWidget> createState() => _MultiSelectionWidgetState();
}

class _MultiSelectionWidgetState extends State<MultiSelectionWidget> {
  List<dynamic> selectedValues = [];

  @override
  void initState() {
    super.initState();
    selectedValues.addAll(widget.selectedValues);
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

class CustomChip<T> extends StatelessWidget {
  final T value;
  final bool isSelected;

  const CustomChip({super.key, required this.value, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Chip(
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    avatar: const ProfileImageWidget(imageUrl: 'https://t3.ftcdn.net/jpg/03/05/02/04/360_F_305020459_6TuRfq7z1FakkT3JDJAqxXnxgRJpqQim.jpg',radius: 50,),
          backgroundColor: isSelected?themeColor.withOpacity(0.4):Colors.white,
      label: Text(
        value.toString(),
        style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
          color: isSelected ? Colors.red : Colors.black
          ),
       ),
    );
  }
}
