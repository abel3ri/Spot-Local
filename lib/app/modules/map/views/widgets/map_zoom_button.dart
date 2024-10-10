import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapZoomButton extends StatelessWidget {
  const MapZoomButton({
    super.key,
    required this.mapController,
    required this.icon,
  });

  final MapController mapController;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Icon(
        icon,
        size: 32,
      ),
    );
  }
}
