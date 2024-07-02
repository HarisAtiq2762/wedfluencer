import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/dependency_injection.dart';
import '../../../infrastructure/domain/authentication/auth_repository.dart';
import '../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../bloc/userProposals/user_proposals_bloc.dart';

class WedfluencerGeneralDropdown extends StatefulWidget {
  final double? width;
  final List data;
  final String hint;
  Color? hintColor;
  String? type;
  String? dropdownValue;
  final bool? isExpanded;
  WedfluencerGeneralDropdown({
    super.key,
    this.width,
    this.type,
    required this.data,
    required this.hint,
    this.dropdownValue,
    this.isExpanded,
    this.hintColor,
  });

  @override
  State<WedfluencerGeneralDropdown> createState() =>
      _WedfluencerGeneralDropdownState();
}

class _WedfluencerGeneralDropdownState
    extends State<WedfluencerGeneralDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButton2<dynamic>(
        dropdownStyleData: const DropdownStyleData(
          elevation: 2,
          openInterval: Interval(0.1, 0.8),
        ),
        value: widget.dropdownValue,
        isExpanded: widget.isExpanded ?? false,
        alignment: AlignmentDirectional.centerStart,
        hint: Text(
          widget.hint,
          style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
            color: widget.hintColor ?? ScreenConfig.theme.hintColor,
          ),
        ),
        underline: Container(),
        onChanged: (val) {
          if (widget.type == 'proposalRange') {
            String day = '';

            if (val.toLowerCase() == 'last 30 days') {
              day = '30';
            } else if (val.toLowerCase() == 'last 90 days') {
              day = '90';
            } else if (val.toLowerCase() == 'last 180 days') {
              day = '180';
            } else if (val.toLowerCase() == 'last 365 days') {
              day = '365';
            } else if (val.toLowerCase() == 'all time') {
              day = 'all';
            }
            DI.i<UserProposalsBloc>().add(GetUserProposals(
                isMe: true,
                range: day,
                accessToken: DI.i<AuthRepository>().accessToken,
                skip: '0',
                proposalVideos: []));
          }
          setState(() {
            widget.dropdownValue = val;
          });
        },
        items: widget.data.map<DropdownMenuItem<dynamic>>((dynamic value) {
          return DropdownMenuItem<dynamic>(
            value: value,
            child: Text(
              value.toString(),
              style: ScreenConfig.theme.textTheme.bodySmall,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class WedfluencerDropdown {
  static Widget wedfluencerDropdown({
    double? width,
    void Function(dynamic)? onChanged,
    required List data,
    required String hint,
    String? dropdownValue,
    bool? isExpanded,
  }) =>
      Container(
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: DropdownButton2<dynamic>(
          dropdownStyleData: const DropdownStyleData(
            elevation: 2,
            openInterval: Interval(0.1, 0.8),
          ),
          value: dropdownValue,
          isExpanded: isExpanded ?? false,
          alignment: AlignmentDirectional.centerStart,
          hint: Text(
            hint,
            style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
              color: ScreenConfig.theme.hintColor,
            ),
          ),
          underline: Container(),
          onChanged: onChanged,
          items: data.map<DropdownMenuItem<dynamic>>((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value,
              child: Text(
                value.toString(),
                style: ScreenConfig.theme.textTheme.bodySmall,
              ),
            );
          }).toList(),
        ),
      );
}
