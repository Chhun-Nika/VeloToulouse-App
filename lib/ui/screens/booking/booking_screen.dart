import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/data/repositories/bikes/bike_repository.dart';
import 'package:velo_toulouse_app/data/repositories/bookings/bookings_repository.dart';
import 'package:velo_toulouse_app/data/repositories/slots/slot_repository.dart';
import 'package:velo_toulouse_app/data/repositories/stations/station_repository.dart';
import 'package:velo_toulouse_app/ui/screens/booking/viewmodel/booking_view_model.dart';
import 'package:velo_toulouse_app/ui/screens/booking/widgets/booking_content.dart';

class BookingScreen extends StatelessWidget {
  final String stationId;
  final String slotId;
  final String bikeId;

  const BookingScreen({
    super.key,
    required this.stationId,
    required this.slotId,
    required this.bikeId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingViewModel(
        bookingsRepository: context.read<BookingsRepository>(),
        stationRepository: context.read<StationRepository>(),
        bikeRepository: context.read<BikeRepository>(),
        slotRepository: context.read<SlotRepository>(),
        stationId: stationId,
        slotId: slotId,
        bikeId: bikeId,
      ),
      child: const BookingContent(),
    );
  }
}
