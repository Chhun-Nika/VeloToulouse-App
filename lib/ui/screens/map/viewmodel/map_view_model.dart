import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/data/repositories/stations/station_repository.dart';
import 'package:velo_toulouse_app/model/station.dart';
import 'package:velo_toulouse_app/ui/utils/async_value.dart';

class StationViewModel extends ChangeNotifier {
  final StationRepository stationRepository;

  AsyncValue<List<Station>> stationsValue = AsyncValue.loading();

  Station? _selectedStation;
  Station? get selectedStation => _selectedStation;

  StationViewModel({required this.stationRepository}) {
    _init();
  }

  void _init() {
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

  void selectStation(Station station) {
    _selectedStation = station;
    notifyListeners();
  }

  void clearSelectedStation() {
    _selectedStation = null;
    notifyListeners();
  }
}
