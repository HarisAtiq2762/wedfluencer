import 'package:flutter/material.dart';

import '../../../../infrastructure/constants/spaces.dart';

class HeightSpacer extends StatelessWidget {
  const HeightSpacer({
    super.key,
    this.space,
  });
  final double? space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space ?? Spaces.defaultSpacingVertical,
    );
  }
}
