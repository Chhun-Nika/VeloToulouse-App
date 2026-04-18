import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/data/repositories/slots/slot_repository.dart';
import 'package:velo_toulouse_app/model/slot.dart';
import 'package:velo_toulouse_app/data/repositories/stations/station_repository.dart';
import 'package:velo_toulouse_app/model/station.dart';
import 'package:velo_toulouse_app/ui/utils/async_value.dart';

class StationViewModel extends ChangeNotifier {
  final StationRepository stationRepository;
  final SlotRepository slotRepository;

  AsyncValue<List<Station>> stationsValue = AsyncValue.loading();
  final Map<String, AsyncValue<int>> _availableBikeCounts = {};

  Station? _selectedStation;
  Station? get selectedStation => _selectedStation;

  StationViewModel({
    required this.stationRepository,
    required this.slotRepository,
  }) {
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

  AsyncValue<int> getAvailableBikeCount(String stationId) {
    return _availableBikeCounts[stationId] ?? AsyncValue.loading();
  }

  String getAvailableBikeLabel(String stationId) {
    final availabilityValue = getAvailableBikeCount(stationId);

    switch (availabilityValue.state) {
      case AsyncValueState.loading:
        return 'Loading available bikes...';
      case AsyncValueState.error:
        return 'Bike availability unavailable';
      case AsyncValueState.success:
        final availableBikeCount = availabilityValue.data!;
        final bikeLabel = availableBikeCount > 1 ? 'Bikes' : 'Bike';
        return '$availableBikeCount Available $bikeLabel';
    }
  }

  bool shouldDisableBooking(String stationId) {
    final availabilityValue = getAvailableBikeCount(stationId);

    return availabilityValue.state == AsyncValueState.success &&
        availabilityValue.data == 0;
  }

  Future<void> loadAvailableBikeCount(String stationId) async {
    _availableBikeCounts[stationId] = AsyncValue.loading();
    notifyListeners();

    try {
      final slots = await slotRepository.getSlotsByStation(stationId);
      final availableBikeCount = slots
          .where(
            (slot) =>
                slot.slotStatus == SlotStatus.occupied && slot.bikeId != null,
          )
          .length;

      _availableBikeCounts[stationId] = AsyncValue.success(availableBikeCount);
      notifyListeners();
    } catch (e) {
      _availableBikeCounts[stationId] = AsyncValue.error(e);
      notifyListeners();
    }
  }
}
