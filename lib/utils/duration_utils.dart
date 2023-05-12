String formatDuration(int seconds) {
  Duration duration = Duration(seconds: seconds);
  if (duration.inHours == 0) {
    return '${duration.inMinutes.remainder(60)}min';
  } else {
    return '${duration.inHours}h ${duration.inMinutes.remainder(60)}min';
  }
}
