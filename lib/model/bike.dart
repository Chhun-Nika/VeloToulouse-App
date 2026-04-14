// bike class
import 'package:uuid/uuid.dart';

var uuid = Uuid();

enum BikeStatus { booked, available }

class Bike {
  final String id;
  final String stationId;
  final String bikeCode;
  final BikeStatus bikeStatus;

  Bike({
    String? id,
    required this.stationId,
    required this.bikeCode,
    required this.bikeStatus,
  }) : id = id ?? uuid.v4();
}
