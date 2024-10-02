import 'package:flutter/material.dart';

class RLinearIndicator extends StatelessWidget {
  const RLinearIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(minHeight: 2);
  }
}
