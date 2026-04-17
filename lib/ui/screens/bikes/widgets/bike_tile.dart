import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/model/bike.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';

class BikeTile extends StatelessWidget {
  final Bike? bike;
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
    final bool isEmpty = bike == null;
    final bool isDisabled = isEmpty || !isAvailable;
    final Color borderColor = isSelected
        ? AppColor.primary
        : isEmpty
        ? const Color(0xFFE4E4E4)
        : const Color(0xFFFFA3A3);
    final Color backgroundColor = isSelected
        ? const Color(0xFFFFF3F2)
        : isEmpty
        ? const Color(0xFFFAFAFA)
        : AppColor.white;
    final Color titleColor = isDisabled
        ? AppColor.neutralLight
        : AppColor.neutral;
    final Color valueColor = isDisabled
        ? AppColor.neutralLight
        : AppColor.neutralDark;

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
          child: Row(
            children: [
              SizedBox(
                width: 42,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Slot',
                      style: AppText.label.copyWith(color: titleColor),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$index',
                      style: AppText.body.copyWith(
                        color: valueColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 18),
                color: const Color(0xFFE8E8E8),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEmpty
                          ? 'Empty'
                          : isAvailable
                          ? 'Bike Number'
                          : 'Bike is not available',
                      style: AppText.label.copyWith(color: titleColor),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      bike?.bikeCode ?? 'No bike docked',
                      style: AppText.body.copyWith(
                        color: valueColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
