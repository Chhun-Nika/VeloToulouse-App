import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Station {
  final String id;
  final String name;
  final double latitude;
  final double longtitude;

  Station({
    String? id,
    required this.name,
    required this.latitude,
    required this.longtitude,
  }) : id = id ?? uuid.v4();
}
