import 'package:flutter/material.dart';

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
        children: List.generate(widget.values.length, (index) {
      final value = widget.values[index];
      bool selected = selectedValues.contains(value);

      return InkWell(
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
      label: Text(
        value.toString(),
        style: TextStyle(color: isSelected ? Colors.red : Colors.black),
      ),
    );
  }
}
