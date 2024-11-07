import 'package:flutter/material.dart';

class RHeaderText extends StatelessWidget {
  const RHeaderText({
    required this.headerText,
    this.color,
    super.key,
  });

  final String headerText;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 24,
          color: Theme.of(context).colorScheme.primary,
          margin: const EdgeInsets.only(right: 4),
        ),
        Expanded(
          child: Text(
            headerText,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
        ),
      ],
    );
  }
}
