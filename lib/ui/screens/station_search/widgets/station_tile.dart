import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';

import '../../../../model/station.dart';

class StationTile extends StatelessWidget {
  const StationTile({super.key, required this.station, required this.onTap});

  final Station station;
  final ValueChanged<Station> onTap;

  String get title => station.name;
  String get subTitle => station.location.shortAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => onTap(station),
          leading: const Icon(Icons.location_on_outlined),
          title: Text(title),
          subtitle: Text(subTitle),
        ),
        Divider(height: 0.5, color: Color(0xFFD9D9D9)),
      ],
    );
  }
}
