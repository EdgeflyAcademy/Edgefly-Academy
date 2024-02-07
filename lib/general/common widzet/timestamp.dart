String generateTimestamp() {
  DateTime currentTime = DateTime.now();
  return currentTime.toUtc().toIso8601String();
}
