import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/data/repositories/stations/station_repository.dart';
import 'package:velo_toulouse_app/model/station.dart';
import 'package:velo_toulouse_app/ui/utils/async_value.dart';

class StationSearchViewModel extends ChangeNotifier {
  final StationRepository stationRepository;
  final String initSearchText;

  AsyncValue<List<Station>> stationsValue = AsyncValue.loading();
  String searchText = "";

  StationSearchViewModel({
    required this.stationRepository,
    required this.initSearchText,
  }) {
    _init();
  }

  void _init() {
    searchText = initSearchText;
    fetchStations();
  }

  Future<void> fetchStations() async {
    stationsValue = AsyncValue.loading();
    notifyListeners();

    try {
      final stations = await stationRepository.getAllStations();
      stationsValue = AsyncValue.success(stations);
    } catch (e) {
      stationsValue = AsyncValue.error(e);
    }

    notifyListeners();
  }

  void updateSearchText(String value) {
    searchText = value;
    notifyListeners();
  }

  List<Station> get filteredStations {
    if (stationsValue.state != AsyncValueState.success) {
      return [];
    }

    if (searchText.trim().isEmpty) {
      return [];
    }

    final stations = stationsValue.data!;

    return stations.where((station) {
      return station.name.toLowerCase().contains(
        searchText.trim().toLowerCase(),
      );
    }).toList();
  }
}
