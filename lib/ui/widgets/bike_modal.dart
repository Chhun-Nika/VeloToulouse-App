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
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
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
