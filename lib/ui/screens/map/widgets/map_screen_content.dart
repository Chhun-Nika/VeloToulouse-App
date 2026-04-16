import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenContent extends StatelessWidget {
  const MapScreenContent({super.key});

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(11.5564, 104.9282), // Phnom Penh
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return const GoogleMap(
      initialCameraPosition: _initialPosition,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
    );
  }
}
