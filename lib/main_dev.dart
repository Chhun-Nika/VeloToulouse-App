import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/data/repositories/bikes/bike_repository.dart';
import 'package:velo_toulouse_app/data/repositories/bikes/bike_repository_firebase.dart';
import 'data/repositories/stations/station_repository.dart';
import 'data/repositories/stations/station_repository_firebase.dart';
import 'main_common.dart';

List<InheritedProvider> get devProviders {
  return [
    // 1 - inject station repository
    Provider<StationRepository>(create: (_) => StationRepositoryFirebase()),

    // 2 - inject bike repository
    Provider<BikeRepository>(create: (_) => BikeRepositoryFirebase()),
  ];
}

void main() {
  mainCommon(devProviders);
}
