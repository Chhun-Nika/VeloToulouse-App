import '../../../model/location.dart';
import '../../../model/station.dart';
import 'station_repository.dart';

class StationRepositoryMock implements StationRepository {
  final List<Station> mockStations = [
    Station(
      id: 'station_001',
      name: 'Central Market',
      location: Location(
        latitude: 11.5696,
        longitude: 104.9210,
        area: 'Phsar Thmey',
        district: 'Daun Penh',
      ),
    ),
    Station(
      id: 'station_002',
      name: 'Riverside',
      location: Location(
        latitude: 11.5730,
        longitude: 104.9282,
        area: 'Wat Phnom',
        district: 'Daun Penh',
      ),
    ),
    Station(
      id: 'station_003',
      name: 'Royal Palace',
      location: Location(
        latitude: 11.5636,
        longitude: 104.9318,
        area: 'Tonle Bassac',
        district: 'Chamkar Mon',
      ),
    ),
    Station(
      id: 'station_004',
      name: 'Wat Phnom',
      location: Location(
        latitude: 11.5763,
        longitude: 104.9287,
        area: 'Wat Phnom',
        district: 'Daun Penh',
      ),
    ),
    Station(
      id: 'station_005',
      name: 'Independence Monument',
      location: Location(
        latitude: 11.5564,
        longitude: 104.9282,
        area: 'Boeung Keng Kang',
        district: 'Chamkar Mon',
      ),
    ),
  ];

  @override
  Future<List<Station>> getAllStations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockStations;
  }
}
