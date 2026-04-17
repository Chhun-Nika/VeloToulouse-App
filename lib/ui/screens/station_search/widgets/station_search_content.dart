import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/model/station.dart';
import 'package:velo_toulouse_app/ui/screens/station_search/view_model/station_search_view_model.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';
import 'package:velo_toulouse_app/ui/utils/async_value.dart';

import 'search_bar.dart';
import 'station_tile.dart';

class StationSearchContent extends StatelessWidget {
  const StationSearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StationSearchViewModel>();

    Widget content;

    switch (vm.stationsValue.state) {
      case AsyncValueState.loading:
        content = const Center(child: CircularProgressIndicator());
        break;

      case AsyncValueState.error:
        content = Center(
          child: Text(
            "Error: ${vm.stationsValue.error}",
            style: const TextStyle(color: Colors.red),
          ),
        );
        break;

      case AsyncValueState.success:
        if (vm.searchText.trim().isEmpty) {
          content = Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search,
                  size: 64,
                  color: Colors.grey.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  "Search for station",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          );
        } else if (vm.filteredStations.isEmpty) {
          content = const Center(child: Text("No stations found"));
        } else {
          content = ListView.builder(
            itemCount: vm.filteredStations.length,
            itemBuilder: (context, index) => StationTile(
              station: vm.filteredStations[index],
              onTap: (station) {
                Navigator.pop<Station>(context, station);
              },
            ),
          );
        }
        break;
    }

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
          child: Column(
            children: [
              StationSearchBar(
                initSearchText: vm.searchText,
                onBackTap: () {
                  if (vm.searchText.trim().isEmpty) {
                    Navigator.pop(context, null); // means "clear"
                  } else {
                    Navigator.pop(context); // normal back
                  }
                },
                onSearchChanged: vm.updateSearchText,
              ),
              const SizedBox(height: 20),
              Expanded(child: content),
            ],
          ),
        ),
      ),
    );
  }
}
