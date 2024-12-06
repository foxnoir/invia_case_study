class Formatter {
  static String formatPrice({required int priceInCents}) {
    final euros = priceInCents ~/ 100;
    final cents = priceInCents % 100;
    return '$euros,${cents.toString().padLeft(2, '0')}';
  }
}
