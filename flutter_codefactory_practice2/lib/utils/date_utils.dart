class DateUtils {
  static DateTimeToString({required DateTime date}) {
    return '${date.year}-${padInteger(number: date.month)}-${padInteger(number: date.day)} ${padInteger(number: date.hour)}:00';
  }

  static String padInteger({
    required int number,
  }) {
    return number.toString().padLeft(2, '0');
  }
}
