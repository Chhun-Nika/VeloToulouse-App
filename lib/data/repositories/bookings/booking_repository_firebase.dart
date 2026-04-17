import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:velo_toulouse_app/data/config/firebase_config.dart';
import 'package:velo_toulouse_app/data/dto/booking_dto.dart';
import 'package:velo_toulouse_app/data/repositories/bookings/bookings_repository.dart';
import 'package:velo_toulouse_app/model/booking.dart';

class BookingRepositoryFirebase implements BookingsRepository {
  @override
  Future<void> createBooking(Booking booking) async {
    final Uri bookingsUri = FirebaseConfig.baseUri.replace(
      path: '/bookings/${booking.id}.json',
    );

    final Map<String, dynamic> bookingJson = BookingDto().toJson(booking);

    // 1 - Send put request to Firebase
    final http.Response response = await http.put(
      bookingsUri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bookingJson),
    );

    // 2 - Handle error if request fails
    if (response.statusCode != 200) {
      throw Exception('Failed to create booking');
    }
  }
}
