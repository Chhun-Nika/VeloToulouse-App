import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/data/repositories/bikes/bike_repository.dart';
import 'package:velo_toulouse_app/ui/screens/bikes/viewmodel/view_bike_view_model.dart';
import 'package:velo_toulouse_app/ui/screens/bikes/widgets/view_bike_content.dart';

class ViewBikeScreen extends StatelessWidget {
  final String stationId;
  const ViewBikeScreen({super.key, required this.stationId});

  @override
  Widget build(BuildContext context) {
    return Text('View bike screen');
  }
}
