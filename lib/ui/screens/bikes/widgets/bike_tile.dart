import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/model/bike.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';

class BikeTile extends StatelessWidget {
  final Bike bike;
  final int index;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isAvailable;

  const BikeTile({
    super.key,
    required this.bike,
    required this.onTap,
    required this.isSelected,
    required this.index,
    required this.isAvailable,
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
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderColor, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Slot',
                      style: AppText.label.copyWith(
                        color: AppColor.neutralLight,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${index + 1}',
                      style: AppText.body.copyWith(
                        color: AppColor.neutralDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderColor, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isAvailable ? 'Bike Number' : 'Bike is already booked',
                      style: AppText.label.copyWith(
                        color: AppColor.neutralLight,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isAvailable ? bike.bikeCode : 'Empty slot',
                      style: AppText.body.copyWith(
                        color: isAvailable
                            ? AppColor.neutralDark
                            : AppColor.neutralLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
