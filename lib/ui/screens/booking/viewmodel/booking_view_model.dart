import 'package:flutter/widgets.dart';
import 'package:velo_toulouse_app/data/repositories/bikes/bike_repository.dart';
import 'package:velo_toulouse_app/data/repositories/bookings/bookings_repository.dart';
import 'package:velo_toulouse_app/data/repositories/slots/slot_repository.dart';
import 'package:velo_toulouse_app/data/repositories/stations/station_repository.dart';
import 'package:velo_toulouse_app/model/bike.dart';
import 'package:velo_toulouse_app/model/booking.dart';
import 'package:velo_toulouse_app/model/slot.dart';
import 'package:velo_toulouse_app/model/station.dart';
import 'package:velo_toulouse_app/ui/utils/async_value.dart';

class BookingViewModel extends ChangeNotifier {
  final BookingsRepository bookingsRepository;
  final StationRepository stationRepository;
  final BikeRepository bikeRepository;
  final SlotRepository slotRepository;
  final String stationId;
  final String slotId;
  final String bikeId;

  AsyncValue<BookingDetails> bookingDetailsValue = AsyncValue.loading();
  PaymentMethod selectedPaymentMethod = PaymentMethod.singleTrip;
  bool isSubmitting = false;
  bool isBookingSuccess = false;
  Object? submitError;

  BookingViewModel({
    required this.bookingsRepository,
    required this.stationRepository,
    required this.bikeRepository,
    required this.slotRepository,
    required this.stationId,
    required this.slotId,
    required this.bikeId,
  }) {
    _init();
  }

  void _init() {
    fetchBookingDetails();
  }

  Future<void> fetchBookingDetails() async {
    bookingDetailsValue = AsyncValue.loading();
    notifyListeners();

    try {
      final List<Station> stations = await stationRepository.getAllStations();
      final Station station = stations.firstWhere(
        (station) => station.id == stationId,
      );

      final Slot? slot = await slotRepository.getSlotById(stationId, slotId);
      if (slot == null) {
        throw Exception('Slot not found');
      }

      final Bike? bike = await bikeRepository.getBikeById(stationId, bikeId);
      if (bike == null) {
        throw Exception('Bike not found');
      }

      bookingDetailsValue = AsyncValue.success(
        BookingDetails(station: station, slot: slot, bike: bike),
      );
      notifyListeners();
    } catch (e) {
      bookingDetailsValue = AsyncValue.error(e);
      notifyListeners();
    }
  }

  void selectPaymentMethod(PaymentMethod paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    notifyListeners();
  }

  Future<void> createBooking() async {
    isSubmitting = true;
    isBookingSuccess = false;
    submitError = null;
    notifyListeners();

    try {
      final booking = Booking(
        bikeId: bikeId,
        stationId: stationId,
        paymentMethod: selectedPaymentMethod,
      );

      await bookingsRepository.createBooking(booking);
      await slotRepository.markSlotAsAvailable(
        stationId: stationId,
        slotId: slotId,
      );

      isBookingSuccess = true;
      isSubmitting = false;
      notifyListeners();
    } catch (e) {
      submitError = e;
      isSubmitting = false;
      notifyListeners();
    }
  }
}

class BookingDetails {
  final Station station;
  final Slot slot;
  final Bike bike;

  BookingDetails({
    required this.station,
    required this.slot,
    required this.bike,
  });
}
