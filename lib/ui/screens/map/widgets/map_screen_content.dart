import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';

import '../../../utils/async_value.dart';
import '../viewmodel/map_view_model.dart';

class MapScreenContent extends StatelessWidget {
  const MapScreenContent({super.key});

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(11.5564, 104.9282), // Phnom Penh
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    StationViewModel vm = context.watch<StationViewModel>();
    final asyncValue = vm.stationsValue;

    Widget content;

    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = const Center(child: CircularProgressIndicator());
        break;

      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error}',
            style: const TextStyle(color: Colors.red),
          ),
        );
        break;

      case AsyncValueState.success:
        content = GoogleMap(
          initialCameraPosition: _initialPosition,
          markers: vm.markers,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
        );
        break;
    }

    return Stack(
      children: [
        content,
        Container(
          padding: EdgeInsets.all(AppSpacing.m),
          height: 230,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white.withValues(alpha: 0.7),
                Colors.white.withValues(alpha: 0.3),
                Colors.white.withValues(alpha: 0.1),
              ],
              stops: [0.80, 0.90, 0.97, 1.0],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppGradient.primary.createShader(bounds),
                  child: Text(
                    "Let’s have a ride!",
                    style: AppText.heading.copyWith(color: AppColor.white),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(36),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => const SearchPage()),
                    // );
                    print("search tap");
                  },
                  child: Container(
                    
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(36),
                      border: Border.all(color: Color(0xFFD9D9D9)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search_rounded, color: Color(0xFF8C939D)),
                        SizedBox(width: 12),
                        Text(
                          "Search",
                          style: TextStyle(color: Color(0xFF8C939D)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
