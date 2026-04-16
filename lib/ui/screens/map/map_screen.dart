import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/stations/station_repository.dart';
import 'viewmodel/map_view_model.dart';
import 'widgets/map_screen_content.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StationViewModel(
        stationRepository: context.read<StationRepository>(),
      ),
      child: MapScreenContent(),
    );
  }
}
