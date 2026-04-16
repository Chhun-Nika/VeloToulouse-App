import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velo_toulouse_app/data/repositories/stations/station_repository.dart';
import 'package:velo_toulouse_app/model/station.dart';
import 'package:velo_toulouse_app/ui/utils/async_value.dart';

import '../../../theme/theme.dart';

class StationViewModel extends ChangeNotifier {
  final StationRepository stationRepository;

  AsyncValue<List<Station>> stationsValue = AsyncValue.loading();

  StationViewModel({required this.stationRepository}) {
    _init();
  }

  void _init() async {
    fetchStations();
  }

  void fetchStations() async {
    stationsValue = AsyncValue.loading();
    notifyListeners();

    try {
      List<Station> stations = await stationRepository.getAllStations();
      stationsValue = AsyncValue.success(stations);
      notifyListeners();
    } catch (e) {
      stationsValue = AsyncValue.error(e);
      notifyListeners();
    }
  }

  Set<Marker> get markers {
    if (stationsValue.state != AsyncValueState.success) {
      return {};
    }

    final stations = stationsValue.data!;

    return stations.map((station) {
      return Marker(
        markerId: MarkerId(station.id),
        position: LatLng(station.location.latitude, station.location.longitude),
        // icon: BitmapDescriptor.defaultMarkerWithHue(270)
        // infoWindow: InfoWindow()
      );
    }).toSet();
  }
}
