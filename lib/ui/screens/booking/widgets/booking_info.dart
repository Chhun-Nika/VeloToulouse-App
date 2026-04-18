import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/ui/screens/booking/viewmodel/booking_view_model.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';

class BookingInfo extends StatelessWidget {
  final BookingDetails details;

  const BookingInfo({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(label: 'Station', value: details.station.name),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFE4E4E4)),
          const SizedBox(height: 14),
          _InfoRow(label: 'Slot', value: details.slot.index.toString()),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFE4E4E4)),
          const SizedBox(height: 14),
          _InfoRow(label: 'Bike Number', value: details.bike.bikeCode),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.label.copyWith(color: AppColor.neutral)),
        const SizedBox(height: 6),
        Text(
          value,
          style: AppText.body.copyWith(color: AppColor.neutralDark),
        ),
      ],
    );
  }
}
