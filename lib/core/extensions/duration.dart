extension CustomDuration on Duration {
  String toStr() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitHours = twoDigits(inHours.remainder(24));
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));

    return '$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds';
  }

  String toStrWithUnits() {
    final int hour = inHours.remainder(24);
    final int minute = inMinutes.remainder(60);
    final int second = inSeconds.remainder(60);
    String result = '';

    if (hour > 0) {
      result += '$hour hr${hour > 1 ? 's' : ''} ';
    }
    if (minute > 0) {
      result += '$minute min${minute > 1 ? 's' : ''} ';
    }
    if (second > 0) {
      result += '$second sec${second > 1 ? 's' : ''} ';
    }
    return result.trim();
  }
}
