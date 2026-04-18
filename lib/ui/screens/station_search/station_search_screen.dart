import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/data/repositories/stations/station_repository.dart';
import 'package:velo_toulouse_app/ui/screens/station_search/view_model/station_search_view_model.dart';
import 'package:velo_toulouse_app/ui/screens/station_search/widgets/station_search_content.dart';

class StationSearchScreen extends StatelessWidget {
  const StationSearchScreen({super.key, required this.initSearchText});

  final String initSearchText;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StationSearchViewModel(
        stationRepository: context.read<StationRepository>(),
        initSearchText: initSearchText,
      ),
      child: const StationSearchContent(),
    );
  }
}
