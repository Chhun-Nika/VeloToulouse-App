import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:velo_toulouse_app/data/config/firebase_config.dart';
import 'package:velo_toulouse_app/data/dto/booking_dto.dart';
import 'package:velo_toulouse_app/data/repositories/bookings/bookings_repository.dart';
import 'package:velo_toulouse_app/model/booking.dart';

class BookingRepositoryFirebase implements BookingsRepository {
  static const String _bookingsPath = '/bookings';

  @override
  Future<void> createBooking(Booking booking) async {
    final Uri bookingsUri = FirebaseConfig.baseUri.replace(
      path: '$_bookingsPath/${booking.id}.json',
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

  @override
  Future<List<Booking>> getAllBookings() async {
    final Uri bookingsUri = FirebaseConfig.baseUri.replace(
      path: '$_bookingsPath.json',
    );
    final http.Response response = await http.get(bookingsUri);

    if (response.statusCode == 200) {
      if (response.body == 'null') {
        return [];
      }

      final decodedBody = json.decode(response.body);
      if (decodedBody is! Map<String, dynamic>) {
        throw FormatException('Expected bookings data to be a map.');
      }

      final List<Booking> result = [];

      for (var bookingEntry in decodedBody.entries) {
        final bookingJson = bookingEntry.value;
        if (bookingJson is! Map) {
          continue;
        }

        result.add(
          BookingDto.fromJson(
            bookingEntry.key,
            Map<String, dynamic>.from(bookingJson),
          ),
        );
      }

      return result;
    } else {
      throw Exception('Failed to load bookings');
    }
  }
}
