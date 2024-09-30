import 'package:flutter/material.dart';

class RCircularIndicator extends StatelessWidget {
  const RCircularIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
