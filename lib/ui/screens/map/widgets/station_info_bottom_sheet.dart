import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse_app/model/station.dart';
import 'package:velo_toulouse_app/ui/screens/map/viewmodel/map_view_model.dart';
import 'package:velo_toulouse_app/ui/screens/bikes/view_bike_screen.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';
import 'package:velo_toulouse_app/ui/utils/async_value.dart';

class StationInfoBottomSheet extends StatelessWidget {
  const StationInfoBottomSheet({super.key, required this.station});

  final Station station;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StationViewModel>();
    final availabilityValue = vm.getAvailableBikeCount(station.id);
    final availabilityLabel = vm.getAvailableBikeLabel(station.id);
    final shouldDisableBooking = vm.shouldDisableBooking(station.id);
    final availabilityColor =
        availabilityValue.state == AsyncValueState.success &&
            availabilityValue.data == 0
        ? AppColor.primary
        : AppColor.neutralDark;

    return Container(
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 52,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColor.neutral.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.l),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    station.name,
                    style: AppText.heading.copyWith(
                      fontSize: 22,
                      color: AppColor.neutralDark,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColor.neutral.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 22,
                      color: AppColor.neutralDark,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 24,
                  color: AppColor.neutral,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    station.location.shortAddress,
                    style: AppText.body.copyWith(
                      fontSize: 16,
                      color: AppColor.neutral,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Divider(height: 1, color: AppColor.neutral.withValues(alpha: 0.18)),

            const SizedBox(height: 18),

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7F2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.pedal_bike_outlined,
                    color: Color(0xFF9BC53D),
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    availabilityLabel,
                    style: AppText.heading.copyWith(
                      fontSize: 18,
                      color: availabilityColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.l),

            Text(
              "Tap ‘Book Now’ to view available bikes at this station.",
              style: AppText.label.copyWith(
                color: AppColor.textLight,
                height: 1.35,
              ),
            ),

            const SizedBox(height: AppSpacing.s),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColor.primary.withValues(
                    alpha: 0.45,
                  ),
                  disabledForegroundColor: Colors.white.withValues(alpha: 0.8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                onPressed: shouldDisableBooking
                    ? null
                    : () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ViewBikeScreen(stationId: station.id),
                          ),
                        );
                      },
                child: Text(
                  "Book Now",
                  style: AppText.body.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
