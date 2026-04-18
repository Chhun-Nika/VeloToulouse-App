import 'package:velo_toulouse_app/model/booking.dart';

abstract class BookingsRepository {
  Future<void> createBooking(Booking booking);
  Future<List<Booking>> getAllBookings();
}
