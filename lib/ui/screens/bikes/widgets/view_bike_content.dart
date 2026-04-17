import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/ui/screens/bikes/viewmodel/view_bike_view_model.dart';
import 'package:velo_toulouse_app/ui/screens/bikes/widgets/bike_tile.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';
import 'package:velo_toulouse_app/ui/utils/async_value.dart';
import 'package:velo_toulouse_app/ui/widgets/bike_modal.dart';

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
        final items = asyncValue.data!;

        if (items.isEmpty) {
          content = const Center(child: Text('No slots found'));
        } else {
          content = ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final isAvailable = vm.isAvailable(item);

              return BikeTile(
                bike: item.bike,
                index: item.slot.index,
                onTap: () {
                  if (!isAvailable) return;

                  vm.selectItem(item);
                },
                isSelected: vm.isItemSelected(item),
                isAvailable: isAvailable,
              );
            },
          );
        }
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0x40DBDBDB)),
        ),
        title: Text(
          "Available Bikes",
          style: AppText.heading.copyWith(color: AppColor.neutralDark),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          vm.selectedItem == null ? 20 : 150,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              "Select a bike",
              style: AppText.body.copyWith(
                color: AppColor.neutralDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(child: content),
          ],
        ),
      ),
      bottomSheet: vm.selectedItem == null
          ? null
          : BikeModal(
              message: "Tap 'Book a Bike' to review your booking details.",
              buttonText: "Book a Bike",
              onPressed: () {
                // navigate to booking screen
              },
            ),
    );
  }
}
