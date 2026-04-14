import 'package:uuid/uuid.dart';

var uuid = Uuid();

enum PaymentMethod { singleTrip, subscriptionPlan }

class Booking {
  final String id;
  final String bikeId;
  final PaymentMethod paymentMethod;
  final DateTime createdAt;

  Booking({String? id, required this.bikeId, required this.paymentMethod, DateTime? createdAt})
    : id = id ?? uuid.v4(), createdAt = createdAt ?? DateTime.now();
}
