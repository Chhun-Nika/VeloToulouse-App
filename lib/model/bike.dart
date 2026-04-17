// bike class
import 'package:uuid/uuid.dart';

var _uuid = Uuid();

enum BikeStatus { booked, available, maintenance }

class Bike {
  final String id;
  final String bikeCode;
  final BikeStatus bikeStatus;

  Bike({
    String? id,
    required this.bikeCode,
    required this.bikeStatus,
  }) : id = id ?? _uuid.v4();
}
