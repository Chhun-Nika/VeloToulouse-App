import '../../../model/bike.dart';

abstract class BikeRepository {
  Future<List<Bike>> getBikesByStation(String stationId);
  Future<void> markBikeAsBooked(String bikeId);
}
