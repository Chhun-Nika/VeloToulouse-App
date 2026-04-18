import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/data/repositories/bikes/bike_repository.dart';
import 'package:velo_toulouse_app/data/repositories/bookings/bookings_repository.dart';
import 'package:velo_toulouse_app/data/repositories/stations/station_repository.dart';
import 'package:velo_toulouse_app/ui/screens/bookings_history/viewmodel/booking_history_view_model.dart';
import 'widgets/booking_history_screen_content.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingHistoryViewModel(
        bookingsRepository: context.read<BookingsRepository>(),
        stationRepository: context.read<StationRepository>(),
        bikeRepository: context.read<BikeRepository>(),
      ),
      child: const BookingHistoryScreenContent(),
    );
  }
}
