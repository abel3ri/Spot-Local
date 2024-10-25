import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RStatusContainer extends StatelessWidget {
  const RStatusContainer({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ['approved', 'active'].contains(status)
            ? Colors.green
            : ['rejected', 'expired'].contains(status)
                ? Colors.red
                : const Color.fromARGB(255, 255, 166, 0),
      ),
      child: Text(
        '${status}'.toUpperCase(),
        style: context.textTheme.bodySmall!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
