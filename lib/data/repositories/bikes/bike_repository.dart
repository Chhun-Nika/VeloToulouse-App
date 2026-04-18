import '../../../model/bike.dart';

abstract class BikeRepository {
  Future<List<Bike>> getBikesByStation(String stationId);
  Future<Bike?> getBikeById(String stationId, String bikeId);
}
