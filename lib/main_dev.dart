import 'package:provider/provider.dart';
import 'data/repositories/stations/station_repository.dart';
import 'data/repositories/stations/station_repository_firebase.dart';
import 'main_common.dart';


List<InheritedProvider> get devProviders {
  return [Provider<StationRepository>(create: (_) => StationRepositoryFirebase())];
}

void main() {
  mainCommon(devProviders);
}
