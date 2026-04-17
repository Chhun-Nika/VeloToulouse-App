
import 'package:velo_toulouse_app/data/repositories/bikes/bike_repository.dart';
import 'package:velo_toulouse_app/model/bike.dart';

class BikeRepositoryFirebase implements BikeRepository {
  
  @override
  Future<Bike?> getBikeById(String stationId, String bikeId) {
    // TODO: implement getBikeById
    throw UnimplementedError();
  }
  
  @override
  Future<List<Bike>> getBikesByStation(String stationId) {
    // TODO: implement getBikesByStation
    throw UnimplementedError();
  }
}
