import 'package:intl/intl.dart';

enum TimeStampFormat { parse_12, parse_24 }

extension DateTimeExtensions on DateTime {
  String dateToStringWithFormat({String format = 'y-M-d'}) {
    return DateFormat(format).format(this);
  }

  DateTime stringToDateWithFormat({
    required String format,
    required String dateString,
  }) =>
      DateFormat(format).parse(dateString);

  String getTimeInFormat(TimeStampFormat format) =>
      format == TimeStampFormat.parse_12
          ? DateFormat.jm().format(this).toUpperCase()
          : DateFormat.Hm().format(this).toUpperCase();

  // change the date to the one of $date
  DateTime changeDateTo(DateTime date) {
    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}
