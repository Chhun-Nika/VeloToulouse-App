import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/ui/screens/booking/booking_success_screen.dart';
import 'package:velo_toulouse_app/ui/screens/booking/viewmodel/booking_view_model.dart';
import 'package:velo_toulouse_app/ui/screens/booking/widgets/booking_info.dart';
import 'package:velo_toulouse_app/ui/screens/booking/widgets/payment_select.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';
import 'package:velo_toulouse_app/ui/utils/async_value.dart';
import 'package:velo_toulouse_app/ui/widgets/bike_modal.dart';

class BookingContent extends StatelessWidget {
  const BookingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingViewModel vm = context.watch<BookingViewModel>();
    final detailsValue = vm.bookingDetailsValue;

    if (vm.isBookingSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BookingSuccessScreen()),
        );
      });
    }

    Widget content;

    switch (detailsValue.state) {
      case AsyncValueState.loading:
        content = const Center(child: CircularProgressIndicator());
        break;

      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${detailsValue.error}',
            style: const TextStyle(color: Colors.red),
          ),
        );
        break;

      case AsyncValueState.success:
        content = ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 150),
          children: [
            Text(
              'Confirm Booking',
              style: AppText.heading.copyWith(color: AppColor.neutralDark),
            ),
            const SizedBox(height: 6),
            Text(
              'Review your Bike and Station before unlocking the bike',
              style: AppText.label.copyWith(color: AppColor.neutral),
            ),
            const SizedBox(height: 14),
            BookingInfo(details: detailsValue.data!),
            const SizedBox(height: 18),
            const PaymentSelect(),
          ],
        );
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
          'Booking Detail',
          style: AppText.heading.copyWith(color: AppColor.neutralDark),
        ),
      ),
      body: content,
      bottomSheet: detailsValue.state == AsyncValueState.success
          ? BikeModal(
              message: "Tap 'Unlock Bike' to start your ride now.",
              buttonText: vm.isSubmitting ? 'Unlocking...' : 'Unlock Bike',
              onPressed: vm.isSubmitting ? () {} : vm.createBooking,
            )
          : null,
    );
  }
}
