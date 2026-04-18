import 'package:flutter/widgets.dart';
import 'package:velo_toulouse_app/data/repositories/bikes/bike_repository.dart';
import 'package:velo_toulouse_app/data/repositories/bookings/bookings_repository.dart';
import 'package:velo_toulouse_app/data/repositories/stations/station_repository.dart';
import 'package:velo_toulouse_app/model/bike.dart';
import 'package:velo_toulouse_app/model/booking.dart';
import 'package:velo_toulouse_app/model/station.dart';
import 'package:velo_toulouse_app/ui/utils/async_value.dart';

class BookingHistoryViewModel extends ChangeNotifier {
  final BookingsRepository bookingsRepository;
  final StationRepository stationRepository;
  final BikeRepository bikeRepository;

  AsyncValue<List<BookingHistoryGroup>> historyValue = AsyncValue.loading();

  BookingHistoryViewModel({
    required this.bookingsRepository,
    required this.stationRepository,
    required this.bikeRepository,
  }) {
    _init();
  }

  void _init() {
    fetchBookingHistory();
  }

  Future<void> fetchBookingHistory() async {
    historyValue = AsyncValue.loading();
    notifyListeners();

    try {
      final List<Booking> bookings = await bookingsRepository.getAllBookings();
      final List<Station> stations = await stationRepository.getAllStations();
      final Map<String, Station> stationsById = {
        for (var station in stations) station.id: station,
      };

      bookings.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      final Map<DateTime, List<BookingHistoryItem>> itemsByDate = {};

      for (var booking in bookings) {
        final Station? station = stationsById[booking.stationId];
        final Bike? bike = await bikeRepository.getBikeById(
          booking.stationId,
          booking.bikeId,
        );

        final DateTime dateKey = DateTime(
          booking.createdAt.year,
          booking.createdAt.month,
          booking.createdAt.day,
        );

        itemsByDate.putIfAbsent(dateKey, () => []);
        itemsByDate[dateKey]!.add(
          BookingHistoryItem(
            booking: booking,
            station: station,
            bike: bike,
          ),
        );
      }

      final List<BookingHistoryGroup> groups = itemsByDate.entries.map((entry) {
        return BookingHistoryGroup(date: entry.key, items: entry.value);
      }).toList();

      historyValue = AsyncValue.success(groups);
      notifyListeners();
    } catch (e) {
      historyValue = AsyncValue.error(e);
      notifyListeners();
    }
  }
}

class BookingHistoryGroup {
  final DateTime date;
  final List<BookingHistoryItem> items;

  BookingHistoryGroup({required this.date, required this.items});
}

class BookingHistoryItem {
  final Booking booking;
  final Station? station;
  final Bike? bike;

  BookingHistoryItem({
    required this.booking,
    required this.station,
    required this.bike,
  });
}
