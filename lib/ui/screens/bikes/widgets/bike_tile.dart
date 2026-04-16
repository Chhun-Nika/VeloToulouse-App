import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/model/bike.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';

class BikeTile extends StatelessWidget {
  final Bike bike;
  final VoidCallback onTap;
  final bool isSelected;

  const BikeTile({
    super.key,
    required this.bike,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isSelected
        ? AppColor.primary
        : AppColor.neutralLight;
    final Color backgroundColor = isSelected
        ? const Color(0xFFFFF3F2)
        : AppColor.white;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bike Number',
                style: AppText.label.copyWith(color: AppColor.neutralLight),
              ),
              SizedBox(height: 8),
              Text(
                bike.bikeCode,
                style: AppText.body.copyWith(color: AppColor.neutralDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
