import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/model/station.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';

import '../../../utils/async_value.dart';
import '../../station_search/station_search_screen.dart';
import '../viewmodel/map_view_model.dart';
import 'station_info_bottom_sheet.dart';

class MapScreenContent extends StatefulWidget {
  const MapScreenContent({super.key});

  @override
  State<MapScreenContent> createState() => _MapScreenContentState();
}

class _MapScreenContentState extends State<MapScreenContent> {
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(11.5564, 104.9282),
    zoom: 14,
  );

  GoogleMapController? _mapController;

  Future<void> _moveToStation(Station station) async {
    await _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(station.location.latitude, station.location.longitude),
        16,
      ),
    );
  }

  Future<void> _showStationBottomSheet(Station station) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => StationInfoBottomSheet(station: station),
    );
  }

  Future<void> onSearchBarTap(BuildContext context) async {
    final vm = context.read<StationViewModel>();

    final Station? selectedStation = await Navigator.push<Station?>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            StationSearchScreen(initSearchText: vm.selectedStation?.name ?? ""),
      ),
    );

    if (selectedStation == null) {
      vm.clearSelectedStation();
      return;
    }

    vm.selectStation(selectedStation);
    await _moveToStation(selectedStation);
  }

  Set<Marker> _buildMarkers(List<Station> stations) {
    return stations.map((station) {
      return Marker(
        markerId: MarkerId(station.id),
        position: LatLng(station.location.latitude, station.location.longitude),
        onTap: () {
          _showStationBottomSheet(station);
        },
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StationViewModel>();
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
        final stations = asyncValue.data!;
        content = GoogleMap(
          initialCameraPosition: _initialPosition,
          markers: _buildMarkers(stations),
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            _mapController = controller;
          },
        );
        break;
    }

    return Stack(
      children: [
        content,
        Container(
          padding: const EdgeInsets.all(AppSpacing.m),
          height: 210,
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
              stops: const [0.80, 0.90, 0.97, 1.0],
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
                const SizedBox(height: AppSpacing.s),
                InkWell(
                  borderRadius: BorderRadius.circular(36),
                  onTap: () => onSearchBarTap(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.m,
                      vertical: AppSpacing.s,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusLarge,
                      ),
                      border: Border.all(color: const Color(0xFFD9D9D9)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded, color: AppColor.neutral),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            vm.selectedStation?.name ?? "Search station",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.body.copyWith(
                              color: vm.selectedStation == null
                                  ? AppColor.textLight
                                  : AppColor.neutralDark,
                            ),
                          ),
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
