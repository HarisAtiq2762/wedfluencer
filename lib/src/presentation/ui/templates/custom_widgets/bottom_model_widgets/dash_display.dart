import 'package:flutter/material.dart';

class DashDisplay extends StatelessWidget {
  const DashDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: 50,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
