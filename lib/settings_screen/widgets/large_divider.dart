import 'package:flutter/material.dart';

class LargeDivider extends StatelessWidget {
  const LargeDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 60),
      child: Divider(),
    );
  }
}
