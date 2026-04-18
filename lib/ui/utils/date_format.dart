import 'package:velo_toulouse_app/model/booking.dart';

String formatBookingDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final value = DateTime(date.year, date.month, date.day);

  if (value == today) {
    return 'Today';
  }

  if (value == yesterday) {
    return 'Yesterday';
  }

  return '${_monthName(date.month)} ${date.day}, ${date.year}';
}

String formatBookingTime(DateTime dateTime) {
  final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final period = dateTime.hour >= 12 ? 'PM' : 'AM';

  return '$hour:$minute $period';
}

String formatPaymentMethod(PaymentMethod paymentMethod) {
  switch (paymentMethod) {
    case PaymentMethod.singleTrip:
      return 'Pay-as-you-go';
    case PaymentMethod.subscriptionPlan:
      return 'Subscription plan';
  }
}

String _monthName(int month) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  return months[month - 1];
}
