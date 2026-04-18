import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/ui/screens/bookings_history/viewmodel/booking_history_view_model.dart';
import 'package:velo_toulouse_app/ui/screens/bookings_history/widgets/booking_history_group_section.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';
import 'package:velo_toulouse_app/ui/utils/async_value.dart';

class BookingHistoryScreenContent extends StatelessWidget {
  const BookingHistoryScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingHistoryViewModel vm = context.watch<BookingHistoryViewModel>();
    final historyValue = vm.historyValue;

    Widget content;

    switch (historyValue.state) {
      case AsyncValueState.loading:
        content = const Center(child: CircularProgressIndicator());
        break;

      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${historyValue.error}',
            style: const TextStyle(color: Colors.red),
          ),
        );
        break;

      case AsyncValueState.success:
        final groups = historyValue.data!;
        if (groups.isEmpty) {
          content = Center(
            child: Text(
              'No booking history yet',
              style: AppText.body.copyWith(color: AppColor.neutral),
            ),
          );
        } else {
          content = RefreshIndicator(
            onRefresh: vm.fetchBookingHistory,
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];

                return BookingHistoryGroupSection(group: group);
              },
            ),
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
          'Booking History',
          style: AppText.heading.copyWith(color: AppColor.neutralDark),
        ),
      ),
      body: content,
    );
  }
}
