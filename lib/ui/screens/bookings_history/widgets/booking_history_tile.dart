import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/ui/screens/bookings_history/viewmodel/booking_history_view_model.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';

import '../../../utils/date_format.dart';

class BookingHistoryTile extends StatelessWidget {
  final BookingHistoryItem item;

  const BookingHistoryTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final booking = item.booking;
    final stationName = item.station?.name ?? 'Unknown station';
    final bikeCode = item.bike?.bikeCode ?? booking.bikeId;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColor.success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking successful',
                      style: AppText.body.copyWith(
                        color: AppColor.neutralDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatBookingTime(booking.createdAt),
                      style: AppText.label.copyWith(color: AppColor.neutral),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFE4E4E4)),
          const SizedBox(height: 14),
          _HistoryLine(label: 'Station', value: stationName),
          const SizedBox(height: 10),
          _HistoryLine(label: 'Bike Number', value: bikeCode),
          const SizedBox(height: 10),
          _HistoryLine(
            label: 'Payment',
            value: formatPaymentMethod(booking.paymentMethod),
          ),
        ],
      ),
    );
  }
}

class _HistoryLine extends StatelessWidget {
  final String label;
  final String value;

  const _HistoryLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 94,
          child: Text(
            label,
            style: AppText.label.copyWith(color: AppColor.neutralLight),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppText.label.copyWith(
              color: AppColor.neutralDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
