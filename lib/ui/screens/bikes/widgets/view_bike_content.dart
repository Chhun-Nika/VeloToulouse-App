import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/ui/screens/bikes/viewmodel/view_bike_view_model.dart';
import 'package:velo_toulouse_app/ui/utils/async_value.dart';

class ViewBikeContent extends StatelessWidget {
  const ViewBikeContent({super.key});

  @override
  Widget build(BuildContext context) {
    ViewBikeViewModel vm = context.watch<ViewBikeViewModel>();
    final asyncValue = vm.bikesValue;

    Widget content;

    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = const Center(child: CircularProgressIndicator());
        break;

      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error}',
            style: const TextStyle(color: Colors.red),
          ),
        );
        break;

      case AsyncValueState.success:
        final bikes = asyncValue.data!;
        if (bikes.isEmpty) {
          content = const Center(child: Text('No bikes found'));
        } else {
          content = ListView.builder(
            itemCount: bikes.length,
            itemBuilder: (context, index) {
              final bike = bikes[index];

              return ListTile(title: Text(bike.bikeCode));
            },
          );
        }
        break;
    }

    return Scaffold(
      appBar: AppBar(title: Text("View All Bikes")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            Text("selected bike"),
            SizedBox(height: 15),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}
