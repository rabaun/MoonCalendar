bool isEkadashi(DateTime date) {
  final year = date.year;
  final month = date.month;
  final day = date.day;

  // Calculate the tithi (lunar day) using the formula from the Vaishnava tradition
  final k = (month + 1) % 12;
  final j = (year + (month + 1) ~/ 12).floor();
  final n = (7 * k + 1) ~/ 12;
  final l = 29 + n - (n * ((3 * k) + 7) ~/ 9).floor();
  final p = (j * 365 + j ~/ 4 - j ~/ 100 + j ~/ 400 + (l * (month - n - 1))) % 7;
  final tithi = (p + day) % 30;

  // Check if the tithi is either Ekadashi or Dwadashi (the day after Ekadashi)
  return tithi == 11 || tithi == 26;
}