// bike class
import 'package:uuid/uuid.dart';

var _uuid = Uuid();


class Bike {
  final String id;
  final String stationId;
  final String bikeCode;

  Bike({
    String? id,
    required this.stationId,
    required this.bikeCode,
  }) : id = id ?? _uuid.v4();
}
