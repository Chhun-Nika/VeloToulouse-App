import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';
import 'package:velo_toulouse_app/ui/widgets/primary_button.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColor.success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 30),
              ),
              const SizedBox(height: 24),
              Text(
                'Booking Successful',
                style: AppText.heading.copyWith(color: AppColor.neutralDark),
              ),
              const SizedBox(height: 16),
              Text(
                'Your bike is unlock, enjoy your ride!',
                style: AppText.label.copyWith(color: AppColor.neutralLight),
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Back to Home',
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
