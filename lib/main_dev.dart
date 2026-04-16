import 'package:provider/provider.dart';
import 'data/repositories/stations/station_repository_mock.dart';
import 'main_common.dart';


List<InheritedProvider> get devProviders {
  return [Provider(create: (_) => StationRepositoryMock())];
}

void main() {
  mainCommon(devProviders);
}
