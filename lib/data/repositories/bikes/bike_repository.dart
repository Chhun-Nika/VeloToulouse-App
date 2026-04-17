import '../../../model/bike.dart';

abstract class BikeRepository {
  Future<List<Bike>> getAllBikes();
  Future<void> markBikeAsBooked(String bikeId);
}
