import 'package:uuid/uuid.dart';
import 'package:velo_toulouse_app/model/location.dart';

var uuid = Uuid();

class Station {
  final String id;
  final String name;
  final Location location;

  Station({String? id, required this.name, required this.location})
    : id = id ?? uuid.v4();
}
