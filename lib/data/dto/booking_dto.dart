import '../../model/booking.dart';

class BookingDto {
  static const String bikeIdKey = 'bikeId';
  static const String paymentMethodKey = 'paymentMethod';
  static const String createdAtKey = 'createdAt';

  static Booking fromJson(String id, Map<String, dynamic> json) {
    assert(json[bikeIdKey] is String);
    assert(json[paymentMethodKey] is String);
    assert(json[createdAtKey] is String);

    return Booking(
      id: id,
      bikeId: json[bikeIdKey],
      paymentMethod: _getPaymentMethod(json[paymentMethodKey]),
      createdAt: json[createdAtKey],
    );
  }

  Map<String, dynamic> toJson(Booking booking) {
    return {
      bikeIdKey: booking.bikeId,
      paymentMethodKey: booking.paymentMethod.name,
      createdAtKey: booking.createdAt.toString()
    };
  }

  static PaymentMethod _getPaymentMethod(String paymentMethod) {
    switch (paymentMethod) {
      case 'singleTrip':
        return PaymentMethod.singleTrip;
      case 'subscriptionPlan':
        return PaymentMethod.subscriptionPlan;
      default:
        return PaymentMethod.singleTrip;
    }
  }
}
