import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/ui/screens/bookings_history/viewmodel/booking_history_view_model.dart';
import 'package:velo_toulouse_app/ui/screens/bookings_history/widgets/booking_history_tile.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';
import '../../../utils/date_format.dart';

class BookingHistoryGroupSection extends StatelessWidget {
  final BookingHistoryGroup group;

  const BookingHistoryGroupSection({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formatBookingDate(group.date),
            style: AppText.body.copyWith(
              color: AppColor.neutralDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...group.items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: BookingHistoryTile(item: item),
            );
          }),
        ],
      ),
    );
  }
}
