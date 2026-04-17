import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';

class BookingContent extends StatelessWidget {
  const BookingContent({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const SizedBox.shrink(),
    );
  }
}
