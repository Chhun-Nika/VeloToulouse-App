import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/model/booking.dart';
import 'package:velo_toulouse_app/ui/screens/booking/viewmodel/booking_view_model.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';

class PaymentSelect extends StatelessWidget {
  const PaymentSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingViewModel vm = context.watch<BookingViewModel>();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose a payment option',
            style: AppText.body.copyWith(
              color: AppColor.neutralDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFEDEDED)),
          const SizedBox(height: 12),
          _PaymentOption(
            title: 'Pay-as-you-go',
            description:
                'Quick ride without subscription.',
            isSelected: vm.selectedPaymentMethod == PaymentMethod.singleTrip,
            onTap: () => vm.selectPaymentMethod(PaymentMethod.singleTrip),
          ),
          const SizedBox(height: 10),
          _PaymentOption(
            title: 'Subscribe a plan',
            description: 'Choose a day, monthly, or annual pass.',
            isSelected:
                vm.selectedPaymentMethod == PaymentMethod.subscriptionPlan,
            onTap: () =>
                vm.selectPaymentMethod(PaymentMethod.subscriptionPlan),
          ),
        ],
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColor.primary : const Color(0xFFE8E8E8),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 16,
              height: 16,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColor.primary : AppColor.neutralLight,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppText.body.copyWith(
                      color: AppColor.neutralDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: AppText.label.copyWith(color: AppColor.neutral),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
