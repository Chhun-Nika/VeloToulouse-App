import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';
import 'package:velo_toulouse_app/ui/widgets/primary_button.dart';

class BikeModal extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  const BikeModal({
    super.key,
    required this.message,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5),

            Text(
              message,
              style: AppText.label.copyWith(color: AppColor.neutralLight),
            ),

            const SizedBox(height: 14),

            PrimaryButton(text: buttonText, onPressed: onPressed),
          ],
        ),
      ),
    );
  }
}
